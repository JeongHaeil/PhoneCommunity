package xyz.itwill.auth;

import com.github.scribejava.core.builder.api.DefaultApi20;

//Kakao OpenAPI를 사용하기 위한 기능을 제공하는 클래스
// => DefaultApi20 클래스를 상속받아 작성
public class KakaoLoginApi extends DefaultApi20 {
	protected KakaoLoginApi() {	}	

	public static class InstanceHolder {
		private static final KakaoLoginApi INSTANCE=new KakaoLoginApi();
	}
	
	public static KakaoLoginApi instance() {
		return InstanceHolder.INSTANCE;
	}
	
	@Override
	public String getAccessTokenEndpoint() {
		return "https://kauth.kakao.com/oauth/token";
	}

	@Override
	protected String getAuthorizationBaseUrl() {
		return "https://kauth.kakao.com/oauth/authorize";
	}
}
