package com.example.project.code.infrastructure.repository

import com.example.project.code.domain.model.Code
import com.example.project.code.domain.repository.CodeRepository
import com.example.project.jooq.tables.MCode.Companion.M_CODE
import org.jooq.DSLContext
import org.jooq.Record
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.stereotype.Repository
import org.springframework.transaction.annotation.Transactional
import org.springframework.transaction.annotation.Isolation
import org.springframework.transaction.annotation.Propagation
import java.time.LocalDateTime

@Repository
class CodeRepositoryImpl(
    @Qualifier("codeMasterDslContext") private val dslContext: DSLContext
) : CodeRepository {
    private val logger = LoggerFactory.getLogger(javaClass)

    @Transactional(transactionManager = "codeMasterTransactionManager", readOnly = true, propagation = Propagation.REQUIRED)
    override fun findAll(): List<Code> {
        logger.info("Finding all codes")
        return try {
            val result = dslContext.selectFrom(M_CODE)
                .orderBy(M_CODE.DISPLAY_ORDER.asc())
                .fetch()
                .map { record -> record.toCode() }
            logger.info("Found ${result.size} codes")
            result
        } catch (e: Exception) {
            logger.error("Error finding all codes: ${e.message}", e)
            throw e
        }
    }

    @Transactional(transactionManager = "codeMasterTransactionManager", readOnly = true, propagation = Propagation.REQUIRED)
    override fun findByUpdatedAtAfter(updatedAt: LocalDateTime): List<Code> {
        logger.info("Finding codes updated after: $updatedAt")
        return try {
            val result = dslContext.selectFrom(M_CODE)
                .where(M_CODE.UPDATED_AT.greaterThan(updatedAt))
                .orderBy(M_CODE.DISPLAY_ORDER.asc())
                .fetch()
                .map { record -> record.toCode() }
            logger.info("Found ${result.size} codes updated after $updatedAt")
            result
        } catch (e: Exception) {
            logger.error("Error finding codes updated after $updatedAt: ${e.message}", e)
            throw e
        }
    }

    @Transactional(transactionManager = "codeMasterTransactionManager", readOnly = true, propagation = Propagation.REQUIRED)
    override fun findByCategory(category: String): List<Code> {
        logger.info("Finding codes by category: $category")
        return try {
            val result = dslContext.selectFrom(M_CODE)
                .where(M_CODE.CODE_CATEGORY.eq(category))
                .fetch()
                .map { record -> record.toCode() }
            logger.info("Found ${result.size} codes in category: $category")
            result
        } catch (e: Exception) {
            logger.error("Error finding codes by category $category: ${e.message}", e)
            throw e
        }
    }

    @Transactional(transactionManager = "codeMasterTransactionManager", readOnly = true, propagation = Propagation.REQUIRED)
    override fun findByCategoryAndCode(category: String, code: String): Code? {
        logger.info("Finding code by category: $category and code: $code")
        try {
            val record = dslContext.selectFrom(M_CODE)
                .where(M_CODE.CODE_CATEGORY.eq(category))
                .and(M_CODE.CODE.eq(code))
                .fetchOne()

            logger.info("Found record: $record")
            return record?.let { it.toCode() }
        } catch (e: Exception) {
            logger.error("Error finding code by category: $category and code: $code: ${e.message}", e)
            throw e
        }
    }

    @Transactional(transactionManager = "codeMasterTransactionManager", propagation = Propagation.REQUIRED)
    override fun save(code: Code): Code {
        logger.info("Saving code: ${code.code} in category: ${code.codeCategory}")
        try {
            // 既存のコードを確認
            val existingCode = dslContext.selectFrom(M_CODE)
                .where(M_CODE.CODE_CATEGORY.eq(code.codeCategory))
                .and(M_CODE.CODE.eq(code.code))
                .fetchOne()

            if (existingCode != null) {
                logger.error("Code already exists: ${code.code} in category: ${code.codeCategory}")
                throw IllegalStateException("Code already exists: ${code.code} in category: ${code.codeCategory}")
            }

            // 新しいレコードを作成して保存
            val now = LocalDateTime.now()
            val record = dslContext.newRecord(M_CODE).apply {
                set(M_CODE.CODE_CATEGORY, code.codeCategory)
                set(M_CODE.CODE, code.code)
                set(M_CODE.CODE_DIVISION, code.codeDivision)
                set(M_CODE.NAME, code.name)
                set(M_CODE.CODE_SHORT_NAME, code.codeShortName)
                set(M_CODE.DESCRIPTION, code.description)
                set(M_CODE.DISPLAY_ORDER, code.displayOrder)
                set(M_CODE.IS_ACTIVE, code.isActive)
                set(M_CODE.EXTENSION1, code.extension1)
                set(M_CODE.EXTENSION2, code.extension2)
                set(M_CODE.EXTENSION3, code.extension3)
                set(M_CODE.EXTENSION4, code.extension4)
                set(M_CODE.EXTENSION5, code.extension5)
                set(M_CODE.EXTENSION6, code.extension6)
                set(M_CODE.EXTENSION7, code.extension7)
                set(M_CODE.EXTENSION8, code.extension8)
                set(M_CODE.EXTENSION9, code.extension9)
                set(M_CODE.EXTENSION10, code.extension10)
                set(M_CODE.EXTENSION11, code.extension11)
                set(M_CODE.EXTENSION12, code.extension12)
                set(M_CODE.EXTENSION13, code.extension13)
                set(M_CODE.EXTENSION14, code.extension14)
                set(M_CODE.EXTENSION15, code.extension15)
                set(M_CODE.CREATED_AT, code.createdAt)
                set(M_CODE.UPDATED_AT, code.updatedAt)
            }
            
            val result = dslContext.insertInto(M_CODE)
                .set(record)
                .execute()

            if (result == 0) {
                logger.error("Failed to save code: no rows affected")
                throw IllegalStateException("Failed to save code: no rows affected")
            }

            // 保存したレコードを取得して返す
            val savedRecord = dslContext.selectFrom(M_CODE)
                .where(M_CODE.CODE_CATEGORY.eq(code.codeCategory))
                .and(M_CODE.CODE.eq(code.code))
                .fetchOne() ?: throw IllegalStateException("Failed to retrieve saved record")

            logger.info("Successfully saved code with result: $result")
            return savedRecord.toCode()
        } catch (e: Exception) {
            logger.error("Error saving code: ${code.code} in category: ${code.codeCategory}: ${e.message}", e)
            throw e
        }
    }

    @Transactional(transactionManager = "codeMasterTransactionManager", propagation = Propagation.REQUIRED)
    override fun update(code: Code): Code {
        logger.info("Updating code: ${code.code} in category: ${code.codeCategory}")
        val now = LocalDateTime.now()
        try {
            val existingRecord = dslContext.selectFrom(M_CODE)
                .where(M_CODE.CODE_CATEGORY.eq(code.codeCategory))
                .and(M_CODE.CODE.eq(code.code))
                .fetchOne() ?: throw IllegalStateException("Record not found")

            existingRecord.apply {
                set(M_CODE.CODE_DIVISION, code.codeDivision)
                set(M_CODE.NAME, code.name)
                set(M_CODE.CODE_SHORT_NAME, code.codeShortName)
                set(M_CODE.DESCRIPTION, code.description)
                set(M_CODE.DISPLAY_ORDER, code.displayOrder)
                set(M_CODE.IS_ACTIVE, code.isActive)
                set(M_CODE.EXTENSION1, code.extension1)
                set(M_CODE.EXTENSION2, code.extension2)
                set(M_CODE.EXTENSION3, code.extension3)
                set(M_CODE.EXTENSION4, code.extension4)
                set(M_CODE.EXTENSION5, code.extension5)
                set(M_CODE.EXTENSION6, code.extension6)
                set(M_CODE.EXTENSION7, code.extension7)
                set(M_CODE.EXTENSION8, code.extension8)
                set(M_CODE.EXTENSION9, code.extension9)
                set(M_CODE.EXTENSION10, code.extension10)
                set(M_CODE.EXTENSION11, code.extension11)
                set(M_CODE.EXTENSION12, code.extension12)
                set(M_CODE.EXTENSION13, code.extension13)
                set(M_CODE.EXTENSION14, code.extension14)
                set(M_CODE.EXTENSION15, code.extension15)
                set(M_CODE.UPDATED_AT, now)
            }

            val result = dslContext.update(M_CODE)
                .set(existingRecord)
                .where(M_CODE.CODE_CATEGORY.eq(code.codeCategory))
                .and(M_CODE.CODE.eq(code.code))
                .execute()

            if (result == 0) {
                logger.error("Failed to update code: no rows affected")
                throw IllegalStateException("Failed to update code: no rows affected")
            }

            logger.info("Successfully updated code: ${code.code} in category: ${code.codeCategory}")
            return code.copy(
                createdAt = existingRecord.get(M_CODE.CREATED_AT) ?: now,
                updatedAt = now
            )
        } catch (e: Exception) {
            logger.error("Error updating code: ${code.code} in category: ${code.codeCategory}: ${e.message}", e)
            throw e
        }
    }

    @Transactional(transactionManager = "codeMasterTransactionManager", propagation = Propagation.REQUIRED)
    override fun delete(category: String, code: String) {
        logger.info("Deleting code: $code in category: $category")
        try {
            val result = dslContext.deleteFrom(M_CODE)
                .where(M_CODE.CODE_CATEGORY.eq(category))
                .and(M_CODE.CODE.eq(code))
                .execute()
            logger.info("Successfully deleted code: $code in category: $category. Affected rows: $result")
        } catch (e: Exception) {
            logger.error("Error deleting code: $code in category: $category: ${e.message}", e)
            throw e
        }
    }

    private fun Record.toCode(): Code {
        return Code(
            codeCategory = this.get(M_CODE.CODE_CATEGORY) ?: "",
            code = this.get(M_CODE.CODE) ?: "",
            codeDivision = this.get(M_CODE.CODE_DIVISION) ?: "",
            name = this.get(M_CODE.NAME) ?: "",
            codeShortName = this.get(M_CODE.CODE_SHORT_NAME),
            description = this.get(M_CODE.DESCRIPTION),
            displayOrder = this.get(M_CODE.DISPLAY_ORDER) ?: 0,
            isActive = this.get(M_CODE.IS_ACTIVE) ?: true,
            extension1 = this.get(M_CODE.EXTENSION1),
            extension2 = this.get(M_CODE.EXTENSION2),
            extension3 = this.get(M_CODE.EXTENSION3),
            extension4 = this.get(M_CODE.EXTENSION4),
            extension5 = this.get(M_CODE.EXTENSION5),
            extension6 = this.get(M_CODE.EXTENSION6),
            extension7 = this.get(M_CODE.EXTENSION7),
            extension8 = this.get(M_CODE.EXTENSION8),
            extension9 = this.get(M_CODE.EXTENSION9),
            extension10 = this.get(M_CODE.EXTENSION10),
            extension11 = this.get(M_CODE.EXTENSION11),
            extension12 = this.get(M_CODE.EXTENSION12),
            extension13 = this.get(M_CODE.EXTENSION13),
            extension14 = this.get(M_CODE.EXTENSION14),
            extension15 = this.get(M_CODE.EXTENSION15),
            createdAt = (this.get(M_CODE.CREATED_AT) as? java.sql.Timestamp)?.toLocalDateTime() ?: LocalDateTime.now(),
            updatedAt = (this.get(M_CODE.UPDATED_AT) as? java.sql.Timestamp)?.toLocalDateTime() ?: LocalDateTime.now()
        )
    }

    private fun Code.toRecord(now: LocalDateTime = LocalDateTime.now()): Record {
        return dslContext.newRecord(M_CODE).apply {
            set(M_CODE.CODE_CATEGORY, this@toRecord.codeCategory)
            set(M_CODE.CODE, this@toRecord.code)
            set(M_CODE.CODE_DIVISION, this@toRecord.codeDivision)
            set(M_CODE.NAME, this@toRecord.name)
            set(M_CODE.CODE_SHORT_NAME, this@toRecord.codeShortName)
            set(M_CODE.DESCRIPTION, this@toRecord.description)
            set(M_CODE.DISPLAY_ORDER, this@toRecord.displayOrder)
            set(M_CODE.IS_ACTIVE, this@toRecord.isActive)
            set(M_CODE.EXTENSION1, this@toRecord.extension1)
            set(M_CODE.EXTENSION2, this@toRecord.extension2)
            set(M_CODE.EXTENSION3, this@toRecord.extension3)
            set(M_CODE.EXTENSION4, this@toRecord.extension4)
            set(M_CODE.EXTENSION5, this@toRecord.extension5)
            set(M_CODE.EXTENSION6, this@toRecord.extension6)
            set(M_CODE.EXTENSION7, this@toRecord.extension7)
            set(M_CODE.EXTENSION8, this@toRecord.extension8)
            set(M_CODE.EXTENSION9, this@toRecord.extension9)
            set(M_CODE.EXTENSION10, this@toRecord.extension10)
            set(M_CODE.EXTENSION11, this@toRecord.extension11)
            set(M_CODE.EXTENSION12, this@toRecord.extension12)
            set(M_CODE.EXTENSION13, this@toRecord.extension13)
            set(M_CODE.EXTENSION14, this@toRecord.extension14)
            set(M_CODE.EXTENSION15, this@toRecord.extension15)
            set(M_CODE.CREATED_AT, now)
            set(M_CODE.UPDATED_AT, now)
        }
    }
} 