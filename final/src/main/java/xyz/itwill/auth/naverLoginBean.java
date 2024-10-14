package xyz.itwill.auth;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

@Component
public class naverLoginBean {
	private final static String NAVER_CLIENT_ID="4b7j9hY3ERZLREDUIura";
	private final static String NAVER_CLIENT_SERCRET="NRkNLsGmoS";
	private final static String NAVER_REDIRECT_URI="http://localhost:8000/final/naver/callback";
	private final static String SESSION_STATE="naver_oauth_state";
	private final static String PROFILE_API_URL="https://openapi.naver.com/v1/nid/me";
	
	private String generateRandomString() {
		return UUID.randomUUID().toString();
	}
	
	private void setSesstion(HttpSession session, String state) {
		session.setAttribute(SESSION_STATE, state);
	}
	
	private String getSession(HttpSession session) {
		return (String)session.getAttribute(SESSION_STATE);		
	}
	
	public String getAuthorizationUrl(HttpSession session) {
		String state=generateRandomString();
		setSesstion(session, state);
		OAuth20Service auth20Service=new ServiceBuilder()
				.apiKey(NAVER_CLIENT_ID)
				.apiSecret(NAVER_CLIENT_SERCRET)
				.callback(NAVER_REDIRECT_URI)
				.state(state)
				.build(naverLoginApi.instance());
		
		return auth20Service.getAuthorizationUrl();
	}
	public OAuth2AccessToken getAccessToken(HttpSession session,String code, String state) throws IOException {
		String sessionState=getSession(session);
		if(StringUtils.pathEquals(sessionState, state)) {
			OAuth20Service auth20Service=new ServiceBuilder()
					.apiKey(NAVER_CLIENT_ID)
					.apiSecret(NAVER_CLIENT_SERCRET)
					.callback(NAVER_REDIRECT_URI)
					.state(state)
					.build(naverLoginApi.instance());
			OAuth2AccessToken accessToken= auth20Service.getAccessToken(code);
			return accessToken;
		}
		return null;
	}
	
	
	
	public String getUserProfile(OAuth2AccessToken auth2AccessToken) throws IOException {
		OAuth20Service auth20Service=new ServiceBuilder()
				.apiKey(NAVER_CLIENT_ID)
				.apiSecret(NAVER_CLIENT_SERCRET)
				.build(naverLoginApi.instance());
		
		OAuthRequest request=new OAuthRequest(Verb.GET, PROFILE_API_URL, auth20Service);
		auth20Service.signRequest(auth2AccessToken, request);
		Response response=request.send();
		return response.getBody();
	}
	
	
}
