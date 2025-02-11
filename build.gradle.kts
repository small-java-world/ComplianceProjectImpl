import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import java.util.Properties
import java.net.URLClassLoader
import java.sql.Driver
import java.sql.DriverManager
import java.sql.Connection

plugins {
    id("org.springframework.boot") version "3.2.2"
    id("io.spring.dependency-management") version "1.1.4"
    id("nu.studer.jooq") version "8.2"
    id("org.flywaydb.flyway") version "9.22.3"
    kotlin("jvm") version "2.1.0"
    kotlin("plugin.spring") version "2.1.0"
    kotlin("plugin.jpa") version "2.1.0"
}

group = "com.example"
version = "0.0.1-SNAPSHOT"

java {
    sourceCompatibility = JavaVersion.VERSION_21
}

repositories {
    mavenCentral()
}

configurations {
    create("jdbcDriver")
}

dependencies {
    // Spring Boot
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("org.springframework.boot:spring-boot-starter-data-jpa")
    implementation("org.springframework.boot:spring-boot-starter-validation")
    implementation("org.springframework.boot:spring-boot-starter-security")
    implementation("org.springframework.boot:spring-boot-starter-actuator")
    implementation("org.springframework.boot:spring-boot-starter-jooq")

    // Kotlin
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
    implementation("org.jetbrains.kotlin:kotlin-reflect")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")

    // Database
    implementation("org.flywaydb:flyway-core:9.22.3")
    implementation("org.flywaydb:flyway-mysql:9.22.3")
    runtimeOnly("com.mysql:mysql-connector-j:8.0.33")
    implementation("org.jooq:jooq:3.19.1")
    implementation("org.jooq:jooq-meta:3.19.1")
    implementation("org.jooq:jooq-codegen:3.19.1")
    jooqGenerator("com.mysql:mysql-connector-j:8.0.33")

    // JDBC driver
    add("jdbcDriver", "com.mysql:mysql-connector-j:8.0.33")
    implementation("com.mysql:mysql-connector-j:8.0.33")

    // AWS SDK for S3/MinIO
    implementation("software.amazon.awssdk:s3:2.22.12")

    // Logging
    implementation("io.github.oshai:kotlin-logging-jvm:5.1.0")

    // Database connection test
    implementation("org.codehaus.groovy:groovy-sql:3.0.19")

    // Test
    testImplementation("org.springframework.boot:spring-boot-starter-test")
    testImplementation("io.kotest:kotest-runner-junit5:5.9.0")
    testImplementation("io.kotest:kotest-assertions-core:5.9.0")
    testImplementation("io.kotest:kotest-property:5.9.0")
    testImplementation("io.mockk:mockk:1.13.9")
    testImplementation("io.kotest.extensions:kotest-extensions-spring:1.1.3")
    testImplementation("org.springframework.security:spring-security-test")
}

buildscript {
    dependencies {
        classpath("org.flywaydb:flyway-mysql:9.22.3")
        classpath("com.mysql:mysql-connector-j:8.0.33")
    }
}

// .envファイルから環境変数を読み込む
fun loadEnvVariables(): Map<String, String> {
    val envFile = file(".env")
    return if (envFile.exists()) {
        envFile.readLines()
            .filter { it.isNotBlank() && !it.startsWith("#") }
            .map { line ->
                val (key, value) = line.split("=", limit = 2)
                key.trim() to value.trim()
            }
            .toMap()
    } else {
        emptyMap()
    }
}

val envVariables = loadEnvVariables()
jooq {
    configurations {
        create("main") {
            jooqConfiguration.apply {
                jdbc.apply {
                    driver = "com.mysql.cj.jdbc.Driver"
                    url = "jdbc:mysql://localhost:3307/code_master_db_test"
                    user = "compliance_user"
                    password = "compliance_pass"
                }
                generator.apply {
                    name = "org.jooq.codegen.DefaultGenerator"
                    database.apply {
                        name = "org.jooq.meta.mysql.MySQLDatabase"
                        inputSchema = "code_master_db_test"
                        includes = ".*"
                        excludes = ""
                    }
                    generate.apply {
                        isDeprecated = false
                        isRecords = true
                        isImmutablePojos = true
                        isFluentSetters = true
                    }
                    target.apply {
                        packageName = "com.example.project.jooq"
                        directory = "build/generated-src/jooq/main"
                    }
                    strategy.name = "org.jooq.codegen.DefaultGeneratorStrategy"
                }
            }
        }
    }
}

// データベース初期化タスク
tasks.register("initDatabase") {
    group = "Database"
    description = "Initialize database with migrations and generate jOOQ classes"
    dependsOn("flywayMigrate", "generateJooq")
}

tasks.named<nu.studer.gradle.jooq.JooqGenerate>("generateJooq") {
    dependsOn("flywayMigrate")
    inputs.files(fileTree("src/main/resources/db/migration"))
        .withPropertyName("migrations")
        .withPathSensitivity(PathSensitivity.RELATIVE)
    allInputsDeclared.set(true)
    outputs.cacheIf { true }
}

tasks.withType<JavaExec> {
    systemProperties = mapOf(
        "file.encoding" to "UTF-8",
        "user.language" to "ja",
        "user.country" to "JP"
    )
}

tasks.withType<Test> {
    useJUnitPlatform()
    systemProperties = mapOf(
        "file.encoding" to "UTF-8",
        "user.language" to "ja",
        "user.country" to "JP"
    )
    testLogging {
        events("passed", "skipped", "failed")
        showStandardStreams = true
        showExceptions = true
        showCauses = true
        showStackTraces = true
    }
}

tasks.withType<JavaCompile> {
    options.encoding = "UTF-8"
}

tasks.withType<KotlinCompile> {
    kotlinOptions {
        freeCompilerArgs += "-Xjsr305=strict"
        jvmTarget = "21"
    }
}

tasks.withType<Exec> {
    environment(mapOf(
        "LANG" to "ja_JP.UTF-8",
        "LC_ALL" to "ja_JP.UTF-8"
    ))
}

tasks.withType<org.gradle.api.tasks.GradleBuild> {
    // 環境変数の設定は削除
}

tasks.register("testDatabaseConnection") {
    group = "Database"
    description = "Test database connection using JDBC"

    doLast {
        // JDBCドライバーをクラスパスに追加
        val jdbcConfiguration = configurations["jdbcDriver"]
        val urls = jdbcConfiguration.files.map { it.toURI().toURL() }.toTypedArray()
        val classLoader = URLClassLoader(urls, this.javaClass.classLoader)
        Thread.currentThread().contextClassLoader = classLoader

        val driver = "com.mysql.cj.jdbc.Driver"
        val url = "jdbc:mysql://localhost:3307/compliance_management_system?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC"
        val user = "compliance_user"
        val password = "compliance_pass"

        try {
            // JDBCドライバーを登録
            val driverClass = Class.forName(driver, true, classLoader)
            val driverInstance = driverClass.getDeclaredConstructor().newInstance() as Driver
            DriverManager.registerDriver(driverInstance)

            // 登録されているドライバーを確認
            println("登録されているドライバー:")
            val drivers = DriverManager.getDrivers()
            while (drivers.hasMoreElements()) {
                val d = drivers.nextElement()
                println(" - ${d.javaClass.name}")
            }

            // データベースに接続
            println("データベースに接続を試みます...")
            val connection = DriverManager.getConnection(url, user, password)
            println("データベース接続成功!")
            connection.close()
        } catch (e: Exception) {
            println("データベース接続エラー: ${e.message}")
            throw e
        }
    }
}

// データベース設定
val databases = listOf(
    "risk_master_db",
    "risk_transaction_db",
    "asset_db",
    "document_db",
    "training_db",
    "code_master_db",
    "organization_db",
    "framework_db",
    "audit_db"
)

// 各データベース用のFlywayタスクを作成
databases.forEach { dbName ->
    // マイグレーションタスク
    tasks.register<org.flywaydb.gradle.task.FlywayMigrateTask>("flywayMigrate${dbName.split('_').joinToString("") { it.capitalize() }}") {
        url = "jdbc:mysql://localhost:3307/${dbName}?allowPublicKeyRetrieval=true&useSSL=false"
        user = "compliance_user"
        password = "compliance_pass"
        driver = "com.mysql.cj.jdbc.Driver"
        locations = arrayOf(
            "filesystem:src/main/resources/db/migration/${dbName}",
            "filesystem:src/main/resources/db/transactiondata/${dbName}"
        )
        validateOnMigrate = true
        outOfOrder = false
        baselineOnMigrate = true
        cleanDisabled = false
    }

    // クリーンタスク
    tasks.register<org.flywaydb.gradle.task.FlywayCleanTask>("flywayClean${dbName.split('_').joinToString("") { it.capitalize() }}") {
        url = "jdbc:mysql://localhost:3307/${dbName}?allowPublicKeyRetrieval=true&useSSL=false"
        user = "compliance_user"
        password = "compliance_pass"
        driver = "com.mysql.cj.jdbc.Driver"
        cleanDisabled = false
    }
}

// データベースクリーンタスク
tasks.register("flywayCleanAll") {
    group = "Database"
    description = "Clean all databases"
    
    databases.forEach { dbName ->
        val taskName = "flywayClean${dbName.split('_').joinToString("") { it.capitalize() }}"
        dependsOn(taskName)
    }
}

// データベース作成タスク
tasks.register("createAllDatabases") {
    group = "Database"
    description = "Create all databases"
    
    doLast {
        databases.forEach { dbName ->
            exec {
                commandLine(
                    "docker",
                    "exec",
                    "compliance_mysql",
                    "mysql",
                    "-uroot",
                    "-proot",
                    "-e",
                    "CREATE DATABASE IF NOT EXISTS ${dbName} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
                )
            }
        }
    }
}

// マイグレーション実行タスク
tasks.register("flywayMigrateAll") {
    group = "Database"
    description = "Run Flyway migrate on all databases"
    dependsOn("createAllDatabases")
    
    databases.forEach { dbName ->
        val taskName = "flywayMigrate${dbName.split('_').joinToString("") { it.capitalize() }}"
        dependsOn(taskName)
    }
}

// データ投入タスク
tasks.register("loadAllData") {
    group = "Database"
    description = "Load all initial data into databases"
    dependsOn("flywayMigrateAll")
}

tasks.register("dropAllDatabases") {
    group = "Database"
    description = "全てのデータベースを削除します"
    
    doLast {
        val databases = listOf(
            "code_master_db",
            "organization_db",
            "framework_db",
            "audit_db",
            "risk_master_db",
            "risk_transaction_db",
            "asset_db",
            "document_db",
            "training_db"
        )
        
        databases.forEach { dbName ->
            exec {
                commandLine(
                    "docker",
                    "exec",
                    "-i",
                    "compliance_mysql",
                    "mysql",
                    "-u",
                    "root",
                    "-proot",
                    "-e",
                    "SET FOREIGN_KEY_CHECKS=0; DROP DATABASE IF EXISTS $dbName; SET FOREIGN_KEY_CHECKS=1;"
                )
            }
        }
    }
}

tasks.register("migrateRiskDatabases") {
    group = "Database"
    description = "リスク関連のデータベースのマイグレーションを実行します"
    
    dependsOn("flywayMigrateRiskMaster")
    dependsOn("flywayMigrateRiskTransaction")
    
    tasks.findByName("flywayMigrateRiskTransaction")?.mustRunAfter("flywayMigrateRiskMaster")
}

tasks.register<org.flywaydb.gradle.task.FlywayRepairTask>("flywayRepairDocument") {
    driver = "com.mysql.cj.jdbc.Driver"
    url = "jdbc:mysql://localhost:3307/document_db?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC"
    user = "compliance_user"
    password = "compliance_pass"
    locations = arrayOf("filesystem:src/main/resources/db/migration/document_db")
}

tasks.register("repairAllDatabases") {
    group = "Database"
    description = "Repairs all database migration histories"
    dependsOn("flywayRepairDocument")
}

// リスクデータベースの作成タスク
tasks.register("createRiskDatabases") {
    group = "Database"
    description = "リスク関連のデータベースを作成します"
    doFirst {
        // データベースの作成
        val jdbcConfiguration = configurations["jdbcDriver"]
        val urls = jdbcConfiguration.files.map { it.toURI().toURL() }.toTypedArray()
        val classLoader = URLClassLoader(urls, this.javaClass.classLoader)
        Thread.currentThread().contextClassLoader = classLoader

        val driver = "com.mysql.cj.jdbc.Driver"
        val baseUrl = "jdbc:mysql://localhost:3307/?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC"
        val user = "compliance_user"
        val password = "compliance_pass"

        try {
            Class.forName(driver)
            DriverManager.getConnection(baseUrl, user, password).use { connection ->
                connection.createStatement().use { statement ->
                    // リスクマスタデータベースの作成
                    statement.executeUpdate("DROP DATABASE IF EXISTS risk_master_db")
                    statement.executeUpdate("CREATE DATABASE risk_master_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")
                    println("リスクマスタデータベースを作成しました")

                    // リスクトランザクションデータベースの作成
                    statement.executeUpdate("DROP DATABASE IF EXISTS risk_transaction_db")
                    statement.executeUpdate("CREATE DATABASE risk_transaction_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")
                    println("リスクトランザクションデータベースを作成しました")
                }
            }
        } catch (e: Exception) {
            println("データベースの作成中にエラーが発生しました: ${e.message}")
            throw e
        }
    }
}

// リスクマスターデータベース用のFlywayタスク
tasks.register<org.flywaydb.gradle.task.FlywayMigrateTask>("flywayMigrateRiskMaster") {
    url = "jdbc:mysql://localhost:3307/risk_master_db?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC"
    user = "compliance_user"
    password = "compliance_pass"
    driver = "com.mysql.cj.jdbc.Driver"
    defaultSchema = "risk_master_db"
    locations = arrayOf("filesystem:src/main/resources/db/migration/risk_master_db")
    validateOnMigrate = true
    outOfOrder = false
    baselineOnMigrate = true
    cleanDisabled = false
}

// リスクトランザクションデータベース用のFlywayタスク
tasks.register<org.flywaydb.gradle.task.FlywayMigrateTask>("flywayMigrateRiskTransaction") {
    url = "jdbc:mysql://localhost:3307/risk_transaction_db?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC"
    user = "compliance_user"
    password = "compliance_pass"
    driver = "com.mysql.cj.jdbc.Driver"
    defaultSchema = "risk_transaction_db"
    locations = arrayOf("filesystem:src/main/resources/db/migration/risk_transaction_db")
    validateOnMigrate = true
    outOfOrder = false
    baselineOnMigrate = true
    cleanDisabled = false
}

// リスクマスターデータベースのリペアタスク
tasks.register<org.flywaydb.gradle.task.FlywayRepairTask>("flywayRepairRiskMaster") {
    description = "Repair risk master database migration history"
    driver = "com.mysql.cj.jdbc.Driver"
    url = "jdbc:mysql://localhost:3307/risk_master_db?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC"
    user = "compliance_user"
    password = "compliance_pass"
    locations = arrayOf("filesystem:src/main/resources/db/migration/risk_master_db")
}

// リスクトランザクションデータベースのリペアタスク
tasks.register<org.flywaydb.gradle.task.FlywayRepairTask>("flywayRepairRiskTransaction") {
    description = "Repair risk transaction database migration history"
    driver = "com.mysql.cj.jdbc.Driver"
    url = "jdbc:mysql://localhost:3307/risk_transaction_db?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC"
    user = "compliance_user"
    password = "compliance_pass"
    locations = arrayOf("filesystem:src/main/resources/db/migration/risk_transaction_db")
}

// リスクデータベースのリペアを実行するタスク
tasks.register("repairRiskDatabases") {
    group = "Database"
    description = "Repair all risk databases migration history"
    dependsOn("flywayRepairRiskMaster", "flywayRepairRiskTransaction")
}

// リスクマスターデータベースのクリーンタスク
tasks.register<org.flywaydb.gradle.task.FlywayCleanTask>("flywayCleanRiskMaster") {
    driver = "com.mysql.cj.jdbc.Driver"
    url = "jdbc:mysql://localhost:3307/risk_master_db?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC"
    user = "compliance_user"
    password = "compliance_pass"
}

// リスクトランザクションデータベースのクリーンタスク
tasks.register<org.flywaydb.gradle.task.FlywayCleanTask>("flywayCleanRiskTransaction") {
    driver = "com.mysql.cj.jdbc.Driver"
    url = "jdbc:mysql://localhost:3307/risk_transaction_db?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC"
    user = "compliance_user"
    password = "compliance_pass"
}

// リスクデータベースのクリーンを実行するタスク
tasks.register("cleanRiskDatabases") {
    group = "Database"
    description = "Clean both risk databases"
    dependsOn("flywayCleanRiskMaster", "flywayCleanRiskTransaction")
}

tasks.register("showDatabaseTables") {
    group = "Database"
    description = "Show tables in all databases"

    doLast {
        val jdbcConfiguration = configurations["jdbcDriver"]
        val urls = jdbcConfiguration.files.map { it.toURI().toURL() }.toTypedArray()
        val classLoader = URLClassLoader(urls, this.javaClass.classLoader)
        Thread.currentThread().contextClassLoader = classLoader

        val driver = "com.mysql.cj.jdbc.Driver"
        val baseUrl = "jdbc:mysql://localhost:3307"
        val user = "compliance_user"
        val password = "compliance_pass"

        val databases = listOf(
            "risk_master_db",
            "risk_transaction_db"
        )

        try {
            Class.forName(driver, true, classLoader)
            databases.forEach { dbName ->
                println("\nテーブル一覧 - $dbName:")
                val connection = DriverManager.getConnection("$baseUrl/$dbName?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC", user, password)
                val metadata = connection.metaData
                val tables = metadata.getTables(dbName, null, "%", arrayOf("TABLE"))
                while (tables.next()) {
                    println(" - ${tables.getString("TABLE_NAME")}")
                }
                connection.close()
            }
        } catch (e: Exception) {
            println("エラーが発生しました: ${e.message}")
            e.printStackTrace()
        }
    }
}

tasks.register("recreateAllDatabases") {
    group = "Database"
    description = "全てのデータベースを再作成します"
    
    dependsOn("dropAllDatabases")
    dependsOn("createAllDatabases")
    dependsOn("flywayMigrateAll")
    dependsOn("migrateRiskDatabases")
    
    tasks.findByName("createAllDatabases")?.mustRunAfter("dropAllDatabases")
    tasks.findByName("flywayMigrateAll")?.mustRunAfter("createAllDatabases")
    tasks.findByName("migrateRiskDatabases")?.mustRunAfter("createAllDatabases")
}

// JDBCドライバーをロードする関数
fun loadJdbcDriver(): URLClassLoader {
    val jdbcConfiguration = configurations["jdbcDriver"]
    val urls = jdbcConfiguration.files.map { it.toURI().toURL() }.toTypedArray()
    val classLoader = URLClassLoader(urls, Thread.currentThread().contextClassLoader)
    Thread.currentThread().contextClassLoader = classLoader
    return classLoader
}

// テスト用データベースのクリーンタスク
tasks.register("cleanTestDatabases") {
    group = "Database"
    description = "Clean test databases"
    doLast {
        val dbNames = listOf(
            "code_master_db_test",
            "organization_db_test",
            "reference_data_db_test",
            "risk_master_db_test",
            "risk_transaction_db_test",
            "asset_db_test",
            "framework_db_test",
            "document_db_test",
            "training_db_test",
            "audit_db_test",
            "compliance_db_test"
        )

        dbNames.forEach { dbName ->
            flyway {
                url = "jdbc:mysql://localhost:3307/$dbName?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC"
                user = "compliance_user"
                password = "compliance_pass"
                locations = arrayOf("filesystem:src/test/resources/db/testmigration/$dbName")
                cleanDisabled = false
            }
            tasks.findByName("flywayClean")?.actions?.forEach { it.execute(tasks.findByName("flywayClean")!!) }
        }
    }
}

// テスト用データベースの作成タスク
tasks.register("createTestDatabases") {
    group = "Database"
    description = "Create test databases"

    doLast {
        // コードマスターDBのマイグレーション
        flyway {
            url = "jdbc:mysql://localhost:3307/code_master_db_test"
            user = "compliance_user"
            password = "compliance_pass"
            locations = arrayOf(
                "classpath:db/migration/code_master_db",  // 本番のマイグレーション
                "classpath:db/testmigration/code_master_db"  // テストデータ
            )
            cleanDisabled = false
            cleanOnValidationError = true
            baselineOnMigrate = true
            outOfOrder = false
            validateOnMigrate = true
            mixed = true
        }
        tasks.getByName("flywayClean").actions.forEach { it.execute(tasks.getByName("flywayClean")) }
        tasks.getByName("flywayMigrate").actions.forEach { it.execute(tasks.getByName("flywayMigrate")) }
    }
}

// テストタスクの依存関係を更新
tasks.test {
    dependsOn("recreateTestDatabases")
    dependsOn("verifyTestDbConnections")
}

// Flyway設定を更新
flyway {
    driver = "com.mysql.cj.jdbc.Driver"
    url = "jdbc:mysql://localhost:3307/compliance_management_system?allowPublicKeyRetrieval=true&useSSL=false"
    user = "compliance_user"
    password = "compliance_pass"
    validateOnMigrate = true
    outOfOrder = false
    baselineOnMigrate = true
    cleanDisabled = false
}

// テスト用データベースのマイグレーションタスク
tasks.register("migrateTestDatabases") {
    group = "Database"
    description = "Migrates all test databases"
    
    doLast {
        // テストデータベースのマイグレーション
        flyway {
            url = "jdbc:mysql://localhost:3307/code_master_db_test?allowPublicKeyRetrieval=true&useSSL=false"
            user = "root"
            password = "root"
            locations = arrayOf(
                "filesystem:src/main/resources/db/migration/code_master_db",
                "filesystem:src/test/resources/db/testmigration/code_master_db"
            )
            validateOnMigrate = true
            outOfOrder = false
            baselineOnMigrate = true
            cleanDisabled = false
        }

        // クリーンアップとマイグレーションを実行
        tasks.findByName("flywayClean")?.actions?.forEach { it.execute(tasks.findByName("flywayClean")!!) }
        tasks.findByName("flywayMigrate")?.actions?.forEach { it.execute(tasks.findByName("flywayMigrate")!!) }
    }
}

// テスト用データベースの再作成タスク
tasks.register("recreateTestDatabases") {
    group = "Database"
    description = "Recreate all test databases"
    
    dependsOn("cleanTestDatabases")
    dependsOn("createTestDatabases")
    dependsOn("migrateTestDatabases")
    
    tasks.findByName("createTestDatabases")?.mustRunAfter("cleanTestDatabases")
    tasks.findByName("migrateTestDatabases")?.mustRunAfter("createTestDatabases")
}

// テスト用データベースの接続確認タスク
tasks.register("verifyTestDbConnections") {
    group = "Database"
    description = "Verifies connections to all test databases"
    dependsOn("migrateTestDatabases")
    
    doLast {
        val testDatabases = listOf(
            "code_master_db_test",
            "organization_db_test",
            "reference_data_db_test",
            "risk_master_db_test",
            "risk_transaction_db_test",
            "asset_db_test",
            "framework_db_test",
            "document_db_test",
            "training_db_test",
            "audit_db_test",
            "compliance_db_test"
        )

        // JDBCドライバーをロード
        val classLoader = loadJdbcDriver()
        Class.forName("com.mysql.cj.jdbc.Driver", true, classLoader)

        testDatabases.forEach { dbName ->
            try {
                val connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3307/$dbName?allowPublicKeyRetrieval=true&useSSL=false",
                    "root",
                    "root"
                )
                connection.use { conn ->
                    conn.createStatement().use { stmt ->
                        val rs = stmt.executeQuery("SELECT 1")
                        if (rs.next()) {
                            println("✓ Successfully connected to $dbName")
                        }
                    }
                }
            } catch (e: Exception) {
                throw GradleException("Failed to connect to $dbName: ${e.message}")
            }
        }
    }
}

// デフォルトのFlywayタスクを無効化
tasks.named("flywayMigrate") {
    enabled = false
}

tasks.named("flywayClean") {
    enabled = false
}

tasks.named("flywayInfo") {
    enabled = false
}

tasks.named("flywayValidate") {
    enabled = false
}

tasks.named("flywayRepair") {
    enabled = false
}

tasks.named("flywayBaseline") {
    enabled = false
} 