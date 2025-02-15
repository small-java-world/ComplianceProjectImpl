package com.example.project.organization.domain.model.vo

enum class DepartmentScope(val value: String) {
    ANY_DEPT("ANY_DEPT"),    // 全部門にアクセス可能
    OWN_DEPT("OWN_DEPT"),    // 自部門のみアクセス可能
    SPECIFIC("SPECIFIC");    // 特定の部門のみアクセス可能

    companion object {
        fun fromValue(value: String): DepartmentScope {
            return values().find { it.value == value }
                ?: throw IllegalArgumentException("Invalid department scope value: $value")
        }

        fun isDepartmentCode(value: String): Boolean = value.startsWith("DEPT_")
    }
} 