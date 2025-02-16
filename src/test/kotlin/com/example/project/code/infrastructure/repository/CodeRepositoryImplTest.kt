package com.example.project.code.infrastructure.repository

import com.example.project.code.domain.model.Code
import com.example.project.code.domain.repository.CodeRepository
import com.example.project.config.TestConfig
import com.example.project.jooq.tables.MCode.Companion.M_CODE
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.ActiveProfiles
import org.springframework.transaction.PlatformTransactionManager
import org.springframework.transaction.TransactionDefinition
import org.springframework.transaction.support.DefaultTransactionDefinition
import org.jooq.DSLContext
import java.time.LocalDateTime
import org.slf4j.LoggerFactory
import org.springframework.transaction.annotation.Transactional
import org.springframework.transaction.annotation.Isolation
import org.springframework.transaction.support.TransactionTemplate

@SpringBootTest(classes = [TestConfig::class])
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@ActiveProfiles("test")
class CodeRepositoryImplTest {

    @Autowired
    private lateinit var codeRepository: CodeRepository

    @Autowired
    private lateinit var dslContext: DSLContext

    @Autowired
    @Qualifier("codeMasterTransactionManager")
    private lateinit var transactionManager: PlatformTransactionManager

    private val logger = LoggerFactory.getLogger(javaClass)
    private lateinit var transactionTemplate: TransactionTemplate

    @BeforeEach
    fun setUp() {
        transactionTemplate = TransactionTemplate(transactionManager).apply {
            isolationLevel = TransactionDefinition.ISOLATION_READ_COMMITTED
            timeout = 180
            isReadOnly = false
        }

        transactionTemplate.execute { _ ->
            dslContext.deleteFrom(M_CODE).execute()
        }
    }

    @Test
    fun testSaveAndFind() {
        transactionTemplate.execute { _ ->
            // テストデータ作成
            val code = Code(
                codeCategory = "TEST",
                code = "TEST_CODE",
                codeDivision = "TEST_DIV",
                name = "テストコード",
                codeShortName = "TEST",
                description = "テスト用のコードです",
                displayOrder = 1,
                isActive = true,
                createdAt = LocalDateTime.now(),
                updatedAt = LocalDateTime.now()
            )

            // 保存
            codeRepository.save(code)

            // 検証
            val found = codeRepository.findByCategoryAndCode("TEST", "TEST_CODE")
            found shouldNotBe null
            found?.let {
                it.code shouldBe "TEST_CODE"
                it.name shouldBe "テストコード"
                it.description shouldBe "テスト用のコードです"
                it.displayOrder shouldBe 1
                it.isActive shouldBe true
            }
            verifyDataInsertion(1)
        }
    }

    @Test
    fun testFindByCode() {
        transactionTemplate.execute { _ ->
            // テストデータ作成
            val code = Code(
                codeCategory = "TEST",
                code = "TEST_CODE",
                codeDivision = "TEST_DIV",
                name = "テストコード",
                codeShortName = "TEST",
                description = "テスト用のコードです",
                displayOrder = 1,
                isActive = true,
                createdAt = LocalDateTime.now(),
                updatedAt = LocalDateTime.now()
            )

            // 保存
            codeRepository.save(code)

            // 検証
            val found = codeRepository.findByCategoryAndCode("TEST", "TEST_CODE")
            found shouldNotBe null
            found?.let {
                it.codeCategory shouldBe "TEST"
                it.name shouldBe "テストコード"
                it.description shouldBe "テスト用のコードです"
                it.displayOrder shouldBe 1
                it.isActive shouldBe true
            }
            verifyDataInsertion(1)
        }
    }

    private fun verifyDataInsertion(expectedCount: Int) {
        val actualCount = dslContext.selectCount().from(M_CODE).fetchOne(0, Int::class.java)
        logger.info("Expected count: $expectedCount, Actual count: $actualCount")
        actualCount shouldBe expectedCount
    }
} 