package xyz.itwill.exception;

import lombok.Getter;

//로그인 처리할 때 전달받은 아이디와 비밀번호에 대한 인증이 실패한 경우 발생될 예외를 생성하기 위한 예외클래스 
public class LoginAuthFailException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	@Getter
	private String userid;
	
	public LoginAuthFailException() {
		// TODO Auto-generated constructor stub
	}

	public LoginAuthFailException(String message, String userid) {
		super(message);
		this.userid=userid;
	}
}
