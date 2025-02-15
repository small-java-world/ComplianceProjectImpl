package com.example.project.organization.infrastructure.repository

import com.example.project.organization.domain.model.Permission
import com.example.project.organization.domain.model.vo.DepartmentScope
import com.example.project.organization.domain.repository.PermissionRepository
import com.example.project.config.TestConfig
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestMethodOrder
import org.junit.jupiter.api.MethodOrderer
import org.junit.jupiter.api.Order
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.test.context.ActiveProfiles
import org.springframework.transaction.annotation.Transactional
import org.jooq.DSLContext
import java.time.LocalDateTime
import org.assertj.core.api.Assertions.assertThat

@SpringBootTest(classes = [TestConfig::class])
@ActiveProfiles("test")
@Transactional
@TestMethodOrder(MethodOrderer.OrderAnnotation::class)
class PermissionRepositoryImplTest {

    @Autowired
    private lateinit var permissionRepository: PermissionRepository

    @Autowired
    private lateinit var jdbcTemplate: JdbcTemplate

    @Autowired
    private lateinit var dsl: DSLContext

    @BeforeEach
    fun setUp() {
        // テストデータのクリーンアップ
        jdbcTemplate.execute("SET FOREIGN_KEY_CHECKS = 0")
        jdbcTemplate.execute("TRUNCATE TABLE permission_detail_department")
        jdbcTemplate.execute("TRUNCATE TABLE permission_detail")
        jdbcTemplate.execute("TRUNCATE TABLE user")
        jdbcTemplate.execute("TRUNCATE TABLE department")
        jdbcTemplate.execute("TRUNCATE TABLE organization")
        jdbcTemplate.execute("SET FOREIGN_KEY_CHECKS = 1")

        // 組織データの作成
        jdbcTemplate.update("""
            INSERT INTO organization (organization_id, name, organization_code, description)
            VALUES ('ORG001', 'テスト組織1', 'TEST_ORG_1', 'テスト用組織1です。')
        """)

        // 部門データの作成
        jdbcTemplate.update("""
            INSERT INTO department (department_id, organization_id, name, department_code)
            VALUES ('DEPT001', 'ORG001', '総務部', 'SOUMU')
        """)
        jdbcTemplate.update("""
            INSERT INTO department (department_id, organization_id, name, department_code)
            VALUES ('DEPT002', 'ORG001', '人事部', 'JINJI')
        """)

        // ユーザーデータの作成
        jdbcTemplate.update("""
            INSERT INTO user (user_id, department_id, username, email, password_hash, role_code)
            VALUES ('user1', 'DEPT001', 'テストユーザー1', 'test1@example.com', 'dummy_hash', 'ROLE_USER')
        """)
        jdbcTemplate.update("""
            INSERT INTO user (user_id, department_id, username, email, password_hash, role_code)
            VALUES ('user2', 'DEPT002', 'テストユーザー2', 'test2@example.com', 'dummy_hash', 'ROLE_USER')
        """)
    }

    @Test
    @Order(1)
    fun findByUserIdTest() {
        // Given
        val now = LocalDateTime.now()
        val permission = Permission(
            permissionDetailId = 0L,
            permissionId = "PERM1",
            userId = "user1",
            permissionType = "DOCUMENT",
            targetId = "TARGET1",
            accessLevel = "READ",
            departmentScope = DepartmentScope.ANY_DEPT,
            specificDepartments = emptyList(),
            createdAt = now,
            updatedAt = now
        )

        // When
        val savedPermission = permissionRepository.save(permission)
        Thread.sleep(1000) // トランザクションの完了を待つ
        val result = permissionRepository.findByUserId("user1")

        // Then
        result.size shouldBe 1
        result[0].let {
            assertThat(it.permissionId).isEqualTo(permission.permissionId)
            assertThat(it.userId).isEqualTo(permission.userId)
            assertThat(it.departmentScope).isEqualTo(DepartmentScope.ANY_DEPT)
        }
    }

    @Test
    @Order(2)
    fun findByUserIdWithSpecificDepartmentsTest() {
        // Given
        val now = LocalDateTime.now()
        val permission = Permission(
            permissionDetailId = 0L,
            permissionId = "PERM2",
            userId = "user1",
            permissionType = "DOCUMENT",
            targetId = "TARGET2",
            accessLevel = "READ",
            departmentScope = DepartmentScope.SPECIFIC,
            specificDepartments = listOf("DEPT001", "DEPT002"),
            createdAt = now,
            updatedAt = now
        )

        // When
        val savedPermission = permissionRepository.save(permission)
        Thread.sleep(1000) // トランザクションの完了を待つ
        val result = permissionRepository.findByUserId("user1")

        // Then
        result.size shouldBe 1
        result[0].let {
            assertThat(it.permissionId).isEqualTo(permission.permissionId)
            assertThat(it.userId).isEqualTo(permission.userId)
            assertThat(it.departmentScope).isEqualTo(DepartmentScope.SPECIFIC)
            assertThat(it.specificDepartments).containsExactlyInAnyOrder("DEPT001", "DEPT002")
        }
    }

    @Test
    @Order(3)
    fun savePermissionTest() {
        // Given
        val now = LocalDateTime.now()
        val permission = Permission(
            permissionDetailId = 0L,
            permissionId = "PERM3",
            userId = "user1",
            permissionType = "DOCUMENT",
            targetId = "TARGET3",
            accessLevel = "READ",
            departmentScope = DepartmentScope.ANY_DEPT,
            specificDepartments = emptyList(),
            createdAt = now,
            updatedAt = now
        )

        // When
        val savedPermission = permissionRepository.save(permission)
        Thread.sleep(1000) // トランザクションの完了を待つ

        // Then
        assertThat(savedPermission.permissionId).isEqualTo(permission.permissionId)
        assertThat(savedPermission.userId).isEqualTo(permission.userId)
        assertThat(savedPermission.departmentScope).isEqualTo(DepartmentScope.ANY_DEPT)
    }

    @Test
    @Order(4)
    fun savePermissionWithSpecificDepartmentsTest() {
        // Given
        val now = LocalDateTime.now()
        val permission = Permission(
            permissionDetailId = 0L,
            permissionId = "PERM4",
            userId = "user1",
            permissionType = "DOCUMENT",
            targetId = "TARGET4",
            accessLevel = "READ",
            departmentScope = DepartmentScope.SPECIFIC,
            specificDepartments = listOf("DEPT001", "DEPT002"),
            createdAt = now,
            updatedAt = now
        )

        // When
        val savedPermission = permissionRepository.save(permission)
        Thread.sleep(1000) // トランザクションの完了を待つ

        // Then
        assertThat(savedPermission.permissionId).isEqualTo(permission.permissionId)
        assertThat(savedPermission.userId).isEqualTo(permission.userId)
        assertThat(savedPermission.departmentScope).isEqualTo(DepartmentScope.SPECIFIC)
        assertThat(savedPermission.specificDepartments).containsExactlyInAnyOrder("DEPT001", "DEPT002")
    }

    @Test
    @Order(5)
    fun updatePermissionTest() {
        // Given
        val now = LocalDateTime.now()
        val permission = Permission(
            permissionDetailId = 0L,
            permissionId = "PERM5",
            userId = "user1",
            permissionType = "DOCUMENT",
            targetId = "TARGET5",
            accessLevel = "READ",
            departmentScope = DepartmentScope.ANY_DEPT,
            specificDepartments = emptyList(),
            createdAt = now,
            updatedAt = now
        )
        val savedPermission = permissionRepository.save(permission)
        Thread.sleep(1000) // トランザクションの完了を待つ

        val updateTime = LocalDateTime.now()
        val updatedPermission = savedPermission.copy(
            accessLevel = "WRITE",
            departmentScope = DepartmentScope.SPECIFIC,
            specificDepartments = listOf("DEPT001"),
            updatedAt = updateTime
        )

        // When
        val result = permissionRepository.update(updatedPermission)
        Thread.sleep(1000) // トランザクションの完了を待つ

        // Then
        assertThat(result.permissionId).isEqualTo(permission.permissionId)
        assertThat(result.userId).isEqualTo(permission.userId)
        assertThat(result.accessLevel).isEqualTo("WRITE")
        assertThat(result.departmentScope).isEqualTo(DepartmentScope.SPECIFIC)
        assertThat(result.specificDepartments).containsExactly("DEPT001")
    }

    @Test
    @Order(6)
    fun deletePermissionTest() {
        // Given
        val now = LocalDateTime.now()
        val permission = Permission(
            permissionDetailId = 0L,
            permissionId = "PERM7",
            userId = "user1",
            permissionType = "DOCUMENT",
            targetId = "TARGET7",
            accessLevel = "READ",
            departmentScope = DepartmentScope.SPECIFIC,
            specificDepartments = listOf("DEPT001", "DEPT002"),
            createdAt = now,
            updatedAt = now
        )
        val savedPermission = permissionRepository.save(permission)
        Thread.sleep(1000) // トランザクションの完了を待つ

        // When
        permissionRepository.delete(savedPermission.permissionDetailId)
        Thread.sleep(1000) // トランザクションの完了を待つ

        // Then
        val result = permissionRepository.findByUserId("user1")
        result.size shouldBe 0
    }
}