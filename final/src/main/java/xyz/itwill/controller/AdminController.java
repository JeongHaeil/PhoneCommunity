package xyz.itwill.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
		
		return "admin/admin_dashboard";
	}
	
	//신고된 (블라인드된) 게시물 출력
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
	                            @RequestParam(value = "prevPage", required = false) String prevPage,
	                            Model model) {
	    Admin post = adminService.getSpamBoardByNum(boardPostIdx);
	    if (post == null) {
	        throw new RuntimeException("게시글을 찾을 수 없습니다.");
	    }
	    model.addAttribute("post", post);
	    model.addAttribute("prevPage", prevPage);
	    return "admin/view_post";
	}
	//유저 제제 상태 부여 및 기한 설정
	@PutMapping("/admin/userStatus")
	public ResponseEntity<String> updateUserStatus(@RequestBody Admin request) {
	    try {
	    	// 요청에서 Duration 값을 가져와 현재 시간에 더함
	    	LocalDateTime localExpiryDate = LocalDateTime.now().plusSeconds((long) request.getDuration());

	    	// LocalDateTime을 Timestamp로 변환하고, 이를 Date로 변환
	    	Date expiryDate = Timestamp.valueOf(localExpiryDate);
	        adminService.updateUserStatusByUserNum(request.getUserNum(), request.getUserStatus(), expiryDate);
	        return ResponseEntity.ok("success");
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating user status");
	    }
	}
	
	//게시글 제제 상태 부여 및 기한 설정
	@PutMapping("/admin/boardStatus")
	public ResponseEntity<String> updateBoardStatus(@RequestBody Admin request) {
	    try {
	    	// 요청에서 Duration 값을 가져와 현재 시간에 더함
	    	LocalDateTime localExpiryDate = LocalDateTime.now().plusSeconds((long) request.getDuration());

	    	// LocalDateTime을 Timestamp로 변환하고, 이를 Date로 변환
	    	Date expiryDate = Timestamp.valueOf(localExpiryDate);
	        adminService.updateBoardStatusByBoardPostIdx(request.getBoardPostIdx(), request.getBoardStatus(), expiryDate);
	        return ResponseEntity.ok("success");
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating board status");
	    }
	}
	
	//유저 리스트 출력
	@GetMapping("/userList")
	public String userListBoard(@RequestParam(defaultValue = "1") int pageNum,
				            @RequestParam(defaultValue = "10") int pageSize,
				            @RequestParam(defaultValue = "5") int blockSize,
				            @RequestParam(required = false) String search,
				            @RequestParam(required = false) String keyword,
				            Model model) {
		
		int totalSize = 0;
		
		Map<String, Object> resultMap = adminService.gettotalUserBoardList(pageNum, pageSize, totalSize, blockSize
				, search, keyword);
		
        model.addAttribute("resultMap", resultMap);
        
        model.addAttribute("search", search);
        model.addAttribute("keyword", keyword);
		
		return "admin/user_list";
	}
	
	//대시보드 이동
	@GetMapping("/dashboard")
	public String adminDashboard() {
		//model.addAttribute("standalone", true);
		return "admin/admin_dashboard";
	}
	
	//신고된 (블라인드된) 게시물 출력 - 템플릿 적용 X
	@GetMapping("/admin/ajax")
	public String spamBoardListAjax(@RequestParam(defaultValue = "1") int pageNum,
							@RequestParam(defaultValue = "10") int pageSize,
							@RequestParam(defaultValue = "5") int blockSize,
							@RequestParam(required = false) String search,
							@RequestParam(required = false) String keyword,
							Model model) {
		int totalSize = 0;
		Map<String, Object> resultMap = adminService.getSpamBoardList(pageNum, pageSize, totalSize, blockSize, search, keyword);
		model.addAttribute("resultMap", resultMap);
		model.addAttribute("search", search);
		model.addAttribute("keyword", keyword);
		//return "admin/admin_page_content";
		return "forward:/WEB-INF/views/admin/admin_page_content.jsp";
	}

	//유저 리스트 출력 - 템플릿 적용 X
	@GetMapping("/userList/ajax")
	public String userListBoardAjax(@RequestParam(defaultValue = "1") int pageNum,
							@RequestParam(defaultValue = "10") int pageSize,
							@RequestParam(defaultValue = "5") int blockSize,
							@RequestParam(required = false) String search,
							@RequestParam(required = false) String keyword,
							Model model) {
		int totalSize = 0;
		Map<String, Object> resultMap = adminService.gettotalUserBoardList(pageNum, pageSize, totalSize, blockSize, search, keyword);
		model.addAttribute("resultMap", resultMap);
		model.addAttribute("search", search);
		model.addAttribute("keyword", keyword);
		//return "admin/user_list_content";
		return "forward:/WEB-INF/views/admin/user_list_content.jsp"; 
	}
	
	
}
