import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import java.util.Properties
import java.net.URLClassLoader
import java.sql.Driver
import java.sql.DriverManager

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
    version.set("3.19.1")
    configurations {
        create("main") {
            jooqConfiguration.apply {
                jdbc.apply {
                    driver = "com.mysql.cj.jdbc.Driver"
                    url = "jdbc:mysql://localhost:3306/compliance_management_system?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC"
                    user = "compliance_user"
                    password = "compliance_pass"
                }
                generator.apply {
                    name = "org.jooq.codegen.KotlinGenerator"
                    database.apply {
                        name = "org.jooq.meta.mysql.MySQLDatabase"
                        inputSchema = "compliance_management_system"
                        forcedTypes.addAll(
                            listOf(
                                org.jooq.meta.jaxb.ForcedType().apply {
                                    name = "java.time.LocalDate"
                                    includeExpression = ".*\\..*_date"
                                    includeTypes = "DATE"
                                },
                                org.jooq.meta.jaxb.ForcedType().apply {
                                    name = "java.time.LocalDateTime"
                                    includeExpression = ".*\\..*_at"
                                    includeTypes = "TIMESTAMP"
                                }
                            )
                        )
                    }
                    generate.apply {
                        isDeprecated = false
                        isRecords = true
                        isImmutablePojos = true
                        isFluentSetters = true
                    }
                    target.apply {
                        packageName = "com.example.project.infrastructure.jooq"
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
    jvmArgs = listOf("-Dfile.encoding=UTF-8")
}

tasks.withType<Test> {
    useJUnitPlatform()
    jvmArgs = listOf("-Dfile.encoding=UTF-8")
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

tasks.register("testDatabaseConnection") {
    group = "Database"
    description = "Test database connection using JDBC"

    // タスクのクラスパスにJDBCドライバーを追加
    configurations {
        create("jdbcDriver")
    }
    dependencies {
        add("jdbcDriver", "com.mysql:mysql-connector-j:8.0.33")
    }

    doLast {
        // JDBCドライバーをクラスパスに追加
        val jdbcConfiguration = configurations["jdbcDriver"]
        val urls = jdbcConfiguration.files.map { it.toURI().toURL() }.toTypedArray()
        val classLoader = URLClassLoader(urls, this.javaClass.classLoader)
        Thread.currentThread().contextClassLoader = classLoader

        val driver = "com.mysql.cj.jdbc.Driver"
        val url = "jdbc:mysql://localhost:3306/compliance_management_system?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC"
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

            val connection = driverInstance.connect(url, Properties().apply {
                setProperty("user", user)
                setProperty("password", password)
            })
            try {
                val statement = connection.createStatement()
                val resultSet = statement.executeQuery("SELECT 1")
                if (resultSet.next()) {
                    println("データベース接続テスト成功！")
                    println("テストクエリ結果: ${resultSet.getInt(1)}")
                }
                resultSet.close()
                statement.close()
            } finally {
                connection.close()
            }
        } catch (e: Exception) {
            println("データベース接続テスト失敗: ${e.message}")
            throw e
        }
    }
}

flyway {
    url = "jdbc:mysql://localhost:3306/compliance_management_system?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC"
    user = "compliance_user"
    password = "compliance_pass"
    driver = "com.mysql.cj.jdbc.Driver"
    defaultSchema = "compliance_management_system"
    locations = arrayOf("filesystem:src/main/resources/db/migration")
    validateOnMigrate = true
    outOfOrder = false
    baselineOnMigrate = true
}

buildscript {
    dependencies {
        classpath("org.flywaydb:flyway-mysql:9.22.3")
        classpath("com.mysql:mysql-connector-j:8.0.33")
    }
}

tasks.register("loadTransactionData") {
    group = "Database"
    description = "Load transaction data into the database"
    
    doLast {
        val flyway = org.flywaydb.core.Flyway.configure()
            .dataSource(
                "jdbc:mysql://localhost:3306/compliance_management_system",
                "root",
                "root"
            )
            .locations("filesystem:src/main/resources/db/transactiondata")
            .baselineOnMigrate(true)
            .outOfOrder(true)
            .validateOnMigrate(false)
            .load()

        flyway.migrate()
    }
} 