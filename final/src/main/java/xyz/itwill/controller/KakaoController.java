package xyz.itwill.controller;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.OAuth2AccessToken;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.auth.KaKaoLoginBean;
import xyz.itwill.dto.SecurityAuth;
import xyz.itwill.dto.User;
import xyz.itwill.service.UserService;

@Controller
@RequestMapping("/kakao")
@RequiredArgsConstructor
public class KakaoController {
    private final KaKaoLoginBean kaKaoLoginBean;
    private final UserService userService;
    
    // 카카오 로그인 페이지로 리다이렉트하는 메소드
    @RequestMapping("/login")
    public String login(HttpSession session) {
        String kakaoAuthUrl = kaKaoLoginBean.getAuthorizationUrl(session);
        return "redirect:" + kakaoAuthUrl;
    }
    
    // 카카오 로그인 성공 시 호출되는 콜백 URL 처리 메소드
    @RequestMapping("/callback")
    public String login(@RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {
        OAuth2AccessToken accessToken = kaKaoLoginBean.getAccessToken(session, code, state);
        String apiResult = kaKaoLoginBean.getUserProfile(accessToken);

        // JSON 파싱
        JSONParser parser = new JSONParser();
        JSONObject jsonObject = (JSONObject) parser.parse(apiResult);
        Long id = (Long) jsonObject.get("id");
        JSONObject propertiesObject = (JSONObject) jsonObject.get("properties");
        String name = (String) propertiesObject.get("nickname");
        JSONObject kakaoAccountObject = (JSONObject) jsonObject.get("kakao_account");
        String email = (String) kakaoAccountObject.get("email");

        // 사용자 정보 및 권한 정보 설정
        String userId = "kakao_" + id;
        User user = userService.getUserByUserId(userId);

        if (user == null) {
            user = new User();
            user.setUserId(userId);
            user.setUserPassword(UUID.randomUUID().toString()); // 비밀번호 랜덤 설정
            user.setUserName(name);
            user.setUserEmail(email);
            user.setUserStatus(1); // 사용자 활성화 상태로 설정

            // 사용자 정보 DB에 저장
            userService.addUser(user);

            // 권한 정보 설정 및 DB 저장
            SecurityAuth auth = new SecurityAuth(userId, "ROLE_USER");
            userService.addSecurityAuth(auth);
        }

        // 인증 처리
        CustomUserDetails userDetails = new CustomUserDetails(user);
        Authentication authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(authentication);

        return "redirect:/";
    }
}
