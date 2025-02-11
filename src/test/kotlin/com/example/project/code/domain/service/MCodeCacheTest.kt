package com.example.project.code.domain.service

import com.example.project.code.application.service.MCodeCacheService
import com.example.project.code.domain.model.MCode
import com.example.project.code.domain.repository.MCodeRepository
import io.kotest.core.spec.style.FunSpec
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.mockk.every
import io.mockk.mockk
import java.time.LocalDateTime

class MCodeCacheTest : FunSpec({

    test("loadAll should populate cache with provided entries") {
        val entries = listOf(
            MCode(
                codeCategory = "TEST_CATEGORY",
                code = "TEST_CODE_1",
                codeDivision = "TEST_DIV",
                name = "テストコード1",
                description = "テスト用コード1",
                displayOrder = 1,
                isActive = true,
                createdAt = LocalDateTime.now(),
                updatedAt = LocalDateTime.now()
            ),
            MCode(
                codeCategory = "TEST_CATEGORY",
                code = "TEST_CODE_2",
                codeDivision = "TEST_DIV",
                name = "テストコード2",
                description = "テスト用コード2",
                displayOrder = 2,
                isActive = true,
                createdAt = LocalDateTime.now(),
                updatedAt = LocalDateTime.now()
            )
        )

        val mockRepository = mockk<MCodeRepository>()
        every { mockRepository.findAll() } returns entries

        val cache = MCodeCacheService(mockRepository)
        cache.loadAll()

        val testCode1 = cache.getEntry("TEST_CATEGORY", "TEST_CODE_1")
        testCode1 shouldNotBe null
        testCode1?.name shouldBe "テストコード1"
        testCode1?.description shouldBe "テスト用コード1"
        testCode1?.isActive shouldBe true

        val testCode2 = cache.getEntry("TEST_CATEGORY", "TEST_CODE_2")
        testCode2 shouldNotBe null
        testCode2?.name shouldBe "テストコード2"
        testCode2?.description shouldBe "テスト用コード2"
        testCode2?.isActive shouldBe true
    }

    test("partialReload should update cache with new entries") {
        val initialEntries = listOf(
            MCode(
                codeCategory = "TEST_CATEGORY",
                code = "TEST_CODE_1",
                codeDivision = "TEST_DIV",
                name = "テストコード1",
                description = "テスト用コード1",
                displayOrder = 1,
                isActive = true,
                createdAt = LocalDateTime.now(),
                updatedAt = LocalDateTime.now()
            )
        )

        val mockRepository = mockk<MCodeRepository>()
        every { mockRepository.findAll() } returns initialEntries

        val cache = MCodeCacheService(mockRepository)
        cache.loadAll()

        val newEntries = listOf(
            MCode(
                codeCategory = "TEST_CATEGORY",
                code = "TEST_CODE_2",
                codeDivision = "TEST_DIV",
                name = "テストコード2",
                description = "テスト用コード2",
                displayOrder = 2,
                isActive = true,
                createdAt = LocalDateTime.now(),
                updatedAt = LocalDateTime.now()
            )
        )

        val reloadTime = LocalDateTime.now().minusHours(1)
        every { mockRepository.findByUpdatedAtAfter(reloadTime) } returns newEntries

        cache.partialReload(reloadTime)

        val testCode2 = cache.getEntry("TEST_CATEGORY", "TEST_CODE_2")
        testCode2 shouldNotBe null
        testCode2?.name shouldBe "テストコード2"
        testCode2?.description shouldBe "テスト用コード2"
        testCode2?.isActive shouldBe true
    }

    test("getByName should return all entries for a name in category") {
        val entries = listOf(
            MCode(
                codeCategory = "TEST_CATEGORY",
                code = "TEST_CODE_1",
                codeDivision = "TEST_DIV",
                name = "テストコード1",
                description = "テスト用コード1",
                displayOrder = 1,
                isActive = true,
                createdAt = LocalDateTime.now(),
                updatedAt = LocalDateTime.now()
            ),
            MCode(
                codeCategory = "TEST_CATEGORY",
                code = "TEST_CODE_2",
                codeDivision = "TEST_DIV",
                name = "テストコード1", // 同じ名前で異なるコード
                description = "テスト用コード2",
                displayOrder = 2,
                isActive = true,
                createdAt = LocalDateTime.now(),
                updatedAt = LocalDateTime.now()
            )
        )

        val mockRepository = mockk<MCodeRepository>()
        every { mockRepository.findAll() } returns entries

        val cache = MCodeCacheService(mockRepository)
        cache.loadAll()

        val testEntries = cache.getByName("TEST_CATEGORY", "テストコード1")
        testEntries.size shouldBe 2
        
        val testCode1 = testEntries.find { it.code == "TEST_CODE_1" }
        testCode1 shouldNotBe null
        testCode1?.name shouldBe "テストコード1"
        
        val testCode2 = testEntries.find { it.code == "TEST_CODE_2" }
        testCode2 shouldNotBe null
        testCode2?.name shouldBe "テストコード1"
    }
}) 