package com.example.project.infrastructure.jooq.converter

import org.jooq.Converter
import java.sql.Timestamp
import java.time.LocalDateTime

class DateAsLocalDateTimeConverter : Converter<Timestamp, LocalDateTime> {
    override fun from(databaseObject: Timestamp?): LocalDateTime? {
        return databaseObject?.toLocalDateTime()
    }

    override fun to(userObject: LocalDateTime?): Timestamp? {
        return userObject?.let { Timestamp.valueOf(it) }
    }

    override fun fromType(): Class<Timestamp> = Timestamp::class.java

    override fun toType(): Class<LocalDateTime> = LocalDateTime::class.java
} 