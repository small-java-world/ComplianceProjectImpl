package com.example.project.code.infrastructure.repository

import com.example.project.code.domain.model.MCode
import com.example.project.code.domain.repository.MCodeRepository
import org.jooq.DSLContext
import org.jooq.Field
import org.jooq.Record
import org.jooq.Table
import org.jooq.impl.DSL
import org.springframework.stereotype.Repository
import java.sql.Timestamp
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
    private val DESCRIPTION: Field<String> = DSL.field("description", String::class.java)
    private val DISPLAY_ORDER: Field<Int> = DSL.field("display_order", Int::class.java)
    private val IS_ACTIVE: Field<Boolean> = DSL.field("is_active", Boolean::class.java)
    private val CREATED_AT: Field<Timestamp> = DSL.field("created_at", Timestamp::class.java)
    private val UPDATED_AT: Field<Timestamp> = DSL.field("updated_at", Timestamp::class.java)

    override fun findAll(): List<MCode> {
        return dslContext
            .select()
            .from(M_CODE)
            .fetch()
            .map { record -> map(record) }
    }

    override fun findByCodeCategory(codeCategory: String): List<MCode> {
        return dslContext
            .select()
            .from(M_CODE)
            .where(CODE_CATEGORY.eq(codeCategory))
            .fetch()
            .map { record -> map(record) }
    }

    override fun findByUpdatedAtAfter(since: LocalDateTime): List<MCode> {
        return dslContext
            .select()
            .from(M_CODE)
            .where(UPDATED_AT.greaterThan(Timestamp.valueOf(since)))
            .fetch()
            .map { record -> map(record) }
    }

    private fun map(record: Record): MCode {
        return MCode(
            codeCategory = record.get(CODE_CATEGORY),
            code = record.get(CODE),
            codeDivision = record.get(CODE_DIVISION),
            name = record.get(CODE_NAME),
            description = record.get(DESCRIPTION),
            displayOrder = record.get(DISPLAY_ORDER),
            isActive = record.get(IS_ACTIVE),
            createdAt = record.get(CREATED_AT).toLocalDateTime(),
            updatedAt = record.get(UPDATED_AT).toLocalDateTime()
        )
    }
} 