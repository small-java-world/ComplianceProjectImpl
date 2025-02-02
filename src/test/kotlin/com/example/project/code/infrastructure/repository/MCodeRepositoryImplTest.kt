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
            adminRole?.codeName shouldBe "管理者"
            adminRole?.extension1 shouldBe "ALL"
            adminRole?.extension3 shouldBe "true"
        }

        test("findByCodeCategory should return records for specific category") {
            // テストデータのセットアップ
            setupComplianceFWTypeData()
            
            val results = mCodeRepository.findByCodeCategory("COMPLIANCE_FW_TYPE")
            results.size shouldBe 2
            
            val iso27001_2022 = results.find { it.code == "ISO27001_2022" }
            iso27001_2022 shouldNotBe null
            iso27001_2022?.codeName shouldBe "ISO27001:2022"
            iso27001_2022?.extension1 shouldBe "2022"
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
            INSERT INTO M_CODE (code_category, code, code_division, code_name, code_short_name, 
                              extension1, extension2, extension3, extension4, extension5)
            VALUES 
            ('AUDIT_STAGE', 'STAGE_INTERNAL', 'INTERNAL', '内部監査', 'Internal Audit', '1', '0', '1', NULL, NULL),
            ('AUDIT_STAGE', 'STAGE1_DOCUMENT', 'ISO27001', '文書審査', 'Document Review', '2', '1', '2', NULL, NULL),
            ('AUDIT_STAGE', 'STAGE2_ONSITE', 'ISO27001', '実地審査', 'Onsite Audit', '3', '2', '3', NULL, NULL),
            ('AUDIT_STAGE', 'SURVEILLANCE1', 'ISO27001', 'サーベイランス1', 'Surveillance 1', '4', '3', '4', NULL, NULL),
            ('AUDIT_STAGE', 'RENEWAL', 'ISO27001', '更新審査', 'Renewal Audit', '5', '4', '5', NULL, NULL),
            ('AUDIT_STAGE', 'CUSTOM_STAGE1', 'TEST', 'カスタムステージ1', 'CustomStage1', '6', '5', '6', NULL, NULL),
            ('AUDIT_STAGE', 'CUSTOM_STAGE2', 'TEST', 'カスタムステージ2', 'CustomStage2', '7', '6', '7', NULL, NULL)
        """)
    }

    private fun setupRoleData() {
        jdbcTemplate.update("""
            INSERT INTO M_CODE (code_category, code, code_division, code_name, code_short_name,
                              extension1, extension2, extension3, extension4, extension5)
            VALUES 
            ('ROLE', 'ADMIN', 'SYSTEM', '管理者', 'Admin', 'ALL', NULL, 'true', 'true', 'true'),
            ('ROLE', 'USER', 'SYSTEM', '一般ユーザー', 'User', 'LIMITED', NULL, 'false', 'false', 'false')
        """)
    }

    private fun setupComplianceFWTypeData() {
        jdbcTemplate.update("""
            INSERT INTO M_CODE (code_category, code, code_division, code_name, code_short_name,
                              extension1, extension2, extension3, extension4, extension5)
            VALUES 
            ('COMPLIANCE_FW_TYPE', 'ISO27001_2022', 'ISO27001', 'ISO27001:2022', 'ISO27001:2022', '2022', NULL, NULL, NULL, NULL),
            ('COMPLIANCE_FW_TYPE', 'ISO27001_2013', 'ISO27001', 'ISO27001:2013', 'ISO27001:2013', '2013', NULL, NULL, NULL, NULL)
        """)
    }

    private fun setupIncidentTypeData() {
        jdbcTemplate.update("""
            INSERT INTO M_CODE (code_category, code, code_division, code_name, code_short_name,
                              extension1, extension2, extension3, extension4, extension5)
            VALUES 
            ('INCIDENT_TYPE', 'SYSTEM_OUTAGE', 'SYSTEM', 'システム障害', 'SystemOutage', 'HIGH', NULL, NULL, NULL, NULL)
        """)
    }
} 