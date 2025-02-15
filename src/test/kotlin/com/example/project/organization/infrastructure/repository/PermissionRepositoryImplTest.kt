package com.example.project.organization.infrastructure.repository

import com.example.project.organization.domain.model.Permission
import com.example.project.organization.domain.model.vo.DepartmentScope
import com.example.project.config.TestConfig
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.test.context.ActiveProfiles
import org.springframework.transaction.annotation.Transactional
import org.jooq.DSLContext
import java.time.LocalDateTime

@SpringBootTest(classes = [TestConfig::class])
@ActiveProfiles("test")
@Transactional
class PermissionRepositoryImplTest {

    @Autowired
    private lateinit var permissionRepositoryImpl: PermissionRepositoryImpl

    @Autowired
    private lateinit var jdbcTemplate: JdbcTemplate

    @Autowired
    private lateinit var dsl: DSLContext

    @BeforeEach
    fun setUp() {
        // テストデータのクリーンアップ
        jdbcTemplate.execute("DELETE FROM permission_detail")
        jdbcTemplate.execute("DELETE FROM permission_detail_department")
    }

    @Test
    fun findByUserIdTest() {
        // テストデータの準備
        val permission = Permission(
            permissionDetailId = 1L,
            permissionId = "PERM1",
            userId = "user1",
            permissionType = "DOCUMENT",
            targetId = "TARGET1",
            accessLevel = "READ",
            departmentScope = DepartmentScope.ANY_DEPT,
            specificDepartments = emptyList(),
            createdAt = LocalDateTime.now(),
            updatedAt = LocalDateTime.now()
        )
        permissionRepositoryImpl.save(permission)

        // テスト実行
        val result = permissionRepositoryImpl.findByUserId("user1")

        // 検証
        result.size shouldBe 1
        result[0].permissionId shouldBe permission.permissionId
        result[0].userId shouldBe permission.userId
        result[0].departmentScope shouldBe DepartmentScope.ANY_DEPT
    }

    @Test
    fun findByUserIdWithSpecificDepartmentsTest() {
        // テストデータの準備
        val permission = Permission(
            permissionDetailId = 2L,
            permissionId = "PERM2",
            userId = "user2",
            permissionType = "DOCUMENT",
            targetId = "TARGET2",
            accessLevel = "READ",
            departmentScope = DepartmentScope.SPECIFIC,
            specificDepartments = listOf("DEPT_A", "DEPT_B"),
            createdAt = LocalDateTime.now(),
            updatedAt = LocalDateTime.now()
        )
        permissionRepositoryImpl.save(permission)

        // テスト実行
        val result = permissionRepositoryImpl.findByUserId("user2")

        // 検証
        result.size shouldBe 1
        result[0].permissionId shouldBe permission.permissionId
        result[0].userId shouldBe permission.userId
        result[0].departmentScope shouldBe DepartmentScope.SPECIFIC
        result[0].specificDepartments shouldBe listOf("DEPT_A", "DEPT_B")
    }

    @Test
    fun savePermissionTest() {
        // テストデータの準備
        val permission = Permission(
            permissionDetailId = 3L,
            permissionId = "PERM3",
            userId = "user3",
            permissionType = "DOCUMENT",
            targetId = "TARGET3",
            accessLevel = "READ",
            departmentScope = DepartmentScope.ANY_DEPT,
            specificDepartments = emptyList(),
            createdAt = LocalDateTime.now(),
            updatedAt = LocalDateTime.now()
        )

        // テスト実行
        val savedPermission = permissionRepositoryImpl.save(permission)

        // 検証
        savedPermission.permissionId shouldBe permission.permissionId
        savedPermission.userId shouldBe permission.userId
        savedPermission.departmentScope shouldBe DepartmentScope.ANY_DEPT
    }

    @Test
    fun savePermissionWithSpecificDepartmentsTest() {
        // テストデータの準備
        val permission = Permission(
            permissionDetailId = 4L,
            permissionId = "PERM4",
            userId = "user4",
            permissionType = "DOCUMENT",
            targetId = "TARGET4",
            accessLevel = "READ",
            departmentScope = DepartmentScope.SPECIFIC,
            specificDepartments = listOf("DEPT_A", "DEPT_B"),
            createdAt = LocalDateTime.now(),
            updatedAt = LocalDateTime.now()
        )

        // テスト実行
        val savedPermission = permissionRepositoryImpl.save(permission)

        // 検証
        savedPermission.permissionId shouldBe permission.permissionId
        savedPermission.userId shouldBe permission.userId
        savedPermission.departmentScope shouldBe DepartmentScope.SPECIFIC
        savedPermission.specificDepartments shouldBe listOf("DEPT_A", "DEPT_B")
    }

    @Test
    fun updatePermissionTest() {
        // テストデータの準備
        val permission = Permission(
            permissionDetailId = 5L,
            permissionId = "PERM5",
            userId = "user5",
            permissionType = "DOCUMENT",
            targetId = "TARGET5",
            accessLevel = "READ",
            departmentScope = DepartmentScope.ANY_DEPT,
            specificDepartments = emptyList(),
            createdAt = LocalDateTime.now(),
            updatedAt = LocalDateTime.now()
        )
        permissionRepositoryImpl.save(permission)

        // 更新データの準備
        val updatedPermission = permission.copy(
            accessLevel = "WRITE",
            updatedAt = LocalDateTime.now()
        )

        // テスト実行
        val result = permissionRepositoryImpl.save(updatedPermission)

        // 検証
        result.permissionId shouldBe updatedPermission.permissionId
        result.userId shouldBe updatedPermission.userId
        result.accessLevel shouldBe "WRITE"
        result.departmentScope shouldBe DepartmentScope.ANY_DEPT
    }

    @Test
    fun updatePermissionWithSpecificDepartmentsTest() {
        // テストデータの準備
        val permission = Permission(
            permissionDetailId = 6L,
            permissionId = "PERM6",
            userId = "user6",
            permissionType = "DOCUMENT",
            targetId = "TARGET6",
            accessLevel = "READ",
            departmentScope = DepartmentScope.SPECIFIC,
            specificDepartments = listOf("DEPT_A"),
            createdAt = LocalDateTime.now(),
            updatedAt = LocalDateTime.now()
        )
        permissionRepositoryImpl.save(permission)

        // 更新データの準備
        val updatedPermission = permission.copy(
            specificDepartments = listOf("DEPT_A", "DEPT_B"),
            updatedAt = LocalDateTime.now()
        )

        // テスト実行
        val result = permissionRepositoryImpl.save(updatedPermission)

        // 検証
        result.permissionId shouldBe updatedPermission.permissionId
        result.userId shouldBe updatedPermission.userId
        result.departmentScope shouldBe DepartmentScope.SPECIFIC
        result.specificDepartments shouldBe listOf("DEPT_A", "DEPT_B")
    }

    @Test
    fun deletePermissionTest() {
        // テストデータの準備
        val permission = Permission(
            permissionDetailId = 7L,
            permissionId = "PERM7",
            userId = "user7",
            permissionType = "DOCUMENT",
            targetId = "TARGET7",
            accessLevel = "READ",
            departmentScope = DepartmentScope.SPECIFIC,
            specificDepartments = listOf("DEPT_A", "DEPT_B"),
            createdAt = LocalDateTime.now(),
            updatedAt = LocalDateTime.now()
        )
        permissionRepositoryImpl.save(permission)

        // テスト実行
        permissionRepositoryImpl.delete(permission.permissionDetailId)

        // 検証
        val result = permissionRepositoryImpl.findByUserId("user7")
        result.size shouldBe 0
    }
}