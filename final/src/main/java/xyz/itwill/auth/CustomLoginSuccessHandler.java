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

// 인증 성공 후 실행될 기능을 제공하기 위한 클래스
@Component
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
    // 인증 성공시 자동 호출되는 메소드
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
        
        // 로그인 사용자의 권한을 저장하기 위한 List 객체 생성
        List<String> roleNames = new ArrayList<String>();
        
        // Authentication.getAuthorities() : 인증된 사용자에 대한 모든 권한정보(GrantedAuthority 객체)가 
        // 요소값으로 저장된 List 객체를 반환하는 메소드
        for(GrantedAuthority authority : authentication.getAuthorities()) {
            // GrantedAuthority.getAuthority() : GrantedAuthority 객체에 저장된 권한정보를 문자열로 반환하는 메소드
            roleNames.add(authority.getAuthority());
        }
        
        // 권한에 따라 리다이렉트
        if(roleNames.contains("ROLE_SUPER_ADMIN")) {
            response.sendRedirect(request.getContextPath() + "/super_admin/");
        } else if(roleNames.contains("ROLE_BOARD_ADMIN")) {
            response.sendRedirect(request.getContextPath() + "/board_admin/");
        } else {
            // 일반 유저는 기본 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}
