package xyz.itwill.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.PhonePlans;
import xyz.itwill.service.CarriersService;
import xyz.itwill.service.ManufacturersService;
import xyz.itwill.service.PhonePlansService;
import xyz.itwill.service.ProductsService;


@Controller
@RequiredArgsConstructor
@RequestMapping("/phone")
public class PhoneProductsController {
    private final ProductsService productsService;
    private final ManufacturersService manufacturersService;
    private final CarriersService carriersService;
    private final PhonePlansService phonePlansService;
    

 
    
    
    @GetMapping("/phone")
    public String PlanComparison(Model model) {
        // 통신사, 제조사, 제품 리스트를 모델에 추가
        model.addAttribute("carriersList", carriersService.getCarriersById());
        model.addAttribute("manufacturersList", manufacturersService.getManufacturersById());
        model.addAttribute("productsList", productsService.getPhoneProducts());
    
        return "phone/phone";  
    }

    @PostMapping("/phonePlansTable")
    @ResponseBody
    public List<PhonePlans> getPlanDetails(
        @RequestParam(required = false) Integer carrierId, 
        @RequestParam(required = false) Integer productId, 
        @RequestParam(required = false) String planAdditional, 
        @RequestParam(required = false) String planProductType, 
        @RequestParam(required = false) String planType,       // 신규/기변 값 처리
        @RequestParam(required = false) String planOption      // 자급제/할부 값 처리
    ) {

        // 필요한 데이터를 Map에 넣어 조건을 동적으로 처리
        Map<String, Object> paramMap = new HashMap<>();
        
        // 통신사 ID 조건
        if (carrierId != null) {
            paramMap.put("carrierId", carrierId);
        }
        
        // 제품 ID 조건
        if (productId != null) {
            paramMap.put("productId", productId);
        }
        
        // 5G/LTE 구분 조건
        if (planProductType != null && !planProductType.isEmpty()) {
            paramMap.put("planProductType", planProductType.toUpperCase());  // 대소문자 구분 방지
        }
        
        // 신규/기변 조건
        if (planType != null && !planType.isEmpty()) {
            paramMap.put("planType", planType);
        }
        
        // 자급제/할부 조건
        if (planOption != null && !planOption.isEmpty()) {
            paramMap.put("planOption", planOption);
        }
        
        // 요금제 조회 (동적 필터링)
        List<PhonePlans> phonePlans = phonePlansService.selectPhonePlans(paramMap);
        
        
        double additionalSupport = 0.0;
        if (planAdditional != null && !planAdditional.isEmpty() && planAdditional.startsWith("추가지원금")) {
            // '추가지원금' 및 '%' 기호 제거 후 숫자로 변환
            planAdditional = planAdditional.replaceAll("[^\\d.]", "");  // 숫자와 소수점만 남김
            
            // 값이 존재하는지 확인한 후 변환
            if (!planAdditional.isEmpty()) {
                try {
                    additionalSupport = Double.parseDouble(planAdditional);  // double로 변환
                } catch (NumberFormatException e) {
                    // 변환 중 오류가 발생할 경우 처리
                    additionalSupport = 0.0;
                   
                }
            }
        }
        // 추가 지원금 할인 적용
        if (additionalSupport > 0) {
            for (PhonePlans plan : phonePlans) {
                int discountedFee = (int) (plan.getTotalMonthlyFee() - (plan.getTotalMonthlyFee() * (additionalSupport / 100.0)));
                plan.setTotalMonthlyFee(discountedFee);  // 할인된 금액 적용
            }
        }

        return phonePlans;  
    }

    
    
    
    
}