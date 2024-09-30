package xyz.itwill.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JacksonInject.Value;

import lombok.RequiredArgsConstructor;
import xyz.itwill.service.ProductService;
import xyz.itwill.dto.Product;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/product")
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;

    // 상품 등록 페이지로 이동
    @GetMapping("/productregister")
    public String showProductForm() {
        return "product/productregister"; // product/register.jsp로 이동
    }
    
    // 상품 등록 처리
    @RequestMapping("/productregister")
    public String registerProductvalue= "/register", method = RequestMethod.POST) {
        // 이미지 파일 업로드 처리
        if (!file.isEmpty()) {
            String fileName = file.getOriginalFilename();
            String savePath = "C:/upload/" + fileName; // 이미지 저장 경로 설정
            try {
                file.transferTo(new File(savePath));
                product.setProductImage(fileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // 상품 등록 처리
        productService.addProduct(product);

        // 상품 리스트 페이지로 리디렉션
        return "redirect:/product/productlist";
    }

    // 상품 리스트 페이지로 이동
    @GetMapping("/productlist")
    public String showProductList(Model model) {
        List<Product> productList = productService.getProductList(); // 상품 목록 가져오기
        model.addAttribute("productList", productList);
        return "product/productlist"; // product/list.jsp로 이동
    }
}
