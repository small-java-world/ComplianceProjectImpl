package com.example.project.config

import com.example.project.code.infrastructure.repository.CodeRepositoryImpl
import com.example.project.code.infrastructure.repository.MCodeRepositoryImpl
import com.example.project.organization.infrastructure.repository.PermissionRepositoryImpl
import org.jooq.DSLContext
import org.jooq.SQLDialect
import org.jooq.impl.DSL
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.context.annotation.Primary
import org.springframework.context.annotation.Profile
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.jdbc.datasource.DriverManagerDataSource
import javax.sql.DataSource
import jakarta.annotation.PostConstruct
import org.flywaydb.core.Flyway

@Configuration
@Profile("test")
class TestConfig {

    @Bean
    @Primary
    fun testDataSource(): DataSource {
        return DriverManagerDataSource().apply {
            setDriverClassName("com.mysql.cj.jdbc.Driver")
            url = "jdbc:mysql://localhost:3307/organization_db_test"
            username = "root"
            password = "root"
        }
    }

    @Bean
    @Primary
    fun testDslContext(dataSource: DataSource): DSLContext {
        return DSL.using(dataSource, SQLDialect.MYSQL)
    }

    @Bean
    @Primary
    fun testJdbcTemplate(dataSource: DataSource): JdbcTemplate {
        return JdbcTemplate(dataSource)
    }

    @Bean
    fun permissionRepositoryImpl(dslContext: DSLContext): PermissionRepositoryImpl {
        return PermissionRepositoryImpl(dslContext)
    }

    @Bean
    fun codeRepositoryImpl(dslContext: DSLContext): CodeRepositoryImpl {
        return CodeRepositoryImpl(dslContext)
    }

    @Bean
    fun mCodeRepositoryImpl(dslContext: DSLContext): MCodeRepositoryImpl {
        return MCodeRepositoryImpl(dslContext)
    }

    @PostConstruct
    fun initDatabase() {
        val dataSource = testDataSource()
        val jdbcTemplate = JdbcTemplate(dataSource)
        
        // データベースの作成
        jdbcTemplate.execute("""
            CREATE DATABASE IF NOT EXISTS organization_db_test
            CHARACTER SET utf8mb4 
            COLLATE utf8mb4_unicode_ci
        """)

        // Flywayマイグレーションの実行
        val flyway = Flyway.configure()
            .dataSource(dataSource)
            .locations(
                "classpath:db/migration/organization_db",
                "classpath:db/testmigration/organization_db"
            )
            .baselineOnMigrate(true)
            .baselineVersion("0")
            .load()

        flyway.repair()
        flyway.migrate()
    }
} 