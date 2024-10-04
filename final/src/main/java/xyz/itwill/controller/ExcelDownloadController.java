package xyz.itwill.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.PhonePlans;
import xyz.itwill.service.PhonePlansService;

@Controller
@RequiredArgsConstructor
@RequestMapping("/phone")
public class ExcelDownloadController {
	
	private final PhonePlansService phonePlansService;
	
	@GetMapping("/download")
	public void excelDownload(HttpServletResponse response) throws IOException {
	    // 엑셀 파일 생성
	    Workbook wb = new HSSFWorkbook();
	    Sheet sheet = wb.createSheet("요금제 데이터");
	    Row row = null;
	    org.apache.poi.ss.usermodel.Cell cell = null;
	    int rowNum = 0;

	    // Header
	    row = sheet.createRow(rowNum++);
	    cell = row.createCell(0);
	    cell.setCellValue("요금제 이름");
	    cell = row.createCell(1);
	    cell.setCellValue("약정 구분");
	    cell = row.createCell(2);
	    cell.setCellValue("데이터 용량");
	    cell = row.createCell(3);
	    cell.setCellValue("추가 지원금");
	    cell = row.createCell(4);
	    cell.setCellValue("월 할부금");
	    cell = row.createCell(5);
	    cell.setCellValue("할부 이자");
	    cell = row.createCell(6);
	    cell.setCellValue("총 월 요금");

	    // Body - PhonePlansService를 통해 요금제 목록을 가져옴
	    List<PhonePlans> phonePlansList = phonePlansService.selectPhonePlans(null);  // 필요한 조건을 map으로 전달할 수 있음

	    for (PhonePlans plan : phonePlansList) {
	        row = sheet.createRow(rowNum++);
	        cell = row.createCell(0);
	        cell.setCellValue(plan.getPlanName());  // 요금제 이름
	        cell = row.createCell(1);
	        cell.setCellValue(plan.getPlanContractType());  // 약정 구분
	        cell = row.createCell(2);
	        cell.setCellValue(plan.getPlanData());  // 데이터 용량
	        cell = row.createCell(3);
	        cell.setCellValue(plan.getPlanAdditional());  // 추가 지원금
	        cell = row.createCell(4);
	        cell.setCellValue(plan.getMonthlyInstallmentFee());  // 월 할부금
	        cell = row.createCell(5);
	        cell.setCellValue(plan.getInstallmentInterest());  // 할부 이자
	        cell = row.createCell(6);
	        cell.setCellValue(plan.getTotalMonthlyFee());  // 총 월 요금
	    }

	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=plans.xlsx");

	    // Excel 파일 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	}
}
