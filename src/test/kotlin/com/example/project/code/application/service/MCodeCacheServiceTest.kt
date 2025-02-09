package com.example.project.code.application.service

import io.kotest.core.spec.style.FunSpec
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.ActiveProfiles
import java.time.LocalDateTime

@SpringBootTest
@ActiveProfiles("test")
class MCodeCacheServiceTest(
    private val mCodeCacheService: MCodeCacheService
) : FunSpec({

    test("loadAll should load all records into cache") {
        // loadAllはPostConstructで自動実行される
        val planningStage = mCodeCacheService.getEntry("AUDIT_STAGE", "PLANNING")
        planningStage shouldNotBe null
        planningStage?.name shouldBe "計画"
        planningStage?.description shouldBe "監査計画段階"
        planningStage?.isActive shouldBe true
    }

    test("getByName should return records for specific category and name") {
        val executionStages = mCodeCacheService.getByName("AUDIT_STAGE", "実施")
        executionStages.size shouldBe 1
        
        val executionStage = executionStages.first()
        executionStage.code shouldBe "EXECUTION"
        executionStage.name shouldBe "実施"
        executionStage.description shouldBe "監査実施段階"
    }

    test("reloadCategory should reload specific category") {
        mCodeCacheService.reloadCategory("AUDIT_STAGE")
        
        val reportingStage = mCodeCacheService.getEntry("AUDIT_STAGE", "REPORTING")
        reportingStage shouldNotBe null
        reportingStage?.name shouldBe "報告"
        reportingStage?.description shouldBe "監査報告段階"
    }

    test("partialReload should update cache with recent changes") {
        val pastTime = LocalDateTime.now().minusYears(1)
        mCodeCacheService.partialReload(pastTime)
        
        val followUpStage = mCodeCacheService.getEntry("AUDIT_STAGE", "FOLLOW_UP")
        followUpStage shouldNotBe null
        followUpStage?.name shouldBe "フォローアップ"
        followUpStage?.description shouldBe "監査フォローアップ段階"
        followUpStage?.isActive shouldBe true
    }
}) 