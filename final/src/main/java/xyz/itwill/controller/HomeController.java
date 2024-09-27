package xyz.itwill.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import xyz.itwill.auth.CustomUserDetails;

// Spring Security 관련 설정 및 기능을 포함한 컨트롤러 클래스
@Slf4j
@Controller
@RequiredArgsConstructor
public class HomeController {

    // 요청 처리 메소드의 매개변수를 Authentication 인터페이스로 작성하여 인증 정보를 사용 가능
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Authentication authentication) {
        if (authentication != null) { // 인증 처리된 사용자인 경우
            // 인증된 사용자의 세부 정보를 CustomUserDetails 객체로 변환하여 사용
            CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
            
            log.warn("아이디 = " + user.getUserId());
            log.warn("이름 = " + user.getName());
            log.warn("이메일 = " + user.getUserEmail()); // getEmail이 아니라 getUserEmail을 사용

            // 사용자의 권한을 확인하고, 필요하다면 추가적인 처리를 여기에 구현할 수 있습니다.
        }
        return "main_page"; // 메인 페이지로 이동
    }

    // 비로그인 사용자 또는 기본적인 게스트 페이지 접근
    @RequestMapping(value = "/guest/", method = RequestMethod.GET)
    public String guestPage() {
        return "guest_page";
    }

    // 일반 사용자 페이지
    @RequestMapping(value = "/user/", method = RequestMethod.GET)
    public String userPage() {
        return "user_page";
    }

    // 게시판 관리자 페이지
    @RequestMapping(value = "/board_admin/", method = RequestMethod.GET)
    public String boardAdminPage() {
        return "board_admin_page";
    }

    // 최고 관리자 페이지
    @RequestMapping(value = "/super_admin/", method = RequestMethod.GET)
    public String superAdminPage() {
        return "super_admin_page";
    }
}
