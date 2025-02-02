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
    private val CODE_SHORT_NAME: Field<String> = DSL.field("code_short_name", String::class.java)
    private val EXTENSION1: Field<String> = DSL.field("extension1", String::class.java)
    private val EXTENSION2: Field<String> = DSL.field("extension2", String::class.java)
    private val EXTENSION3: Field<String> = DSL.field("extension3", String::class.java)
    private val EXTENSION4: Field<String> = DSL.field("extension4", String::class.java)
    private val EXTENSION5: Field<String> = DSL.field("extension5", String::class.java)
    private val EXTENSION6: Field<String> = DSL.field("extension6", String::class.java)
    private val EXTENSION7: Field<String> = DSL.field("extension7", String::class.java)
    private val EXTENSION8: Field<String> = DSL.field("extension8", String::class.java)
    private val EXTENSION9: Field<String> = DSL.field("extension9", String::class.java)
    private val EXTENSION10: Field<String> = DSL.field("extension10", String::class.java)
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
            codeName = record.get(CODE_NAME),
            codeShortName = record.get(CODE_SHORT_NAME),
            extension1 = record.get(EXTENSION1),
            extension2 = record.get(EXTENSION2),
            extension3 = record.get(EXTENSION3),
            extension4 = record.get(EXTENSION4),
            extension5 = record.get(EXTENSION5),
            extension6 = record.get(EXTENSION6),
            extension7 = record.get(EXTENSION7),
            extension8 = record.get(EXTENSION8),
            extension9 = record.get(EXTENSION9),
            extension10 = record.get(EXTENSION10),
            createdAt = record.get(CREATED_AT).toLocalDateTime(),
            updatedAt = record.get(UPDATED_AT).toLocalDateTime()
        )
    }
} 