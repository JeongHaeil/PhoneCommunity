package xyz.itwill.auth;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import xyz.itwill.dao.UserDAO; // UserDAO 임포트 추가
import xyz.itwill.dto.User; // User DTO 임포트 추가
import lombok.RequiredArgsConstructor;

// 인증 성공 후 실행될 기능을 제공하기 위한 클래스
@Component
@RequiredArgsConstructor // 생성자 주입을 위한 어노테이션
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
    private final UserDAO userDAO; // UserDAO를 주입받기 위한 변수

    // 인증 성공시 자동 호출되는 메소드
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
        
        // 로그인 사용자의 권한을 저장하기 위한 List 객체 생성
        List<String> roleNames = new ArrayList<String>();
        
        String prevPage = (String) request.getSession().getAttribute("prevPage");
        if (prevPage != null) {
            request.getSession().removeAttribute("prevPage");
        }
        
        // Authentication.getAuthorities() : 인증된 사용자에 대한 모든 권한정보(GrantedAuthority 객체)가 
        // 요소값으로 저장된 List 객체를 반환하는 메소드
        for (GrantedAuthority authority : authentication.getAuthorities()) {
            // GrantedAuthority.getAuthority() : GrantedAuthority 객체에 저장된 권한정보를 문자열로 반환하는 메소드
            roleNames.add(authority.getAuthority());
        }

        // 사용자 ID를 통해 사용자 정보를 가져옴
        String username = authentication.getName();
        User user = userDAO.selectUserByUserId(username); // UserDAO를 통해 사용자 정보 조회

        // 사용자 정보 및 권한을 세션에 저장
        if (user != null) {
            request.getSession().setAttribute("userLevel", user.getUserLevel()); // 사용자 레벨 저장
            request.getSession().setAttribute("roleNames", roleNames.toArray(new String[0])); // 권한 배열 저장
            
            // 최근 로그인 시간 업데이트
            userDAO.updateLastLogin(user.getUserId()); // 최근 로그인 시간 업데이트 메서드 호출
            
            // 디버깅 로그 추가
            System.out.println("User Level: " + user.getUserLevel());
            System.out.println("User Roles: " + roleNames);
            System.out.println("Last Login Time Updated for User: " + user.getUserId());
        }

        // 권한에 따라 리다이렉트
        if (roleNames.contains("ROLE_SUPER_ADMIN")) {
            response.sendRedirect(request.getContextPath() + "/super_admin/");
        } else if (roleNames.contains("ROLE_BOARD_ADMIN")) {
            response.sendRedirect(request.getContextPath() + "/board_admin/");
        } else {
            // 일반 유저는 기본 페이지로 리다이렉트
            response.sendRedirect(prevPage);
        }
    }
}
