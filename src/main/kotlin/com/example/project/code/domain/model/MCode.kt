package com.example.project.code.domain.model

import java.time.LocalDateTime

data class MCode(
    val codeId: Long,
    val codeCategory: String,
    val code: String,
    val name: String,
    val description: String?,
    val displayOrder: Int,
    val isActive: Boolean,
    val createdAt: LocalDateTime,
    val updatedAt: LocalDateTime
) 