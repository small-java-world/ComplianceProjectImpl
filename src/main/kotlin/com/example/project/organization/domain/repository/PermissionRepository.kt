package com.example.project.organization.domain.repository

import com.example.project.organization.domain.model.Permission

interface PermissionRepository {
    fun findById(permissionDetailId: Long): Permission?
    fun findByUserId(userId: String): List<Permission>
    fun save(permission: Permission): Permission
    fun update(permission: Permission): Permission
    fun delete(permissionDetailId: Long)
} 