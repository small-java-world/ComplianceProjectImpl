package com.example.project.code.infrastructure.repository

import com.example.project.code.domain.model.MCode
import com.example.project.code.domain.repository.MCodeRepository
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
class MCodeRepositoryImplTest {

    @Autowired
    private lateinit var mCodeRepositoryImpl: MCodeRepositoryImpl

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
                code_category, code, code_division, name, code_short_name,
                display_order, description, is_active, created_at, updated_at
            ) VALUES (
                'TEST_CATEGORY', 'TEST_CODE', 'TEST_DIVISION', 'テストコード', 'テスト',
                1, 'テスト説明', true, '${now}', '${now}'
            )
        """)

        // テスト実行
        val result = mCodeRepositoryImpl.findByCodeCategoryAndCode("TEST_CATEGORY", "TEST_CODE")

        // 検証
        result shouldBe MCode(
            codeCategory = "TEST_CATEGORY",
            code = "TEST_CODE",
            codeDivision = "TEST_DIVISION",
            name = "テストコード",
            codeShortName = "テスト",
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
        val mCode = MCode(
            codeCategory = "NEW_CATEGORY",
            code = "NEW_CODE",
            codeDivision = "NEW_DIVISION",
            name = "新規コード",
            codeShortName = "新規",
            displayOrder = 1,
            description = "新規コード説明",
            isActive = true,
            createdAt = now,
            updatedAt = now
        )

        // テスト実行
        mCodeRepositoryImpl.save(mCode)

        // 検証
        val result = mCodeRepositoryImpl.findByCodeCategoryAndCode("NEW_CATEGORY", "NEW_CODE")
        result shouldBe mCode
    }
} 