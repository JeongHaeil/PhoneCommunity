package xyz.itwill.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import xyz.itwill.service.AdminService;

@Slf4j
@Controller
@RequestMapping("/super_admin")
@RequiredArgsConstructor
public class AdminController {
	
	private final AdminService adminService;

	/*
	 * @RequestMapping(value = "/admin", method = RequestMethod.GET) public String
	 * adminPage(@RequestParam Map<String, Object> map, Model model) {
	 * 
	 * model.addAttribute("resultMap", adminService.getSpamBoardList(0, 0, 0, 0,
	 * null, null)); model.addAttribute("searchMap", map);
	 * 
	 * return "admin/admin_page"; // admin_page.jsp 페이지로 이동 }
	 */
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String adminPage(@RequestParam(defaultValue = "1") int pageNum,
                            @RequestParam(defaultValue = "10") int pageSize,
                            @RequestParam(defaultValue = "5") int blockSize,
                            @RequestParam(required = false) String search,
                            @RequestParam(required = false) String keyword,
                            Model model) {
        
        // 전체 게시글 수는 서비스 계층에서 처리하므로 0으로 설정
        int totalSize = 0;

        // 서비스 호출
        Map<String, Object> resultMap = adminService.getSpamBoardList(pageNum, pageSize, totalSize, blockSize, search, keyword);

        // 모델에 결과 추가
        model.addAttribute("resultMap", resultMap);
        
        // 검색 조건을 모델에 추가
        model.addAttribute("search", search);
        model.addAttribute("keyword", keyword);

        return "admin/admin_page"; // admin_page.jsp 페이지로 이동
    }
	
}
