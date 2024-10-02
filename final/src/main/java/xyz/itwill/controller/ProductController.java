package xyz.itwill.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.HtmlUtils;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Product;
import xyz.itwill.service.ProductService;

@Controller
@RequestMapping
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;
    
    private static final String UPLOAD_DIR = "C:/upload/"; // 파일 업로드 디렉토리 설정 (경로는 환경에 맞게 변경)

    @RequestMapping("/list")
    public String list(@RequestParam Map<String, Object> map, Model model) {
        model.addAttribute("resultMap", productService.getProductList(map));
        model.addAttribute("searchMap", map);
        return "product/productlist";
    }
    
    @RequestMapping(value= "/register", method = RequestMethod.GET)
    public String register() {
        return "product/productregister";
    }
    
    @RequestMapping(value= "/register", method = RequestMethod.POST)
    public String register(@ModelAttribute Product product, @RequestParam("imageFile") MultipartFile productImage) {
    	System.out.println("컨스톨러 실행");
        try {
        	if(productImage.isEmpty()) {
        		 return "redirect:/product/list";
        	}
        	System.out.println("이미지 삽입");
            // 이미지 파일 업로드 처리
            if (!productImage.isEmpty()) {
                // 업로드된 파일 이름 생성 (고유하게 하기 위해 현재 시간 사용)
                String fileName = System.currentTimeMillis() + "_" + productImage.getOriginalFilename();
                // 파일 저장 경로 설정
                File file = new File("C:/upload/" + fileName); // 파일 경로는 환경에 맞게 설정하세요
                productImage.transferTo(file); // 파일 저장

                // Product 객체에 파일 이름 저장
                product.setProductImage(fileName);
            }

            // 기타 필드 처리
            product.setProcutSubject(HtmlUtils.htmlEscape(product.getProcutSubject()));
            product.setProcutContent(HtmlUtils.htmlEscape(product.getProcutContent()));

            // Product 등록
            productService.addProduct(product);
        } catch (IOException e) {
            e.printStackTrace(); // 파일 업로드 오류 처리
        }

        return "redirect:/product/list";
    }
    
    @RequestMapping("/detail")
    public String detail(@RequestParam Map<String, Object> map, Model model) {
        int productIdx = Integer.parseInt((String) map.get("productIdx"));
        model.addAttribute("product", productService.getProductByNum(productIdx));
        model.addAttribute("searchMap", map);
        return "product/productdetail";
    }
    
    @PreAuthorize("hasRole('ROLE_ADMIN') or principal.userid eq #map['productUserid']")
    @RequestMapping(value = "/modify", method = RequestMethod.GET)
    public String modify(@RequestParam Map<String, Object> map, Model model) {
        int productIdx = Integer.parseInt((String) map.get("productIdx"));
        model.addAttribute("product", productService.getProductByNum(productIdx));
        model.addAttribute("searchMap", map);
        return "product/product_modify";
    }

    @PreAuthorize("hasRole('ROLE_ADMIN') or principal.userid eq #map['productUserid']")
    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    public String modify(@ModelAttribute Product product, 
                         @RequestParam Map<String, Object> map, 
                         @RequestParam("imageFile") MultipartFile imageFile) throws UnsupportedEncodingException {
        try {
            // 이미지 파일 업로드 처리
            if (!imageFile.isEmpty()) {
                String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
                File file = new File(UPLOAD_DIR + fileName);
                imageFile.transferTo(file); // 파일 저장
                product.setProductImage(fileName); // 파일명을 product 객체에 저장
            }

            product.setProcutSubject(HtmlUtils.htmlEscape(product.getProcutSubject()));
            product.setProcutContent(HtmlUtils.htmlEscape(product.getProcutContent()));
            productService.modifyProduct(product);
        } catch (IOException e) {
            e.printStackTrace(); // 파일 업로드 오류 처리
        }
        
        String pageNum = (String) map.get("pageNum");
        String pageSize = (String) map.get("pageSize");
        String column = (String) map.get("column");
        String keyword = URLEncoder.encode((String) map.get("keyword"), "utf-8");
        
        return "redirect:/product/detail?productIdx=" + product.getProductIdx() + "&pageNum=" + pageNum
               + "&pageSize=" + pageSize + "&column=" + column + "&keyword=" + keyword;
    }

    @PreAuthorize("hasRole('ROLE_ADMIN') or principal.userid eq #productUserid")
    @RequestMapping("/remove")
    public String remove(@RequestParam int productIdx, @RequestParam String productUserid) {
        productService.removeProduct(productIdx);
        return "redirect:/product/list";
    }
}
