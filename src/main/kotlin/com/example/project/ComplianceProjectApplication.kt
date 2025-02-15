package com.example.project

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.transaction.annotation.EnableTransactionManagement
import org.springframework.context.annotation.ComponentScan

@SpringBootApplication
@EnableTransactionManagement
@ComponentScan(
    basePackages = ["com.example.project"]
)
class ComplianceProjectApplication

fun main(args: Array<String>) {
    runApplication<ComplianceProjectApplication>(*args)
} 