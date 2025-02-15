package com.example.project.code.domain.model

import java.time.LocalDateTime

data class MCode(
    val codeCategory: String,
    val code: String,
    val codeDivision: String,
    val name: String,
    val codeShortName: String?,
    val displayOrder: Int,
    val isActive: Boolean,
    val description: String?,
    val createdAt: LocalDateTime,
    val updatedAt: LocalDateTime
) 