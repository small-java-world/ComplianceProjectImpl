package com.example.project.code.application.service

import com.example.project.code.domain.model.MCode
import com.example.project.code.domain.model.vo.MCodeKey
import com.example.project.code.domain.repository.MCodeRepository
import jakarta.annotation.PostConstruct
import org.springframework.stereotype.Service
import java.time.LocalDateTime
import java.util.concurrent.ConcurrentHashMap
import java.util.concurrent.locks.ReentrantReadWriteLock
import kotlin.concurrent.read
import kotlin.concurrent.write
import org.slf4j.Logger
import org.slf4j.LoggerFactory

@Service
class MCodeCacheService(
    private val mCodeRepository: MCodeRepository
) {
    private val cache: ConcurrentHashMap<MCodeKey, MCode> = ConcurrentHashMap()
    private val lock = ReentrantReadWriteLock()
    private val logger: Logger = LoggerFactory.getLogger(this::class.java)

    @PostConstruct
    fun loadAll() {
        val records = mCodeRepository.findAll()
        val tempMap = ConcurrentHashMap<MCodeKey, MCode>()
        records.forEach { record ->
            tempMap[MCodeKey(record.codeCategory, record.code)] = record
        }
        // replace entire cache
        lock.write {
            cache.clear()
            cache.putAll(tempMap)
        }
    }

    fun partialReload(since: LocalDateTime) {
        val changed = mCodeRepository.findByUpdatedAtAfter(since)
        lock.write {
            changed.forEach { record ->
                cache[MCodeKey(record.codeCategory, record.code)] = record
            }
        }
    }

    fun reloadCategory(category: String) {
        logger.debug("Reloading category: $category")
        val records = mCodeRepository.findByCodeCategory(category)
        logger.debug("Found ${records.size} records for category $category")
        
        lock.write {
            logger.debug("Removing existing entries for category $category")
            val keysToRemove = cache.keys.filter { it.codeCategory == category }
            logger.debug("Found ${keysToRemove.size} keys to remove")
            keysToRemove.forEach { key ->
                logger.debug("Removing key: $key")
                cache.remove(key)
            }
            
            logger.debug("Adding new entries")
            records.forEach { record ->
                val key = MCodeKey(record.codeCategory, record.code)
                logger.debug("Adding entry with key: $key")
                cache[key] = record
            }
        }
        logger.debug("Category reload completed")
    }

    fun getEntry(category: String, code: String): MCode? =
        lock.read { cache[MCodeKey(category, code)] }

    fun getByDivision(category: String, division: String): List<MCode> =
        lock.read { 
            cache.values
                .filter { it.codeCategory == category && it.codeDivision == division }
                .toList()
        }
} 