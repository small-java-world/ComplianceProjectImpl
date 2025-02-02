package com.example.project.code.domain.model

import java.time.LocalDateTime

data class MCode(
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
    val createdAt: LocalDateTime,
    val updatedAt: LocalDateTime
) 