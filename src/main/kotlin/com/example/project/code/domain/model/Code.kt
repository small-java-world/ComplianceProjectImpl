package com.example.project.code.domain.model

import java.time.LocalDateTime

data class Code(
    val codeCategory: String,
    val code: String,
    val codeDivision: String,
    val name: String,
    val codeShortName: String?,
    val description: String?,
    val displayOrder: Int,
    val isActive: Boolean,
    val extension1: String? = null,
    val extension2: String? = null,
    val extension3: String? = null,
    val extension4: String? = null,
    val extension5: String? = null,
    val extension6: String? = null,
    val extension7: String? = null,
    val extension8: String? = null,
    val extension9: String? = null,
    val extension10: String? = null,
    val extension11: String? = null,
    val extension12: String? = null,
    val extension13: String? = null,
    val extension14: String? = null,
    val extension15: String? = null,
    val createdAt: LocalDateTime = LocalDateTime.now(),
    val updatedAt: LocalDateTime = LocalDateTime.now()
) 