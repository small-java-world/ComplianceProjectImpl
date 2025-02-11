package com.example.project.code.infrastructure.repository

import com.example.project.code.domain.model.MCode
import io.kotest.core.spec.style.FunSpec
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.test.context.ActiveProfiles
import org.springframework.transaction.annotation.Transactional
import java.time.LocalDateTime

@SpringBootTest
@ActiveProfiles("test")
@Transactional
class MCodeRepositoryImplTest(
    private val mCodeRepository: MCodeRepositoryImpl,
    private val jdbcTemplate: JdbcTemplate
) : FunSpec() {
    init {
        beforeTest {
            // テストデータをクリーンアップ
            jdbcTemplate.execute("DELETE FROM M_CODE")
        }

        test("findAll should return all M_CODE records") {
            // テストデータのセットアップ
            setupAllTestData()
            
            val results = mCodeRepository.findAll()
            results.size shouldBe 12
            
            val adminRole = results.find { it.codeCategory == "ROLE" && it.code == "ADMIN" }
            adminRole shouldNotBe null
            adminRole?.name shouldBe "管理者"
            adminRole?.description shouldBe "システム管理者権限を持つユーザー"
            adminRole?.isActive shouldBe true
        }

        test("findByCodeCategory should return records for specific category") {
            // テストデータのセットアップ
            setupComplianceFWTypeData()
            
            val results = mCodeRepository.findByCodeCategory("COMPLIANCE_FW_TYPE")
            results.size shouldBe 2
            
            val iso27001_2022 = results.find { it.code == "ISO27001_2022" }
            iso27001_2022 shouldNotBe null
            iso27001_2022?.name shouldBe "ISO27001:2022"
            iso27001_2022?.description shouldBe "ISO/IEC 27001:2022規格"
        }

        test("findByUpdatedAtAfter should return records updated after specified time") {
            // テストデータのセットアップ
            setupAllTestData()
            
            val pastTime = LocalDateTime.now().minusYears(1)
            val results = mCodeRepository.findByUpdatedAtAfter(pastTime)
            results.size shouldBe 12
        }
    }

    private fun setupAllTestData() {
        setupAuditStageData()
        setupRoleData()
        setupComplianceFWTypeData()
        setupIncidentTypeData()
    }

    private fun setupAuditStageData() {
        jdbcTemplate.update("""
            INSERT INTO M_CODE (code_category, code, code_division, code_name, description, display_order, is_active)
            VALUES 
            ('AUDIT_STAGE', 'STAGE_INTERNAL', 'AUDIT', '内部監査', '組織内で実施する監査', 1, true),
            ('AUDIT_STAGE', 'STAGE1_DOCUMENT', 'AUDIT', '文書審査', 'ISO27001認証の文書審査フェーズ', 2, true),
            ('AUDIT_STAGE', 'STAGE2_ONSITE', 'AUDIT', '実地審査', 'ISO27001認証の実地審査フェーズ', 3, true),
            ('AUDIT_STAGE', 'SURVEILLANCE1', 'AUDIT', 'サーベイランス1', 'ISO27001認証の維持審査1', 4, true),
            ('AUDIT_STAGE', 'RENEWAL', 'AUDIT', '更新審査', 'ISO27001認証の更新審査', 5, true),
            ('AUDIT_STAGE', 'CUSTOM_STAGE1', 'AUDIT', 'カスタムステージ1', 'カスタム監査ステージ1', 6, true),
            ('AUDIT_STAGE', 'CUSTOM_STAGE2', 'AUDIT', 'カスタムステージ2', 'カスタム監査ステージ2', 7, true)
        """)
    }

    private fun setupRoleData() {
        jdbcTemplate.update("""
            INSERT INTO M_CODE (code_category, code, code_division, code_name, description, display_order, is_active)
            VALUES 
            ('ROLE', 'ADMIN', 'USER', '管理者', 'システム管理者権限を持つユーザー', 1, true),
            ('ROLE', 'USER', 'USER', '一般ユーザー', '一般的なユーザー権限', 2, true)
        """)
    }

    private fun setupComplianceFWTypeData() {
        jdbcTemplate.update("""
            INSERT INTO M_CODE (code_category, code, code_division, code_name, description, display_order, is_active)
            VALUES 
            ('COMPLIANCE_FW_TYPE', 'ISO27001_2022', 'FW', 'ISO27001:2022', 'ISO/IEC 27001:2022規格', 1, true),
            ('COMPLIANCE_FW_TYPE', 'ISO27001_2013', 'FW', 'ISO27001:2013', 'ISO/IEC 27001:2013規格', 2, true)
        """)
    }

    private fun setupIncidentTypeData() {
        jdbcTemplate.update("""
            INSERT INTO M_CODE (code_category, code, code_division, code_name, description, display_order, is_active)
            VALUES 
            ('INCIDENT_TYPE', 'SYSTEM_OUTAGE', 'INCIDENT', 'システム障害', 'システムの重大な障害', 1, true)
        """)
    }
} 