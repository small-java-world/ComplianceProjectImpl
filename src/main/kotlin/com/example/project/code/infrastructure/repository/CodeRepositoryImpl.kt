package com.example.project.code.infrastructure.repository

import com.example.project.code.domain.model.Code
import com.example.project.code.domain.repository.CodeRepository
import com.example.project.jooq.tables.MCode.Companion.M_CODE
import org.jooq.DSLContext
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.stereotype.Repository
import java.time.LocalDateTime

@Repository
class CodeRepositoryImpl(
    @Qualifier("codeMasterDslContext") private val dslContext: DSLContext
) : CodeRepository {

    override fun findAll(): List<Code> {
        return dslContext.selectFrom(M_CODE)
            .orderBy(M_CODE.DISPLAY_ORDER.asc())
            .fetch()
            .map { record ->
                Code(
                    codeCategory = record.codeCategory ?: throw IllegalStateException("codeCategory must not be null"),
                    code = record.code ?: throw IllegalStateException("code must not be null"),
                    codeDivision = record.codeDivision ?: throw IllegalStateException("codeDivision must not be null"),
                    name = record.name ?: throw IllegalStateException("name must not be null"),
                    codeShortName = record.codeShortName,
                    description = record.description,
                    displayOrder = record.displayOrder ?: throw IllegalStateException("displayOrder must not be null"),
                    isActive = record.isActive ?: throw IllegalStateException("isActive must not be null"),
                    extension1 = record.extension1,
                    extension2 = record.extension2,
                    extension3 = record.extension3,
                    extension4 = record.extension4,
                    extension5 = record.extension5,
                    extension6 = record.extension6,
                    extension7 = record.extension7,
                    extension8 = record.extension8,
                    extension9 = record.extension9,
                    extension10 = record.extension10,
                    extension11 = record.extension11,
                    extension12 = record.extension12,
                    extension13 = record.extension13,
                    extension14 = record.extension14,
                    extension15 = record.extension15,
                    createdAt = record.createdAt ?: LocalDateTime.now(),
                    updatedAt = record.updatedAt ?: LocalDateTime.now()
                )
            }
    }

    override fun findByUpdatedAtAfter(updatedAt: LocalDateTime): List<Code> {
        return dslContext.selectFrom(M_CODE)
            .where(M_CODE.UPDATED_AT.gt(updatedAt))
            .orderBy(M_CODE.DISPLAY_ORDER.asc())
            .fetch()
            .map { record ->
                Code(
                    codeCategory = record.codeCategory ?: throw IllegalStateException("codeCategory must not be null"),
                    code = record.code ?: throw IllegalStateException("code must not be null"),
                    codeDivision = record.codeDivision ?: throw IllegalStateException("codeDivision must not be null"),
                    name = record.name ?: throw IllegalStateException("name must not be null"),
                    codeShortName = record.codeShortName,
                    description = record.description,
                    displayOrder = record.displayOrder ?: throw IllegalStateException("displayOrder must not be null"),
                    isActive = record.isActive ?: throw IllegalStateException("isActive must not be null"),
                    extension1 = record.extension1,
                    extension2 = record.extension2,
                    extension3 = record.extension3,
                    extension4 = record.extension4,
                    extension5 = record.extension5,
                    extension6 = record.extension6,
                    extension7 = record.extension7,
                    extension8 = record.extension8,
                    extension9 = record.extension9,
                    extension10 = record.extension10,
                    extension11 = record.extension11,
                    extension12 = record.extension12,
                    extension13 = record.extension13,
                    extension14 = record.extension14,
                    extension15 = record.extension15,
                    createdAt = record.createdAt ?: LocalDateTime.now(),
                    updatedAt = record.updatedAt ?: LocalDateTime.now()
                )
            }
    }

    override fun findByCategory(category: String): List<Code> {
        return dslContext.selectFrom(M_CODE)
            .where(M_CODE.CODE_CATEGORY.eq(category))
            .fetch()
            .map { record ->
                Code(
                    codeCategory = record.codeCategory ?: throw IllegalStateException("codeCategory must not be null"),
                    code = record.code ?: throw IllegalStateException("code must not be null"),
                    codeDivision = record.codeDivision ?: throw IllegalStateException("codeDivision must not be null"),
                    name = record.name ?: throw IllegalStateException("name must not be null"),
                    codeShortName = record.codeShortName,
                    description = record.description,
                    displayOrder = record.displayOrder ?: throw IllegalStateException("displayOrder must not be null"),
                    isActive = record.isActive ?: throw IllegalStateException("isActive must not be null"),
                    extension1 = record.extension1,
                    extension2 = record.extension2,
                    extension3 = record.extension3,
                    extension4 = record.extension4,
                    extension5 = record.extension5,
                    extension6 = record.extension6,
                    extension7 = record.extension7,
                    extension8 = record.extension8,
                    extension9 = record.extension9,
                    extension10 = record.extension10,
                    extension11 = record.extension11,
                    extension12 = record.extension12,
                    extension13 = record.extension13,
                    extension14 = record.extension14,
                    extension15 = record.extension15,
                    createdAt = record.createdAt ?: LocalDateTime.now(),
                    updatedAt = record.updatedAt ?: LocalDateTime.now()
                )
            }
    }

    override fun findByCategoryAndCode(category: String, code: String): Code? {
        return dslContext.selectFrom(M_CODE)
            .where(M_CODE.CODE_CATEGORY.eq(category))
            .and(M_CODE.CODE.eq(code))
            .fetchOne()
            ?.let { record ->
                Code(
                    codeCategory = record.codeCategory ?: throw IllegalStateException("codeCategory must not be null"),
                    code = record.code ?: throw IllegalStateException("code must not be null"),
                    codeDivision = record.codeDivision ?: throw IllegalStateException("codeDivision must not be null"),
                    name = record.name ?: throw IllegalStateException("name must not be null"),
                    codeShortName = record.codeShortName,
                    description = record.description,
                    displayOrder = record.displayOrder ?: throw IllegalStateException("displayOrder must not be null"),
                    isActive = record.isActive ?: throw IllegalStateException("isActive must not be null"),
                    extension1 = record.extension1,
                    extension2 = record.extension2,
                    extension3 = record.extension3,
                    extension4 = record.extension4,
                    extension5 = record.extension5,
                    extension6 = record.extension6,
                    extension7 = record.extension7,
                    extension8 = record.extension8,
                    extension9 = record.extension9,
                    extension10 = record.extension10,
                    extension11 = record.extension11,
                    extension12 = record.extension12,
                    extension13 = record.extension13,
                    extension14 = record.extension14,
                    extension15 = record.extension15,
                    createdAt = record.createdAt ?: LocalDateTime.now(),
                    updatedAt = record.updatedAt ?: LocalDateTime.now()
                )
            }
    }

    override fun save(code: Code): Code {
        val now = LocalDateTime.now()
        val record = dslContext.newRecord(M_CODE).apply {
            codeCategory = code.codeCategory
            this.code = code.code
            codeDivision = code.codeDivision
            name = code.name
            codeShortName = code.codeShortName
            description = code.description
            displayOrder = code.displayOrder
            isActive = code.isActive
            extension1 = code.extension1
            extension2 = code.extension2
            extension3 = code.extension3
            extension4 = code.extension4
            extension5 = code.extension5
            extension6 = code.extension6
            extension7 = code.extension7
            extension8 = code.extension8
            extension9 = code.extension9
            extension10 = code.extension10
            extension11 = code.extension11
            extension12 = code.extension12
            extension13 = code.extension13
            extension14 = code.extension14
            extension15 = code.extension15
            createdAt = now
            updatedAt = now
        }
        record.store()
        return code.copy(
            createdAt = now,
            updatedAt = now
        )
    }

    override fun update(code: Code): Code {
        val now = LocalDateTime.now()
        val existingRecord = dslContext.selectFrom(M_CODE)
            .where(M_CODE.CODE_CATEGORY.eq(code.codeCategory))
            .and(M_CODE.CODE.eq(code.code))
            .fetchOne() ?: throw IllegalStateException("Record not found")

        existingRecord.apply {
            codeDivision = code.codeDivision
            name = code.name
            codeShortName = code.codeShortName
            description = code.description
            displayOrder = code.displayOrder
            isActive = code.isActive
            extension1 = code.extension1
            extension2 = code.extension2
            extension3 = code.extension3
            extension4 = code.extension4
            extension5 = code.extension5
            extension6 = code.extension6
            extension7 = code.extension7
            extension8 = code.extension8
            extension9 = code.extension9
            extension10 = code.extension10
            extension11 = code.extension11
            extension12 = code.extension12
            extension13 = code.extension13
            extension14 = code.extension14
            extension15 = code.extension15
            updatedAt = now
        }
        existingRecord.update()
        return code.copy(
            createdAt = existingRecord.createdAt ?: now,
            updatedAt = now
        )
    }

    override fun delete(category: String, code: String) {
        dslContext.deleteFrom(M_CODE)
            .where(M_CODE.CODE_CATEGORY.eq(category))
            .and(M_CODE.CODE.eq(code))
            .execute()
    }
} 