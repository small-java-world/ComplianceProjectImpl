package com.example.project.code.infrastructure.repository

import com.example.project.code.domain.model.MCode
import com.example.project.code.domain.repository.MCodeRepository
import org.jooq.DSLContext
import org.jooq.Field
import org.jooq.Record
import org.jooq.Table
import org.jooq.impl.DSL
import org.springframework.stereotype.Repository
import java.time.LocalDateTime

@Repository
class MCodeRepositoryImpl(
    private val dslContext: DSLContext
) : MCodeRepository {

    private val M_CODE: Table<Record> = DSL.table("M_CODE")
    private val CODE_CATEGORY: Field<String> = DSL.field("code_category", String::class.java)
    private val CODE: Field<String> = DSL.field("code", String::class.java)
    private val CODE_DIVISION: Field<String> = DSL.field("code_division", String::class.java)
    private val CODE_NAME: Field<String> = DSL.field("code_name", String::class.java)
    private val CODE_SHORT_NAME: Field<String> = DSL.field("code_short_name", String::class.java)
    private val DISPLAY_ORDER: Field<Int> = DSL.field("display_order", Int::class.java)
    private val IS_ACTIVE: Field<Boolean> = DSL.field("is_active", Boolean::class.java)
    private val DESCRIPTION: Field<String> = DSL.field("description", String::class.java)
    private val CREATED_AT: Field<LocalDateTime> = DSL.field("created_at", LocalDateTime::class.java)
    private val UPDATED_AT: Field<LocalDateTime> = DSL.field("updated_at", LocalDateTime::class.java)

    override fun findAll(): List<MCode> {
        return dslContext.select()
            .from(M_CODE)
            .orderBy(DISPLAY_ORDER.asc())
            .fetch()
            .map { toMCode(it) }
    }

    override fun findByUpdatedAtAfter(since: LocalDateTime): List<MCode> {
        return dslContext.select()
            .from(M_CODE)
            .where(UPDATED_AT.greaterThan(since))
            .orderBy(DISPLAY_ORDER.asc())
            .fetch()
            .map { toMCode(it) }
    }

    override fun findByCodeCategory(category: String): List<MCode> {
        return dslContext.select()
            .from(M_CODE)
            .where(CODE_CATEGORY.eq(category))
            .orderBy(DISPLAY_ORDER.asc())
            .fetch()
            .map { toMCode(it) }
    }

    override fun findByCodeCategoryAndCode(category: String, code: String): MCode? {
        return dslContext.select()
            .from(M_CODE)
            .where(CODE_CATEGORY.eq(category))
            .and(CODE.eq(code))
            .fetchOne()
            ?.let { toMCode(it) }
    }

    override fun save(mCode: MCode): MCode {
        val now = LocalDateTime.now()
        dslContext.insertInto(M_CODE)
            .set(CODE_CATEGORY, mCode.codeCategory)
            .set(CODE, mCode.code)
            .set(CODE_DIVISION, mCode.codeDivision)
            .set(CODE_NAME, mCode.name)
            .set(CODE_SHORT_NAME, mCode.codeShortName)
            .set(DISPLAY_ORDER, mCode.displayOrder)
            .set(IS_ACTIVE, mCode.isActive)
            .set(DESCRIPTION, mCode.description)
            .set(CREATED_AT, now)
            .set(UPDATED_AT, now)
            .execute()
        return mCode.copy(createdAt = now, updatedAt = now)
    }

    override fun update(mCode: MCode): MCode {
        val now = LocalDateTime.now()
        dslContext.update(M_CODE)
            .set(CODE_DIVISION, mCode.codeDivision)
            .set(CODE_NAME, mCode.name)
            .set(CODE_SHORT_NAME, mCode.codeShortName)
            .set(DISPLAY_ORDER, mCode.displayOrder)
            .set(IS_ACTIVE, mCode.isActive)
            .set(DESCRIPTION, mCode.description)
            .set(UPDATED_AT, now)
            .where(CODE_CATEGORY.eq(mCode.codeCategory))
            .and(CODE.eq(mCode.code))
            .execute()
        return mCode.copy(updatedAt = now)
    }

    override fun delete(category: String, code: String) {
        dslContext.deleteFrom(M_CODE)
            .where(CODE_CATEGORY.eq(category))
            .and(CODE.eq(code))
            .execute()
    }

    private fun toMCode(record: Record): MCode {
        return MCode(
            codeCategory = record.get(CODE_CATEGORY),
            code = record.get(CODE),
            codeDivision = record.get(CODE_DIVISION),
            name = record.get(CODE_NAME),
            codeShortName = record.get(CODE_SHORT_NAME),
            displayOrder = record.get(DISPLAY_ORDER),
            isActive = record.get(IS_ACTIVE),
            description = record.get(DESCRIPTION),
            createdAt = record.get(CREATED_AT),
            updatedAt = record.get(UPDATED_AT)
        )
    }
} 