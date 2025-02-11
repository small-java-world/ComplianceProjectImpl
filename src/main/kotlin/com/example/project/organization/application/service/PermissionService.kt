package com.example.project.organization.application.service

import com.example.project.organization.domain.model.Permission
import com.example.project.organization.domain.model.vo.DepartmentScope
import com.example.project.organization.domain.repository.PermissionRepository
import com.example.project.organization.domain.repository.PermissionDepartmentRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class PermissionService(
    private val permissionRepository: PermissionRepository,
    private val permissionDepartmentRepository: PermissionDepartmentRepository
) {
    @Transactional(readOnly = true)
    fun findUserPermissions(userId: String): List<Permission> {
        return permissionRepository.findByUserId(userId).map { permission ->
            if (permission.departmentScope == DepartmentScope.SPECIFIC) {
                permission.copy(
                    specificDepartments = permissionDepartmentRepository
                        .findByPermissionDetailId(permission.permissionDetailId)
                )
            } else {
                permission
            }
        }
    }

    @Transactional
    fun createPermission(permission: Permission): Permission {
        val savedPermission = permissionRepository.save(permission)
        
        if (permission.departmentScope == DepartmentScope.SPECIFIC) {
            permissionDepartmentRepository.save(
                savedPermission.permissionDetailId,
                permission.specificDepartments
            )
        }
        
        return savedPermission
    }

    @Transactional
    fun updatePermission(permission: Permission): Permission {
        val updatedPermission = permissionRepository.update(permission)
        
        if (permission.departmentScope == DepartmentScope.SPECIFIC) {
            permissionDepartmentRepository.delete(permission.permissionDetailId)
            permissionDepartmentRepository.save(
                permission.permissionDetailId,
                permission.specificDepartments
            )
        }
        
        return updatedPermission
    }

    @Transactional
    fun deletePermission(permissionDetailId: Long) {
        permissionDepartmentRepository.delete(permissionDetailId)
        permissionRepository.delete(permissionDetailId)
    }

    @Transactional(readOnly = true)
    fun hasPermission(
        userId: String,
        permissionType: String,
        targetId: String?,
        accessLevel: String,
        departmentId: String,
        userDepartmentId: String
    ): Boolean {
        return permissionRepository.findByUserId(userId)
            .filter { it.permissionType == permissionType }
            .filter { it.targetId == targetId }
            .filter { it.accessLevel == accessLevel }
            .any { permission ->
                when (permission.departmentScope) {
                    DepartmentScope.ANY_DEPT -> true
                    DepartmentScope.OWN_DEPT -> permission.canAccess(departmentId, userDepartmentId)
                    DepartmentScope.SPECIFIC -> {
                        val specificDepartments = permissionDepartmentRepository
                            .findByPermissionDetailId(permission.permissionDetailId)
                        permission.copy(specificDepartments = specificDepartments)
                            .canAccess(departmentId, userDepartmentId)
                    }
                }
            }
    }
} 