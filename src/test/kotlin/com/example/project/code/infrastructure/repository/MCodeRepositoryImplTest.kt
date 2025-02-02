package com.example.project.code.infrastructure.repository

import io.kotest.core.spec.style.FunSpec
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.ActiveProfiles
import java.time.LocalDateTime

@SpringBootTest
@ActiveProfiles("test")
class MCodeRepositoryImplTest(
    private val mCodeRepository: MCodeRepositoryImpl
) : FunSpec({

    test("findAll should return all M_CODE records") {
        val results = mCodeRepository.findAll()
        results.size shouldBe 7 // テストデータで登録した7件
        
        val adminRole = results.find { it.codeCategory == "ROLE" && it.code == "ADMIN" }
        adminRole shouldNotBe null
        adminRole?.codeName shouldBe "管理者"
        adminRole?.extension1 shouldBe "ALL"
        adminRole?.extension3 shouldBe "true"
        adminRole?.extension4 shouldBe "true"
        adminRole?.extension5 shouldBe "true"
    }

    test("findByCodeCategory should return records for specific category") {
        val results = mCodeRepository.findByCodeCategory("COMPLIANCE_FW_TYPE")
        results.size shouldBe 2 // ISO27001の2013版と2022版
        
        val iso27001_2022 = results.find { it.code == "ISO27001_2022" }
        iso27001_2022 shouldNotBe null
        iso27001_2022?.codeName shouldBe "ISO27001:2022"
        iso27001_2022?.extension1 shouldBe "2022"
    }

    test("findByUpdatedAtAfter should return records updated after specified time") {
        val pastTime = LocalDateTime.now().minusYears(1)
        val results = mCodeRepository.findByUpdatedAtAfter(pastTime)
        results.size shouldBe 7 // すべてのテストデータは現在時刻で登録されているため
    }
}) 