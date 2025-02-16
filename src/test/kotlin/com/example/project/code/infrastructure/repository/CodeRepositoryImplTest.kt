package com.example.project.code.infrastructure.repository

import org.springframework.boot.test.context.SpringBootTest
import org.springframework.transaction.annotation.Transactional
import org.springframework.test.annotation.Commit
import org.jooq.DSLContext
import org.slf4j.LoggerFactory
import org.junit.jupiter.api.*
import org.junit.jupiter.api.Assertions.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.beans.factory.annotation.Qualifier
import com.example.project.code.domain.model.Code
import com.example.project.code.domain.repository.CodeRepository
import com.example.project.jooq.tables.MCode.Companion.M_CODE
import com.example.project.config.TestConfig
import java.time.LocalDateTime
import java.util.concurrent.TimeUnit
import org.springframework.test.context.ActiveProfiles

@SpringBootTest(classes = [TestConfig::class])
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@ActiveProfiles("test")
@TestMethodOrder(MethodOrderer.OrderAnnotation::class)
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
        logger.info("Setting up test environment")
        cleanupTestData()
    }

    @AfterEach
    fun tearDown() {
        logger.info("Cleaning up after test case")
        cleanupTestData()
    }

    private fun cleanupTestData() {
        logger.info("Cleaning up test data for current test")
        dslContext.transaction { config ->
            val deletedRows = config.dsl()
                .deleteFrom(M_CODE)
                .where(M_CODE.CODE_CATEGORY.eq("TEST"))
                .execute()
            logger.info("Deleted $deletedRows test records")
        }
    }

    private fun cleanupAllTestData() {
        logger.info("Cleaning up all test data")
        try {
            dslContext.transaction { config ->
                val deletedCount = config.dsl().deleteFrom(M_CODE).execute()
                logger.info("Deleted $deletedCount records in total")
            }
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
        
        dslContext.transaction { config ->
            val testCode = Code(
                codeCategory = "TEST",
                code = "TEST_CODE_1",
                codeDivision = "TEST_DIV",
                name = "テストコード",
                codeShortName = "TEST",
                description = "テスト用のコードです",
                displayOrder = 1,
                isActive = true,
                createdAt = LocalDateTime.now(),
                updatedAt = LocalDateTime.now()
            )

            logger.info("Saving test code: $testCode")
            val savedResult = codeRepository.save(testCode)
            assertNotNull(savedResult, "Saved result should not be null")

            // 明示的にコミット
            config.dsl().connection { it.commit() }

            val savedCode = codeRepository.findByCategoryAndCode("TEST", "TEST_CODE_1")
            logger.info("Database record after save: $savedCode")

            assertNotNull(savedCode, "Saved code should not be null")
            savedCode?.let {
                assertEquals(testCode.code, it.code)
                assertEquals(testCode.codeCategory, it.codeCategory)
                assertEquals(testCode.codeDivision, it.codeDivision)
                assertEquals(testCode.name, it.name)
                assertEquals(testCode.codeShortName, it.codeShortName)
                assertEquals(testCode.description, it.description)
                assertEquals(testCode.displayOrder, it.displayOrder)
                assertEquals(testCode.isActive, it.isActive)
            }
        }
    }

    @Test
    @Order(2)
    @Timeout(value = 10, unit = TimeUnit.SECONDS)
    fun testFindByCode() {
        logger.info("Starting testFindByCode")
        
        dslContext.transaction { config ->
            val testCode = Code(
                codeCategory = "TEST",
                code = "TEST_CODE_2",
                codeDivision = "TEST_DIV",
                name = "テストコード2",
                codeShortName = "TEST2",
                description = "テスト用のコードです2",
                displayOrder = 2,
                isActive = true,
                createdAt = LocalDateTime.now(),
                updatedAt = LocalDateTime.now()
            )

            logger.info("Saving test code: $testCode")
            val savedResult = codeRepository.save(testCode)
            assertNotNull(savedResult, "Saved result should not be null")

            // 明示的にコミット
            config.dsl().connection { it.commit() }

            val foundCode = codeRepository.findByCategoryAndCode("TEST", "TEST_CODE_2")
            logger.info("Database record after save: $foundCode")

            assertNotNull(foundCode, "Found code should not be null")
            foundCode?.let {
                assertEquals(testCode.code, it.code)
                assertEquals(testCode.codeCategory, it.codeCategory)
                assertEquals(testCode.codeDivision, it.codeDivision)
                assertEquals(testCode.name, it.name)
                assertEquals(testCode.codeShortName, it.codeShortName)
                assertEquals(testCode.description, it.description)
                assertEquals(testCode.displayOrder, it.displayOrder)
                assertEquals(testCode.isActive, it.isActive)
            }
        }
    }
} 