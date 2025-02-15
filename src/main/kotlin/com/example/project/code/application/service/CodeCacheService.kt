package com.example.project.code.application.service

import com.example.project.code.domain.model.Code
import com.example.project.code.domain.repository.CodeRepository
import jakarta.annotation.PostConstruct
import org.springframework.stereotype.Service
import java.time.LocalDateTime
import java.util.concurrent.ConcurrentHashMap
import org.slf4j.Logger
import org.slf4j.LoggerFactory

@Service
class CodeCacheService(
    private val codeRepository: CodeRepository
) {
    private val cache = ConcurrentHashMap<String, ConcurrentHashMap<String, Code>>()
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)

    @PostConstruct
    fun loadAll() {
        val entries = codeRepository.findAll()
        entries.forEach { entry ->
            cache.computeIfAbsent(entry.codeCategory) { ConcurrentHashMap() }[entry.code] = entry
        }
    }

    fun partialReload(reloadTime: LocalDateTime) {
        val entries = codeRepository.findByUpdatedAtAfter(reloadTime)
        entries.forEach { entry ->
            cache.computeIfAbsent(entry.codeCategory) { ConcurrentHashMap() }[entry.code] = entry
        }
    }

    fun reloadCategory(category: String) {
        logger.debug("Reloading category: $category")
        val records = codeRepository.findByCategory(category)
        logger.debug("Found ${records.size} records for category $category")
        
        cache.computeIfAbsent(category) { ConcurrentHashMap() }.clear()
        records.forEach { record ->
            cache[category]?.put(record.code, record)
        }
        logger.debug("Category reload completed")
    }

    fun getEntry(category: String, code: String): Code? {
        return cache[category]?.get(code)
    }

    fun getByName(category: String, name: String): List<Code> {
        return cache[category]?.values?.filter { it.name == name } ?: emptyList()
    }
} 