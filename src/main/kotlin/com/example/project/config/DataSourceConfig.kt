package com.example.project.config

import org.springframework.boot.jdbc.DataSourceBuilder
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.context.annotation.Profile
import javax.sql.DataSource

@Configuration
class DataSourceConfig {
    @Bean
    @Profile("test")
    fun testDataSource(): DataSource {
        return DataSourceBuilder.create()
            .url("jdbc:mysql://localhost:3307/organization_db_test")
            .username("root")
            .password("root")
            .driverClassName("com.mysql.cj.jdbc.Driver")
            .build()
    }

    @Bean
    @Profile("!test")
    fun dataSource(): DataSource {
        return DataSourceBuilder.create()
            .url("jdbc:mysql://localhost:3307/organization_db")
            .username("root")
            .password("root")
            .driverClassName("com.mysql.cj.jdbc.Driver")
            .build()
    }
} 