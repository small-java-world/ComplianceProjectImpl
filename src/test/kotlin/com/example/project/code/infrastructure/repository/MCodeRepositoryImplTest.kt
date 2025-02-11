package com.example.project.code.infrastructure.repository

import com.example.project.code.domain.model.MCode
import com.example.project.code.domain.repository.MCodeRepository
import io.kotest.core.spec.style.FunSpec
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.extensions.spring.SpringExtension
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.test.context.ActiveProfiles
import org.springframework.transaction.annotation.Transactional
import java.time.LocalDateTime

@SpringBootTest
@ActiveProfiles("test")
@Transactional
class MCodeRepositoryImplTest(
    private val mCodeRepository: MCodeRepository,
    private val jdbcTemplate: JdbcTemplate
) : FunSpec({
    extensions(SpringExtension)

    beforeTest {
        // テストデータをクリーンアップ
        jdbcTemplate.execute("DELETE FROM M_CODE")
        
        // テストデータを投入
        jdbcTemplate.update("""
            INSERT INTO M_CODE (code_category, code, code_division, code_name, description, display_order, is_active)
            VALUES 
            ('TEST_CATEGORY', 'TEST_CODE_1', 'TEST_DIV', 'テストコード1', 'テスト用コード1', 1, true),
            ('TEST_CATEGORY', 'TEST_CODE_2', 'TEST_DIV', 'テストコード2', 'テスト用コード2', 2, true)
        """)
    }

    test("findAll should return all M_CODE records") {
        val results = mCodeRepository.findAll()
        results.size shouldBe 2
        
        val testCode1 = results.find { it.codeCategory == "TEST_CATEGORY" && it.code == "TEST_CODE_1" }
        testCode1 shouldNotBe null
        testCode1?.name shouldBe "テストコード1"
        testCode1?.description shouldBe "テスト用コード1"
        testCode1?.isActive shouldBe true
    }

    test("findByCodeCategory should return records for specific category") {
        val results = mCodeRepository.findByCodeCategory("TEST_CATEGORY")
        results.size shouldBe 2
        
        val testCode2 = results.find { it.code == "TEST_CODE_2" }
        testCode2 shouldNotBe null
        testCode2?.name shouldBe "テストコード2"
        testCode2?.description shouldBe "テスト用コード2"
    }

    test("findByUpdatedAtAfter should return records updated after specified time") {
        val pastTime = LocalDateTime.now().minusYears(1)
        val results = mCodeRepository.findByUpdatedAtAfter(pastTime)
        results.size shouldBe 2
    }
}) 