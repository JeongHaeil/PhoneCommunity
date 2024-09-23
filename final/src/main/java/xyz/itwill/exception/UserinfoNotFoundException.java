package xyz.itwill.exception;

//회원정보에 대한 변경, 삭제, 검색할 때 전달받은 아이디의 회원정보를 찾을 수 없는 경우 발생될
//예외를 생성하기 위한 예외클래스 
public class UserinfoNotFoundException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public UserinfoNotFoundException() {
		// TODO Auto-generated constructor stub
	}
	
	public UserinfoNotFoundException(String message) {
		super(message);
	}
}
