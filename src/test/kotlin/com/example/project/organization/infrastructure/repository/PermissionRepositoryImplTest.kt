package com.example.project.organization.infrastructure.repository

import com.example.project.organization.domain.model.Permission
import com.example.project.organization.domain.model.vo.DepartmentScope
import com.example.project.organization.domain.repository.PermissionRepository
import com.example.project.config.TestConfig
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.ActiveProfiles
import org.jooq.DSLContext
import org.jooq.impl.DSL
import java.time.LocalDateTime
import org.assertj.core.api.Assertions.assertThat
import io.github.oshai.kotlinlogging.KotlinLogging
import org.springframework.transaction.annotation.Transactional
import org.springframework.test.context.transaction.TestTransaction
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.test.annotation.Rollback
import org.springframework.jdbc.core.JdbcTemplate

@SpringBootTest(classes = [TestConfig::class])
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@ActiveProfiles("test")
@TestMethodOrder(MethodOrderer.OrderAnnotation::class)
class PermissionRepositoryImplTest {

    @Autowired
    private lateinit var permissionRepository: PermissionRepository

    @Autowired
    @Qualifier("organizationDslContext")
    private lateinit var dsl: DSLContext

    @Autowired
    @Qualifier("organizationJdbcTemplate")
    private lateinit var jdbcTemplate: JdbcTemplate

    private val logger = KotlinLogging.logger {}

    companion object {
        private const val PERMISSION_DETAIL = "permission_detail"
        private const val PERMISSION_DETAIL_DEPARTMENT = "permission_detail_department"
    }

    @BeforeAll
    fun setUpAll() {
        logger.info { "Setting up test environment" }
        cleanupAllTestData()
    }

    @BeforeEach
    fun setUp() {
        logger.info { "Setting up test data" }
        cleanupTestData()
        setupTestData()
    }

    @AfterEach
    fun tearDown() {
        logger.info { "Cleaning up after test case" }
        cleanupTestData()
    }

    private fun cleanupTestData() {
        logger.info { "Cleaning up test data for current test" }
        dsl.transaction { config ->
            try {
                // 外部キー制約を一時的に無効化
                config.dsl().execute("SET FOREIGN_KEY_CHECKS = 0")
                
                // 削除順序を明示的に制御
                config.dsl().deleteFrom(DSL.table("permission_detail_department")).execute()
                config.dsl().deleteFrom(DSL.table("permission_detail")).execute()
                config.dsl().deleteFrom(DSL.table("user")).execute()
                config.dsl().deleteFrom(DSL.table("department")).execute()
                config.dsl().deleteFrom(DSL.table("organization")).execute()
                
                // 外部キー制約を再有効化
                config.dsl().execute("SET FOREIGN_KEY_CHECKS = 1")
                
                logger.info { "Successfully cleaned up test data" }
            } catch (e: Exception) {
                logger.error(e) { "Failed to cleanup test data" }
                throw e
            }
        }
    }

    private fun cleanupAllTestData() {
        logger.info { "Cleaning up all test data" }
        try {
            cleanupTestData()
        } catch (e: Exception) {
            logger.error(e) { "Failed to cleanup all test data" }
            throw e
        }
    }

    private fun setupTestData() {
        logger.info { "Setting up test data" }
        dsl.transaction { config ->
            try {
                val now = LocalDateTime.now()

                // 組織データの作成
                config.dsl().insertInto(DSL.table("organization"))
                    .columns(
                        DSL.field("organization_id"),
                        DSL.field("name"),
                        DSL.field("organization_code"),
                        DSL.field("description"),
                        DSL.field("created_at"),
                        DSL.field("updated_at")
                    )
                    .values(
                        "ORG001",
                        "テスト組織1",
                        "TEST_ORG_1",
                        "テスト用組織1です。",
                        now,
                        now
                    )
                    .execute()

                // 部門データの作成
                config.dsl().insertInto(DSL.table("department"))
                    .columns(
                        DSL.field("department_id"),
                        DSL.field("organization_id"),
                        DSL.field("name"),
                        DSL.field("department_code"),
                        DSL.field("created_at"),
                        DSL.field("updated_at")
                    )
                    .values(
                        "DEPT001",
                        "ORG001",
                        "総務部",
                        "SOUMU",
                        now,
                        now
                    )
                    .execute()

                config.dsl().insertInto(DSL.table("department"))
                    .columns(
                        DSL.field("department_id"),
                        DSL.field("organization_id"),
                        DSL.field("name"),
                        DSL.field("department_code"),
                        DSL.field("created_at"),
                        DSL.field("updated_at")
                    )
                    .values(
                        "DEPT002",
                        "ORG001",
                        "人事部",
                        "JINJI",
                        now,
                        now
                    )
                    .execute()

                // ユーザーデータの作成
                config.dsl().insertInto(DSL.table("user"))
                    .columns(
                        DSL.field("user_id"),
                        DSL.field("department_id"),
                        DSL.field("username"),
                        DSL.field("email"),
                        DSL.field("password_hash"),
                        DSL.field("role_code"),
                        DSL.field("created_at"),
                        DSL.field("updated_at")
                    )
                    .values(
                        "user1",
                        "DEPT001",
                        "テストユーザー1",
                        "test1@example.com",
                        "dummy_hash",
                        "ROLE_USER",
                        now,
                        now
                    )
                    .execute()

                config.dsl().insertInto(DSL.table("user"))
                    .columns(
                        DSL.field("user_id"),
                        DSL.field("department_id"),
                        DSL.field("username"),
                        DSL.field("email"),
                        DSL.field("password_hash"),
                        DSL.field("role_code"),
                        DSL.field("created_at"),
                        DSL.field("updated_at")
                    )
                    .values(
                        "user2",
                        "DEPT002",
                        "テストユーザー2",
                        "test2@example.com",
                        "dummy_hash",
                        "ROLE_USER",
                        now,
                        now
                    )
                    .execute()

                // 基本的なパーミッションデータの作成
                config.dsl().insertInto(DSL.table("permission_detail"))
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
                        "PERM_TEST_1",
                        "user1",
                        "DOCUMENT",
                        "TARGET1",
                        "READ",
                        "ANY_DEPT",
                        now,
                        now
                    )
                    .execute()

                val permissionDetailId1 = config.dsl()
                    .select(DSL.field("LAST_INSERT_ID()", Long::class.java))
                    .fetchOne()?.value1()
                    ?: throw IllegalStateException("Failed to get permission_detail_id")

                // 特定部門のパーミッションデータの作成
                config.dsl().insertInto(DSL.table("permission_detail"))
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
                        "PERM_TEST_2",
                        "user2",
                        "DOCUMENT",
                        "TARGET2",
                        "READ",
                        "SPECIFIC",
                        now,
                        now
                    )
                    .execute()

                val permissionDetailId2 = config.dsl()
                    .select(DSL.field("LAST_INSERT_ID()", Long::class.java))
                    .fetchOne()?.value1()
                    ?: throw IllegalStateException("Failed to get permission_detail_id")

                // 特定部門のパーミッション詳細データの作成
                config.dsl().insertInto(DSL.table("permission_detail_department"))
                    .columns(
                        DSL.field("permission_detail_id"),
                        DSL.field("department_id"),
                        DSL.field("created_at"),
                        DSL.field("updated_at")
                    )
                    .values(
                        permissionDetailId2,
                        "DEPT001",
                        now,
                        now
                    )
                    .execute()

                config.dsl().insertInto(DSL.table("permission_detail_department"))
                    .columns(
                        DSL.field("permission_detail_id"),
                        DSL.field("department_id"),
                        DSL.field("created_at"),
                        DSL.field("updated_at")
                    )
                    .values(
                        permissionDetailId2,
                        "DEPT002",
                        now,
                        now
                    )
                    .execute()

                logger.info { "Successfully set up test data" }
            } catch (e: Exception) {
                logger.error(e) { "Failed to set up test data" }
                throw e
            }
        }
    }

    @Test
    @Order(1)
    fun findByUserIdTest() {
        // When
        val result = permissionRepository.findByUserId("user1")

        // Then
        assertThat(result.size).isEqualTo(1)
        result[0].let {
            assertThat(it.permissionId).isEqualTo("PERM_TEST_1")
            assertThat(it.userId).isEqualTo("user1")
            assertThat(it.departmentScope).isEqualTo(DepartmentScope.ANY_DEPT)
        }
    }

    @Test
    @Order(2)
    fun findByUserIdWithSpecificDepartmentsTest() {
        // When
        val result = permissionRepository.findByUserId("user2")

        // Then
        assertThat(result.size).isEqualTo(1)
        result[0].let {
            assertThat(it.permissionId).isEqualTo("PERM_TEST_2")
            assertThat(it.userId).isEqualTo("user2")
            assertThat(it.departmentScope).isEqualTo(DepartmentScope.SPECIFIC)
            assertThat(it.specificDepartments).containsExactlyInAnyOrder("DEPT001", "DEPT002")
        }
    }

    @Test
    @Order(3)
    fun savePermissionTest() {
        logger.info { "Starting savePermissionTest" }
        try {
            // Given
            val now = LocalDateTime.now()
            val permission = Permission(
                permissionDetailId = null,  // 自動生成されるため、nullを設定
                permissionId = "PERM_TEST_3",
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

            // Then
            assertThat(savedPermission).isNotNull
            assertThat(savedPermission.permissionDetailId).isNotNull()  // 自動生成されたIDが設定されていることを確認
            assertThat(savedPermission.permissionId).isEqualTo("PERM_TEST_3")
            assertThat(savedPermission.userId).isEqualTo("user1")
            assertThat(savedPermission.departmentScope).isEqualTo(DepartmentScope.ANY_DEPT)
            assertThat(savedPermission.specificDepartments).isEmpty()

            val result = dsl.select()
                .from(DSL.table(PERMISSION_DETAIL))
                .where("permission_id = ?", "PERM_TEST_3")
                .fetchOne()

            assertThat(result).isNotNull
            assertThat(result?.get("permission_id", String::class.java)).isEqualTo("PERM_TEST_3")
            assertThat(result?.get("user_id", String::class.java)).isEqualTo("user1")
            assertThat(result?.get("department_scope", String::class.java)).isEqualTo("ANY_DEPT")
        } catch (e: Exception) {
            logger.error(e) { "Test failed: ${e.message}" }
            throw e
        }
    }

    @Test
    @Order(4)
    fun savePermissionWithSpecificDepartmentsTest() {
        logger.info { "Starting savePermissionWithSpecificDepartmentsTest" }
        try {
            // Given
            val now = LocalDateTime.now()
            val permission = Permission(
                permissionDetailId = null,  // 自動生成されるため、nullを設定
                permissionId = "PERM_TEST_4",
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

            // Then
            assertThat(savedPermission).isNotNull
            assertThat(savedPermission.permissionDetailId).isNotNull()  // 自動生成されたIDが設定されていることを確認
            assertThat(savedPermission.permissionId).isEqualTo("PERM_TEST_4")
            assertThat(savedPermission.userId).isEqualTo("user1")
            assertThat(savedPermission.departmentScope).isEqualTo(DepartmentScope.SPECIFIC)
            assertThat(savedPermission.specificDepartments).containsExactlyInAnyOrder("DEPT001", "DEPT002")

            val result = dsl.select()
                .from(DSL.table(PERMISSION_DETAIL))
                .where("permission_id = ?", "PERM_TEST_4")
                .fetchOne()

            assertThat(result).isNotNull
            assertThat(result?.get("permission_id", String::class.java)).isEqualTo("PERM_TEST_4")
            assertThat(result?.get("user_id", String::class.java)).isEqualTo("user1")
            assertThat(result?.get("department_scope", String::class.java)).isEqualTo("SPECIFIC")

            val departments = dsl.select()
                .from(DSL.table(PERMISSION_DETAIL_DEPARTMENT))
                .where("permission_detail_id = ?", savedPermission.permissionDetailId)
                .fetch()
                .map { it.get("department_id", String::class.java) }
                .toList()

            assertThat(departments).containsExactlyInAnyOrder("DEPT001", "DEPT002")
        } catch (e: Exception) {
            logger.error(e) { "Test failed: ${e.message}" }
            throw e
        }
    }

    @Test
    @Order(5)
    fun updatePermissionTest() {
        logger.info { "Starting updatePermissionTest" }
        try {
            // Given
            val existingPermission = dsl.select()
                .from(PERMISSION_DETAIL)
                .where("permission_id = ?", "PERM_TEST_1")
                .fetchOne() ?: throw IllegalStateException("Permission not found")

            val permissionDetailId = existingPermission.get("permission_detail_id", Long::class.java)
            val now = LocalDateTime.now()

            val permission = Permission(
                permissionDetailId = permissionDetailId,
                permissionId = "PERM_TEST_1",
                userId = "user1",
                permissionType = "DOCUMENT",
                targetId = "TARGET1_UPDATED",
                accessLevel = "WRITE",
                departmentScope = DepartmentScope.SPECIFIC,
                specificDepartments = listOf("DEPT001"),
                createdAt = existingPermission.get("created_at", LocalDateTime::class.java),
                updatedAt = now
            )

            // When
            val updatedPermission = permissionRepository.update(permission)

            // Then
            assertThat(updatedPermission).isNotNull
            assertThat(updatedPermission.permissionId).isEqualTo("PERM_TEST_1")
            assertThat(updatedPermission.targetId).isEqualTo("TARGET1_UPDATED")
            assertThat(updatedPermission.accessLevel).isEqualTo("WRITE")
            assertThat(updatedPermission.departmentScope).isEqualTo(DepartmentScope.SPECIFIC)
            assertThat(updatedPermission.specificDepartments).containsExactly("DEPT001")

            val result = dsl.select()
                .from(PERMISSION_DETAIL)
                .where("permission_id = ?", "PERM_TEST_1")
                .fetchOne()

            assertThat(result).isNotNull
            assertThat(result?.get("permission_id", String::class.java)).isEqualTo("PERM_TEST_1")
            assertThat(result?.get("target_id", String::class.java)).isEqualTo("TARGET1_UPDATED")
            assertThat(result?.get("access_level", String::class.java)).isEqualTo("WRITE")
            assertThat(result?.get("department_scope", String::class.java)).isEqualTo("SPECIFIC")

            val departments = dsl.select(DSL.field("department_id"))
                .from(PERMISSION_DETAIL_DEPARTMENT)
                .where("permission_detail_id = ?", updatedPermission.permissionDetailId)
                .fetch()
                .map { it.get("department_id", String::class.java) }
                .toList()

            assertThat(departments).containsExactly("DEPT001")
        } catch (e: Exception) {
            logger.error(e) { "Test failed: ${e.message}" }
            throw e
        }
    }

    @Test
    @Order(6)
    fun deletePermissionTest() {
        logger.info { "Starting deletePermissionTest" }
        try {
            // Given
            val existingPermission = dsl.select()
                .from(DSL.table(PERMISSION_DETAIL))
                .where("permission_id = ?", "PERM_TEST_1")
                .fetchOne() ?: throw IllegalStateException("Permission not found")

            val permissionDetailId = existingPermission.get("permission_detail_id", Long::class.java)

            // When
            permissionRepository.delete(permissionDetailId)

            // Then
            val result = dsl.select()
                .from(DSL.table(PERMISSION_DETAIL))
                .where("permission_detail_id = ?", permissionDetailId)
                .fetchOne()

            assertThat(result).isNull()

            val departments = dsl.select()
                .from(DSL.table(PERMISSION_DETAIL_DEPARTMENT))
                .where("permission_detail_id = ?", permissionDetailId)
                .fetch()

            assertThat(departments.size).isZero()
        } catch (e: Exception) {
            logger.error(e) { "Test failed: ${e.message}" }
            throw e
        }
    }
}