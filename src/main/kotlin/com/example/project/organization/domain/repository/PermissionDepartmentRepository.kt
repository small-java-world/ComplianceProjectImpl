package com.example.project.organization.domain.repository

interface PermissionDepartmentRepository {
    fun findByPermissionDetailId(permissionDetailId: Long): List<String>
    fun save(permissionDetailId: Long, departmentIds: List<String>)
    fun delete(permissionDetailId: Long)
} 