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
        val adminRole = mCodeCacheService.getEntry("ROLE", "ADMIN")
        adminRole shouldNotBe null
        adminRole?.codeName shouldBe "管理者"
        adminRole?.extension3 shouldBe "true" // canInternalAudit
    }

    test("getByDivision should return records for specific category and division") {
        val isoFrameworks = mCodeCacheService.getByDivision("COMPLIANCE_FW_TYPE", "ISO27001")
        isoFrameworks.size shouldBe 2
        
        val iso27001_2022 = isoFrameworks.find { it.code == "ISO27001_2022" }
        iso27001_2022 shouldNotBe null
        iso27001_2022?.codeName shouldBe "ISO27001:2022"
    }

    test("reloadCategory should reload specific category") {
        mCodeCacheService.reloadCategory("AUDIT_STAGE")
        
        val internalAudit = mCodeCacheService.getEntry("AUDIT_STAGE", "STAGE_INTERNAL")
        internalAudit shouldNotBe null
        internalAudit?.codeName shouldBe "内部監査"
    }

    test("partialReload should update cache with recent changes") {
        val pastTime = LocalDateTime.now().minusYears(1)
        mCodeCacheService.partialReload(pastTime)
        
        val userRole = mCodeCacheService.getEntry("ROLE", "USER")
        userRole shouldNotBe null
        userRole?.codeName shouldBe "一般ユーザー"
        userRole?.extension3 shouldBe "false" // canInternalAudit
    }
}) 