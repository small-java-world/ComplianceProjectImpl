package com.example.project.infrastructure.config

import io.github.oshai.kotlinlogging.KotlinLogging
import org.springframework.context.annotation.Configuration
import org.springframework.context.annotation.Profile
import jakarta.annotation.PostConstruct
import java.io.File

private val logger = KotlinLogging.logger {}

@Configuration
@Profile("local")
class EnvConfig {

    @PostConstruct
    fun loadEnvFile() {
        val envFile = File(".env")
        if (envFile.exists()) {
            logger.info { "Loading environment variables from .env file" }
            envFile.readLines()
                .filter { it.isNotBlank() && !it.startsWith("#") }
                .forEach { line ->
                    val (key, value) = line.split("=", limit = 2)
                    System.setProperty(key.trim(), value.trim())
                }
        } else {
            logger.warn { ".env file not found in local profile" }
        }
    }
} 