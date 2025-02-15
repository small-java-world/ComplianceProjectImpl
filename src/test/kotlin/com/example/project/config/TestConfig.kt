package com.example.project.config

import com.example.project.code.domain.repository.CodeRepository
import com.example.project.code.infrastructure.repository.CodeRepositoryImpl
import com.example.project.organization.domain.repository.PermissionRepository
import com.example.project.organization.infrastructure.repository.PermissionRepositoryImpl
import com.zaxxer.hikari.HikariDataSource
import org.jooq.DSLContext
import org.jooq.SQLDialect
import org.jooq.impl.DSL
import org.jooq.impl.DefaultConfiguration
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.context.annotation.Primary
import org.springframework.context.annotation.Profile
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.jdbc.datasource.DataSourceTransactionManager
import org.springframework.transaction.PlatformTransactionManager
import org.springframework.transaction.annotation.EnableTransactionManagement
import javax.sql.DataSource
import jakarta.annotation.PostConstruct
import org.flywaydb.core.Flyway

@Configuration
@Profile("test")
@EnableTransactionManagement
class TestConfig {

    @Bean
    @Primary
    @Qualifier("organizationDataSource")
    fun organizationTestDataSource(): DataSource {
        return createHikariDataSource(
            url = "jdbc:mysql://localhost:3307/organization_db_test",
            username = "root",
            password = "root",
            poolName = "HikariPool-organization-test"
        )
    }

    @Bean
    @Qualifier("codeMasterDataSource")
    fun codeMasterTestDataSource(): DataSource {
        return createHikariDataSource(
            url = "jdbc:mysql://localhost:3307/code_master_db_test",
            username = "root",
            password = "root",
            poolName = "HikariPool-code-master-test"
        )
    }

    @Bean
    @Qualifier("documentDataSource")
    fun documentTestDataSource(): DataSource {
        return createHikariDataSource(
            url = "jdbc:mysql://localhost:3307/document_db_test",
            username = "root",
            password = "root",
            poolName = "HikariPool-document-test"
        )
    }

    @Bean
    @Qualifier("frameworkDataSource")
    fun frameworkTestDataSource(): DataSource {
        return createHikariDataSource(
            url = "jdbc:mysql://localhost:3307/framework_db_test",
            username = "root",
            password = "root",
            poolName = "HikariPool-framework-test"
        )
    }

    @Bean
    @Qualifier("auditDataSource")
    fun auditTestDataSource(): DataSource {
        return createHikariDataSource(
            url = "jdbc:mysql://localhost:3307/audit_db_test",
            username = "root",
            password = "root",
            poolName = "HikariPool-audit-test"
        )
    }

    @Bean
    @Qualifier("trainingDataSource")
    fun trainingTestDataSource(): DataSource {
        return createHikariDataSource(
            url = "jdbc:mysql://localhost:3307/training_db_test",
            username = "root",
            password = "root",
            poolName = "HikariPool-training-test"
        )
    }

    @Bean
    @Primary
    @Qualifier("organizationDslContext")
    fun organizationTestDslContext(@Qualifier("organizationDataSource") dataSource: DataSource): DSLContext {
        return createDslContext(dataSource)
    }

    @Bean
    @Qualifier("codeMasterDslContext")
    fun codeMasterTestDslContext(@Qualifier("codeMasterDataSource") dataSource: DataSource): DSLContext {
        return createDslContext(dataSource)
    }

    @Bean
    @Qualifier("documentDslContext")
    fun documentTestDslContext(@Qualifier("documentDataSource") dataSource: DataSource): DSLContext {
        return createDslContext(dataSource)
    }

    @Bean
    @Qualifier("frameworkDslContext")
    fun frameworkTestDslContext(@Qualifier("frameworkDataSource") dataSource: DataSource): DSLContext {
        return createDslContext(dataSource)
    }

    @Bean
    @Qualifier("auditDslContext")
    fun auditTestDslContext(@Qualifier("auditDataSource") dataSource: DataSource): DSLContext {
        return createDslContext(dataSource)
    }

    @Bean
    @Qualifier("trainingDslContext")
    fun trainingTestDslContext(@Qualifier("trainingDataSource") dataSource: DataSource): DSLContext {
        return createDslContext(dataSource)
    }

    @Bean
    @Primary
    fun organizationJdbcTemplate(@Qualifier("organizationDataSource") dataSource: DataSource): JdbcTemplate {
        return JdbcTemplate(dataSource)
    }

    @Bean
    @Qualifier("codeMasterJdbcTemplate")
    fun codeMasterJdbcTemplate(@Qualifier("codeMasterDataSource") dataSource: DataSource): JdbcTemplate {
        return JdbcTemplate(dataSource)
    }

    @Bean
    @Primary
    fun codeRepository(
        @Qualifier("codeMasterDslContext") dslContext: DSLContext
    ): CodeRepository {
        return CodeRepositoryImpl(dslContext)
    }

    @Bean
    @Primary
    fun permissionRepository(
        @Qualifier("organizationDslContext") dslContext: DSLContext
    ): PermissionRepository {
        return PermissionRepositoryImpl(dslContext)
    }

    @Bean
    @Primary
    fun transactionManager(@Qualifier("organizationDataSource") dataSource: DataSource): PlatformTransactionManager {
        val transactionManager = DataSourceTransactionManager(dataSource)
        transactionManager.isRollbackOnCommitFailure = true
        transactionManager.defaultTimeout = 60
        transactionManager.isValidateExistingTransaction = true
        transactionManager.isGlobalRollbackOnParticipationFailure = true
        return transactionManager
    }

    @Bean
    @Qualifier("codeMasterTransactionManager")
    fun codeMasterTransactionManager(@Qualifier("codeMasterDataSource") dataSource: DataSource): PlatformTransactionManager {
        return DataSourceTransactionManager(dataSource)
    }

    @Bean
    @Qualifier("documentTransactionManager")
    fun documentTransactionManager(@Qualifier("documentDataSource") dataSource: DataSource): PlatformTransactionManager {
        return DataSourceTransactionManager(dataSource)
    }

    @Bean
    @Qualifier("frameworkTransactionManager")
    fun frameworkTransactionManager(@Qualifier("frameworkDataSource") dataSource: DataSource): PlatformTransactionManager {
        return DataSourceTransactionManager(dataSource)
    }

    @Bean
    @Qualifier("auditTransactionManager")
    fun auditTransactionManager(@Qualifier("auditDataSource") dataSource: DataSource): PlatformTransactionManager {
        return DataSourceTransactionManager(dataSource)
    }

    @Bean
    @Qualifier("trainingTransactionManager")
    fun trainingTransactionManager(@Qualifier("trainingDataSource") dataSource: DataSource): PlatformTransactionManager {
        return DataSourceTransactionManager(dataSource)
    }

    private fun createHikariDataSource(
        url: String,
        username: String,
        password: String,
        poolName: String
    ): HikariDataSource {
        return HikariDataSource().apply {
            jdbcUrl = if (url.contains("?")) {
                "$url&serverTimezone=Asia/Tokyo&rewriteBatchedStatements=true&useLocalTransactionState=true&socketTimeout=60000&allowPublicKeyRetrieval=true&useSSL=false"
            } else {
                "$url?serverTimezone=Asia/Tokyo&rewriteBatchedStatements=true&useLocalTransactionState=true&socketTimeout=60000&allowPublicKeyRetrieval=true&useSSL=false"
            }
            this.username = username
            this.password = password
            driverClassName = "com.mysql.cj.jdbc.Driver"
            maximumPoolSize = 10
            minimumIdle = 5
            idleTimeout = 300000
            connectionTimeout = 60000
            maxLifetime = 1800000
            this.poolName = poolName
            isAutoCommit = false
            transactionIsolation = "TRANSACTION_READ_COMMITTED"
            leakDetectionThreshold = 60000
            validationTimeout = 5000
            initializationFailTimeout = -1
        }
    }

    private fun createDslContext(dataSource: DataSource): DSLContext {
        val config = DefaultConfiguration()
            .set(dataSource)
            .set(SQLDialect.MYSQL)
            .set(org.jooq.conf.Settings().withRenderSchema(false))

        return DSL.using(config)
    }

    @PostConstruct
    fun initDatabase() {
        val databases = listOf(
            "organization_db_test",
            "code_master_db_test",
            "document_db_test",
            "framework_db_test",
            "audit_db_test",
            "training_db_test"
        )

        val adminDataSource = createHikariDataSource(
            url = "jdbc:mysql://localhost:3307",
            username = "root",
            password = "root",
            poolName = "HikariPool-admin"
        )

        val jdbcTemplate = JdbcTemplate(adminDataSource)

        // データベースの作成
        databases.forEach { dbName ->
            jdbcTemplate.execute("DROP DATABASE IF EXISTS $dbName")
            jdbcTemplate.execute("""
                CREATE DATABASE $dbName
                CHARACTER SET utf8mb4 
                COLLATE utf8mb4_unicode_ci
            """)
        }

        // Flywayマイグレーションの実行
        databases.forEach { dbName ->
            val dataSource = when (dbName) {
                "organization_db_test" -> organizationTestDataSource()
                "code_master_db_test" -> codeMasterTestDataSource()
                "document_db_test" -> documentTestDataSource()
                "framework_db_test" -> frameworkTestDataSource()
                "audit_db_test" -> auditTestDataSource()
                "training_db_test" -> trainingTestDataSource()
                else -> throw IllegalArgumentException("Unknown database: $dbName")
            }

            val migrationLocation = when (dbName) {
                "organization_db_test" -> "organization_db"
                "code_master_db_test" -> "code_master_db"
                "document_db_test" -> "document_db"
                "framework_db_test" -> "framework_db"
                "audit_db_test" -> "audit_db"
                "training_db_test" -> "training_db"
                else -> throw IllegalArgumentException("Unknown database: $dbName")
            }

            val flyway = Flyway.configure()
                .dataSource(dataSource)
                .locations(
                    "classpath:db/migration/$migrationLocation",
                    "classpath:db/testmigration/$migrationLocation"
                )
                .baselineOnMigrate(true)
                .baselineVersion("0")
                .cleanDisabled(false)
                .load()

            flyway.clean()
            flyway.migrate()
        }

        adminDataSource.close()
    }
} 