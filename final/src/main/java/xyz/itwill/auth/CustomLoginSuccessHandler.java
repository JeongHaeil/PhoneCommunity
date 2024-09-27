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

//인증 성공 후 실행될 기능을 제공하기 위한 클래스
// => 마지막 로그인 날짜 변경 처리 또는 로그인 실패 횟수 초기화 등의 기능 구현
// => AuthenticationSuccessHandler 인터페이스를 상속받아 작성하거나 AuthenticationSuccessHandler 
//인터페이스를 상속받은 자식클래스를 상속받아 작성

//인증 성공 후 사용자 권한에 따라 다른 페이지로 이동하는 기능을 제공
@Component
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	//인증 성공시 자동 호출되는 메소드
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		//로그인 사용자의 권한을 저장하기 위한 List 객체 생성
		List<String> roleNames=new ArrayList<String>();
		
		//Authentication.getAuthorities() : 인증된 사용자에 대한 모든 권한정보(GrantedAuthority 객체)가 
		//요소값으로 저장된 List 객체를 반환하는 메소드
		// => GrantedAuthority 객체 : 사용자의 권한정보가 저장된 객체
		for(GrantedAuthority authority : authentication.getAuthorities()) {
			//GrantedAuthority.getAuthority() : GrantedAuthority 객체에 저장된 권한정보를 문자열로 반환하는 메소드
			roleNames.add(authority.getAuthority());
		}
		
		//Collection<T>.contains(T Obj) : Collection 객체에 저장된 요소값을 매개변수로 전달받은
		//값과 비교하여 요소값이 없으면 [false]를 반환하고 요소값이 있으면 [true]를 반환하는 메소드 
		if(roleNames.contains("ROLE_ADMIN")) {
			//클라이언트에게 URL 주소를 전달하여 응답 처리
			response.sendRedirect(request.getContextPath()+"/admin/");
		} else if(roleNames.contains("ROLE_MANAGER")) {
			response.sendRedirect(request.getContextPath()+"/manager/");
		} else if(roleNames.contains("ROLE_USER")) {
			response.sendRedirect(request.getContextPath()+"/user/");
		} else {
			response.sendRedirect(request.getContextPath()+"/guest/");
		}
	}
}







