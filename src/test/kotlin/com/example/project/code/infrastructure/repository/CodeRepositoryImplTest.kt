package com.example.project.code.infrastructure.repository

import com.example.project.code.domain.model.Code
import com.example.project.code.domain.repository.CodeRepository
import com.example.project.config.TestConfig
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
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
import org.springframework.beans.factory.annotation.Qualifier
import java.time.format.DateTimeFormatter

@SpringBootTest(classes = [TestConfig::class])
@ActiveProfiles("test")
@Transactional("codeMasterTransactionManager")
class CodeRepositoryImplTest {

    @Autowired
    private lateinit var codeRepositoryImpl: CodeRepositoryImpl

    @Autowired
    @Qualifier("codeMasterJdbcTemplate")
    private lateinit var jdbcTemplate: JdbcTemplate

    @Autowired
    @Qualifier("codeMasterDslContext")
    private lateinit var dsl: DSLContext

    @BeforeEach
    fun setUp() {
        // テストデータのクリーンアップ
        jdbcTemplate.execute("SET FOREIGN_KEY_CHECKS = 0")
        jdbcTemplate.execute("TRUNCATE TABLE M_CODE")
        jdbcTemplate.execute("SET FOREIGN_KEY_CHECKS = 1")
    }

    @Test
    fun `カテゴリとコードで検索できること`() {
        // テストデータの準備
        val now = LocalDateTime.now()
        jdbcTemplate.execute("""
            INSERT INTO M_CODE (
                code_category, code, code_division, name,
                code_short_name, extension1, extension2, extension3,
                extension4, extension5, extension6, extension7,
                extension8, extension9, extension10, extension11,
                extension12, extension13, extension14, extension15,
                display_order, description, is_active,
                created_at, updated_at
            ) VALUES (
                'TEST_CATEGORY', 'TEST_CODE', 'TEST_DIVISION', 'テストコード',
                'テスト', 'ext1', 'ext2', 'ext3',
                'ext4', 'ext5', 'ext6', 'ext7',
                'ext8', 'ext9', 'ext10', 'ext11',
                'ext12', 'ext13', 'ext14', 'ext15',
                1, 'テスト説明', true,
                '${now}', '${now}'
            )
        """)

        // テスト実行
        val result = codeRepositoryImpl.findByCategoryAndCode("TEST_CATEGORY", "TEST_CODE")

        // 検証
        result?.let {
            it.codeCategory shouldBe "TEST_CATEGORY"
            it.code shouldBe "TEST_CODE"
            it.codeDivision shouldBe "TEST_DIVISION"
            it.name shouldBe "テストコード"
            it.codeShortName shouldBe "テスト"
            it.extension1 shouldBe "ext1"
            it.extension2 shouldBe "ext2"
            it.extension3 shouldBe "ext3"
            it.extension4 shouldBe "ext4"
            it.extension5 shouldBe "ext5"
            it.extension6 shouldBe "ext6"
            it.extension7 shouldBe "ext7"
            it.extension8 shouldBe "ext8"
            it.extension9 shouldBe "ext9"
            it.extension10 shouldBe "ext10"
            it.extension11 shouldBe "ext11"
            it.extension12 shouldBe "ext12"
            it.extension13 shouldBe "ext13"
            it.extension14 shouldBe "ext14"
            it.extension15 shouldBe "ext15"
            it.displayOrder shouldBe 1
            it.description shouldBe "テスト説明"
            it.isActive shouldBe true
        }
    }

    @Test
    fun `新しいコードを保存できること`() {
        // Given
        val code = Code(
            codeCategory = "NEW_CATEGORY",
            code = "NEW_CODE",
            codeDivision = "NEW_DIVISION",
            name = "新規コード",
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
            isActive = true
        )

        // When
        val savedCode = codeRepositoryImpl.save(code)

        // Then
        val result = codeRepositoryImpl.findByCategoryAndCode(code.codeCategory, code.code)
        result?.let {
            it.codeCategory shouldBe code.codeCategory
            it.code shouldBe code.code
            it.codeDivision shouldBe code.codeDivision
            it.name shouldBe code.name
            it.codeShortName shouldBe code.codeShortName
            it.extension1 shouldBe code.extension1
            it.extension2 shouldBe code.extension2
            it.extension3 shouldBe code.extension3
            it.extension4 shouldBe code.extension4
            it.extension5 shouldBe code.extension5
            it.extension6 shouldBe code.extension6
            it.extension7 shouldBe code.extension7
            it.extension8 shouldBe code.extension8
            it.extension9 shouldBe code.extension9
            it.extension10 shouldBe code.extension10
            it.extension11 shouldBe code.extension11
            it.extension12 shouldBe code.extension12
            it.extension13 shouldBe code.extension13
            it.extension14 shouldBe code.extension14
            it.extension15 shouldBe code.extension15
            it.displayOrder shouldBe code.displayOrder
            it.description shouldBe code.description
            it.isActive shouldBe code.isActive
            it.createdAt shouldNotBe null
            it.updatedAt shouldNotBe null
        }
    }

    @Test
    fun `全てのコードを取得できること`() {
        // テストデータの準備
        val now = LocalDateTime.now().withNano(0)
        val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")
        
        jdbcTemplate.execute("""
            INSERT INTO M_CODE (
                code_category, code, code_division, name,
                code_short_name, extension1, extension2, extension3,
                extension4, extension5, extension6, extension7,
                extension8, extension9, extension10, extension11,
                extension12, extension13, extension14, extension15,
                display_order, description, is_active,
                created_at, updated_at
            ) VALUES
            (
                'TEST_CATEGORY_1', 'TEST_CODE_1', 'TEST_DIVISION_1', 'テストコード1',
                'テスト1', 'ext1_1', 'ext2_1', 'ext3_1',
                'ext4_1', 'ext5_1', 'ext6_1', 'ext7_1',
                'ext8_1', 'ext9_1', 'ext10_1', 'ext11_1',
                'ext12_1', 'ext13_1', 'ext14_1', 'ext15_1',
                1, 'テスト説明1', true,
                '${now.format(formatter)}', '${now.format(formatter)}'
            ),
            (
                'TEST_CATEGORY_2', 'TEST_CODE_2', 'TEST_DIVISION_2', 'テストコード2',
                'テスト2', 'ext1_2', 'ext2_2', 'ext3_2',
                'ext4_2', 'ext5_2', 'ext6_2', 'ext7_2',
                'ext8_2', 'ext9_2', 'ext10_2', 'ext11_2',
                'ext12_2', 'ext13_2', 'ext14_2', 'ext15_2',
                2, 'テスト説明2', true,
                '${now.format(formatter)}', '${now.format(formatter)}'
            )
        """)

        // テスト実行
        val results = codeRepositoryImpl.findAll()

        // 検証
        results.size shouldBe 2
        results.map { it.codeCategory }.toSet() shouldBe setOf("TEST_CATEGORY_1", "TEST_CATEGORY_2")
        results.map { it.code }.toSet() shouldBe setOf("TEST_CODE_1", "TEST_CODE_2")
        results.map { it.displayOrder }.toSet() shouldBe setOf(1, 2)
    }

    @Test
    fun `指定した日時以降に更新されたコードを取得できること`() {
        // テストデータの準備
        val baseTime = LocalDateTime.now().withNano(0)
        val beforeTime = baseTime.minusHours(1)
        val afterTime = baseTime.plusHours(1)
        val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")
        
        // 1つ目のデータを挿入
        jdbcTemplate.execute("""
            INSERT INTO M_CODE (
                code_category, code, code_division, name,
                code_short_name, extension1, extension2, extension3,
                extension4, extension5, extension6, extension7,
                extension8, extension9, extension10, extension11,
                extension12, extension13, extension14, extension15,
                display_order, description, is_active,
                created_at, updated_at
            ) VALUES (
                'TEST_CATEGORY_1', 'TEST_CODE_1', 'TEST_DIVISION_1', 'テストコード1',
                'テスト1', 'ext1_1', 'ext2_1', 'ext3_1',
                'ext4_1', 'ext5_1', 'ext6_1', 'ext7_1',
                'ext8_1', 'ext9_1', 'ext10_1', 'ext11_1',
                'ext12_1', 'ext13_1', 'ext14_1', 'ext15_1',
                1, 'テスト説明1', true,
                '${beforeTime.format(formatter)}', '${beforeTime.format(formatter)}'
            )
        """)

        // 2つ目のデータを挿入
        jdbcTemplate.execute("""
            INSERT INTO M_CODE (
                code_category, code, code_division, name,
                code_short_name, extension1, extension2, extension3,
                extension4, extension5, extension6, extension7,
                extension8, extension9, extension10, extension11,
                extension12, extension13, extension14, extension15,
                display_order, description, is_active,
                created_at, updated_at
            ) VALUES (
                'TEST_CATEGORY_2', 'TEST_CODE_2', 'TEST_DIVISION_2', 'テストコード2',
                'テスト2', 'ext1_2', 'ext2_2', 'ext3_2',
                'ext4_2', 'ext5_2', 'ext6_2', 'ext7_2',
                'ext8_2', 'ext9_2', 'ext10_2', 'ext11_2',
                'ext12_2', 'ext13_2', 'ext14_2', 'ext15_2',
                2, 'テスト説明2', true,
                '${afterTime.format(formatter)}', '${afterTime.format(formatter)}'
            )
        """)

        // テスト実行
        val results = codeRepositoryImpl.findByUpdatedAtAfter(baseTime)

        // 検証
        results.size shouldBe 1
        results[0].codeCategory shouldBe "TEST_CATEGORY_2"
        results[0].code shouldBe "TEST_CODE_2"
        results[0].displayOrder shouldBe 2
    }
} 