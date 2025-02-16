package com.example.project.code.infrastructure.repository

import com.example.project.code.domain.model.Code
import com.example.project.code.domain.repository.CodeRepository
import com.example.project.config.TestConfig
import com.example.project.jooq.CodeMasterDbTest
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

@SpringBootTest(classes = [TestConfig::class])
@ActiveProfiles("test")
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class CodeRepositoryImplTest {
    private val logger = LoggerFactory.getLogger(javaClass)

    @Autowired
    @Qualifier("codeMasterDslContext")
    private lateinit var dsl: DSLContext

    @Autowired
    @Qualifier("codeMasterTransactionManager")
    private lateinit var transactionManager: PlatformTransactionManager

    @Autowired
    private lateinit var codeRepositoryImpl: CodeRepositoryImpl

    private fun createTransactionDefinition(): DefaultTransactionDefinition {
        return DefaultTransactionDefinition().apply {
            propagationBehavior = TransactionDefinition.PROPAGATION_REQUIRES_NEW
            isolationLevel = TransactionDefinition.ISOLATION_READ_COMMITTED
            timeout = 60
        }
    }

    private fun verifyDataInsertion(expectedCount: Int) {
        val records = dsl.selectFrom(M_CODE).fetch()
        logger.info("Verifying data: found ${records.size} records, expected $expectedCount")
        records.forEach { record ->
            logger.info("Record: category=${record.get(M_CODE.CODE_CATEGORY)}, code=${record.get(M_CODE.CODE)}")
        }
        if (records.size != expectedCount) {
            throw IllegalStateException("Data verification failed. Expected $expectedCount records, but found ${records.size}")
        }
    }

    private fun cleanupDatabase() {
        logger.info("Starting database cleanup")
        val cleanupTxStatus = transactionManager.getTransaction(createTransactionDefinition())
        try {
            // まず現在のレコード数を確認
            val initialRecords = dsl.selectFrom(M_CODE).fetch()
            logger.info("Initial record count: ${initialRecords.size}")

            // 外部キー制約を無効化
            dsl.execute("SET FOREIGN_KEY_CHECKS = 0")
            logger.info("Foreign key checks disabled")

            // テーブルを切り詰める
            dsl.execute("TRUNCATE TABLE M_CODE")
            logger.info("Table truncated")

            // 外部キー制約を再度有効化
            dsl.execute("SET FOREIGN_KEY_CHECKS = 1")
            logger.info("Foreign key checks enabled")

            // AUTO_INCREMENTをリセット
            dsl.execute("ALTER TABLE M_CODE AUTO_INCREMENT = 1")
            logger.info("Auto increment reset")

            // クリーンアップ後のレコード数を確認
            val remainingRecords = dsl.selectFrom(M_CODE).fetch()
            logger.info("Remaining records after cleanup: ${remainingRecords.size}")

            if (remainingRecords.isNotEmpty()) {
                logger.error("Cleanup failed: ${remainingRecords.size} records still remain")
                remainingRecords.forEach { record ->
                    logger.error("Remaining record: category=${record.get(M_CODE.CODE_CATEGORY)}, code=${record.get(M_CODE.CODE)}")
                }
                throw IllegalStateException("Cleanup failed: ${remainingRecords.size} records still remain")
            }

            transactionManager.commit(cleanupTxStatus)
            logger.info("Cleanup transaction committed successfully")

            // コミット後の最終確認
            val finalRecords = dsl.selectFrom(M_CODE).fetch()
            logger.info("Final record count after commit: ${finalRecords.size}")
            if (finalRecords.isNotEmpty()) {
                throw IllegalStateException("Cleanup verification failed: ${finalRecords.size} records found after commit")
            }
        } catch (e: Exception) {
            logger.error("Error during cleanup: ${e.message}", e)
            try {
                transactionManager.rollback(cleanupTxStatus)
                logger.info("Cleanup transaction rolled back")
            } catch (rollbackEx: Exception) {
                logger.error("Error during rollback: ${rollbackEx.message}", rollbackEx)
            }
            throw e
        }
    }

    @BeforeEach
    fun setUp() {
        try {
            // データベースの状態を確認
            val initialRecords = dsl.selectFrom(M_CODE).fetch()
            logger.info("Initial state before setup: ${initialRecords.size} records")

            // クリーンアップを実行
            cleanupDatabase()
            logger.info("Database setup completed successfully")

            // セットアップ後の最終確認
            val setupRecords = dsl.selectFrom(M_CODE).fetch()
            logger.info("Record count after setup: ${setupRecords.size}")
            if (setupRecords.isNotEmpty()) {
                throw IllegalStateException("Setup verification failed: ${setupRecords.size} records found after setup")
            }
        } catch (e: Exception) {
            logger.error("Error during setup: ${e.message}", e)
            throw e
        }
    }

    @Test
    fun `全てのコードを取得できること`() {
        val setupTxStatus = transactionManager.getTransaction(createTransactionDefinition())
        logger.info("Data setup transaction started with ID: ${setupTxStatus.hashCode()}")
        val now = LocalDateTime.now()
        
        try {
            // データ挿入前の状態を確認
            val beforeInsertRecords = dsl.selectFrom(M_CODE).fetch()
            logger.info("Records before insertion: ${beforeInsertRecords.size}")

            logger.info("Inserting test data...")
            // 1つ目のテストデータ
            val result1 = dsl.insertInto(M_CODE)
                .set(M_CODE.CODE_CATEGORY, "TEST_CATEGORY_1")
                .set(M_CODE.CODE, "TEST_CODE_1")
                .set(M_CODE.CODE_DIVISION, "TEST_DIVISION_1")
                .set(M_CODE.NAME, "テストコード1")
                .set(M_CODE.CODE_SHORT_NAME, "テスト1")
                .set(M_CODE.DISPLAY_ORDER, 1)
                .set(M_CODE.DESCRIPTION, "テスト説明1")
                .set(M_CODE.IS_ACTIVE, true)
                .set(M_CODE.CREATED_AT, now)
                .set(M_CODE.UPDATED_AT, now)
                .execute()
            logger.info("First record inserted: $result1 rows affected")

            // 2つ目のテストデータ
            val result2 = dsl.insertInto(M_CODE)
                .set(M_CODE.CODE_CATEGORY, "TEST_CATEGORY_2")
                .set(M_CODE.CODE, "TEST_CODE_2")
                .set(M_CODE.CODE_DIVISION, "TEST_DIVISION_2")
                .set(M_CODE.NAME, "テストコード2")
                .set(M_CODE.CODE_SHORT_NAME, "テスト2")
                .set(M_CODE.DISPLAY_ORDER, 2)
                .set(M_CODE.DESCRIPTION, "テスト説明2")
                .set(M_CODE.IS_ACTIVE, true)
                .set(M_CODE.CREATED_AT, now)
                .set(M_CODE.UPDATED_AT, now)
                .execute()
            logger.info("Second record inserted: $result2 rows affected")

            verifyDataInsertion(2)
            transactionManager.commit(setupTxStatus)
            logger.info("Data setup transaction committed with ID: ${setupTxStatus.hashCode()}")

            // コミット後の確認
            val setupRecords = dsl.selectFrom(M_CODE).fetch()
            logger.info("Record count after setup commit: ${setupRecords.size}")
            if (setupRecords.size != 2) {
                throw IllegalStateException("Setup verification failed: Expected 2 records, but found ${setupRecords.size}")
            }
        } catch (e: Exception) {
            logger.error("Error during setup with transaction ID ${setupTxStatus.hashCode()}: ${e.message}", e)
            try {
                transactionManager.rollback(setupTxStatus)
                logger.info("Setup transaction rolled back")
            } catch (rollbackEx: Exception) {
                logger.error("Error during rollback: ${rollbackEx.message}", rollbackEx)
            }
            throw e
        }

        val testTxStatus = transactionManager.getTransaction(createTransactionDefinition())
        logger.info("Test execution transaction started with ID: ${testTxStatus.hashCode()}")
        try {
            logger.info("Executing test...")
            val codes = codeRepositoryImpl.findAll()
            logger.info("Found ${codes.size} codes in transaction ${testTxStatus.hashCode()}")

            codes.size shouldBe 2
            
            val firstCode = codes.find { it.code == "TEST_CODE_1" }
            firstCode shouldNotBe null
            firstCode shouldBe Code(
                codeCategory = "TEST_CATEGORY_1",
                code = "TEST_CODE_1",
                codeDivision = "TEST_DIVISION_1",
                name = "テストコード1",
                codeShortName = "テスト1",
                description = "テスト説明1",
                displayOrder = 1,
                isActive = true,
                extension1 = null,
                extension2 = null,
                extension3 = null,
                extension4 = null,
                extension5 = null,
                extension6 = null,
                extension7 = null,
                extension8 = null,
                extension9 = null,
                extension10 = null,
                extension11 = null,
                extension12 = null,
                extension13 = null,
                extension14 = null,
                extension15 = null,
                createdAt = firstCode?.createdAt ?: now,
                updatedAt = firstCode?.updatedAt ?: now
            )

            transactionManager.commit(testTxStatus)
            logger.info("Test execution transaction committed with ID: ${testTxStatus.hashCode()}")
        } catch (e: Exception) {
            logger.error("Error during test with transaction ID ${testTxStatus.hashCode()}: ${e.message}", e)
            try {
                transactionManager.rollback(testTxStatus)
                logger.info("Test transaction rolled back")
            } catch (rollbackEx: Exception) {
                logger.error("Error during rollback: ${rollbackEx.message}", rollbackEx)
            }
            throw e
        }
    }

    @Test
    fun `カテゴリとコードで検索できること`() {
        val setupTxStatus = transactionManager.getTransaction(createTransactionDefinition())
        logger.info("Data setup transaction started with ID: ${setupTxStatus.hashCode()}")
        val now = LocalDateTime.now()
        
        try {
            // データ挿入前の状態を確認
            val beforeInsertRecords = dsl.selectFrom(M_CODE).fetch()
            logger.info("Records before insertion: ${beforeInsertRecords.size}")

            logger.info("Inserting test data...")
            val result = dsl.insertInto(M_CODE)
                .set(M_CODE.CODE_CATEGORY, "TEST_CATEGORY")
                .set(M_CODE.CODE, "TEST_CODE")
                .set(M_CODE.CODE_DIVISION, "TEST_DIVISION")
                .set(M_CODE.NAME, "テストコード")
                .set(M_CODE.CODE_SHORT_NAME, "テスト")
                .set(M_CODE.DISPLAY_ORDER, 1)
                .set(M_CODE.DESCRIPTION, "テスト説明")
                .set(M_CODE.IS_ACTIVE, true)
                .set(M_CODE.CREATED_AT, now)
                .set(M_CODE.UPDATED_AT, now)
                .execute()
            logger.info("Record inserted: $result rows affected")

            verifyDataInsertion(1)
            transactionManager.commit(setupTxStatus)
            logger.info("Data setup transaction committed with ID: ${setupTxStatus.hashCode()}")

            // コミット後の確認
            val setupRecords = dsl.selectFrom(M_CODE).fetch()
            logger.info("Record count after setup commit: ${setupRecords.size}")
            if (setupRecords.size != 1) {
                throw IllegalStateException("Setup verification failed: Expected 1 record, but found ${setupRecords.size}")
            }
        } catch (e: Exception) {
            logger.error("Error during setup with transaction ID ${setupTxStatus.hashCode()}: ${e.message}", e)
            try {
                transactionManager.rollback(setupTxStatus)
                logger.info("Setup transaction rolled back")
            } catch (rollbackEx: Exception) {
                logger.error("Error during rollback: ${rollbackEx.message}", rollbackEx)
            }
            throw e
        }

        val testTxStatus = transactionManager.getTransaction(createTransactionDefinition())
        logger.info("Test execution transaction started with ID: ${testTxStatus.hashCode()}")
        try {
            logger.info("Executing test...")
            val code = codeRepositoryImpl.findByCategoryAndCode("TEST_CATEGORY", "TEST_CODE")
            logger.info("Found code: ${code != null} in transaction ${testTxStatus.hashCode()}")

            code shouldNotBe null
            code shouldBe Code(
                codeCategory = "TEST_CATEGORY",
                code = "TEST_CODE",
                codeDivision = "TEST_DIVISION",
                name = "テストコード",
                codeShortName = "テスト",
                description = "テスト説明",
                displayOrder = 1,
                isActive = true,
                extension1 = null,
                extension2 = null,
                extension3 = null,
                extension4 = null,
                extension5 = null,
                extension6 = null,
                extension7 = null,
                extension8 = null,
                extension9 = null,
                extension10 = null,
                extension11 = null,
                extension12 = null,
                extension13 = null,
                extension14 = null,
                extension15 = null,
                createdAt = code?.createdAt ?: now,
                updatedAt = code?.updatedAt ?: now
            )

            transactionManager.commit(testTxStatus)
            logger.info("Test execution transaction committed with ID: ${testTxStatus.hashCode()}")
        } catch (e: Exception) {
            logger.error("Error during test with transaction ID ${testTxStatus.hashCode()}: ${e.message}", e)
            try {
                transactionManager.rollback(testTxStatus)
                logger.info("Test transaction rolled back")
            } catch (rollbackEx: Exception) {
                logger.error("Error during rollback: ${rollbackEx.message}", rollbackEx)
            }
            throw e
        }
    }

    @Test
    fun `指定した日時以降に更新されたコードを取得できること`() {
        val setupTxStatus = transactionManager.getTransaction(createTransactionDefinition())
        logger.info("Data setup transaction started with ID: ${setupTxStatus.hashCode()}")
        val now = LocalDateTime.now()
        val laterTime = now.plusHours(1)
        
        try {
            // データ挿入前の状態を確認
            val beforeInsertRecords = dsl.selectFrom(M_CODE).fetch()
            logger.info("Records before insertion: ${beforeInsertRecords.size}")

            logger.info("Inserting test data...")
            // 1つ目のテストデータ（古い更新日時）
            val result1 = dsl.insertInto(M_CODE)
                .set(M_CODE.CODE_CATEGORY, "TEST_CATEGORY_1")
                .set(M_CODE.CODE, "TEST_CODE_1")
                .set(M_CODE.CODE_DIVISION, "TEST_DIVISION_1")
                .set(M_CODE.NAME, "テストコード1")
                .set(M_CODE.CODE_SHORT_NAME, "テスト1")
                .set(M_CODE.DISPLAY_ORDER, 1)
                .set(M_CODE.DESCRIPTION, "テスト説明1")
                .set(M_CODE.IS_ACTIVE, true)
                .set(M_CODE.CREATED_AT, now)
                .set(M_CODE.UPDATED_AT, now)
                .execute()
            logger.info("First record inserted: $result1 rows affected")

            // 2つ目のテストデータ（新しい更新日時）
            val result2 = dsl.insertInto(M_CODE)
                .set(M_CODE.CODE_CATEGORY, "TEST_CATEGORY_2")
                .set(M_CODE.CODE, "TEST_CODE_2")
                .set(M_CODE.CODE_DIVISION, "TEST_DIVISION_2")
                .set(M_CODE.NAME, "テストコード2")
                .set(M_CODE.CODE_SHORT_NAME, "テスト2")
                .set(M_CODE.DISPLAY_ORDER, 2)
                .set(M_CODE.DESCRIPTION, "テスト説明2")
                .set(M_CODE.IS_ACTIVE, true)
                .set(M_CODE.CREATED_AT, laterTime)
                .set(M_CODE.UPDATED_AT, laterTime)
                .execute()
            logger.info("Second record inserted: $result2 rows affected")

            verifyDataInsertion(2)
            transactionManager.commit(setupTxStatus)
            logger.info("Data setup transaction committed with ID: ${setupTxStatus.hashCode()}")

            // コミット後の確認
            val setupRecords = dsl.selectFrom(M_CODE).fetch()
            logger.info("Record count after setup commit: ${setupRecords.size}")
            if (setupRecords.size != 2) {
                throw IllegalStateException("Setup verification failed: Expected 2 records, but found ${setupRecords.size}")
            }
        } catch (e: Exception) {
            logger.error("Error during setup with transaction ID ${setupTxStatus.hashCode()}: ${e.message}", e)
            try {
                transactionManager.rollback(setupTxStatus)
                logger.info("Setup transaction rolled back")
            } catch (rollbackEx: Exception) {
                logger.error("Error during rollback: ${rollbackEx.message}", rollbackEx)
            }
            throw e
        }

        val testTxStatus = transactionManager.getTransaction(createTransactionDefinition())
        logger.info("Test execution transaction started with ID: ${testTxStatus.hashCode()}")
        try {
            logger.info("Executing test...")
            val codes = codeRepositoryImpl.findByUpdatedAtAfter(now)
            logger.info("Found ${codes.size} codes in transaction ${testTxStatus.hashCode()}")

            codes.size shouldBe 1
            
            val code = codes.first()
            code shouldBe Code(
                codeCategory = "TEST_CATEGORY_2",
                code = "TEST_CODE_2",
                codeDivision = "TEST_DIVISION_2",
                name = "テストコード2",
                codeShortName = "テスト2",
                description = "テスト説明2",
                displayOrder = 2,
                isActive = true,
                extension1 = null,
                extension2 = null,
                extension3 = null,
                extension4 = null,
                extension5 = null,
                extension6 = null,
                extension7 = null,
                extension8 = null,
                extension9 = null,
                extension10 = null,
                extension11 = null,
                extension12 = null,
                extension13 = null,
                extension14 = null,
                extension15 = null,
                createdAt = code.createdAt,
                updatedAt = code.updatedAt
            )

            transactionManager.commit(testTxStatus)
            logger.info("Test execution transaction committed with ID: ${testTxStatus.hashCode()}")
        } catch (e: Exception) {
            logger.error("Error during test with transaction ID ${testTxStatus.hashCode()}: ${e.message}", e)
            try {
                transactionManager.rollback(testTxStatus)
                logger.info("Test transaction rolled back")
            } catch (rollbackEx: Exception) {
                logger.error("Error during rollback: ${rollbackEx.message}", rollbackEx)
            }
            throw e
        }
    }
} 