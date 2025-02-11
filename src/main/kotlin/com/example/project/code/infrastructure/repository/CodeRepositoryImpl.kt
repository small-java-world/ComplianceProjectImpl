package com.example.project.code.infrastructure.repository

import com.example.project.code.domain.model.Code
import com.example.project.code.domain.repository.CodeRepository
import com.example.project.jooq.tables.MCode
import com.example.project.jooq.tables.records.MCodeRecord
import org.jooq.DSLContext
import org.jooq.impl.DSL
import org.springframework.stereotype.Repository
import java.time.LocalDateTime

@Repository
class CodeRepositoryImpl(
    private val dsl: DSLContext
) : CodeRepository {

    private val m = MCode.M_CODE

    override fun findByCodeCategory(codeCategory: String): List<Code> {
        return dsl.selectFrom(m)
            .where(m.CODE_CATEGORY.eq(codeCategory))
            .orderBy(m.DISPLAY_ORDER.asc())
            .fetch()
            .map { record -> record.toCode() }
    }

    override fun findByCodeCategoryAndCode(codeCategory: String, code: String): Code? {
        return dsl.selectFrom(m)
            .where(
                m.CODE_CATEGORY.eq(codeCategory)
                    .and(m.CODE.eq(code))
            )
            .fetchOne()
            ?.toCode()
    }

    override fun save(code: Code): Code {
        dsl.insertInto(m)
            .set(m.CODE_CATEGORY, code.codeCategory)
            .set(m.CODE, code.code)
            .set(m.CODE_DIVISION, code.codeDivision)
            .set(m.CODE_NAME, code.codeName)
            .set(m.CODE_SHORT_NAME, code.codeShortName)
            .set(m.EXTENSION1, code.extension1)
            .set(m.EXTENSION2, code.extension2)
            .set(m.EXTENSION3, code.extension3)
            .set(m.EXTENSION4, code.extension4)
            .set(m.EXTENSION5, code.extension5)
            .set(m.EXTENSION6, code.extension6)
            .set(m.EXTENSION7, code.extension7)
            .set(m.EXTENSION8, code.extension8)
            .set(m.EXTENSION9, code.extension9)
            .set(m.EXTENSION10, code.extension10)
            .set(m.EXTENSION11, code.extension11)
            .set(m.EXTENSION12, code.extension12)
            .set(m.EXTENSION13, code.extension13)
            .set(m.EXTENSION14, code.extension14)
            .set(m.EXTENSION15, code.extension15)
            .set(m.DISPLAY_ORDER, code.displayOrder)
            .set(m.IS_ACTIVE, code.isActive)
            .set(m.DESCRIPTION, code.description)
            .set(m.CREATED_AT, code.createdAt)
            .set(m.UPDATED_AT, code.updatedAt)
            .execute()

        return code
    }

    override fun update(code: Code): Code {
        dsl.update(m)
            .set(m.CODE_DIVISION, code.codeDivision)
            .set(m.CODE_NAME, code.codeName)
            .set(m.CODE_SHORT_NAME, code.codeShortName)
            .set(m.EXTENSION1, code.extension1)
            .set(m.EXTENSION2, code.extension2)
            .set(m.EXTENSION3, code.extension3)
            .set(m.EXTENSION4, code.extension4)
            .set(m.EXTENSION5, code.extension5)
            .set(m.EXTENSION6, code.extension6)
            .set(m.EXTENSION7, code.extension7)
            .set(m.EXTENSION8, code.extension8)
            .set(m.EXTENSION9, code.extension9)
            .set(m.EXTENSION10, code.extension10)
            .set(m.EXTENSION11, code.extension11)
            .set(m.EXTENSION12, code.extension12)
            .set(m.EXTENSION13, code.extension13)
            .set(m.EXTENSION14, code.extension14)
            .set(m.EXTENSION15, code.extension15)
            .set(m.DISPLAY_ORDER, code.displayOrder)
            .set(m.IS_ACTIVE, code.isActive)
            .set(m.DESCRIPTION, code.description)
            .set(m.UPDATED_AT, code.updatedAt)
            .where(
                m.CODE_CATEGORY.eq(code.codeCategory)
                    .and(m.CODE.eq(code.code))
            )
            .execute()

        return code
    }

    override fun delete(codeCategory: String, code: String) {
        dsl.deleteFrom(m)
            .where(
                m.CODE_CATEGORY.eq(codeCategory)
                    .and(m.CODE.eq(code))
            )
            .execute()
    }

    private fun MCodeRecord.toCode(): Code {
        return Code(
            codeCategory = codeCategory!!,
            code = code!!,
            codeDivision = codeDivision!!,
            codeName = codeName!!,
            codeShortName = codeShortName,
            extension1 = extension1,
            extension2 = extension2,
            extension3 = extension3,
            extension4 = extension4,
            extension5 = extension5,
            extension6 = extension6,
            extension7 = extension7,
            extension8 = extension8,
            extension9 = extension9,
            extension10 = extension10,
            extension11 = extension11,
            extension12 = extension12,
            extension13 = extension13,
            extension14 = extension14,
            extension15 = extension15,
            displayOrder = displayOrder!!,
            isActive = isActive!!,
            description = description,
            createdAt = createdAt!!,
            updatedAt = updatedAt!!
        )
    }
} 