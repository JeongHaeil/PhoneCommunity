package xyz.itwill.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;

import lombok.RequiredArgsConstructor;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.auth.naverLoginBean;
import xyz.itwill.dto.SecurityAuth;
import xyz.itwill.dto.User;
import xyz.itwill.service.SecurityAuthService;
import xyz.itwill.service.UserService;

@Controller
@RequestMapping("/naver")
@RequiredArgsConstructor
public class NaverController {
	private final naverLoginBean naverLoginBean;
	private final UserService userService;
	private final SecurityAuthService securityAuthService;
	
	//네이버 로그인 페이지 요청
	@RequestMapping("/login")
	public String login(HttpSession session) {
		String naverAuthUrl=naverLoginBean.getAuthorizationUrl(session);
		return "redirect:"+naverAuthUrl;
	}
	
	//로그인 성공식 콜백 실행
	@RequestMapping("/callback")
	public String login(@RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {
		
		OAuth2AccessToken accessToken=naverLoginBean.getAccessToken(session, code, state);
		String apiResult=naverLoginBean.getUserProfile(accessToken);
		
		JSONParser parser=new JSONParser();
		JSONObject jsonObject=(JSONObject)parser.parse(apiResult);
		JSONObject response=(JSONObject)jsonObject.get("response");
		String id=(String)response.get("id");
		String name=(String)response.get("name");
		String phone=(String)response.get("mobile");
		String email=(String)response.get("email");
		String nickname=(String)response.get("nickname");
		System.out.println("name="+name+", nickna,e="+nickname);
		
		
		SecurityAuth auth=new SecurityAuth();
		auth.setAuth("naver_"+id);
		auth.setAuth("ROLE_USER");
		List<SecurityAuth> authList=new ArrayList<SecurityAuth>();
		authList.add(auth);
		
		User user=new User();
		user.setUserId("naver_"+id);
		user.setUserPassword(UUID.randomUUID().toString());
		user.setUserName(name);
		user.setUserEmail(email);
		user.setUserPhoneNum(phone.replace("-", ""));
		user.setUserNickname(nickname);
		user.setUserStatus(1);
		
		//처음 로그인시 회원가입 실행
		if(userService.getUser("naver_"+id)==null) {
			userService.addUser(user);
		}
		//로그인 성공 후 로그인 기록 update
		userService.updateLastLoginTime("naver_"+id);
		CustomUserDetails userDetails=new CustomUserDetails(user, authList);	
		Authentication authentication=new UsernamePasswordAuthenticationToken
				(userDetails,null,userDetails.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(authentication);
		return"redirect:/";
	}
}
