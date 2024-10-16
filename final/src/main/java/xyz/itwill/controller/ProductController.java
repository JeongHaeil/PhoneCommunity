package xyz.itwill.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpSession;

import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.HtmlUtils;

import lombok.RequiredArgsConstructor;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.dto.Product;
import xyz.itwill.dto.User;
import xyz.itwill.service.ProductService;
import xyz.itwill.service.UserService;
import xyz.itwill.util.ExperienceUtil;


@Controller
@RequestMapping("/product")
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;
    private final WebApplicationContext context;

    private static final String UPLOAD_DIR = "/resources/images/";
    private final UserService userService; // UserService 추가

    // InitBinder 메서드 추가: 모든 String 타입 입력값에 대해 HTML 이스케이프 처리
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(false) {
            @Override
            public void setAsText(String text) {
                // HTML 이스케이프 처리 적용
                setValue(text == null ? null : HtmlUtils.htmlEscape(text));
            }
        });
    }
	// 상품 목록과 검색 처리
	@RequestMapping("/list")
	public String list(@RequestParam Map<String, Object> map, @RequestParam(required = false) Integer productSold, Model model) {
	    map.put("productStatus", 1); // 기본적으로 상태가 1인 상품만 보여줌

	    // 검색 키워드 처리
	    String keyword = (String) map.get("keyword");
	    if (keyword != null && !keyword.isEmpty()) {
	        map.put("keyword", keyword); // 검색어가 있으면 검색 조건에 추가
	    }

	    // 상품 판매 상태 필터링
	    if (productSold != null) {
	        map.put("productSold", productSold); // 드랍다운에서 선택된 판매 상태에 따른 필터링
	    }

	    // 상품 목록을 서비스에서 가져옴
	    Map<String, Object> resultMap = productService.getProductList(map);
	    model.addAttribute("result", resultMap);
	    model.addAttribute("searchMap", map); // 검색 조건도 뷰에 전달
	    
	    

	    return "product/productlist"; // 상품 목록 JSP로 이동
	}


	// 상품 등록 페이지로 이동
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(Authentication authentication) {
		if (authentication == null) {
			return "redirect:/user/login"; // 로그인하지 않은 사용자는 로그인 페이지로 리다이렉트
		}
		return "product/productregister"; // 상품 등록 페이지로 이동
	}

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
				filenameList.add(uploadFilename); // 파일명을 리스트에 저장
			}
		}

		// 사용자가 이미지를 업로드하지 않았을 경우 기본 이미지 설정
		if (filenameList.isEmpty()) {
			filenameList.add("150.png"); // 기본 이미지 파일명
		}

		product.setProductImage(String.join(",", filenameList)); // 여러 이미지 파일명을 콤마로 연결해서 저장
		productService.addProduct(product);
		return "redirect:/product/list";
	}

	@RequestMapping("/details")
	public String detail(@RequestParam("productIdx") int productIdx, 
	                     @RequestParam Map<String, Object> map, 
	                     Model model, 
	                     Authentication authentication) {

	    // 로거 생성
	    Logger logger = LoggerFactory.getLogger(ProductController.class);

	    // 로그 추가
	    logger.info("Entering detail method with productIdx: {}", productIdx);

	    // 조회수 증가
	    try {
	        productService.increaseProductCount(productIdx);
	        logger.info("Product count increased successfully for productIdx: {}", productIdx);
	    } catch (Exception e) {
	        logger.error("Error increasing product count for productIdx: {}", productIdx, e);
	        // 에러 페이지로 이동
	        return "error/errorPage";
	    }

	    // 상품 정보 조회
	    Product product = null;
	    try {
	        product = productService.getProductByNum(productIdx);
	        if (product == null) {
	            logger.warn("No product found for productIdx: {}", productIdx);
	            return "error/noProductFound"; // 상품이 없을 때의 처리
	        }
	        logger.info("Product retrieved successfully for productIdx: {}", productIdx);
	    } catch (Exception e) {
	        logger.error("Error retrieving product for productIdx: {}", productIdx, e);
	        return "error/errorPage"; // 에러 페이지로 이동
	    }

	    // 글쓴 사람의 정보 조회
	    User seller = null;
	    try {
	        seller = userService.getUser(product.getProductUserid());  // 글쓴 사람의 정보 가져오기
	        if (seller == null) {
	            logger.warn("No seller found for userId: {}", product.getProductUserid());
	            return "error/noSellerFound"; // 글쓴 사람이 없을 때의 처리
	        }
	        logger.info("Seller retrieved successfully for userId: {}", product.getProductUserid());
	    } catch (Exception e) {
	        logger.error("Error retrieving seller for userId: {}", product.getProductUserid(), e);
	        return "error/errorPage"; // 에러 페이지로 이동
	    }

	    // 상품 이미지 처리 (콤마로 구분된 이미지 리스트로 변환)
	    String[] productImages = product.getProductImage().split(",");
	    model.addAttribute("productImages", productImages); // 여러 이미지 전달
	    model.addAttribute("product", product); // 상품 정보 전달
	    model.addAttribute("searchMap", map); // 검색 조건도 다시 전달

	    // 글쓴 사람의 레벨, 경험치 정보 전달
	    try {
	        int sellerLevel = seller.getUserLevel();
	        int sellerExperience = seller.getUserExperience();
	        int experienceForNextLevel = ExperienceUtil.getExperienceForNextLevel(sellerLevel);
	        int progressPercentage = ExperienceUtil.calculateProgressPercentage(sellerExperience, experienceForNextLevel);

	        model.addAttribute("seller", seller); // 글쓴 사람의 전체 정보를 전달
	        model.addAttribute("sellerLevel", sellerLevel); // 글쓴 사람의 레벨
	        model.addAttribute("sellerExperience", sellerExperience); // 글쓴 사람의 현재 경험치
	        model.addAttribute("experienceForNextLevel", experienceForNextLevel); // 다음 레벨업까지 필요한 경험치
	        model.addAttribute("progressPercentage", progressPercentage); // 경험치 진행률

	        logger.info("Seller Level: {}, Seller Experience: {}, Progress: {}%", sellerLevel, sellerExperience, progressPercentage);
	    } catch (Exception e) {
	        logger.error("Error processing seller's experience and level", e);
	        return "error/errorPage"; // 에러 페이지로 이동
	    }

	    // 현재 로그인한 사용자 정보 전달
	    if (authentication != null) {
	        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
	        model.addAttribute("currentUserId", userDetails.getUserId()); // 로그인 사용자 ID 전달
	        logger.info("Current logged-in userId: {}", userDetails.getUserId());
	    } else {
	        logger.warn("No user is currently logged in.");
	    }

	    return "product/productdetail"; // 상세 페이지로 이동
	}




	// 수정 페이지로 이동 (로그인 사용자만 가능)
	@PreAuthorize("hasRole('ROLE_ADMIN') or principal.userid eq #map['productUserid']")
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modifyForm(@RequestParam("productIdx") int productIdx, Model model) {
		Product product = productService.getProductByNum(productIdx);
		model.addAttribute("product", product); // 수정할 상품 정보 전달 
		return "product/productmodify"; // 수정 페이지로 이동
	}
 

	
	// 상품 수정 처리 (로그인된 사용자만 가능) 
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyProduct(@ModelAttribute Product product,
	        @RequestParam("productImage2") List<MultipartFile> productImages, 
	        Authentication authentication, Model model) throws IOException {

	    // 로그인된 사용자인지 확인
	    if (authentication == null) {
	        return "redirect:/user/login"; // 로그인하지 않은 사용자는 로그인 페이지로 리다이렉트
	    }

	    CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
	    String currentUserId = userDetails.getUserId();

	    // 기존 상품 정보 가져오기
	    Product existingProduct = productService.getProductByNum(product.getProductIdx());

	    // 본인이 작성한 글이 아닌 경우 수정 불가
	    if (!existingProduct.getProductUserid().equals(currentUserId)) {
	        return "redirect:/user/login"; // 작성자가 아니면 로그인 페이지로 리다이렉트
	    }

	    String uploadDirectory = context.getServletContext().getRealPath(UPLOAD_DIR);

	    // 새로운 이미지가 있을 경우 처리
	    if (!productImages.isEmpty() && productImages.get(0).getSize() > 0) {
	        List<String> uploadedImageList = new ArrayList<>();
	        for (MultipartFile file : productImages) {
	            if (!file.isEmpty()) {
	                String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
	                File uploadFile = new File(uploadDirectory, fileName);
	                file.transferTo(uploadFile);
	                uploadedImageList.add(fileName); // 새 이미지 리스트 설정
	            }
	        }
	        product.setProductImage(String.join(",", uploadedImageList)); // 새 이미지 파일명 설정
	    } else {
	        // 이미지가 비어있을 경우 기존 이미지 유지
	        product.setProductImage(existingProduct.getProductImage()); // 기존 이미지 유지
	    }

	    productService.modifyProduct(product); // 상품 정보 수정

	    return "redirect:/product/details?productIdx=" + product.getProductIdx(); // 상세 페이지로 리다이렉트
	}



	// 상품 삭제 처리 (로그인된 사용자만 가능)
	@PreAuthorize("hasRole('ROLE_ADMIN') or principal.userid eq #productUserid")
	@RequestMapping("/remove")
	public String remove(@RequestParam("productIdx") int productIdx,
			@RequestParam("productUserid") String productUserid) {
		productService.updateProductStatus(productIdx); // 상태를 0으로 변경
		return "redirect:/product/list"; // 상품 목록으로 리다이렉트
	}

	@PostMapping("/updateStatus")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public String updateProductStatus(@RequestBody Map<String, Object> requestData) {
	    int productIdx = (int) requestData.get("productIdx");
	    int productSold = (int) requestData.get("productSold");
	    
	    productService.updateProductSoldStatus(productIdx, productSold);
	    
	    return "success";
	}


	// 상품 등록 처리
	@PostMapping("/chat")
	public String registerProduct(@ModelAttribute Product product, HttpSession session) {
		// 현재 로그인한 사용자 정보를 세션에서 가져옴
		String sellerId = (String) session.getAttribute("userId");

		// 상품에 판매자 ID 저장
		product.setProductUserid(sellerId);

		// 상품 등록 처리
		productService.addProduct(product);

		return "redirect:/product/list"; // 상품 목록 페이지로 리다이렉트
	}

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String getProductDetail(@RequestParam("productIdx") int productIdx, Model model) {
		Product product = productService.getProductByNum(productIdx); // 서비스에서 제품 정보 가져옴
		model.addAttribute("product", product); // 모델에 제품 정보 추가
		return "product/productdetail"; // JSP 파일 이름
	}
	
	// 인기글 목록을 조회해서 화면에 전달
    @RequestMapping("/popular")
    public String getPopularProducts(Model model) {
        List<Product> popularProducts = productService.getPopularProducts();
        model.addAttribute("popularProducts", popularProducts);
        return "product/productlist"; // 인기글 리스트 페이지로 이동
    }

}
