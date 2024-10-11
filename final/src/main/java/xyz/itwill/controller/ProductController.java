package xyz.itwill.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.dto.Product;
import xyz.itwill.service.ProductService;

@Controller
@RequestMapping("/product")
@RequiredArgsConstructor
public class ProductController {
	private final ProductService productService;
	private final WebApplicationContext context;

	private static final String UPLOAD_DIR = "/resources/images/";

	// 상품 리스트
	@RequestMapping("/list")
	public String list(@RequestParam Map<String, Object> map, Model model) {
		Map<String, Object> resultMap = productService.getProductList(map);
		model.addAttribute("result", resultMap);
		model.addAttribute("searchMap", map);
		return "product/productlist";
	}

	// 상품 등록 페이지로 이동
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(Authentication authentication) {
		if (authentication == null) {
			return "redirect:/user/login";
		}
		return "product/productregister";
	}

	// 상품 등록 처리
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(@ModelAttribute Product product, List<MultipartFile> productImage2,
			Authentication authentication) throws IllegalStateException, IOException {

		if (authentication != null) {
			CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
			product.setProductUserid(userDetails.getUserId());
		}

		// 업로드 경로 설정
		String uploadDirectory = context.getServletContext().getRealPath(UPLOAD_DIR);

		List<String> filenameList = new ArrayList<>();
		for (MultipartFile multipartFile : productImage2) {
			if (!multipartFile.isEmpty()) {
				String uploadFilename = UUID.randomUUID().toString() + "_" + multipartFile.getOriginalFilename();
				File file = new File(uploadDirectory, uploadFilename);
				multipartFile.transferTo(file);
				filenameList.add(uploadFilename);
				product.setProductImage(uploadFilename);
			}
		}

		productService.addProduct(product);
		return "redirect:/product/list";
	}

	@RequestMapping("/detail")
	public String detail(@RequestParam("productIdx") int productIdx, @RequestParam Map<String, Object> map, Model model,
			Authentication authentication) {

		// 조회수 증가
		productService.increaseProductCount(productIdx);

		// 제품 정보 조회
		model.addAttribute("product", productService.getProductByNum(productIdx));
		model.addAttribute("searchMap", map);
 
		// 현재 로그인한 사용자 정보 전달
		if (authentication != null) {
			CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
			model.addAttribute("currentUserId", userDetails.getUserId()); // 현재 로그인한 사용자 ID 전달
		}

		return "product/productdetail";
	}

	// 수정 페이지로 이동 (로그인 사용자만 가능)
	@PreAuthorize("hasRole('ROLE_ADMIN') or principal.userid eq #map['productUserid']")
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modifyForm(@RequestParam("productIdx") int productIdx, Model model) {
		// 수정할 상품 정보 조회
		Product product = productService.getProductByNum(productIdx);
		model.addAttribute("product", product);
		return "product/productmodify"; // 수정 페이지로 이동
	}

	// 상품 수정 처리 (로그인된 사용자만 가능)
	@PreAuthorize("hasRole('ROLE_ADMIN') or principal.userid eq #product.productUserid")
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyProduct(@ModelAttribute Product product,
			@RequestParam("productImage2") List<MultipartFile> productImages, Authentication authentication)
			throws IOException {
		if (authentication != null ) {
			String uploadDirectory = context.getServletContext().getRealPath(UPLOAD_DIR);

			// 새로운 이미지가 있을 경우 처리
			if (!productImages.isEmpty()) {
				for (MultipartFile file : productImages) {
					if (!file.isEmpty()) {
						String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
						File uploadFile = new File(uploadDirectory, fileName);
						file.transferTo(uploadFile);
						product.setProductImage(fileName); // 새 이미지가 업로드된 경우 이미지 설정
					}
				}
			} else {
				// 이미지가 비어있을 경우 기존 이미지 유지
				Product existingProduct = productService.getProductByNum(product.getProductIdx());
				product.setProductImage(existingProduct.getProductImage());
			}
			productService.modifyProduct(product); // 상품 정보 수정
		} 

		return "redirect:/product/detail?productIdx=" + product.getProductIdx();
	}

	// 상품 삭제 처리 (로그인된 사용자만 가능)
	@PreAuthorize("hasRole('ROLE_ADMIN') or principal.userid eq #productUserid")
	@RequestMapping("/remove")
	public String remove(@RequestParam int productIdx, @RequestParam String productUserid) {
		productService.removeProduct(productIdx);
		return "redirect:/product/list";
	}
	
	
	@PostMapping("/chat")
    public String registerProduct(@ModelAttribute Product product, HttpSession session) {
        // 현재 로그인한 사용자 정보를 세션에서 가져옴
        String sellerId = (String) session.getAttribute("userId");

        // 상품에 판매자 ID 저장
        product.setProductUserid(sellerId);

        // 상품 등록 처리
        productService.addProduct(product);

        return "redirect:/product/list";  // 상품 목록 페이지로 리다이렉트
    }
}