package com.example.project.organization.domain.model.vo

enum class DepartmentScope(val value: String) {
    ANY_DEPT("ANY_DEPT"),
    OWN_DEPT("OWN_DEPT"),
    SPECIFIC("SPECIFIC");

    companion object {
        fun fromValue(value: String): DepartmentScope {
            return if (value.startsWith("DEPT_")) {
                SPECIFIC
            } else {
                values().find { it.value == value }
                    ?: throw IllegalArgumentException("Invalid department scope: $value")
            }
        }

        fun isDepartmentCode(value: String): Boolean = value.startsWith("DEPT_")
    }
} 