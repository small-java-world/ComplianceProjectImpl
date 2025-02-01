package com.example.project.infrastructure.config

import org.jooq.SQLDialect
import org.jooq.impl.DataSourceConnectionProvider
import org.jooq.impl.DefaultConfiguration
import org.jooq.impl.DefaultDSLContext
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.jdbc.datasource.TransactionAwareDataSourceProxy
import javax.sql.DataSource

@Configuration
class JooqConfig {

    @Bean
    fun connectionProvider(dataSource: DataSource) =
        DataSourceConnectionProvider(TransactionAwareDataSourceProxy(dataSource))

    @Bean
    fun dsl(dataSource: DataSource) = DefaultDSLContext(configuration(dataSource))

    private fun configuration(dataSource: DataSource): DefaultConfiguration {
        val jooqConfiguration = DefaultConfiguration()
        val connectionProvider = connectionProvider(dataSource)
        
        return jooqConfiguration.apply {
            set(connectionProvider)
            set(SQLDialect.MYSQL)
        }
    }
} 