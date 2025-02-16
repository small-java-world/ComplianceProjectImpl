package com.example.project.code.infrastructure.repository

import com.example.project.code.domain.model.Code
import com.example.project.code.domain.repository.CodeRepository
import com.example.project.jooq.tables.MCode.Companion.M_CODE
import io.github.oshai.kotlinlogging.KotlinLogging
import org.jooq.DSLContext
import org.jooq.Record
import org.springframework.stereotype.Repository
import org.springframework.transaction.annotation.Transactional
import org.springframework.transaction.annotation.Isolation
import org.springframework.transaction.annotation.Propagation
import java.time.LocalDateTime

private val logger = KotlinLogging.logger {}

@Repository
class CodeRepositoryImpl(
    private val dslContext: DSLContext
) : CodeRepository {

    override fun save(code: Code): Code {
        logger.info { "Saving code: $code" }
        return dslContext.transactionResult { config ->
            try {
                val now = LocalDateTime.now()
                val result = config.dsl().insertInto(M_CODE)
                    .set(M_CODE.CODE_CATEGORY, code.codeCategory)
                    .set(M_CODE.CODE, code.code)
                    .set(M_CODE.CODE_DIVISION, code.codeDivision)
                    .set(M_CODE.NAME, code.name)
                    .set(M_CODE.CODE_SHORT_NAME, code.codeShortName)
                    .set(M_CODE.DESCRIPTION, code.description)
                    .set(M_CODE.DISPLAY_ORDER, code.displayOrder)
                    .set(M_CODE.IS_ACTIVE, code.isActive)
                    .set(M_CODE.EXTENSION1, code.extension1)
                    .set(M_CODE.EXTENSION2, code.extension2)
                    .set(M_CODE.EXTENSION3, code.extension3)
                    .set(M_CODE.EXTENSION4, code.extension4)
                    .set(M_CODE.EXTENSION5, code.extension5)
                    .set(M_CODE.EXTENSION6, code.extension6)
                    .set(M_CODE.EXTENSION7, code.extension7)
                    .set(M_CODE.EXTENSION8, code.extension8)
                    .set(M_CODE.EXTENSION9, code.extension9)
                    .set(M_CODE.EXTENSION10, code.extension10)
                    .set(M_CODE.EXTENSION11, code.extension11)
                    .set(M_CODE.EXTENSION12, code.extension12)
                    .set(M_CODE.EXTENSION13, code.extension13)
                    .set(M_CODE.EXTENSION14, code.extension14)
                    .set(M_CODE.EXTENSION15, code.extension15)
                    .set(M_CODE.CREATED_AT, now)
                    .set(M_CODE.UPDATED_AT, now)
                    .execute()

                if (result == 0) {
                    logger.error { "Failed to save code: no rows affected" }
                    throw IllegalStateException("Failed to save code: no rows affected")
                }

                logger.info { "Code saved successfully: $code" }
                
                // 同一トランザクション内で検索
                val savedCode = findByCategoryAndCodeInternal(config.dsl(), code.codeCategory, code.code)
                savedCode ?: throw IllegalStateException("Saved code not found: $code")
            } catch (e: Exception) {
                logger.error(e) { "Failed to save code: $code" }
                throw e
            }
        }
    }

    override fun findByCategoryAndCode(codeCategory: String, code: String): Code? {
        logger.info { "Finding code by category: $codeCategory and code: $code" }
        return dslContext.transactionResult { config ->
            findByCategoryAndCodeInternal(config.dsl(), codeCategory, code)
        }
    }

    private fun findByCategoryAndCodeInternal(dsl: DSLContext, codeCategory: String, code: String): Code? {
        val record = dsl.selectFrom(M_CODE)
            .where(M_CODE.CODE_CATEGORY.eq(codeCategory))
            .and(M_CODE.CODE.eq(code))
            .fetchOne()

        logger.info { "Found code: $record" }
        return record?.let {
            Code(
                codeCategory = it.codeCategory,
                code = it.code,
                codeDivision = it.codeDivision,
                name = it.name,
                codeShortName = it.codeShortName,
                description = it.description,
                displayOrder = it.displayOrder ?: 0,
                isActive = it.isActive ?: true,
                extension1 = it.extension1,
                extension2 = it.extension2,
                extension3 = it.extension3,
                extension4 = it.extension4,
                extension5 = it.extension5,
                extension6 = it.extension6,
                extension7 = it.extension7,
                extension8 = it.extension8,
                extension9 = it.extension9,
                extension10 = it.extension10,
                extension11 = it.extension11,
                extension12 = it.extension12,
                extension13 = it.extension13,
                extension14 = it.extension14,
                extension15 = it.extension15,
                createdAt = it.createdAt ?: LocalDateTime.now(),
                updatedAt = it.updatedAt ?: LocalDateTime.now()
            )
        }
    }

    @Transactional(transactionManager = "codeMasterTransactionManager", readOnly = true, propagation = Propagation.REQUIRED)
    override fun findAll(): List<Code> {
        logger.info { "Finding all codes" }
        return try {
            val result = dslContext.selectFrom(M_CODE)
                .orderBy(M_CODE.DISPLAY_ORDER.asc())
                .fetch()
                .map { record -> record.toCode() }
            logger.info { "Found ${result.size} codes" }
            result
        } catch (e: Exception) {
            logger.error(e) { "Failed to find all codes" }
            throw e
        }
    }

    @Transactional(transactionManager = "codeMasterTransactionManager", readOnly = true, propagation = Propagation.REQUIRED)
    override fun findByUpdatedAtAfter(updatedAt: LocalDateTime): List<Code> {
        logger.info { "Finding codes updated after: $updatedAt" }
        return try {
            val result = dslContext.selectFrom(M_CODE)
                .where(M_CODE.UPDATED_AT.greaterThan(updatedAt))
                .orderBy(M_CODE.DISPLAY_ORDER.asc())
                .fetch()
                .map { record -> record.toCode() }
            logger.info { "Found ${result.size} codes updated after $updatedAt" }
            result
        } catch (e: Exception) {
            logger.error(e) { "Failed to find codes updated after $updatedAt" }
            throw e
        }
    }

    @Transactional(transactionManager = "codeMasterTransactionManager", readOnly = true, propagation = Propagation.REQUIRED)
    override fun findByCategory(category: String): List<Code> {
        logger.info { "Finding codes by category: $category" }
        return try {
            val result = dslContext.selectFrom(M_CODE)
                .where(M_CODE.CODE_CATEGORY.eq(category))
                .fetch()
                .map { record -> record.toCode() }
            logger.info { "Found ${result.size} codes in category: $category" }
            result
        } catch (e: Exception) {
            logger.error(e) { "Failed to find codes by category: $category" }
            throw e
        }
    }

    @Transactional(transactionManager = "codeMasterTransactionManager", propagation = Propagation.REQUIRED)
    override fun update(code: Code): Code {
        logger.info { "Updating code: $code" }
        val now = LocalDateTime.now()
        try {
            val existingRecord = dslContext.selectFrom(M_CODE)
                .where(M_CODE.CODE_CATEGORY.eq(code.codeCategory))
                .and(M_CODE.CODE.eq(code.code))
                .fetchOne() ?: throw IllegalStateException("Record not found")

            val result = dslContext.update(M_CODE)
                .set(M_CODE.CODE_DIVISION, code.codeDivision)
                .set(M_CODE.NAME, code.name)
                .set(M_CODE.CODE_SHORT_NAME, code.codeShortName)
                .set(M_CODE.DESCRIPTION, code.description)
                .set(M_CODE.DISPLAY_ORDER, code.displayOrder)
                .set(M_CODE.IS_ACTIVE, code.isActive)
                .set(M_CODE.EXTENSION1, code.extension1)
                .set(M_CODE.EXTENSION2, code.extension2)
                .set(M_CODE.EXTENSION3, code.extension3)
                .set(M_CODE.EXTENSION4, code.extension4)
                .set(M_CODE.EXTENSION5, code.extension5)
                .set(M_CODE.EXTENSION6, code.extension6)
                .set(M_CODE.EXTENSION7, code.extension7)
                .set(M_CODE.EXTENSION8, code.extension8)
                .set(M_CODE.EXTENSION9, code.extension9)
                .set(M_CODE.EXTENSION10, code.extension10)
                .set(M_CODE.EXTENSION11, code.extension11)
                .set(M_CODE.EXTENSION12, code.extension12)
                .set(M_CODE.EXTENSION13, code.extension13)
                .set(M_CODE.EXTENSION14, code.extension14)
                .set(M_CODE.EXTENSION15, code.extension15)
                .set(M_CODE.UPDATED_AT, now)
                .where(M_CODE.CODE_CATEGORY.eq(code.codeCategory))
                .and(M_CODE.CODE.eq(code.code))
                .execute()

            if (result == 0) {
                logger.error { "Failed to update code: no rows affected" }
                throw IllegalStateException("Failed to update code: no rows affected")
            }

            logger.info { "Code updated successfully: $code" }
            return code.copy(
                createdAt = existingRecord.get(M_CODE.CREATED_AT) ?: now,
                updatedAt = now
            )
        } catch (e: Exception) {
            logger.error(e) { "Failed to update code: $code" }
            throw e
        }
    }

    @Transactional(transactionManager = "codeMasterTransactionManager", propagation = Propagation.REQUIRED)
    override fun delete(category: String, code: String) {
        logger.info { "Deleting code by category: $category and code: $code" }
        try {
            val result = dslContext.deleteFrom(M_CODE)
                .where(M_CODE.CODE_CATEGORY.eq(category))
                .and(M_CODE.CODE.eq(code))
                .execute()
            logger.info { "Successfully deleted code: $code in category: $category. Affected rows: $result" }
            if (result == 0) {
                logger.error { "No code found to delete for category: $category and code: $code" }
                throw IllegalStateException("Failed to delete code: no rows affected")
            }
        } catch (e: Exception) {
            logger.error(e) { "Failed to delete code by category: $category and code: $code" }
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
            createdAt = this.get(M_CODE.CREATED_AT) ?: LocalDateTime.now(),
            updatedAt = this.get(M_CODE.UPDATED_AT) ?: LocalDateTime.now()
        )
    }
} 