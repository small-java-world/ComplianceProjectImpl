package com.example.project.infrastructure.jooq.converter

import org.jooq.Converter
import java.sql.Date
import java.time.LocalDate

class DateAsLocalDateConverter : Converter<Date, LocalDate> {
    override fun from(databaseObject: Date?): LocalDate? {
        return databaseObject?.toLocalDate()
    }

    override fun to(userObject: LocalDate?): Date? {
        return userObject?.let { Date.valueOf(it) }
    }

    override fun fromType(): Class<Date> = Date::class.java

    override fun toType(): Class<LocalDate> = LocalDate::class.java
} 