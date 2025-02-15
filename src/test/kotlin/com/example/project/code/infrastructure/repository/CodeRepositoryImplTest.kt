package com.example.project.code.infrastructure.repository

import com.example.project.code.domain.model.Code
import com.example.project.code.domain.repository.CodeRepository
import com.example.project.config.TestConfig
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.context.annotation.Import
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.test.context.ActiveProfiles
import org.springframework.transaction.annotation.Transactional
import org.jooq.DSLContext
import java.time.LocalDateTime

@SpringBootTest(classes = [TestConfig::class])
@ActiveProfiles("test")
@Transactional
class CodeRepositoryImplTest {

    @Autowired
    private lateinit var codeRepositoryImpl: CodeRepositoryImpl

    @Autowired
    private lateinit var jdbcTemplate: JdbcTemplate

    @Autowired
    private lateinit var dsl: DSLContext

    @BeforeEach
    fun setUp() {
        // テストデータのクリーンアップ
        jdbcTemplate.execute("DELETE FROM M_CODE")
    }

    @Test
    fun `カテゴリとコードで検索できること`() {
        // テストデータの準備
        val now = LocalDateTime.now()
        jdbcTemplate.execute("""
            INSERT INTO M_CODE (
                code_category, code, code_division, code_name, code_short_name,
                extension1, extension2, extension3, extension4, extension5,
                extension6, extension7, extension8, extension9, extension10,
                extension11, extension12, extension13, extension14, extension15,
                display_order, description, is_active, created_at, updated_at
            ) VALUES (
                'TEST_CATEGORY', 'TEST_CODE', 'TEST_DIVISION', 'テストコード', 'テスト',
                'ext1', 'ext2', 'ext3', 'ext4', 'ext5',
                'ext6', 'ext7', 'ext8', 'ext9', 'ext10',
                'ext11', 'ext12', 'ext13', 'ext14', 'ext15',
                1, 'テスト説明', true, '${now}', '${now}'
            )
        """)

        // テスト実行
        val result = codeRepositoryImpl.findByCodeCategoryAndCode("TEST_CATEGORY", "TEST_CODE")

        // 検証
        result shouldBe Code(
            codeCategory = "TEST_CATEGORY",
            code = "TEST_CODE",
            codeDivision = "TEST_DIVISION",
            codeName = "テストコード",
            codeShortName = "テスト",
            extension1 = "ext1",
            extension2 = "ext2",
            extension3 = "ext3",
            extension4 = "ext4",
            extension5 = "ext5",
            extension6 = "ext6",
            extension7 = "ext7",
            extension8 = "ext8",
            extension9 = "ext9",
            extension10 = "ext10",
            extension11 = "ext11",
            extension12 = "ext12",
            extension13 = "ext13",
            extension14 = "ext14",
            extension15 = "ext15",
            displayOrder = 1,
            description = "テスト説明",
            isActive = true,
            createdAt = now,
            updatedAt = now
        )
    }

    @Test
    fun `新しいコードを保存できること`() {
        // テストデータの準備
        val now = LocalDateTime.now()
        val code = Code(
            codeCategory = "NEW_CATEGORY",
            code = "NEW_CODE",
            codeDivision = "NEW_DIVISION",
            codeName = "新規コード",
            codeShortName = "新規",
            extension1 = "new_ext1",
            extension2 = "new_ext2",
            extension3 = "new_ext3",
            extension4 = "new_ext4",
            extension5 = "new_ext5",
            extension6 = "new_ext6",
            extension7 = "new_ext7",
            extension8 = "new_ext8",
            extension9 = "new_ext9",
            extension10 = "new_ext10",
            extension11 = "new_ext11",
            extension12 = "new_ext12",
            extension13 = "new_ext13",
            extension14 = "new_ext14",
            extension15 = "new_ext15",
            displayOrder = 1,
            description = "新規コード説明",
            isActive = true,
            createdAt = now,
            updatedAt = now
        )

        // テスト実行
        codeRepositoryImpl.save(code)

        // 検証
        val result = codeRepositoryImpl.findByCodeCategoryAndCode("NEW_CATEGORY", "NEW_CODE")
        result shouldBe code
    }
} 