package com.example.project.config

import org.jooq.DSLContext
import org.jooq.SQLDialect
import org.jooq.impl.DSL
import org.jooq.impl.DefaultConfiguration
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import javax.sql.DataSource

@Configuration
class JooqConfig {
    @Bean
    fun dslContext(dataSource: DataSource): DSLContext {
        val config = DefaultConfiguration().apply {
            set(dataSource)
            set(SQLDialect.MYSQL)
        }
        return DSL.using(config)
    }
} 