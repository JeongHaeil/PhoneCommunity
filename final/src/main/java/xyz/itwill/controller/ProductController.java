package xyz.itwill.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.HtmlUtils;

import lombok.RequiredArgsConstructor;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.dto.Product;
import xyz.itwill.service.ProductService;

@Controller
@RequestMapping
@RequiredArgsConstructor
public class ProductController {
	private final ProductService productService;
	private final WebApplicationContext context;

	private static final String UPLOAD_DIR = "C:/upload/"; // 파일 업로드 디렉토리 설정 (경로는 환경에 맞게 변경)

	@RequestMapping("/list")
	public String list(@RequestParam Map<String, Object> map, Model model) {
		Map<String, Object> resultMap = productService.getProductList(map);
		model.addAttribute("result", resultMap);
		model.addAttribute("searchMap", map);
		return "product/productlist";
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(Authentication authentication) {

		if (authentication == null) {
			return "redirect:/user/login";
		}
		return "product/productregister";
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(@ModelAttribute Product product, List<MultipartFile> productImage2,
			Authentication authentication) throws IllegalStateException, IOException {
		System.out.println("컨트롤러 실행");

		if (authentication != null) {
			CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
			product.setProductUserid(userDetails.getUserId());
		}

		String uploadDirectory = context.getServletContext().getRealPath("/resources/uploadFile/freeboard_image");
		List<String> filenameList = new ArrayList<>();
		for (MultipartFile multipartFile : productImage2) {
			if (!multipartFile.isEmpty()) {
				String uploadFilename = UUID.randomUUID().toString() + "_" + multipartFile.getOriginalFilename();
				File file = new File(uploadDirectory, uploadFilename);
				multipartFile.transferTo(file);
				filenameList.add(uploadFilename);
				// 업로드된 파일명을 product 객체의 productImage 필드에 설정
				product.setProductImage(uploadFilename);
			}
		}

		productService.addProduct(product);
		return "redirect:/list";
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
	public String modify(@ModelAttribute Product product, @RequestParam Map<String, Object> map,
			@RequestParam("imageFile") MultipartFile imageFile) throws UnsupportedEncodingException {
		try {
			// 이미지 파일 업로드 처리
			if (!imageFile.isEmpty()) {
				String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
				File file = new File(UPLOAD_DIR + fileName);
				imageFile.transferTo(file); // 파일 저장
				product.setProductImage(fileName); // 파일명을 product 객체에 저장
			}

			product.setProductSubject(HtmlUtils.htmlEscape(product.getProductSubject()));
			product.setProductContent(HtmlUtils.htmlEscape(product.getProductContent()));
			productService.modifyProduct(product);
		} catch (IOException e) {
			e.printStackTrace(); // 파일 업로드 오류 처리
		}

		String pageNum = (String) map.get("pageNum");
		String pageSize = (String) map.get("pageSize");
		String column = (String) map.get("column");
		String keyword = URLEncoder.encode((String) map.get("keyword"), "utf-8");

		return "redirect:/product/detail?productIdx=" + product.getProductIdx() + "&pageNum=" + pageNum + "&pageSize="
				+ pageSize + "&column=" + column + "&keyword=" + keyword;
	}

	@PreAuthorize("hasRole('ROLE_ADMIN') or principal.userid eq #productUserid")
	@RequestMapping("/remove")
	public String remove(@RequestParam int productIdx, @RequestParam String productUserid) {
		productService.removeProduct(productIdx);
		return "redirect:/product/list";
	}
}
