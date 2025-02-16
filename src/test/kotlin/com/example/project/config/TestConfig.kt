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
import org.springframework.transaction.support.TransactionTemplate

@Configuration
@Profile("test")
@EnableTransactionManagement(proxyTargetClass = true)
class TestConfig {

    @Bean
    @Primary
    @Qualifier("organizationDataSource")
    fun organizationTestDataSource(): DataSource {
        return createHikariDataSource(
            url = "jdbc:mysql://localhost:3307/organization_db_test?characterEncoding=UTF-8&useUnicode=yes&characterSetResults=UTF-8&useSSL=false&allowPublicKeyRetrieval=true&rewriteBatchedStatements=true&socketTimeout=10000&connectTimeout=10000&autoReconnect=false",
            username = "root",
            password = "root",
            poolName = "HikariPool-organization-test"
        )
    }

    @Bean
    @Qualifier("codeMasterDataSource")
    fun codeMasterTestDataSource(): DataSource {
        return createHikariDataSource(
            url = "jdbc:mysql://localhost:3307/code_master_db_test?characterEncoding=UTF-8&useUnicode=yes&characterSetResults=UTF-8&useSSL=false&allowPublicKeyRetrieval=true&rewriteBatchedStatements=true&socketTimeout=10000&connectTimeout=10000&autoReconnect=false",
            username = "root",
            password = "root",
            poolName = "HikariPool-code-master-test"
        )
    }

    @Bean
    @Qualifier("documentDataSource")
    fun documentTestDataSource(): DataSource {
        return createHikariDataSource(
            url = "jdbc:mysql://localhost:3307/document_db_test?characterEncoding=UTF-8&useUnicode=yes&characterSetResults=UTF-8&useSSL=false&allowPublicKeyRetrieval=true&rewriteBatchedStatements=true&socketTimeout=10000&connectTimeout=10000&autoReconnect=false",
            username = "root",
            password = "root",
            poolName = "HikariPool-document-test"
        )
    }

    @Bean
    @Qualifier("frameworkDataSource")
    fun frameworkTestDataSource(): DataSource {
        return createHikariDataSource(
            url = "jdbc:mysql://localhost:3307/framework_db_test?characterEncoding=UTF-8&useUnicode=yes&characterSetResults=UTF-8&useSSL=false&allowPublicKeyRetrieval=true&rewriteBatchedStatements=true&socketTimeout=10000&connectTimeout=10000&autoReconnect=false",
            username = "root",
            password = "root",
            poolName = "HikariPool-framework-test"
        )
    }

    @Bean
    @Qualifier("auditDataSource")
    fun auditTestDataSource(): DataSource {
        return createHikariDataSource(
            url = "jdbc:mysql://localhost:3307/audit_db_test?characterEncoding=UTF-8&useUnicode=yes&characterSetResults=UTF-8&useSSL=false&allowPublicKeyRetrieval=true&rewriteBatchedStatements=true&socketTimeout=10000&connectTimeout=10000&autoReconnect=false",
            username = "root",
            password = "root",
            poolName = "HikariPool-audit-test"
        )
    }

    @Bean
    @Qualifier("trainingDataSource")
    fun trainingTestDataSource(): DataSource {
        return createHikariDataSource(
            url = "jdbc:mysql://localhost:3307/training_db_test?characterEncoding=UTF-8&useUnicode=yes&characterSetResults=UTF-8&useSSL=false&allowPublicKeyRetrieval=true&rewriteBatchedStatements=true&socketTimeout=10000&connectTimeout=10000&autoReconnect=false",
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
        return DataSourceTransactionManager(dataSource).apply {
            isRollbackOnCommitFailure = true
            defaultTimeout = 30
            isValidateExistingTransaction = true
            isGlobalRollbackOnParticipationFailure = true
            isNestedTransactionAllowed = true
        }
    }

    @Bean
    @Qualifier("codeMasterTransactionManager")
    fun codeMasterTransactionManager(@Qualifier("codeMasterDataSource") dataSource: DataSource): PlatformTransactionManager {
        return DataSourceTransactionManager(dataSource).apply {
            isRollbackOnCommitFailure = true
            defaultTimeout = 30
            isValidateExistingTransaction = true
            isGlobalRollbackOnParticipationFailure = true
            isNestedTransactionAllowed = true
        }
    }

    @Bean
    @Qualifier("codeMasterTransactionTemplate")
    fun codeMasterTransactionTemplate(
        @Qualifier("codeMasterTransactionManager") transactionManager: PlatformTransactionManager
    ): TransactionTemplate {
        return TransactionTemplate(transactionManager).apply {
            timeout = 30
            isReadOnly = false
        }
    }

    @Bean
    @Qualifier("documentTransactionManager")
    fun documentTransactionManager(@Qualifier("documentDataSource") dataSource: DataSource): PlatformTransactionManager {
        return DataSourceTransactionManager(dataSource).apply {
            isRollbackOnCommitFailure = true
            defaultTimeout = 10
            isValidateExistingTransaction = true
            isGlobalRollbackOnParticipationFailure = true
            isNestedTransactionAllowed = true
        }
    }

    @Bean
    @Qualifier("frameworkTransactionManager")
    fun frameworkTransactionManager(@Qualifier("frameworkDataSource") dataSource: DataSource): PlatformTransactionManager {
        return DataSourceTransactionManager(dataSource).apply {
            isRollbackOnCommitFailure = true
            defaultTimeout = 10
            isValidateExistingTransaction = true
            isGlobalRollbackOnParticipationFailure = true
            isNestedTransactionAllowed = true
        }
    }

    @Bean
    @Qualifier("auditTransactionManager")
    fun auditTransactionManager(@Qualifier("auditDataSource") dataSource: DataSource): PlatformTransactionManager {
        return DataSourceTransactionManager(dataSource).apply {
            isRollbackOnCommitFailure = true
            defaultTimeout = 10
            isValidateExistingTransaction = true
            isGlobalRollbackOnParticipationFailure = true
            isNestedTransactionAllowed = true
        }
    }

    @Bean
    @Qualifier("trainingTransactionManager")
    fun trainingTransactionManager(@Qualifier("trainingDataSource") dataSource: DataSource): PlatformTransactionManager {
        return DataSourceTransactionManager(dataSource).apply {
            isRollbackOnCommitFailure = true
            defaultTimeout = 10
            isValidateExistingTransaction = true
            isGlobalRollbackOnParticipationFailure = true
            isNestedTransactionAllowed = true
        }
    }

    private fun createHikariDataSource(
        url: String,
        username: String,
        password: String,
        poolName: String
    ): HikariDataSource {
        return HikariDataSource().apply {
            jdbcUrl = url
            this.username = username
            this.password = password
            driverClassName = "com.mysql.cj.jdbc.Driver"
            maximumPoolSize = 5
            minimumIdle = 2
            idleTimeout = 30000
            connectionTimeout = 20000
            maxLifetime = 60000
            this.poolName = poolName
            isAutoCommit = false
            transactionIsolation = "TRANSACTION_READ_COMMITTED"
            leakDetectionThreshold = 30000
            validationTimeout = 5000
            initializationFailTimeout = -1
            isIsolateInternalQueries = true
            isRegisterMbeans = false
            keepaliveTime = 30000
            connectionTestQuery = "SELECT 1"
        }
    }

    private fun createDslContext(dataSource: DataSource): DSLContext {
        val config = DefaultConfiguration()
            .set(dataSource)
            .set(SQLDialect.MYSQL)
            .set(org.jooq.conf.Settings()
                .withRenderSchema(false)
                .withExecuteLogging(true)
                .withExecuteWithOptimisticLocking(true)
                .withExecuteWithOptimisticLockingExcludeUnversioned(false)
            )

        return DSL.using(config)
    }

    @PostConstruct
    fun migrateTestDatabases() {
        // Code Master DB
        Flyway.configure()
            .dataSource(codeMasterTestDataSource())
            .locations(
                "classpath:db/migration/code_master_db",
                "classpath:db/migration/code_master_db_test",
                "classpath:db/testmigration/code_master_db_test"
            )
            .baselineOnMigrate(true)
            .outOfOrder(true)
            .validateOnMigrate(false)
            .load()
            .migrate()

        // Organization DB
        Flyway.configure()
            .dataSource(organizationTestDataSource())
            .locations("classpath:db/migration/organization_db")
            .baselineOnMigrate(true)
            .outOfOrder(true)
            .validateOnMigrate(false)
            .load()
            .migrate()

        // Document DB
        Flyway.configure()
            .dataSource(documentTestDataSource())
            .locations("classpath:db/migration/document_db")
            .baselineOnMigrate(true)
            .outOfOrder(true)
            .validateOnMigrate(false)
            .load()
            .migrate()

        // Framework DB
        Flyway.configure()
            .dataSource(frameworkTestDataSource())
            .locations("classpath:db/migration/framework_db")
            .baselineOnMigrate(true)
            .outOfOrder(true)
            .validateOnMigrate(false)
            .load()
            .migrate()

        // Audit DB
        Flyway.configure()
            .dataSource(auditTestDataSource())
            .locations("classpath:db/migration/audit_db")
            .baselineOnMigrate(true)
            .outOfOrder(true)
            .validateOnMigrate(false)
            .load()
            .migrate()

        // Training DB
        Flyway.configure()
            .dataSource(trainingTestDataSource())
            .locations("classpath:db/migration/training_db")
            .baselineOnMigrate(true)
            .outOfOrder(true)
            .validateOnMigrate(false)
            .load()
            .migrate()
    }
} 