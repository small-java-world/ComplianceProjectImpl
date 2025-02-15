package com.example.project.code.domain.repository

import com.example.project.code.domain.model.MCode
import java.time.LocalDateTime

interface MCodeRepository {
    fun findAll(): List<MCode>
    fun findByUpdatedAtAfter(since: LocalDateTime): List<MCode>
    fun findByCodeCategory(category: String): List<MCode>
    fun findByCodeCategoryAndCode(category: String, code: String): MCode?
    fun save(mCode: MCode): MCode
    fun update(mCode: MCode): MCode
    fun delete(category: String, code: String)
} 