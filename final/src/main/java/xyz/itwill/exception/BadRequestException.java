package xyz.itwill.exception;

//비정상적인 요청인 경우 발생될 예외를 생성하기 위한 예외클래스 
public class BadRequestException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public BadRequestException() {
		// TODO Auto-generated constructor stub
	}
	
	public BadRequestException(String message) {
		super(message);
	}
}
