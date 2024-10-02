package xyz.itwill.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Table.Cell;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.PhonePlans;
import xyz.itwill.service.PhonePlansService;

@Controller
@RequiredArgsConstructor
public class Exceldownload {
	private final PhonePlansService phonePlansService;

	
	
	
	
	@RequestMapping("/phone/downloadExel")
	@ResponseBody
	public void downloadExel(HttpServletResponse response,
            @RequestParam(required = false) Integer carrierId,
            @RequestParam(required = false) Integer productId,
            @RequestParam(required = false) String planProductType) throws IOException {
		
		 Map<String, Object> paramMap = new HashMap<>();
	        if (carrierId != null) paramMap.put("carrierId", carrierId);
	        if (productId != null) paramMap.put("productId", productId);
	        if (planProductType != null && !planProductType.isEmpty()) {
	            paramMap.put("planProductType", planProductType.toUpperCase());
	        }
		
	      List<PhonePlans> phonePlans = phonePlansService.selectPhonePlans(paramMap);

		
		HSSFWorkbook workbook= new HSSFWorkbook();
		Sheet sheet= workbook.createSheet();
		
		
	
		
		
		
		Row headerRow= sheet.createRow(0);
		String[] columns={"요금제 이름", "약정 구분", "데이터 용량", "추가 지원금", "월 할부금", "할부 이자", "총 월 요금"};
		
		
		
		for (int i = 0; i < columns.length; i++) {
            org.apache.poi.ss.usermodel.Cell cell = headerRow.createCell(i);  
            cell.setCellValue(columns[i]);
        }
		int rowNum = 0;
		for (PhonePlans plan : phonePlans) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(plan.getPlanName());
            row.createCell(1).setCellValue(plan.getPlanContractType());
            row.createCell(2).setCellValue(plan.getPlanData());
            row.createCell(3).setCellValue(plan.getAdditionalSupport());
            row.createCell(4).setCellValue(plan.getMonthlyInstallmentFee());
            row.createCell(5).setCellValue(plan.getInstallmentInterest());
            row.createCell(6).setCellValue(plan.getTotalMonthlyFee());
        }
		 response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	        response.setHeader("Content-Disposition", "attachment; filename=phone_plans.xlsx");
	        workbook.write(response.getOutputStream());
	        workbook.close();
		
	}
}
