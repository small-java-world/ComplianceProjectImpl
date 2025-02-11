package com.example.project.code.domain.repository

import com.example.project.code.domain.model.Code

interface CodeRepository {
    fun findByCodeCategory(codeCategory: String): List<Code>
    fun findByCodeCategoryAndCode(codeCategory: String, code: String): Code?
    fun save(code: Code): Code
    fun update(code: Code): Code
    fun delete(codeCategory: String, code: String)
} 