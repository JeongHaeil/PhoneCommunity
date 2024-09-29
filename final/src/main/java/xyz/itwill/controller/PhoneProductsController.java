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
    public String showPlanComparison(Model model) {
        // 통신사, 제조사, 제품 리스트를 모델에 추가
        model.addAttribute("carriersList", carriersService.getCarriersById());
        model.addAttribute("manufacturersList", manufacturersService.getManufacturersById());
        model.addAttribute("productsList", productsService.getPhoneProducts());

        return "phone/phone";  // 하나의 JSP 파일로 이동
    }

    @PostMapping("/phone")
    public String calculatePlan(
        @RequestParam(defaultValue = "0") int carrierId, 
        @RequestParam(defaultValue = "0") int productId, 
        @RequestParam String planProductType, 
        @RequestParam String planType, 
        @RequestParam(defaultValue = "0") int planMonths,  
        @RequestParam String planOption, 
        @RequestParam(defaultValue = "0") int planAdditional,  
        Model model) {

        // 자급제 선택 시 할부 개월 수를 0으로 설정
        if ("자급제".equals(planOption)) {
            planMonths = 0;
        }

        // 필요한 데이터를 Map에 넣어 조회
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("carrierId", carrierId);
        paramMap.put("productId", productId);
        paramMap.put("planProductType", planProductType);
        paramMap.put("planType", planType);
        paramMap.put("planMonths", planMonths);
        paramMap.put("planOption", planOption);
        paramMap.put("planAdditional", planAdditional);

        List<PhonePlans> phonePlans = phonePlansService.selectPhonePlans(paramMap);
        model.addAttribute("phonePlans", phonePlans);

        // 첫 번째 요금제 정보를 모델에 추가하여 출력
        if (!phonePlans.isEmpty()) {
            PhonePlans planDetails = phonePlans.get(0); 
            model.addAttribute("planDetails", planDetails);
        }

        return "phone/phone";  // 조회 후 동일한 JSP 파일로 반환
    }
}
