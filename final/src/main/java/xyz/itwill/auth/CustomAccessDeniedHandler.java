package xyz.itwill.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

//접근이 제한된 페이지를 요청할 경우 호출될 메소드가 작성된 클래스
// => 계정 잠금 기능 활성화 등의 명령 작성
// => AccessDeniedHandler 인터페이스를 상속받아 작성
@Component
public class CustomAccessDeniedHandler implements AccessDeniedHandler {
	//접근이 제한된 페이지를 요청할 경우 자동 호출되는 메소드
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		response.sendRedirect(request.getContextPath()+"/access_denied");
	}
}
