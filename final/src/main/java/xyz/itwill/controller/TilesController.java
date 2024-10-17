package xyz.itwill.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Product;
import xyz.itwill.service.ProductService;
@Controller
@RequiredArgsConstructor
public class TilesController {
	private final ProductService productService;
		@RequestMapping("/")
		public String tiles(Model model) {
			System.out.println("작동?");
		    List<Product> latestProducts = productService.getLatestProducts();
		    model.addAttribute("latestProducts", latestProducts);
		    return "main";
		}
		
	
		
	}

