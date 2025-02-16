package com.example.project.organization.infrastructure.repository

import com.example.project.organization.domain.model.Permission
import com.example.project.organization.domain.model.vo.DepartmentScope
import com.example.project.organization.domain.repository.PermissionRepository
import org.jooq.DSLContext
import org.jooq.impl.DSL
import org.springframework.stereotype.Repository
import org.springframework.transaction.annotation.Transactional
import java.time.LocalDateTime
import io.github.oshai.kotlinlogging.KotlinLogging

private val logger = KotlinLogging.logger {}

@Repository
class PermissionRepositoryImpl(
    private val dsl: DSLContext
) : PermissionRepository {

    companion object {
        private const val PERMISSION_DETAIL = "permission_detail"
        private const val PERMISSION_DETAIL_DEPARTMENT = "permission_detail_department"
        private const val USER = "user"
        private const val DEPARTMENT = "department"
    }

    override fun findById(permissionDetailId: Long): Permission? {
        logger.info { "Finding permission by id: $permissionDetailId" }
        return dsl.transactionResult { config ->
            try {
                val result = config.dsl()
                    .select(
                        DSL.field("pd.permission_detail_id"),
                        DSL.field("pd.permission_id"),
                        DSL.field("pd.user_id"),
                        DSL.field("pd.permission_type"),
                        DSL.field("pd.target_id"),
                        DSL.field("pd.access_level"),
                        DSL.field("pd.department_scope"),
                        DSL.field("pd.created_at"),
                        DSL.field("pd.updated_at"),
                        DSL.field("pdd.department_id")
                    )
                    .from(DSL.table("permission_detail").`as`("pd"))
                    .leftJoin(DSL.table("permission_detail_department").`as`("pdd"))
                    .on("pd.permission_detail_id = pdd.permission_detail_id")
                    .where("pd.permission_detail_id = ?", permissionDetailId)
                    .fetch()

                if (result.isEmpty()) {
                    logger.info { "Permission not found with id: $permissionDetailId" }
                    return@transactionResult null
                }

                val firstRow = result[0]
                val departmentIds = result
                    .filter { it.get("department_id", String::class.java) != null }
                    .map { it.get("department_id", String::class.java) }
                    .toList()

                Permission(
                    permissionDetailId = firstRow.get("permission_detail_id", Long::class.java),
                    permissionId = firstRow.get("permission_id", String::class.java),
                    userId = firstRow.get("user_id", String::class.java),
                    permissionType = firstRow.get("permission_type", String::class.java),
                    targetId = firstRow.get("target_id", String::class.java),
                    accessLevel = firstRow.get("access_level", String::class.java),
                    departmentScope = DepartmentScope.valueOf(firstRow.get("department_scope", String::class.java)),
                    specificDepartments = departmentIds,
                    createdAt = firstRow.get("created_at", LocalDateTime::class.java),
                    updatedAt = firstRow.get("updated_at", LocalDateTime::class.java)
                ).also {
                    logger.info { "Found permission: $it" }
                }
            } catch (e: Exception) {
                logger.error(e) { "Failed to find permission by id: $permissionDetailId" }
                throw e
            }
        }
    }

    override fun findByUserId(userId: String): List<Permission> {
        logger.info { "Finding permissions for user: $userId" }
        return dsl.transactionResult { config ->
            // ユーザーの存在確認
            val userExists = config.dsl().selectCount()
                .from(USER)
                .where("user_id = ?", userId)
                .fetchOne(0, Int::class.java) ?: 0

            if (userExists == 0) {
                logger.info { "User not found: $userId" }
                return@transactionResult emptyList()
            }

            val result = config.dsl().select()
                .from(PERMISSION_DETAIL)
                .leftJoin(PERMISSION_DETAIL_DEPARTMENT)
                .on("$PERMISSION_DETAIL.permission_detail_id = $PERMISSION_DETAIL_DEPARTMENT.permission_detail_id")
                .where("$PERMISSION_DETAIL.user_id = ?", userId)
                .fetch()

            result.intoGroups { it.get("permission_detail_id") }
                .map { (_, records) ->
                    val record = records.first()
                    val departmentIds = records.mapNotNull { it.get("department_id", String::class.java) }.distinct()

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
                }.also { logger.info { "Found ${it.size} permissions for user: $userId" } }
        }
    }

    override fun save(permission: Permission): Permission {
        logger.info { "Saving permission: $permission" }
        return dsl.transactionResult { config ->
            try {
                // ユーザーの存在確認
                val userExists = config.dsl()
                    .selectCount()
                    .from(DSL.table(USER))
                    .where("user_id = ?", permission.userId)
                    .fetchOne(0, Int::class.java) ?: 0

                if (userExists == 0) {
                    logger.error { "User not found: ${permission.userId}" }
                    throw IllegalStateException("User not found: ${permission.userId}")
                }

                // 部門の存在確認（SPECIFIC スコープの場合）
                if (permission.departmentScope == DepartmentScope.SPECIFIC) {
                    permission.specificDepartments.forEach { departmentId ->
                        val departmentExists = config.dsl()
                            .selectCount()
                            .from(DSL.table(DEPARTMENT))
                            .where("department_id = ?", departmentId)
                            .fetchOne(0, Int::class.java) ?: 0

                        if (departmentExists == 0) {
                            logger.error { "Department not found: $departmentId" }
                            throw IllegalStateException("Department not found: $departmentId")
                        }
                    }
                }

                val now = LocalDateTime.now()
                
                // Insert into permission_detail
                config.dsl()
                    .insertInto(DSL.table(PERMISSION_DETAIL))
                    .set(DSL.field("permission_id"), permission.permissionId)
                    .set(DSL.field("user_id"), permission.userId)
                    .set(DSL.field("permission_type"), permission.permissionType)
                    .set(DSL.field("target_id"), permission.targetId)
                    .set(DSL.field("access_level"), permission.accessLevel)
                    .set(DSL.field("department_scope"), permission.departmentScope.toString())
                    .set(DSL.field("created_at"), now)
                    .set(DSL.field("updated_at"), now)
                    .execute()

                val permissionDetailId = config.dsl()
                    .select(DSL.field("LAST_INSERT_ID()", Long::class.java))
                    .fetchOne()
                    ?.value1()
                    ?: throw IllegalStateException("Failed to get permission_detail_id after insert")

                // Insert department associations if any
                if (permission.specificDepartments.isNotEmpty()) {
                    permission.specificDepartments.forEach { departmentId ->
                        config.dsl()
                            .insertInto(DSL.table(PERMISSION_DETAIL_DEPARTMENT))
                            .set(DSL.field("permission_detail_id"), permissionDetailId)
                            .set(DSL.field("department_id"), departmentId)
                            .set(DSL.field("created_at"), now)
                            .set(DSL.field("updated_at"), now)
                            .execute()
                    }
                }

                permission.copy(
                    permissionDetailId = permissionDetailId,
                    createdAt = now,
                    updatedAt = now
                ).also {
                    logger.info { "Successfully saved permission: $it" }
                }
            } catch (e: Exception) {
                logger.error(e) { "Failed to save permission: $permission" }
                throw e
            }
        }
    }

    override fun update(permission: Permission): Permission {
        logger.info { "Updating permission: $permission" }
        return dsl.transactionResult { config ->
            try {
                // 権限の存在確認
                val existingPermission = config.dsl()
                    .select()
                    .from(DSL.table(PERMISSION_DETAIL))
                    .where("permission_detail_id = ?", permission.permissionDetailId)
                    .fetchOne() ?: throw IllegalStateException("Permission not found: ${permission.permissionDetailId}")

                // ユーザーの存在確認
                val userExists = config.dsl()
                    .selectCount()
                    .from(DSL.table(USER))
                    .where("user_id = ?", permission.userId)
                    .fetchOne(0, Int::class.java) ?: 0

                if (userExists == 0) {
                    logger.error { "User not found: ${permission.userId}" }
                    throw IllegalStateException("User not found: ${permission.userId}")
                }

                // 部門の存在確認（SPECIFIC スコープの場合）
                if (permission.departmentScope == DepartmentScope.SPECIFIC) {
                    permission.specificDepartments.forEach { departmentId ->
                        val departmentExists = config.dsl()
                            .selectCount()
                            .from(DSL.table(DEPARTMENT))
                            .where("department_id = ?", departmentId)
                            .fetchOne(0, Int::class.java) ?: 0

                        if (departmentExists == 0) {
                            logger.error { "Department not found: $departmentId" }
                            throw IllegalStateException("Department not found: $departmentId")
                        }
                    }
                }

                val now = LocalDateTime.now()
                val createdAt = existingPermission.get("created_at", LocalDateTime::class.java)

                // Update permission_detail
                val updateCount = config.dsl()
                    .update(DSL.table(PERMISSION_DETAIL))
                    .set(DSL.field("permission_id"), permission.permissionId)
                    .set(DSL.field("user_id"), permission.userId)
                    .set(DSL.field("permission_type"), permission.permissionType)
                    .set(DSL.field("target_id"), permission.targetId)
                    .set(DSL.field("access_level"), permission.accessLevel)
                    .set(DSL.field("department_scope"), permission.departmentScope.toString())
                    .set(DSL.field("updated_at"), now)
                    .where("permission_detail_id = ?", permission.permissionDetailId)
                    .execute()

                if (updateCount == 0) {
                    throw IllegalStateException("Failed to update permission with id: ${permission.permissionDetailId}")
                }

                // 部門の関連付けを更新
                config.dsl()
                    .deleteFrom(DSL.table(PERMISSION_DETAIL_DEPARTMENT))
                    .where("permission_detail_id = ?", permission.permissionDetailId)
                    .execute()

                if (permission.departmentScope == DepartmentScope.SPECIFIC) {
                    permission.specificDepartments.forEach { departmentId ->
                        config.dsl()
                            .insertInto(DSL.table(PERMISSION_DETAIL_DEPARTMENT))
                            .set(DSL.field("permission_detail_id"), permission.permissionDetailId)
                            .set(DSL.field("department_id"), departmentId)
                            .set(DSL.field("created_at"), now)
                            .set(DSL.field("updated_at"), now)
                            .execute()
                    }
                }

                permission.copy(
                    createdAt = createdAt,
                    updatedAt = now
                ).also {
                    logger.info { "Successfully updated permission: $it" }
                }
            } catch (e: Exception) {
                logger.error(e) { "Failed to update permission: $permission" }
                throw e
            }
        }
    }

    override fun delete(permissionDetailId: Long) {
        logger.info { "Deleting permission with id: $permissionDetailId" }
        dsl.transaction { config ->
            try {
                // Check if permission exists
                val exists = config.dsl()
                    .selectCount()
                    .from(DSL.table("permission_detail"))
                    .where("permission_detail_id = ?", permissionDetailId)
                    .fetchOne(0, Int::class.java) ?: 0

                if (exists == 0) {
                    logger.error { "Permission not found with id: $permissionDetailId" }
                    throw IllegalStateException("Permission not found with id: $permissionDetailId")
                }

                // Delete department associations first
                val deletedAssociations = config.dsl()
                    .deleteFrom(DSL.table("permission_detail_department"))
                    .where("permission_detail_id = ?", permissionDetailId)
                    .execute()

                logger.info { "Deleted $deletedAssociations department associations for permission: $permissionDetailId" }

                // Delete permission detail
                val deletedPermission = config.dsl()
                    .deleteFrom(DSL.table("permission_detail"))
                    .where("permission_detail_id = ?", permissionDetailId)
                    .execute()

                if (deletedPermission == 0) {
                    logger.error { "Failed to delete permission: $permissionDetailId" }
                    throw IllegalStateException("Failed to delete permission: $permissionDetailId")
                }

                logger.info { "Successfully deleted permission: $permissionDetailId" }
            } catch (e: Exception) {
                logger.error(e) { "Failed to delete permission: $permissionDetailId" }
                throw e
            }
        }
    }
} 