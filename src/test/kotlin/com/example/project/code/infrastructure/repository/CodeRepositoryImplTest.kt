package com.example.project.code.infrastructure.repository

import com.example.project.code.domain.model.Code
import io.kotest.core.spec.style.FunSpec
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.ActiveProfiles
import org.springframework.transaction.annotation.Transactional
import java.time.LocalDateTime

@SpringBootTest
@ActiveProfiles("test")
@Transactional
class CodeRepositoryImplTest(
    private val codeRepository: CodeRepositoryImpl
) : FunSpec({

    test("findByCodeCategory should return all codes for the category") {
        // Given
        val codes = codeRepository.findByCodeCategory("DEPARTMENT_TYPE")

        // Then
        codes.size shouldBe 3
        codes[0].code shouldBe "SALES"
        codes[1].code shouldBe "IT"
        codes[2].code shouldBe "HR"
    }

    test("findByCodeCategoryAndCode should return specific code") {
        // Given
        val code = codeRepository.findByCodeCategoryAndCode("DEPARTMENT_TYPE", "SALES")

        // Then
        code shouldNotBe null
        code?.codeCategory shouldBe "DEPARTMENT_TYPE"
        code?.code shouldBe "SALES"
        code?.codeName shouldBe "営業部門"
        code?.codeShortName shouldBe "営業"
    }

    test("save should create new code") {
        // Given
        val now = LocalDateTime.now()
        val newCode = Code(
            codeCategory = "TEST_CATEGORY",
            code = "TEST_CODE",
            codeDivision = "TEST",
            codeName = "テストコード",
            codeShortName = "テスト",
            extension1 = null,
            extension2 = null,
            extension3 = null,
            extension4 = null,
            extension5 = null,
            extension6 = null,
            extension7 = null,
            extension8 = null,
            extension9 = null,
            extension10 = null,
            extension11 = null,
            extension12 = null,
            extension13 = null,
            extension14 = null,
            extension15 = null,
            displayOrder = 1,
            isActive = true,
            description = "テスト用コード",
            createdAt = now,
            updatedAt = now
        )

        // When
        codeRepository.save(newCode)

        // Then
        val savedCode = codeRepository.findByCodeCategoryAndCode("TEST_CATEGORY", "TEST_CODE")
        savedCode shouldNotBe null
        savedCode?.codeName shouldBe "テストコード"
        savedCode?.codeShortName shouldBe "テスト"
    }

    test("update should modify existing code") {
        // Given
        val code = codeRepository.findByCodeCategoryAndCode("DEPARTMENT_TYPE", "SALES")
        val updatedCode = code?.copy(
            codeName = "更新後営業部門",
            codeShortName = "更新営業"
        )

        // When
        updatedCode?.let { codeRepository.update(it) }

        // Then
        val result = codeRepository.findByCodeCategoryAndCode("DEPARTMENT_TYPE", "SALES")
        result shouldNotBe null
        result?.codeName shouldBe "更新後営業部門"
        result?.codeShortName shouldBe "更新営業"
    }

    test("delete should remove code") {
        // Given
        val codeCategory = "DEPARTMENT_TYPE"
        val code = "SALES"

        // When
        codeRepository.delete(codeCategory, code)

        // Then
        val deletedCode = codeRepository.findByCodeCategoryAndCode(codeCategory, code)
        deletedCode shouldBe null
    }
}) 