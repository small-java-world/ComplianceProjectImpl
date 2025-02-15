package com.example.project.code.domain.repository

import com.example.project.code.domain.model.Code
import java.time.LocalDateTime

interface CodeRepository {
    fun findAll(): List<Code>
    fun findByUpdatedAtAfter(updatedAt: LocalDateTime): List<Code>
    fun findByCategory(category: String): List<Code>
    fun findByCategoryAndCode(category: String, code: String): Code?
    fun save(code: Code): Code
    fun update(code: Code): Code
    fun delete(category: String, code: String)
} 