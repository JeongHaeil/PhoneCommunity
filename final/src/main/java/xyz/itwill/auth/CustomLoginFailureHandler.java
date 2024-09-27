package xyz.itwill.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;

//인증 실패 후 실행될 기능을 제공하기 위한 클래스
// => 로그인 실패 횟수 누적, 계정 비활성화 처리 등의 기능 구현
// => AuthenticationFailureHandler 인터페이스를 상속받아 작성하거나 AuthenticationFailureHandler 
//인터페이스를 상속받은 자식클래스를 상속받아 작성

//인증 실패시 Session Scope 속성값으로 아이디를 저장하고 로그인 페이지로 이동하는 기능을 제공
// => SimpleUrlAuthenticationFailureHandler 클래스를 상속받아 작성
@Component
public class CustomLoginFailureHandler extends SimpleUrlAuthenticationFailureHandler {
	//인증 실패시 자동 호출되는 메소드
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		request.getSession().setAttribute("userid", request.getParameter("userid"));
		setDefaultFailureUrl("/user_login");
		super.onAuthenticationFailure(request, response, exception);
	}
}