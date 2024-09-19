package xyz.itwill.template;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class TilesController {
	
	
		@RequestMapping("/")
		public String tiles() {
			return "main";
		}
		//@RequestMapping("/tiles/") << 폴더 요청
		@RequestMapping("/tiles")
		public String tiles1() {
			return "layout/tiles";
		}
		
		@RequestMapping("/admin/")
		public String admin() {
			return "admin";
		}
		
		
		
	}

