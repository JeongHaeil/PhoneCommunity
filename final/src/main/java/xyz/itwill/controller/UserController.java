package xyz.itwill.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.User;
import xyz.itwill.dto.Email;
import xyz.itwill.service.UserService;
import xyz.itwill.service.EmailService;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;
    private final EmailService emailService;

    // 이용약관 페이지로 이동 (GET 요청)
    @RequestMapping(value = "/terms", method = RequestMethod.GET)
    public String showTermsPage() {
        return "user/tern"; // 이용약관 페이지로 이동
    }

    // 회원가입 페이지를 보여주는 메서드 (GET 요청)
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String showRegisterPage(HttpSession session) {
        Boolean agreedTerms = (Boolean) session.getAttribute("agreedTerms");

        if (agreedTerms == null || !agreedTerms) {
            return "redirect:/user/terms"; // 이용약관 동의를 하지 않았다면 이용약관 페이지로 리다이렉트
        }

        return "user/join"; // 이용약관 동의 후 회원가입 페이지로 이동
    }

    // 이용약관 동의 처리 (POST 요청)
    @RequestMapping(value = "/agreeTerms", method = RequestMethod.POST)
    public String agreeTerms(HttpSession session, @RequestParam("agreeTerms") boolean agreeTerms, @RequestParam("agreePrivacy") boolean agreePrivacy) {
        if (agreeTerms && agreePrivacy) {
            session.setAttribute("agreedTerms", true);
            return "redirect:/user/register"; // 동의 후 회원가입 페이지로 이동
        } else {
            session.setAttribute("agreedTerms", false);
            return "redirect:/user/terms"; // 동의하지 않으면 다시 이용약관 페이지로 이동
        }
    }

    // 회원가입 처리 (POST 요청)
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String registerUser(@ModelAttribute User user, Model model) {
        // 회원 정보 임시 저장
        userService.addUser(user);

        // 인증 코드 생성
        int emailCode = (int) (Math.random() * 1000000); // 6자리 코드

        try {
            // 이메일 발송
            emailService.sendVerificationEmail(user.getUserEmail(), emailCode);

            // 이메일 인증 정보 저장
            Email emailVerification = new Email();
            emailVerification.setEmailUserNum(user.getUserNum());
            emailVerification.setEmailCode(emailCode);
            emailVerification.setEmailExpiration(emailService.calculateExpirationDate());
            emailService.addEmail(emailVerification);

            // 이메일 인증 페이지로 리다이렉트
            return "redirect:/user/email";
        } catch (Exception e) {
            // 이메일 전송에 실패한 경우 예외 처리
            model.addAttribute("error", "이메일 전송에 실패했습니다. 다시 시도해주세요.");
            return "user/join"; // 회원가입 페이지로 다시 이동
        }
    }

    // 이메일 인증 페이지로 이동 (GET 요청)
    @RequestMapping(value = "/email", method = RequestMethod.GET)
    public String showEmailVerificationPage() {
        return "user/email";  // 이메일 인증 페이지로 이동 (email.jsp)
    }

    // 로그인 페이지로 이동 (GET 요청)
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "user/login";  // login.jsp 경로 유지
    }

    // 로그인 처리
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@ModelAttribute User user, Model model, HttpSession session) {
        User authUser = userService.loginAuth(user);
        session.setAttribute("loginUser", authUser);
        return "redirect:/user/profile"; // 로그인 성공 후 프로필 페이지로 이동
    }

    // 로그아웃 처리
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/user/login";  // 로그아웃 후 로그인 페이지로 이동
    }

    // 회원 프로필 조회 (JSP 파일명: mypage.jsp)
    @RequestMapping("/profile")
    public String profile(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/user/login";
        }
        model.addAttribute("user", loginUser);
        return "user/mypage";  // 프로필 페이지 경로를 mypage.jsp로 변경
    }

    // 회원 목록 조회 (관리자용, JSP 파일명: list.jsp로 추가 필요)
    @RequestMapping("/list")
    public String list(Model model) {
        model.addAttribute("userList", userService.getUserList());
        return "user/list";  // 관리자용 회원 목록 페이지 추가 필요
    }

    // 회원정보 수정 페이지 이동 (JSP 파일명: update.jsp)
    @RequestMapping(value = "/modify", method = RequestMethod.GET)
    public String modifyForm(@RequestParam String userId, Model model) {
        model.addAttribute("user", userService.getUser(userId));
        return "user/update";  // 수정 페이지 경로를 update.jsp로 변경
    }

    // 회원정보 수정 처리
    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    public String modify(@ModelAttribute User user, HttpSession session) {
        userService.modifyUser(user);
        
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser != null && loginUser.getUserId().equals(user.getUserId())) {
            session.setAttribute("loginUser", userService.getUser(user.getUserId()));
        }

        return "redirect:user/profile";  // 수정 후 프로필 페이지로 이동
    }

    // 회원 삭제 처리
    @RequestMapping("/remove")
    public String remove(@RequestParam String userId, HttpSession session) {
        userService.removeUser(userId);
        
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser != null && loginUser.getUserId().equals(userId)) {
            return "redirect:/user/logout";  // 삭제 후 로그아웃 처리
        }

        return "redirect:/user/list";  // 관리자용 회원 목록으로 이동
    }

    // 이메일 인증 코드 검증 및 회원가입 완료 처리
    @RequestMapping(value = "/verify", method = RequestMethod.POST)
    public String verifyEmail(@RequestParam("emailCode") int emailCode, HttpSession session, Model model) {
        User user = (User) session.getAttribute("tempUser");

        if (user == null) {
            return "redirect:/user/register";
        }

        Email emailVerification = emailService.getEmailByCode(emailCode);

        if (emailVerification == null || emailVerification.isExpired()) {
            model.addAttribute("error", "유효하지 않은 인증 코드입니다. 다시 시도하세요.");
            return "user/email";
        }

        user.setUserAuth(1); // 인증된 사용자로 설정
        userService.updateUserAuth(user);

        session.removeAttribute("tempUser");

        return "redirect:/user/login";
    }

    // 아이디 찾기 페이지로 이동 (GET 요청)
    @RequestMapping(value = "/findId", method = RequestMethod.GET)
    public String showFindIdPage() {
        return "user/idfind";  // 아이디 찾기 페이지로 이동 (idfind.jsp)
    }

    // 비밀번호 찾기 페이지로 이동 (GET 요청)
    @RequestMapping(value = "/findPassword", method = RequestMethod.GET)
    public String showFindPasswordPage() {
        return "user/passwordfind";  // 비밀번호 찾기 페이지로 이동 (passwordfind.jsp)
    }
    
    // 아이디 중복 확인
    @RequestMapping(value = "/checkUserId", method = RequestMethod.GET)
    @ResponseBody
    public String checkUserId(@RequestParam("userId") String userId) {
        User user = userService.getUser(userId);
        return (user == null) ? "AVAILABLE" : "EXISTS";
    }

    @RequestMapping(value = "/checkNickname", method = RequestMethod.GET)
    @ResponseBody
    public String checkNickname(@RequestParam("userNickName") String userNickName) {
        User user = userService.getUserByNickname(userNickName);
        return (user == null) ? "AVAILABLE" : "EXISTS";
    }
}
