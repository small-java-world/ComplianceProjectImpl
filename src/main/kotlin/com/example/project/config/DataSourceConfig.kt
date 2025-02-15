package com.example.project.config

import com.zaxxer.hikari.HikariDataSource
import org.jooq.DSLContext
import org.jooq.SQLDialect
import org.jooq.impl.DSL
import org.jooq.impl.DefaultConfiguration
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.boot.context.properties.EnableConfigurationProperties
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.context.annotation.Primary
import javax.sql.DataSource

@Configuration
@EnableConfigurationProperties(DataSourceProperties::class)
class DataSourceConfig(
    private val properties: DataSourceProperties
) {
    @Bean
    @Primary
    @Qualifier("organizationDataSource")
    fun organizationDataSource(): DataSource {
        return createHikariDataSource(
            properties.organization,
            properties.pool,
            "HikariPool-organization"
        )
    }

    @Bean
    @Qualifier("codeMasterDataSource")
    fun codeMasterDataSource(): DataSource {
        return createHikariDataSource(
            properties.codeMaster,
            properties.pool,
            "HikariPool-code-master"
        )
    }

    @Bean
    @Qualifier("documentDataSource")
    fun documentDataSource(): DataSource {
        return createHikariDataSource(
            properties.document,
            properties.pool,
            "HikariPool-document"
        )
    }

    @Bean
    @Qualifier("frameworkDataSource")
    fun frameworkDataSource(): DataSource {
        return createHikariDataSource(
            properties.framework,
            properties.pool,
            "HikariPool-framework"
        )
    }

    @Bean
    @Qualifier("auditDataSource")
    fun auditDataSource(): DataSource {
        return createHikariDataSource(
            properties.audit,
            properties.pool,
            "HikariPool-audit"
        )
    }

    @Bean
    @Qualifier("trainingDataSource")
    fun trainingDataSource(): DataSource {
        return createHikariDataSource(
            properties.training,
            properties.pool,
            "HikariPool-training"
        )
    }

    @Bean
    @Primary
    @Qualifier("organizationDslContext")
    fun organizationDslContext(@Qualifier("organizationDataSource") dataSource: DataSource): DSLContext {
        return createDslContext(dataSource)
    }

    @Bean
    @Qualifier("codeMasterDslContext")
    fun codeMasterDslContext(@Qualifier("codeMasterDataSource") dataSource: DataSource): DSLContext {
        return createDslContext(dataSource)
    }

    @Bean
    @Qualifier("documentDslContext")
    fun documentDslContext(@Qualifier("documentDataSource") dataSource: DataSource): DSLContext {
        return createDslContext(dataSource)
    }

    @Bean
    @Qualifier("frameworkDslContext")
    fun frameworkDslContext(@Qualifier("frameworkDataSource") dataSource: DataSource): DSLContext {
        return createDslContext(dataSource)
    }

    @Bean
    @Qualifier("auditDslContext")
    fun auditDslContext(@Qualifier("auditDataSource") dataSource: DataSource): DSLContext {
        return createDslContext(dataSource)
    }

    @Bean
    @Qualifier("trainingDslContext")
    fun trainingDslContext(@Qualifier("trainingDataSource") dataSource: DataSource): DSLContext {
        return createDslContext(dataSource)
    }

    private fun createHikariDataSource(
        dbConfig: DbConfig,
        poolConfig: PoolConfig,
        poolName: String
    ): HikariDataSource {
        return HikariDataSource().apply {
            jdbcUrl = if (dbConfig.url.contains("?")) {
                "${dbConfig.url}&serverTimezone=Asia/Tokyo"
            } else {
                "${dbConfig.url}?serverTimezone=Asia/Tokyo"
            }
            username = dbConfig.username
            password = dbConfig.password
            driverClassName = dbConfig.driverClassName
            maximumPoolSize = poolConfig.maximumPoolSize
            minimumIdle = poolConfig.minimumIdle
            idleTimeout = poolConfig.idleTimeout
            connectionTimeout = poolConfig.connectionTimeout
            maxLifetime = poolConfig.maxLifetime
            this.poolName = poolName
        }
    }

    private fun createDslContext(dataSource: DataSource): DSLContext {
        val config = DefaultConfiguration()
            .set(dataSource)
            .set(SQLDialect.MYSQL)
            .set(object : org.jooq.conf.Settings() {
                init {
                    withRenderSchema(false)
                }
            })

        return DSL.using(config)
    }
}

@ConfigurationProperties(prefix = "spring.datasource")
data class DataSourceProperties(
    val organization: DbConfig = DbConfig(),
    val codeMaster: DbConfig = DbConfig(),
    val document: DbConfig = DbConfig(),
    val framework: DbConfig = DbConfig(),
    val audit: DbConfig = DbConfig(),
    val training: DbConfig = DbConfig(),
    val pool: PoolConfig = PoolConfig()
)

data class DbConfig(
    val url: String = "",
    val username: String = "",
    val password: String = "",
    val driverClassName: String = "com.mysql.cj.jdbc.Driver"
)

data class PoolConfig(
    val maximumPoolSize: Int = 10,
    val minimumIdle: Int = 5,
    val idleTimeout: Long = 300000,
    val connectionTimeout: Long = 20000,
    val maxLifetime: Long = 1200000
) 