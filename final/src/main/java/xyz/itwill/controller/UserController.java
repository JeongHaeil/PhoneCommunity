package xyz.itwill.controller;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.dto.Email;
import xyz.itwill.dto.User;
import xyz.itwill.service.EmailService;
import xyz.itwill.service.UserService;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

    private final UserService userService;
    private final EmailService emailService;
    private final PasswordEncoder passwordEncoder; // PasswordEncoder 주입
    

    // 홈 페이지 요청을 처리하는 메서드
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Authentication authentication) {
        if (authentication != null) { // 인증된 사용자인 경우
            CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
            log.warn("아이디 = " + user.getUserId());
            log.warn("이름 = " + user.getName());
            log.warn("이메일 = " + user.getUserEmail());
        }
        return "main_page"; // 메인 페이지로 이동
    }

    // 게스트 페이지 요청을 처리하는 메서드
    @RequestMapping(value = "/guest/", method = RequestMethod.GET)
    public String guestPage() {
        return "guest_page";
    }

    // 일반 사용자 페이지 요청을 처리하는 메서드
    @RequestMapping(value = "/user/", method = RequestMethod.GET)
    public String userPage() {
        return "user_page";
    }

    // 게시판 관리자 페이지 요청을 처리하는 메서드
    @RequestMapping(value = "/board_admin/", method = RequestMethod.GET)
    public String boardAdminPage() {
        return "board_admin_page";
    }

    // 최고 관리자 페이지 요청을 처리하는 메서드
    @RequestMapping(value = "/super_admin/", method = RequestMethod.GET)
    public String superAdminPage() {
        return "super_admin_page";
    }

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
    public String registerUser(
            @ModelAttribute User user, 
            @RequestParam("phone_first") String phoneFirst,
            @RequestParam("phone_middle") String phoneMiddle, 
            @RequestParam("phone_last") String phoneLast,
            Model model, HttpSession session) {
        
        try {
            // 핸드폰 번호 합치기
            String fullPhoneNumber = phoneFirst + phoneMiddle + phoneLast;
            user.setUserPhoneNum(fullPhoneNumber);  // User 객체에 핸드폰 번호 설정
            
            session.setAttribute("tempUser", user);

            // 이메일 인증 코드 생성 및 전송
            int emailCode = (int) (Math.random() * 1000000); // 6자리 코드
            emailService.sendVerificationEmail(user.getUserEmail(), emailCode);

            // 이메일 인증 정보 저장
            Email emailVerification = new Email();
            emailVerification.setEmailUserNum(0); // 아직 저장되지 않은 사용자
            emailVerification.setEmailCode(emailCode);
            emailVerification.setEmailExpiration(emailService.calculateExpirationDate());
            emailService.addEmail(emailVerification);

            return "redirect:/user/email";
        } catch (Exception e) {
            model.addAttribute("error", "이메일 전송에 실패했습니다. 다시 시도해주세요.");
            return "user/join";
        }
    }
    @RequestMapping(value = "/email", method = RequestMethod.GET)
    public String showEmailVerificationPage() {
        return "user/email";  // 이메일 인증 페이지로 이동 (email.jsp)
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

        userService.addUser(user);

        User savedUser = userService.getUser(user.getUserId());
        emailVerification.setEmailUserNum(savedUser.getUserNum());
        emailVerification.setEmailAuth(true);
        emailService.updateEmail(emailVerification);

        session.removeAttribute("tempUser");

        return "redirect:/user/login";
    }

    // 로그인 페이지로 이동 (GET 요청)
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "user/login";  // login.jsp 경로 유지
    }

 // 회원 프로필 조회 (JSP 파일명: mypage.jsp)
    @RequestMapping("/profile")
    public String profile(Authentication authentication, Model model) {
        if (authentication == null) {
            return "redirect:/user/login";  // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
        }

        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        User loginUser = userService.getUser(userDetails.getUserId());  // 로그인된 사용자의 정보를 DB에서 조회

        model.addAttribute("user", loginUser);  // 사용자 정보를 모델에 추가하여 뷰에 전달
        return "user/mypage";  // 프로필 페이지로 이동
    }


    // 아이디 중복 확인
    @RequestMapping(value = "/checkUserId", method = RequestMethod.GET)
    @ResponseBody
    public String checkUserId(@RequestParam("userId") String userId) {
        User user = userService.getUser(userId);
        return (user == null) ? "AVAILABLE" : "EXISTS";
    }

    
    // 아이디 찾기 페이지 요청 (GET 요청)
    @RequestMapping(value = "/idfind", method = RequestMethod.GET)
    public String showIdFindPage() {
        return "user/idfind"; // idfind.jsp 파일로 이동
    }

    // 아이디 찾기 요청 처리
    @RequestMapping(value = "/displayUserId", method = RequestMethod.POST)
    public String displayUserId(@RequestParam("email") String email,
                                @RequestParam("name") String name, Model model) {
        log.info("아이디 찾기 요청: 이메일={}, 이름={}", email, name); // 로그 추가
        String userId = userService.findUserIdByEmailAndName(email, name);

        if (userId != null) {
            model.addAttribute("userId", userId);
        } else {
            model.addAttribute("error", "해당 정보로 등록된 아이디가 없습니다.");
        }

        return "user/displayUserId"; // 결과를 보여줄 JSP 페이지로 이동
    }

    // GET 요청 처리
    @RequestMapping(value = "/displayUserId", method = RequestMethod.GET)
    public String showUserId(@RequestParam("email") String email,
                             @RequestParam("name") String name, Model model) {
        String userId = userService.findUserIdByEmailAndName(email, name);

        if (userId != null) {
            model.addAttribute("userId", userId);
        } else {
            model.addAttribute("error", "일치하는 회원이 없습니다.");
        }

        return "user/displayUserId"; // displayUserId.jsp 경로로 이동
    }

    // 비밀번호 찾기 페이지로 이동
    @RequestMapping(value = "/passwordfind", method = RequestMethod.GET)
    public String showPasswordFindPage() {
        return "user/passwordfind";  // passwordfind.jsp 페이지로 이동
    }

    // 비밀번호 찾기 처리
    @RequestMapping(value = "/findPassword", method = RequestMethod.POST)
    public String findPassword(@RequestParam("userId") String userId,
                               @RequestParam("userName") String userName,
                               @RequestParam("userEmail") String userEmail, Model model) {
        User user = userService.findUserByIdNameAndEmail(userId, userName, userEmail);

        if (user == null || !user.getUserId().equals(userId) || !user.getUserName().equals(userName)) {
            model.addAttribute("error", "입력하신 정보와 일치하는 사용자가 없습니다.");
            return "user/passwordfind";
        }

        // 임시 비밀번호 생성
        String tempPassword = generateTempPassword();

        // 이메일로 임시 비밀번호 전송
        emailService.sendTemporaryPassword(userEmail, tempPassword);

        // 임시 비밀번호를 암호화하여 저장
        user.setUserPassword(BCrypt.hashpw(tempPassword, BCrypt.gensalt()));
        userService.modifyUser(user);

        // 성공 메시지를 Model에 추가
        model.addAttribute("message", "임시 비밀번호가 이메일로 전송되었습니다.");

        // 비밀번호가 전송되었다는 페이지로 이동
        return "user/displayUserpw";
    }

    // 임시 비밀번호 생성 메서드
    private String generateTempPassword() {
        // 임시 비밀번호는 영숫자 조합으로 8자리 생성
    	String chars = "0123456789";
        StringBuilder tempPassword = new StringBuilder();
        Random rnd = new Random();
        while (tempPassword.length() < 8) {  // 비밀번호 길이
            int index = (int) (rnd.nextFloat() * chars.length());
            tempPassword.append(chars.charAt(index));
        }
        return tempPassword.toString();
    }
 // 회원정보 수정 페이지로 이동 (GET 방식)
    @RequestMapping(value = "/userUpdate", method = RequestMethod.GET)
    public String showUserUpdatePage(Authentication authentication, Model model) {
        if (authentication == null) {
            return "redirect:/user/login";  // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
        }

        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        User loginUser = userService.getUser(userDetails.getUserId());
        model.addAttribute("user", loginUser);

        return "user/userUpdate";  // userUpdate.jsp로 이동
    }

    // 회원정보 수정 처리 (POST 방식)
    @RequestMapping(value = "/userUpdate", method = RequestMethod.POST)
    public String updateUser(
            @ModelAttribute User user, 
            Authentication authentication, 
            Model model) {
        if (authentication == null) {
            return "redirect:/user/login";  // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
        }

        try {
            userService.modifyUser(user);
            model.addAttribute("message", "회원 정보가 성공적으로 업데이트되었습니다.");
        } catch (Exception e) {
            model.addAttribute("error", "회원 정보 업데이트 중 오류가 발생했습니다.");
        }
        
        return "user/userUpdate";
    }

 // 비밀번호 변경 페이지로 이동 (GET 요청)
    @RequestMapping(value = "/passwordUpdate", method = RequestMethod.GET)
    public String showPasswordUpdatePage(Authentication authentication, Model model) {
        // 인증된 사용자의 ID를 가져와서 뷰에 전달
        if (authentication != null) {
            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
            model.addAttribute("userId", userDetails.getUserId()); // userId를 폼에 전달
        }
        return "user/passwordUpdate"; // 비밀번호 변경 페이지로 이동
    }
 // 비밀번호 변경 처리 (POST 요청)
    @RequestMapping(value = "/passwordUpdate", method = RequestMethod.POST)
    public String updatePassword(
        @RequestParam("currentPassword") String currentPassword,
        @RequestParam("newPassword") String newPassword,
        @RequestParam("confirmNewPassword") String confirmNewPassword,
        Authentication authentication, 
        Model model) {

        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        User loginUser = userService.getUser(userDetails.getUserId());

        if (!passwordEncoder.matches(currentPassword, loginUser.getUserPassword())) {
            model.addAttribute("error", "현재 비밀번호가 일치하지 않습니다.");
            return "user/passwordUpdate";
        }

        if (!newPassword.equals(confirmNewPassword)) {
            model.addAttribute("error", "새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
            return "user/passwordUpdate";
        }

        loginUser.setUserPassword(passwordEncoder.encode(newPassword));
        userService.modifyUser(loginUser);

        model.addAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
        return "user/passwordUpdate";
    }
 // 회원 탈퇴 확인 페이지로 이동 (GET 요청)
    @RequestMapping(value = "/userDelete", method = RequestMethod.GET)
    public String showUserDeletePage(Authentication authentication, Model model) {
        if (authentication != null) {
            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
            model.addAttribute("userId", userDetails.getUserId()); // 로그인한 사용자의 ID 전달
        }
        return "user/deleteUser"; // 탈퇴 페이지로 이동
    }
 
 // 회원 탈퇴 처리 (POST 방식)
    @RequestMapping(value = "/userDelete", method = RequestMethod.POST)
    public String deleteUser(
        Authentication authentication,
        @RequestParam("password") String password, 
        HttpServletRequest request,  // HttpServletRequest 추가
        HttpServletResponse response, // HttpServletResponse 추가
        Model model) {

        if (authentication == null) {
            return "redirect:/user/login";  // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
        }

        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        User loginUser = userService.getUser(userDetails.getUserId());

        // 비밀번호 확인
        if (!passwordEncoder.matches(password, loginUser.getUserPassword())) {
            model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
            return "user/userDelete";
        }

        // user_status를 0으로 변경하여 계정 비활성화
        loginUser.setUserStatus(0);
        userService.modifyUser(loginUser);  // 상태 업데이트

        // 인증 상태 해제 및 로그아웃 처리
        new SecurityContextLogoutHandler().logout(request, response, authentication);

        model.addAttribute("message", "회원 탈퇴가 완료되었습니다.");
        return "redirect:/user/login";  // 로그인 페이지로 리다이렉트
    }
    
 // 스크랩 보기 페이지로 이동
    @RequestMapping(value = "/myScrap", method = RequestMethod.GET)
    public String showMyScrapPage() {
        return "user/myScrap"; // 스크랩 보기 페이지로 이동
    }

    // 작성 글 보기 페이지로 이동
    @RequestMapping(value = "/myWrite", method = RequestMethod.GET)
    public String showMyWritePage() {
        return "user/myWrite"; // 작성 글 보기 페이지로 이동
    }

    // 자동 로그인 관리 페이지로 이동
    @RequestMapping(value = "/myRemember-me", method = RequestMethod.GET)
    public String showMyRememberMePage() {
        return "user/myRemember-me"; // 자동 로그인 관리 페이지로 이동
    }

    // 작성 댓글 보기 페이지로 이동
    @RequestMapping(value = "/myComment", method = RequestMethod.GET)
    public String showMyCommentPage() {
        return "user/myComment"; // 작성 댓글 보기 페이지로 이동
    }
}