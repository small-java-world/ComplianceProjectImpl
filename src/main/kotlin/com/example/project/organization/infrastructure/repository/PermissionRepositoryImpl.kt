package com.example.project.organization.infrastructure.repository

import com.example.project.organization.domain.model.Permission
import com.example.project.organization.domain.model.vo.DepartmentScope
import com.example.project.organization.domain.repository.PermissionRepository
import org.jooq.DSLContext
import org.jooq.impl.DSL
import org.springframework.stereotype.Repository
import org.springframework.transaction.annotation.Transactional
import java.time.LocalDateTime

@Repository
@Transactional
class PermissionRepositoryImpl(
    private val dsl: DSLContext
) : PermissionRepository {

    override fun findById(permissionDetailId: Long): Permission? {
        val result = dsl.select()
            .from("permission_detail")
            .leftJoin("permission_detail_department")
            .on("permission_detail.permission_detail_id = permission_detail_department.permission_detail_id")
            .where("permission_detail.permission_detail_id = ?", permissionDetailId)
            .fetch()

        if (result.isEmpty()) return null

        val record = result.first()
        val departmentIds = result.mapNotNull { it.get("department_id", String::class.java) }

        return Permission(
            permissionDetailId = record.get("permission_detail_id", Long::class.java),
            permissionId = record.get("permission_id", String::class.java),
            userId = record.get("user_id", String::class.java),
            permissionType = record.get("permission_type", String::class.java),
            targetId = record.get("target_id", String::class.java),
            accessLevel = record.get("access_level", String::class.java),
            departmentScope = DepartmentScope.fromValue(record.get("department_scope", String::class.java)),
            specificDepartments = departmentIds,
            createdAt = record.get("created_at", LocalDateTime::class.java),
            updatedAt = record.get("updated_at", LocalDateTime::class.java)
        )
    }

    override fun findByUserId(userId: String): List<Permission> {
        val result = dsl.select()
            .from("permission_detail")
            .leftJoin("permission_detail_department")
            .on("permission_detail.permission_detail_id = permission_detail_department.permission_detail_id")
            .where("permission_detail.user_id = ?", userId)
            .fetch()

        return result.intoGroups { it.get("permission_detail_id") }
            .map { (_, records) ->
                val record = records.first()
                val departmentIds = records.mapNotNull { it.get("department_id", String::class.java) }

                Permission(
                    permissionDetailId = record.get("permission_detail_id", Long::class.java),
                    permissionId = record.get("permission_id", String::class.java),
                    userId = record.get("user_id", String::class.java),
                    permissionType = record.get("permission_type", String::class.java),
                    targetId = record.get("target_id", String::class.java),
                    accessLevel = record.get("access_level", String::class.java),
                    departmentScope = DepartmentScope.fromValue(record.get("department_scope", String::class.java)),
                    specificDepartments = departmentIds,
                    createdAt = record.get("created_at", LocalDateTime::class.java),
                    updatedAt = record.get("updated_at", LocalDateTime::class.java)
                )
            }
    }

    override fun save(permission: Permission): Permission {
        val now = LocalDateTime.now()
        
        val permissionDetailId = dsl.insertInto(DSL.table("permission_detail"))
            .columns(
                DSL.field("permission_id"),
                DSL.field("user_id"),
                DSL.field("permission_type"),
                DSL.field("target_id"),
                DSL.field("access_level"),
                DSL.field("department_scope"),
                DSL.field("created_at"),
                DSL.field("updated_at")
            )
            .values(
                permission.permissionId,
                permission.userId,
                permission.permissionType,
                permission.targetId,
                permission.accessLevel,
                permission.departmentScope.value,
                now,
                now
            )
            .returningResult(DSL.field("permission_detail_id", Long::class.java))
            .fetchOne()
            ?.value1()
            ?: throw IllegalStateException("Failed to get generated permission_detail_id")

        if (permission.departmentScope == DepartmentScope.SPECIFIC) {
            permission.specificDepartments.forEach { departmentId ->
                dsl.insertInto(DSL.table("permission_detail_department"))
                    .columns(
                        DSL.field("permission_detail_id"),
                        DSL.field("department_id")
                    )
                    .values(
                        permissionDetailId,
                        departmentId
                    )
                    .execute()
            }
        }

        return permission.copy(permissionDetailId = permissionDetailId)
    }

    override fun update(permission: Permission): Permission {
        val now = LocalDateTime.now()
        
        dsl.update(DSL.table("permission_detail"))
            .set(DSL.field("permission_id"), permission.permissionId)
            .set(DSL.field("user_id"), permission.userId)
            .set(DSL.field("permission_type"), permission.permissionType)
            .set(DSL.field("target_id"), permission.targetId)
            .set(DSL.field("access_level"), permission.accessLevel)
            .set(DSL.field("department_scope"), permission.departmentScope.value)
            .set(DSL.field("updated_at"), now)
            .where("permission_detail_id = ?", permission.permissionDetailId)
            .execute()

        dsl.deleteFrom(DSL.table("permission_detail_department"))
            .where("permission_detail_id = ?", permission.permissionDetailId)
            .execute()

        if (permission.departmentScope == DepartmentScope.SPECIFIC) {
            permission.specificDepartments.forEach { departmentId ->
                dsl.insertInto(DSL.table("permission_detail_department"))
                    .columns(
                        DSL.field("permission_detail_id"),
                        DSL.field("department_id")
                    )
                    .values(
                        permission.permissionDetailId,
                        departmentId
                    )
                    .execute()
            }
        }

        return permission
    }

    override fun delete(permissionDetailId: Long) {
        dsl.deleteFrom(DSL.table("permission_detail_department"))
            .where("permission_detail_id = ?", permissionDetailId)
            .execute()

        dsl.deleteFrom(DSL.table("permission_detail"))
            .where("permission_detail_id = ?", permissionDetailId)
            .execute()
    }
} 