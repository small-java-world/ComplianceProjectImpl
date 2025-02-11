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
                codeId = 1L,
                codeCategory = "ROLE",
                code = "ADMIN",
                name = "管理者",
                description = "システム管理者権限を持つユーザー",
                displayOrder = 1,
                isActive = true,
                createdAt = LocalDateTime.now(),
                updatedAt = LocalDateTime.now()
            ),
            MCode(
                codeId = 2L,
                codeCategory = "ROLE",
                code = "USER",
                name = "一般ユーザー",
                description = "一般的なユーザー権限",
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

        val adminRole = cache.getEntry("ROLE", "ADMIN")
        adminRole shouldNotBe null
        adminRole?.name shouldBe "管理者"
        adminRole?.description shouldBe "システム管理者権限を持つユーザー"
        adminRole?.isActive shouldBe true

        val userRole = cache.getEntry("ROLE", "USER")
        userRole shouldNotBe null
        userRole?.name shouldBe "一般ユーザー"
        userRole?.description shouldBe "一般的なユーザー権限"
        userRole?.isActive shouldBe true
    }

    test("partialReload should update cache with new entries") {
        val initialEntries = listOf(
            MCode(
                codeId = 1L,
                codeCategory = "ROLE",
                code = "ADMIN",
                name = "管理者",
                description = "システム管理者権限を持つユーザー",
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
                codeId = 2L,
                codeCategory = "ROLE",
                code = "USER",
                name = "一般ユーザー",
                description = "一般的なユーザー権限",
                displayOrder = 2,
                isActive = true,
                createdAt = LocalDateTime.now(),
                updatedAt = LocalDateTime.now()
            )
        )

        val reloadTime = LocalDateTime.now().minusHours(1)
        every { mockRepository.findByUpdatedAtAfter(reloadTime) } returns newEntries

        cache.partialReload(reloadTime)

        val userRole = cache.getEntry("ROLE", "USER")
        userRole shouldNotBe null
        userRole?.name shouldBe "一般ユーザー"
        userRole?.description shouldBe "一般的なユーザー権限"
        userRole?.isActive shouldBe true
    }

    test("getByName should return all entries for a name in category") {
        val entries = listOf(
            MCode(
                codeId = 1L,
                codeCategory = "ROLE",
                code = "ADMIN",
                name = "管理者",
                description = "システム管理者権限を持つユーザー",
                displayOrder = 1,
                isActive = true,
                createdAt = LocalDateTime.now(),
                updatedAt = LocalDateTime.now()
            ),
            MCode(
                codeId = 2L,
                codeCategory = "ROLE",
                code = "USER",
                name = "一般ユーザー",
                description = "一般的なユーザー権限",
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

        val roleEntries = cache.getByName("ROLE", "管理者")
        roleEntries.size shouldBe 1
        
        val adminRole = roleEntries.first()
        adminRole.code shouldBe "ADMIN"
        adminRole.name shouldBe "管理者"
    }
}) 