package com.example.project.organization.domain.model

import com.example.project.organization.domain.model.vo.DepartmentScope
import java.time.LocalDateTime

data class Permission(
    val permissionDetailId: Long,
    val permissionId: String,
    val userId: String,
    val permissionType: String,
    val targetId: String?,
    val accessLevel: String,
    val departmentScope: DepartmentScope,
    val specificDepartments: List<String> = emptyList(),
    val createdAt: LocalDateTime = LocalDateTime.now(),
    val updatedAt: LocalDateTime = LocalDateTime.now()
) {
    fun canAccess(targetDepartmentId: String, userDepartmentId: String): Boolean {
        return when (departmentScope) {
            DepartmentScope.ANY_DEPT -> true
            DepartmentScope.OWN_DEPT -> isSameOrSubDepartment(userDepartmentId, targetDepartmentId)
            DepartmentScope.SPECIFIC -> specificDepartments.contains(targetDepartmentId)
        }
    }

    private fun isSameOrSubDepartment(userDepartmentId: String, targetDepartmentId: String): Boolean {
        // 現時点では単純な一致チェックのみ実装
        // TODO: 組織階層チェックロジックの実装
        return userDepartmentId == targetDepartmentId
    }
} 