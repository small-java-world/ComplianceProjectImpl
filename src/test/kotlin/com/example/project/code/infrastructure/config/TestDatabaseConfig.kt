package com.example.project.code.infrastructure.config

import org.springframework.boot.test.context.TestConfiguration
import org.springframework.context.annotation.Bean
import org.springframework.jdbc.core.JdbcTemplate
import javax.sql.DataSource
import org.springframework.boot.test.context.TestComponent
import org.springframework.context.annotation.Profile
import jakarta.annotation.PostConstruct

@TestConfiguration
@Profile("test")
class TestDatabaseConfig(private val dataSource: DataSource) {

    @PostConstruct
    fun init() {
        val jdbcTemplate = JdbcTemplate(dataSource)
        
        // データベースの文字セットを設定
        jdbcTemplate.execute("""
            ALTER DATABASE compliance_management_system_test 
            CHARACTER SET utf8mb4 
            COLLATE utf8mb4_unicode_ci
        """)
        
        // テーブルの文字セットを設定
        jdbcTemplate.execute("""
            ALTER TABLE m_code 
            CONVERT TO CHARACTER SET utf8mb4 
            COLLATE utf8mb4_unicode_ci
        """)
    }
} 