package xyz.itwill.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

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
    	     @RequestParam(required = false) Integer planAdditional, 
    	     @RequestParam(required = false) String planProductType) {

    	    // 필요한 데이터를 Map에 넣어 조건을 동적으로 처리
    	    Map<String, Object> paramMap = new HashMap<>();
    	    if (carrierId != null) {
    	        paramMap.put("carrierId", carrierId);
    	    }
    	    if (productId != null) {
    	        paramMap.put("productId", productId);
    	    }
    	    if (planProductType != null && !planProductType.isEmpty()) {
    	        paramMap.put("planProductType", planProductType.toUpperCase());  // 대소문자 구분 방지
    	    }	
    		
    		
    		
       
		List<PhonePlans> phonePlans = phonePlansService.selectPhonePlans(paramMap);
		
		if (planAdditional != null) {
	        for (PhonePlans plan : phonePlans) {
	            int discountedFee = (int) (plan.getTotalMonthlyFee() - (plan.getTotalMonthlyFee() * planAdditional));
	            plan.setTotalMonthlyFee(discountedFee); // 할인된 금액 적용
	        }
	    }

        return phonePlans;  
    }
    
    
    
    
}