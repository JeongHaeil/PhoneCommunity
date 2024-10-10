package xyz.itwill.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import xyz.itwill.dto.Admin;
import xyz.itwill.service.AdminService;

//로그를 기록하기 위한 Lombok 어노테이션
@Slf4j
//Spring MVC 컨트롤러로 지정
@Controller
//URL 경로 /super_admin에 매핑
@RequestMapping("/super_admin")
//생성자를 통한 의존성 주입을 위한 Lombok 어노테이션
@RequiredArgsConstructor
public class AdminController {
	
	//AdminService 인스턴스 주입
	private final AdminService adminService;
	
	@RequestMapping(value = "/")
	public String superAdminPage() {
		
		return "admin/super_admin";
	}
	

	@GetMapping("/admin")
    public String spamBoardList(@RequestParam(defaultValue = "1") int pageNum,
                            @RequestParam(defaultValue = "10") int pageSize,
                            @RequestParam(defaultValue = "5") int blockSize,
                            @RequestParam(required = false) String search,
                            @RequestParam(required = false) String keyword,
                            Model model) {
        
        // 전체 게시글 수는 서비스 계층에서 처리하므로 0으로 설정
        int totalSize = 0;

        // 서비스 호출
        Map<String, Object> resultMap = adminService.getSpamBoardList(pageNum, pageSize, totalSize, blockSize
        		, search, keyword);

        // 모델에 결과 추가
        model.addAttribute("resultMap", resultMap);
        
        // 검색 조건을 모델에 추가
        model.addAttribute("search", search);
        model.addAttribute("keyword", keyword);

        return "admin/admin_page"; // admin_page.jsp 페이지로 이동
    }
	
	@GetMapping("/admin/view")
	public String spamBoardView(@RequestParam("boardPostIdx") int boardPostIdx,
								Model model) {
		
		//파라미터로 받은 boardPostIdx 를 사용해 해당 boardPostIdx 게시글을 가져옴 
		Admin post = adminService.getSpamBoardByNum(boardPostIdx);
	    
	    if (post == null) {
	        throw new RuntimeException("게시글을 찾을 수 없습니다.");
	    }
	    
	    model.addAttribute("post", post);
	    
	    return "admin/view_post"; // view_post.jsp 페이지로 이동
	}
	
	@PutMapping("/admin/userStatus")
	@ResponseBody
	public ResponseEntity<String> updateUserStatus(@RequestParam int userId, @RequestParam int status) {
		
		adminService.updateUserStatusByUserId(userId, status);
		
		
		return ResponseEntity.ok("사용자의 상태 변경을 성공하였습니다.");
		
	}
	
	@PutMapping("/admin/boardStatus")
	@ResponseBody
	public ResponseEntity<String> updateBoardStatus (@RequestParam int boardPostIdx, @RequestParam int status) {
		adminService.updateBoardStatusByBoardPostIdx(boardPostIdx, status);
		
		return ResponseEntity.ok("게시물의 상태 변경을 성공하였습니다");
	}
	
	
	
}
