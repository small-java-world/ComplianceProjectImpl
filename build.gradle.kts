import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import java.util.Properties
import java.net.URLClassLoader
import java.sql.Driver
import java.sql.DriverManager
import java.sql.Connection

plugins {
    id("org.springframework.boot") version "3.2.2"
    id("io.spring.dependency-management") version "1.1.4"
    id("org.flywaydb.flyway") version "9.22.3"
    id("nu.studer.jooq") version "8.2"
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
    annotationProcessor("org.springframework.boot:spring-boot-configuration-processor")

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

// データベース設定
val dbConfig = mapOf(
    "code_master_db" to project.property("dbCodeMasterTest").toString(),
    "organization_db" to project.property("dbOrganizationTest").toString(),
    "risk_db" to project.property("dbRiskTest").toString(),
    "framework_db" to project.property("dbFrameworkTest").toString(),
    "audit_db" to project.property("dbAuditTest").toString(),
    "document_db" to project.property("dbDocumentTest").toString(),
    "training_db" to project.property("dbTrainingTest").toString()
)

jooq {
    version.set("3.19.1")
    configurations {
        create("main") {
            jooqConfiguration.apply {
                jdbc.apply {
                    driver = "com.mysql.cj.jdbc.Driver"
                    url = "jdbc:mysql://${project.property("dbHost")}:${project.property("dbPort")}/${project.property("dbCodeMasterTest")}"
                    user = project.property("dbUsername").toString()
                    password = project.property("dbPassword").toString()
                }
                generator.apply {
                    name = "org.jooq.codegen.KotlinGenerator"
                    database.apply {
                        name = "org.jooq.meta.mysql.MySQLDatabase"
                        inputSchema = "code_master_db_test"
                        includes = ".*"
                        excludes = ""
                        forcedTypes.addAll(
                            listOf(
                                org.jooq.meta.jaxb.ForcedType()
                                    .withName("BOOLEAN")
                                    .withIncludeTypes("TINYINT\\(1\\)")
                            )
                        )
                    }
                    generate.apply {
                        isDeprecated = false
                        isRecords = true
                        isImmutablePojos = true
                        isFluentSetters = true
                        isPojosEqualsAndHashCode = true
                        isJavaTimeTypes = true
                        isKotlinNotNullRecordAttributes = true
                        isKotlinNotNullPojoAttributes = true
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

tasks {
    register("recreateAllDatabases") {
        group = "Database"
        description = "Recreate all test databases"
        
        doLast {
            val jdbcConfiguration = configurations["jdbcDriver"]
            val urls = jdbcConfiguration.files.map { it.toURI().toURL() }.toTypedArray()
            val classLoader = URLClassLoader(urls, this.javaClass.classLoader)
            Thread.currentThread().contextClassLoader = classLoader

            val driver = "com.mysql.cj.jdbc.Driver"
            val baseUrl = "jdbc:mysql://${project.property("dbHost")}:${project.property("dbPort")}"
            val user = project.property("dbUsername").toString()
            val password = project.property("dbPassword").toString()

            try {
                Class.forName(driver, true, classLoader)
                val connection = DriverManager.getConnection(baseUrl, user, password)
                connection.use { conn ->
                    val statement = conn.createStatement()
                    dbConfig.values.forEach { dbName ->
                        println("Creating database: $dbName")
                        statement.execute("DROP DATABASE IF EXISTS $dbName")
                        statement.execute("CREATE DATABASE $dbName CHARACTER SET ${project.property("dbCharset")} COLLATE ${project.property("dbCollation")}")
                    }
                }
            } catch (e: Exception) {
                println("Error: ${e.message}")
                e.printStackTrace()
                throw e
            }
        }
    }

    register("flywayMigrateAll") {
        group = "Database"
        description = "Run Flyway migrations for all databases"
        dependsOn("recreateAllDatabases")
        
        doLast {
            val jdbcConfiguration = configurations["jdbcDriver"]
            val urls = jdbcConfiguration.files.map { it.toURI().toURL() }.toTypedArray()
            val classLoader = URLClassLoader(urls, this.javaClass.classLoader)
            Thread.currentThread().contextClassLoader = classLoader

            Class.forName("com.mysql.cj.jdbc.Driver", true, classLoader)

            dbConfig.forEach { (key, dbName) ->
                println("Running Flyway migration for: $dbName")
                project.extensions.getByType<org.flywaydb.gradle.FlywayExtension>().apply {
                    url = "jdbc:mysql://${project.property("dbHost")}:${project.property("dbPort")}/$dbName"
                    user = project.property("dbUsername").toString()
                    password = project.property("dbPassword").toString()
                    baselineOnMigrate = true
                    baselineVersion = "0"
                    locations = arrayOf(
                        "classpath:db/migration/${key}",
                        "classpath:db/testmigration/${key}"
                    )
                }
                project.tasks.getByName("flywayMigrate").actions.forEach { action ->
                    action.execute(project.tasks.getByName("flywayMigrate"))
                }
            }
        }
    }

    named<nu.studer.gradle.jooq.JooqGenerate>("generateJooq") {
        dependsOn("flywayMigrateAll")
        
        inputs.files(fileTree("src/main/resources/db/migration"))
            .withPropertyName("migrations")
            .withPathSensitivity(PathSensitivity.RELATIVE)
        allInputsDeclared.set(true)
        outputs.cacheIf { true }
    }

    named("compileKotlin") {
        dependsOn("generateJooq")
    }

    withType<KotlinCompile> {
        kotlinOptions {
            freeCompilerArgs += "-Xjsr305=strict"
            jvmTarget = "21"
        }
    }
} 