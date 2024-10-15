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

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.UserDAO;
import xyz.itwill.dto.User;

@Component
@RequiredArgsConstructor
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
    private final UserDAO userDAO;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        
        List<String> roleNames = new ArrayList<>();
        
        // Authentication 객체에서 사용자 권한 추출
        for (GrantedAuthority authority : authentication.getAuthorities()) {
            roleNames.add(authority.getAuthority());
        }

        // 사용자 정보 가져오기
        String username = authentication.getName();
        User user = userDAO.selectUserByUserId(username);

        // 사용자 정보를 세션에 저장하고 최근 로그인 시간 업데이트
        if (user != null) {
            request.getSession().setAttribute("userLevel", user.getUserLevel());
            request.getSession().setAttribute("roleNames", roleNames.toArray(new String[0]));
            userDAO.updateLastLogin(user.getUserId());
        }

        // 권한에 따른 리다이렉트
        if (roleNames.contains("ROLE_SUPER_ADMIN")) {
            response.sendRedirect(request.getContextPath() + "/super_admin/");
        } else if (roleNames.contains("ROLE_BOARD_ADMIN")) {
            response.sendRedirect(request.getContextPath() + "/board_admin/");
        } else {
            // 일반 사용자나 비밀번호 찾기 후 로그인 시 무조건 메인 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath());  // 메인 페이지로 리다이렉트
        }
    }
}
