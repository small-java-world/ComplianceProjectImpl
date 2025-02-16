package com.example.project.code.infrastructure.repository

import com.example.project.code.domain.model.Code
import com.example.project.code.domain.repository.CodeRepository
import com.example.project.config.TestConfig
import com.example.project.jooq.tables.MCode.Companion.M_CODE
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import org.junit.jupiter.api.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.ActiveProfiles
import org.springframework.transaction.annotation.Transactional
import org.jooq.DSLContext
import java.time.LocalDateTime
import org.slf4j.LoggerFactory
import java.util.concurrent.TimeUnit

@SpringBootTest(classes = [TestConfig::class])
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@ActiveProfiles("test")
@TestMethodOrder(MethodOrderer.OrderAnnotation::class)
@Transactional("codeMasterTransactionManager")
class CodeRepositoryImplTest {

    @Autowired
    private lateinit var codeRepository: CodeRepository

    @Autowired
    @Qualifier("codeMasterDslContext")
    private lateinit var dslContext: DSLContext

    private val logger = LoggerFactory.getLogger(javaClass)

    @BeforeAll
    fun setUpAll() {
        logger.info("Setting up test environment")
        cleanupAllTestData()
    }

    @BeforeEach
    fun setUp() {
        logger.info("Setting up test case")
        cleanupTestData()
    }

    private fun cleanupTestData() {
        logger.info("Cleaning up test data for current test")
        try {
            val deletedCount = dslContext.deleteFrom(M_CODE)
                .where(M_CODE.CODE_CATEGORY.eq("TEST"))
                .execute()
            logger.info("Deleted $deletedCount test records")
        } catch (e: Exception) {
            logger.error("Error during test data cleanup: ${e.message}", e)
            throw e
        }
    }

    private fun cleanupAllTestData() {
        logger.info("Cleaning up all test data")
        try {
            val deletedCount = dslContext.deleteFrom(M_CODE).execute()
            logger.info("Deleted $deletedCount records in total")
        } catch (e: Exception) {
            logger.error("Failed to cleanup all test data: ${e.message}", e)
            throw e
        }
    }

    @Test
    @Order(1)
    @Timeout(value = 10, unit = TimeUnit.SECONDS)
    fun testSaveAndFind() {
        logger.info("Starting testSaveAndFind")
        
        // テストデータ作成
        val now = LocalDateTime.now()
        val code = Code(
            codeCategory = "TEST",
            code = "TEST_CODE",
            codeDivision = "TEST_DIV",
            name = "テストコード",
            codeShortName = "TEST",
            description = "テスト用のコードです",
            displayOrder = 1,
            isActive = true,
            createdAt = now,
            updatedAt = now
        )

        // 保存
        logger.info("Saving test code: $code")
        val savedCode = codeRepository.save(code)
        logger.info("Saved code successfully: $savedCode")

        // データベースの状態を確認
        val dbRecord = dslContext.selectFrom(M_CODE)
            .where(M_CODE.CODE_CATEGORY.eq("TEST"))
            .and(M_CODE.CODE.eq("TEST_CODE"))
            .fetchOne()
        logger.info("Database record after save: $dbRecord")
        dbRecord shouldNotBe null

        // リポジトリを通じた検索の検証
        logger.info("Verifying saved code through repository")
        val found = codeRepository.findByCategoryAndCode("TEST", "TEST_CODE")
        logger.info("Found code: $found")

        found shouldNotBe null
        found?.let {
            logger.info("Verifying code properties")
            it.codeCategory shouldBe "TEST"
            it.code shouldBe "TEST_CODE"
            it.codeDivision shouldBe "TEST_DIV"
            it.name shouldBe "テストコード"
            it.codeShortName shouldBe "TEST"
            it.description shouldBe "テスト用のコードです"
            it.displayOrder shouldBe 1
            it.isActive shouldBe true
            it.createdAt shouldNotBe null
            it.updatedAt shouldNotBe null
        }

        // データ件数の検証
        val count = dslContext.selectCount().from(M_CODE)
            .where(M_CODE.CODE_CATEGORY.eq("TEST"))
            .fetchOne(0, Int::class.java)
        logger.info("Record count after save: $count")
        count shouldBe 1
    }

    @Test
    @Order(2)
    @Timeout(value = 10, unit = TimeUnit.SECONDS)
    fun testFindByCode() {
        logger.info("Starting testFindByCode")
        
        // テストデータ作成
        val now = LocalDateTime.now()
        val code = Code(
            codeCategory = "TEST",
            code = "TEST_CODE",
            codeDivision = "TEST_DIV",
            name = "テストコード",
            codeShortName = "TEST",
            description = "テスト用のコードです",
            displayOrder = 1,
            isActive = true,
            createdAt = now,
            updatedAt = now
        )

        // 保存
        logger.info("Saving test code: $code")
        val savedCode = codeRepository.save(code)
        logger.info("Saved code successfully: $savedCode")

        // データベースの状態を確認
        val dbRecord = dslContext.selectFrom(M_CODE)
            .where(M_CODE.CODE_CATEGORY.eq("TEST"))
            .and(M_CODE.CODE.eq("TEST_CODE"))
            .fetchOne()
        logger.info("Database record after save: $dbRecord")
        dbRecord shouldNotBe null

        // 検索と検証
        logger.info("Verifying findByCategoryAndCode")
        val found = codeRepository.findByCategoryAndCode("TEST", "TEST_CODE")
        logger.info("Found code: $found")

        found shouldNotBe null
        found?.let {
            logger.info("Verifying found code properties")
            it.codeCategory shouldBe "TEST"
            it.code shouldBe "TEST_CODE"
            it.codeDivision shouldBe "TEST_DIV"
            it.name shouldBe "テストコード"
            it.codeShortName shouldBe "TEST"
            it.description shouldBe "テスト用のコードです"
            it.displayOrder shouldBe 1
            it.isActive shouldBe true
            it.createdAt shouldNotBe null
            it.updatedAt shouldNotBe null
        }
    }
} 