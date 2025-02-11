package com.example.project.code.domain.model

import java.time.LocalDateTime

data class Code(
    val codeCategory: String,
    val code: String,
    val codeDivision: String,
    val codeName: String,
    val codeShortName: String?,
    val extension1: String?,
    val extension2: String?,
    val extension3: String?,
    val extension4: String?,
    val extension5: String?,
    val extension6: String?,
    val extension7: String?,
    val extension8: String?,
    val extension9: String?,
    val extension10: String?,
    val extension11: String?,
    val extension12: String?,
    val extension13: String?,
    val extension14: String?,
    val extension15: String?,
    val displayOrder: Int,
    val isActive: Boolean,
    val description: String?,
    val createdAt: LocalDateTime,
    val updatedAt: LocalDateTime
) 