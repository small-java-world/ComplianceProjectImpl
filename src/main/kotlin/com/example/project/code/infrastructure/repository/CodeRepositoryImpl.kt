package com.example.project.code.infrastructure.repository

import com.example.project.code.domain.model.Code
import com.example.project.code.domain.repository.CodeRepository
import com.example.project.jooq.tables.MCode.Companion.M_CODE
import org.jooq.DSLContext
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.stereotype.Repository
import java.time.LocalDateTime

@Repository
class CodeRepositoryImpl(
    @Qualifier("codeMasterDslContext") private val dslContext: DSLContext
) : CodeRepository {
    private val logger = LoggerFactory.getLogger(javaClass)

    override fun findAll(): List<Code> {
        logger.info("Finding all codes")
        return try {
            val result = dslContext.selectFrom(M_CODE)
                .orderBy(M_CODE.DISPLAY_ORDER.asc())
                .fetch()
                .map { record ->
                    Code(
                        codeCategory = record.get(M_CODE.CODE_CATEGORY) ?: throw IllegalStateException("codeCategory must not be null"),
                        code = record.get(M_CODE.CODE) ?: throw IllegalStateException("code must not be null"),
                        codeDivision = record.get(M_CODE.CODE_DIVISION) ?: throw IllegalStateException("codeDivision must not be null"),
                        name = record.get(M_CODE.NAME) ?: throw IllegalStateException("name must not be null"),
                        codeShortName = record.get(M_CODE.CODE_SHORT_NAME),
                        description = record.get(M_CODE.DESCRIPTION),
                        displayOrder = record.get(M_CODE.DISPLAY_ORDER) ?: throw IllegalStateException("displayOrder must not be null"),
                        isActive = record.get(M_CODE.IS_ACTIVE) ?: throw IllegalStateException("isActive must not be null"),
                        extension1 = record.get(M_CODE.EXTENSION1),
                        extension2 = record.get(M_CODE.EXTENSION2),
                        extension3 = record.get(M_CODE.EXTENSION3),
                        extension4 = record.get(M_CODE.EXTENSION4),
                        extension5 = record.get(M_CODE.EXTENSION5),
                        extension6 = record.get(M_CODE.EXTENSION6),
                        extension7 = record.get(M_CODE.EXTENSION7),
                        extension8 = record.get(M_CODE.EXTENSION8),
                        extension9 = record.get(M_CODE.EXTENSION9),
                        extension10 = record.get(M_CODE.EXTENSION10),
                        extension11 = record.get(M_CODE.EXTENSION11),
                        extension12 = record.get(M_CODE.EXTENSION12),
                        extension13 = record.get(M_CODE.EXTENSION13),
                        extension14 = record.get(M_CODE.EXTENSION14),
                        extension15 = record.get(M_CODE.EXTENSION15),
                        createdAt = record.get(M_CODE.CREATED_AT) ?: LocalDateTime.now(),
                        updatedAt = record.get(M_CODE.UPDATED_AT) ?: LocalDateTime.now()
                    )
                }
            logger.info("Found ${result.size} codes")
            result
        } catch (e: Exception) {
            logger.error("Error finding all codes: ${e.message}", e)
            throw e
        }
    }

    override fun findByUpdatedAtAfter(updatedAt: LocalDateTime): List<Code> {
        logger.info("Finding codes updated after: $updatedAt")
        return try {
            val result = dslContext.selectFrom(M_CODE)
                .where(M_CODE.UPDATED_AT.greaterThan(updatedAt))
                .orderBy(M_CODE.DISPLAY_ORDER.asc())
                .fetch()
                .map { record ->
                    Code(
                        codeCategory = record.get(M_CODE.CODE_CATEGORY) ?: throw IllegalStateException("codeCategory must not be null"),
                        code = record.get(M_CODE.CODE) ?: throw IllegalStateException("code must not be null"),
                        codeDivision = record.get(M_CODE.CODE_DIVISION) ?: throw IllegalStateException("codeDivision must not be null"),
                        name = record.get(M_CODE.NAME) ?: throw IllegalStateException("name must not be null"),
                        codeShortName = record.get(M_CODE.CODE_SHORT_NAME),
                        description = record.get(M_CODE.DESCRIPTION),
                        displayOrder = record.get(M_CODE.DISPLAY_ORDER) ?: throw IllegalStateException("displayOrder must not be null"),
                        isActive = record.get(M_CODE.IS_ACTIVE) ?: throw IllegalStateException("isActive must not be null"),
                        extension1 = record.get(M_CODE.EXTENSION1),
                        extension2 = record.get(M_CODE.EXTENSION2),
                        extension3 = record.get(M_CODE.EXTENSION3),
                        extension4 = record.get(M_CODE.EXTENSION4),
                        extension5 = record.get(M_CODE.EXTENSION5),
                        extension6 = record.get(M_CODE.EXTENSION6),
                        extension7 = record.get(M_CODE.EXTENSION7),
                        extension8 = record.get(M_CODE.EXTENSION8),
                        extension9 = record.get(M_CODE.EXTENSION9),
                        extension10 = record.get(M_CODE.EXTENSION10),
                        extension11 = record.get(M_CODE.EXTENSION11),
                        extension12 = record.get(M_CODE.EXTENSION12),
                        extension13 = record.get(M_CODE.EXTENSION13),
                        extension14 = record.get(M_CODE.EXTENSION14),
                        extension15 = record.get(M_CODE.EXTENSION15),
                        createdAt = record.get(M_CODE.CREATED_AT) ?: LocalDateTime.now(),
                        updatedAt = record.get(M_CODE.UPDATED_AT) ?: LocalDateTime.now()
                    )
                }
            logger.info("Found ${result.size} codes updated after $updatedAt")
            result
        } catch (e: Exception) {
            logger.error("Error finding codes updated after $updatedAt: ${e.message}", e)
            throw e
        }
    }

    override fun findByCategory(category: String): List<Code> {
        return dslContext.selectFrom(M_CODE)
            .where(M_CODE.CODE_CATEGORY.eq(category))
            .fetch()
            .map { record ->
                Code(
                    codeCategory = record.get(M_CODE.CODE_CATEGORY) ?: throw IllegalStateException("codeCategory must not be null"),
                    code = record.get(M_CODE.CODE) ?: throw IllegalStateException("code must not be null"),
                    codeDivision = record.get(M_CODE.CODE_DIVISION) ?: throw IllegalStateException("codeDivision must not be null"),
                    name = record.get(M_CODE.NAME) ?: throw IllegalStateException("name must not be null"),
                    codeShortName = record.get(M_CODE.CODE_SHORT_NAME),
                    description = record.get(M_CODE.DESCRIPTION),
                    displayOrder = record.get(M_CODE.DISPLAY_ORDER) ?: throw IllegalStateException("displayOrder must not be null"),
                    isActive = record.get(M_CODE.IS_ACTIVE) ?: throw IllegalStateException("isActive must not be null"),
                    extension1 = record.get(M_CODE.EXTENSION1),
                    extension2 = record.get(M_CODE.EXTENSION2),
                    extension3 = record.get(M_CODE.EXTENSION3),
                    extension4 = record.get(M_CODE.EXTENSION4),
                    extension5 = record.get(M_CODE.EXTENSION5),
                    extension6 = record.get(M_CODE.EXTENSION6),
                    extension7 = record.get(M_CODE.EXTENSION7),
                    extension8 = record.get(M_CODE.EXTENSION8),
                    extension9 = record.get(M_CODE.EXTENSION9),
                    extension10 = record.get(M_CODE.EXTENSION10),
                    extension11 = record.get(M_CODE.EXTENSION11),
                    extension12 = record.get(M_CODE.EXTENSION12),
                    extension13 = record.get(M_CODE.EXTENSION13),
                    extension14 = record.get(M_CODE.EXTENSION14),
                    extension15 = record.get(M_CODE.EXTENSION15),
                    createdAt = record.get(M_CODE.CREATED_AT) ?: LocalDateTime.now(),
                    updatedAt = record.get(M_CODE.UPDATED_AT) ?: LocalDateTime.now()
                )
            }
    }

    override fun findByCategoryAndCode(category: String, code: String): Code? {
        logger.info("Finding code by category: $category and code: $code")
        return try {
            val result = dslContext.selectFrom(M_CODE)
                .where(M_CODE.CODE_CATEGORY.eq(category))
                .and(M_CODE.CODE.eq(code))
                .fetchOne()
                ?.let { record ->
                    Code(
                        codeCategory = record.get(M_CODE.CODE_CATEGORY) ?: throw IllegalStateException("codeCategory must not be null"),
                        code = record.get(M_CODE.CODE) ?: throw IllegalStateException("code must not be null"),
                        codeDivision = record.get(M_CODE.CODE_DIVISION) ?: throw IllegalStateException("codeDivision must not be null"),
                        name = record.get(M_CODE.NAME) ?: throw IllegalStateException("name must not be null"),
                        codeShortName = record.get(M_CODE.CODE_SHORT_NAME),
                        description = record.get(M_CODE.DESCRIPTION),
                        displayOrder = record.get(M_CODE.DISPLAY_ORDER) ?: throw IllegalStateException("displayOrder must not be null"),
                        isActive = record.get(M_CODE.IS_ACTIVE) ?: throw IllegalStateException("isActive must not be null"),
                        extension1 = record.get(M_CODE.EXTENSION1),
                        extension2 = record.get(M_CODE.EXTENSION2),
                        extension3 = record.get(M_CODE.EXTENSION3),
                        extension4 = record.get(M_CODE.EXTENSION4),
                        extension5 = record.get(M_CODE.EXTENSION5),
                        extension6 = record.get(M_CODE.EXTENSION6),
                        extension7 = record.get(M_CODE.EXTENSION7),
                        extension8 = record.get(M_CODE.EXTENSION8),
                        extension9 = record.get(M_CODE.EXTENSION9),
                        extension10 = record.get(M_CODE.EXTENSION10),
                        extension11 = record.get(M_CODE.EXTENSION11),
                        extension12 = record.get(M_CODE.EXTENSION12),
                        extension13 = record.get(M_CODE.EXTENSION13),
                        extension14 = record.get(M_CODE.EXTENSION14),
                        extension15 = record.get(M_CODE.EXTENSION15),
                        createdAt = record.get(M_CODE.CREATED_AT) ?: LocalDateTime.now(),
                        updatedAt = record.get(M_CODE.UPDATED_AT) ?: LocalDateTime.now()
                    )
                }
            logger.info("Found code: ${result != null}")
            result
        } catch (e: Exception) {
            logger.error("Error finding code by category: $category and code: $code: ${e.message}", e)
            throw e
        }
    }

    override fun save(code: Code): Code {
        logger.info("Saving code: ${code.code} in category: ${code.codeCategory}")
        val now = LocalDateTime.now()
        try {
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
                set(M_CODE.CREATED_AT, now)
                set(M_CODE.UPDATED_AT, now)
            }
            record.store()
            logger.info("Successfully saved code: ${code.code} in category: ${code.codeCategory}")
            return code.copy(
                createdAt = now,
                updatedAt = now
            )
        } catch (e: Exception) {
            logger.error("Error saving code: ${code.code} in category: ${code.codeCategory}: ${e.message}", e)
            throw e
        }
    }

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
            existingRecord.update()
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
} 