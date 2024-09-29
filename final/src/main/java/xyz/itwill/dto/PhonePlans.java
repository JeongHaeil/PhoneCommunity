package xyz.itwill.dto;

import lombok.Data;

@Data
public class PhonePlans {
    private int planId;  					// 요금제 ID
    private int carrierId;                  // 통신사 ID
    private int productId;                  // 제품 ID
    private String planProductType;         // 구분 (5G, LTE 등)
    private String planType;                // 가입 구분 (신규, 번호이동 등)
    private int planMonths;                 // 할부 개월수
    private String planOption;              // 자급제/약정 여부
    private int planAdditional;             // 추가 지원금

    // 조인된 데이터용 필드
    private String carrierName;             // 통신사 이름
    private String productName;             // 제품 이름
    
    
    private String planName;                // 요금제 이름 (예: 5GX 레귤러, 5GX 프라임)
    private String planContractType;        // 약정 구분 (예: 선택약정, 24개월 약정)
    private String planData;                // 데이터 (예: 100G, 무제한)
    private int additionalSupport;          // 추가지원금 (원)
    private int monthlyInstallmentFee;      // 월 할부금 (원)
    private int installmentInterest;        // 할부 이자 (원)
    private int totalMonthlyFee;            // 총 월요금 (원)
    
    
}
