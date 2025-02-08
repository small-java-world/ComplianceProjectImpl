package com.example.project.code.infrastructure.config

import org.springframework.boot.test.context.TestConfiguration
import org.springframework.context.annotation.Bean
import org.springframework.jdbc.core.JdbcTemplate
import javax.sql.DataSource
import org.springframework.boot.test.context.TestComponent
import org.springframework.context.annotation.Profile
import jakarta.annotation.PostConstruct
import org.flywaydb.core.Flyway

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

        // Flywayの設定と実行
        val flyway = Flyway.configure()
            .dataSource(
                "jdbc:mysql://localhost:3306/compliance_management_system_test?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8&useUnicode=true",
                "root",
                "root"
            )
            .locations("classpath:db/migration")
            .load()

        // repairとmigrateを実行
        flyway.repair()
        flyway.migrate()
    }
} 