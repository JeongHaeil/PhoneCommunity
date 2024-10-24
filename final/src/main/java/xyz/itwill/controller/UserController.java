package xyz.itwill.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.dto.Board;
import xyz.itwill.dto.Comments;
import xyz.itwill.dto.Email;
import xyz.itwill.dto.Product;
import xyz.itwill.dto.User;
import xyz.itwill.service.BoardService;
import xyz.itwill.service.CommentsService;
import xyz.itwill.service.EmailService;
import xyz.itwill.service.ProductService;
import xyz.itwill.service.UserService;
import xyz.itwill.util.ExperienceUtil;
import xyz.itwill.util.Pager;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/user") 
public class UserController {

    private final UserService userService;
    private final EmailService emailService;
    private final PasswordEncoder passwordEncoder; // PasswordEncoder 주입
    private final BoardService boardService; // BoardService 주입
    private final CommentsService commentsService; // CommentsService 주입
    private final ProductService productService; // ProductService 추가
    

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
    public String verifyEmail(
        @RequestParam("emailCode") int emailCode, 
        HttpSession session, 
        Model model, 
        RedirectAttributes redirectAttributes) {

        User user = (User) session.getAttribute("tempUser");

        if (user == null) {
            return "redirect:/user/register"; // 세션에 사용자가 없으면 회원가입 페이지로 리다이렉트
        }

        Email emailVerification = emailService.getEmailByCode(emailCode);

        // 인증 코드가 유효하지 않거나 만료된 경우
        if (emailVerification == null || emailVerification.isExpired()) {
            model.addAttribute("errorMessage", "유효하지 않은 인증 코드입니다. 다시 시도하세요.");
            return "user/email"; // 오류 메시지를 출력하고 현재 페이지 유지
        }

        // 인증이 성공한 경우 회원 가입 진행
        userService.addUser(user);
        User savedUser = userService.getUser(user.getUserId());

        // 인증 정보를 업데이트
        emailVerification.setEmailUserNum(savedUser.getUserNum());
        emailVerification.setEmailAuth(true);
        emailService.updateEmail(emailVerification);

        session.removeAttribute("tempUser");

        // 회원가입 완료 메시지 전달
        redirectAttributes.addFlashAttribute("successMessage", "회원가입이 완료되었습니다.");
        
        // 팝업을 띄울 페이지로 리다이렉트
        return "redirect:/user/email";
    }
    
    // 회원가입 완료 후 팝업을 띄우는 페이지로 리다이렉트 처리
    @RequestMapping(value = "/registrationSuccess", method = RequestMethod.GET)
    public String showRegistrationSuccessPage() {
        return "user/registrationSuccess";  // 회원가입 완료 팝업을 띄울 페이지
    }

    // 로그인 페이지로 이동 (GET 요청)
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(HttpServletRequest request) {
    	String prevPage=request.getHeader("Referer");
    	if(prevPage!=null && !prevPage.contains("/login")) {
    		request.getSession().setAttribute("prevPage", prevPage);
    	}
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

        // 현재 경험치와 레벨 정보를 가져옴
        int currentExperience = loginUser.getUserExperience();
        int currentLevel = loginUser.getUserLevel();

        // 다음 레벨에 도달하기 위한 경험치 계산
        int experienceForNextLevel = ExperienceUtil.getExperienceForNextLevel(currentLevel);
        int progressPercentage = ExperienceUtil.calculateProgressPercentage(currentExperience, experienceForNextLevel);

        // 모델에 추가
        model.addAttribute("currentExperience", currentExperience);
        model.addAttribute("experienceForNextLevel", experienceForNextLevel);
        model.addAttribute("progressPercentage", progressPercentage);
        model.addAttribute("user", loginUser);

        return "user/mypage";  // 프로필 페이지로 이동
    }
    // 아이디 중복 확인
    @RequestMapping(value = "/checkUserId", method = RequestMethod.GET)
    @ResponseBody
    public String checkUserId(@RequestParam("userId") String userId) {
        User user = userService.getUser(userId);
        return (user == null) ? "AVAILABLE" : "EXISTS";
    }
    // 이메일 중복 확인
    @RequestMapping(value = "/checkEmail", method = RequestMethod.GET)
    @ResponseBody
    public String checkEmail(@RequestParam("userEmail") String userEmail) {
        User user = userService.getUser(userEmail);
        return (user == null) ? "AVAILABLE" : "EXISTS";
    }

    // 닉네임 중복 확인
    @RequestMapping(value = "/checkNickname", method = RequestMethod.GET)
    @ResponseBody
    public String checkNickname(@RequestParam("userNickname") String userNickname) {
        User user = userService.getUser(userNickname);
        return (user == null) ? "AVAILABLE" : "EXISTS";
    }
 // 이메일 인증 코드 재발송 처리 (POST 요청)
    @RequestMapping(value = "/email/resend", method = RequestMethod.POST)
    public String resendVerificationEmail(HttpSession session, Model model) {
        // 세션에서 tempUser를 가져옴 (회원가입 시 입력한 이메일 정보가 포함된 User 객체)
        User tempUser = (User) session.getAttribute("tempUser");

        // tempUser가 없으면 오류 메시지를 반환하도록 수정
        if (tempUser == null) {
            model.addAttribute("errorMessage", "세션이 만료되었습니다. 다시 회원가입을 진행해주세요.");
            return "user/email";  // 로그인 페이지로 리다이렉트하지 않고 인증 페이지로 유지
        }

        try {
            // 새로운 이메일 인증 코드 생성
            int emailCode = (int) (Math.random() * 1000000); // 6자리 인증 코드 생성
            emailService.sendVerificationEmail(tempUser.getUserEmail(), emailCode); // 인증 코드 전송

            // 새로운 이메일 인증 정보 생성 및 저장
            Email newEmailVerification = new Email();
            newEmailVerification.setEmailUserNum(tempUser.getUserNum()); // 해당 사용자의 userNum으로 설정
            newEmailVerification.setEmailCode(emailCode); // 새로운 인증 코드 설정
            newEmailVerification.setEmailExpiration(emailService.calculateExpirationDate()); // 새로운 만료 시간 설정
            emailService.addEmail(newEmailVerification); // 새로운 이메일 인증 정보 DB에 저장

            // 인증 페이지로 리다이렉트
            model.addAttribute("resendMessage", "인증 코드가 이메일로 다시 전송되었습니다.");
            return "user/email";  // 인증 페이지로 유지
        } catch (Exception e) {
            model.addAttribute("errorMessage", "인증 코드 재발송 중 오류가 발생했습니다. 다시 시도해주세요.");
            return "user/email"; // 오류 시 다시 인증 페이지로 이동
        }
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

 // 비밀번호 찾기 처리 (POST 요청)
    @RequestMapping(value = "/findPassword", method = RequestMethod.POST)
    public String findPassword(@RequestParam("userId") String userId,
                               @RequestParam("userName") String userName,
                               @RequestParam("userEmail") String userEmail, 
                               RedirectAttributes redirectAttributes) {
        User user = userService.findUserByIdNameAndEmail(userId, userName, userEmail);

        if (user == null || !user.getUserId().equals(userId) || !user.getUserName().equals(userName)) {
            // FlashAttribute에 오류 메시지 추가
            redirectAttributes.addFlashAttribute("error", "입력하신 정보와 일치하는 사용자가 없습니다.");
            return "redirect:/user/passwordfind"; // 리다이렉트를 사용하여 새로고침 시 메시지가 남지 않게 처리
        }

        // 서비스에서 임시 비밀번호 생성 및 비밀번호 업데이트 처리
        userService.updatePassword(user);

        // 성공 메시지를 FlashAttribute에 추가
        redirectAttributes.addFlashAttribute("successMessage", "임시 비밀번호가 이메일로 전송되었습니다.");

        // 팝업 후 로그인 페이지로 리다이렉트
        return "redirect:/user/passwordfind"; // 팝업이 뜬 후 로그인 페이지로 이동
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

 // 회원정보 수정 처리 (POST 방식) - 닉네임 변경
    @RequestMapping(value = "/updateNickname", method = RequestMethod.POST)
    public String updateNickname(
            @RequestParam("nickname") String nickname, 
            Authentication authentication, 
            RedirectAttributes redirectAttributes, 
            Model model) {
        
        // 인증되지 않은 사용자는 로그인 페이지로 리다이렉트
        if (authentication == null) {
            return "redirect:/user/login";
        }

        // 현재 로그인된 사용자의 ID 가져오기
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        String userId = userDetails.getUserId();

        // 닉네임 중복 확인
        User existingUser = userService.getUser(nickname);
        
        if (existingUser != null && !existingUser.getUserId().equals(userId)) {
            // 중복된 닉네임이 있고, 그 닉네임이 현재 사용자의 것이 아니면 오류 메시지 출력
            model.addAttribute("errorMessage", "이미 사용중인 닉네임입니다.");
            
            // 기존 사용자 정보를 다시 모델에 담아 JSP로 전달
            User loginUser = userService.getUser(userId);
            model.addAttribute("user", loginUser);
            model.addAttribute("currentExperience", loginUser.getUserExperience());
            model.addAttribute("experienceForNextLevel", ExperienceUtil.getExperienceForNextLevel(loginUser.getUserLevel()));
            model.addAttribute("progressPercentage", ExperienceUtil.calculateProgressPercentage(loginUser.getUserExperience(), ExperienceUtil.getExperienceForNextLevel(loginUser.getUserLevel())));
            
            return "user/mypage"; // 오류 시 다시 마이페이지로 이동
        }

        try {
            // 닉네임 수정
            userService.modifyUserNickname(userId, nickname);
            
            // 성공 메시지 전달
            redirectAttributes.addFlashAttribute("successMessage", "닉네임이 성공적으로 변경되었습니다.");
            return "redirect:/user/profile";  // 닉네임 변경 후 마이페이지로 리다이렉트
        } catch (Exception e) {
            // 예외 발생 시 오류 메시지 출력
            model.addAttribute("error", "닉네임 업데이트 중 오류가 발생했습니다.");
            
            // 기존 사용자 정보를 다시 모델에 담아 JSP로 전달
            User loginUser = userService.getUser(userId);
            model.addAttribute("user", loginUser);
            model.addAttribute("currentExperience", loginUser.getUserExperience());
            model.addAttribute("experienceForNextLevel", ExperienceUtil.getExperienceForNextLevel(loginUser.getUserLevel()));
            model.addAttribute("progressPercentage", ExperienceUtil.calculateProgressPercentage(loginUser.getUserExperience(), ExperienceUtil.getExperienceForNextLevel(loginUser.getUserLevel())));
            
            return "user/mypage";  // 오류 시 수정 페이지 유지
        }
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
        @RequestParam("newPassword") String newPassword,
        @RequestParam("confirmNewPassword") String confirmNewPassword,
        Authentication authentication, 
        RedirectAttributes redirectAttributes) {

        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        User loginUser = userService.getUser(userDetails.getUserId());

        // 새 비밀번호와 확인 비밀번호가 일치하는지 확인
        if (!newPassword.equals(confirmNewPassword)) {
            redirectAttributes.addFlashAttribute("error", "새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
            return "redirect:/user/passwordUpdate";
        }

        // 새 비밀번호로 업데이트
        userService.updateUserPassword(loginUser, newPassword);

        // 성공 메시지 전달 (리다이렉트 후 JSP에서 메시지를 확인해 팝업 표시)
        redirectAttributes.addFlashAttribute("successMessage", "비밀번호가 성공적으로 변경되었습니다.");
        
        return "redirect:/user/passwordUpdate";
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
        HttpServletRequest request, 
        HttpServletResponse response, 
        Model model) {

        // 현재 사용자가 인증되었는지 확인
        if (authentication == null) {
            return "redirect:/user/login";  // 인증되지 않았으면 로그인 페이지로 리다이렉트
        }

        // 현재 사용자 정보 가져오기
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        User loginUser = userService.getUser(userDetails.getUserId());

        // 입력된 비밀번호와 DB에 저장된 비밀번호 로그로 출력 (디버깅용)
        log.info("입력된 비밀번호: " + password);
        log.info("DB에 저장된 암호화된 비밀번호: " + loginUser.getUserPassword());

        // 입력된 비밀번호와 DB에 저장된 비밀번호를 비교
        if (!passwordEncoder.matches(password, loginUser.getUserPassword())) {
            log.warn("비밀번호 불일치");
            model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
            return "user/deleteUser";  // 비밀번호가 틀리면 탈퇴 페이지로 다시 이동
        }

        log.info("비밀번호 일치, 회원 탈퇴 진행");

        // user_status를 0으로 변경하는 메서드를 호출
        userService.updateUserStatus(loginUser.getUserId(), 0);  // 상태 변경 후 DB에 반영

        // 로그아웃 처리 및 세션 해제
        new SecurityContextLogoutHandler().logout(request, response, authentication);

        return "redirect:/user/login";  // 탈퇴 후 로그인 페이지로 리다이렉트
    }


   
    
 // 작성 댓글 보기 페이지로 이동 (GET 방식)
    @RequestMapping(value = "/myComment", method = RequestMethod.GET)
    public String showMyCommentPage(
            Authentication authentication, 
            Model model, 
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum, 
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) {

        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/user/login";
        }

        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        String userId = userDetails.getUserId();

        // 댓글 목록 가져오기 (전체 목록)
        List<Comments> commentList = commentsService.getCommentsByUserId(userId);

        // 전체 댓글 수
        int totalSize = commentList.size();

        // 페이징 객체 생성 (blockSize는 페이지 네비게이션에 보여질 페이지 번호 개수, 예: 5)
        Pager pager = new Pager(pageNum, pageSize, totalSize, 5);

        // 시작 행과 끝 행을 계산하여 부분 리스트 추출
        List<Comments> paginatedCommentList = commentList.subList(pager.getStartRow() - 1, Math.min(pager.getEndRow(), totalSize));

        // 모델에 댓글 목록 및 페이징 정보 추가
        model.addAttribute("commentList", paginatedCommentList);
        model.addAttribute("pager", pager);

        return "user/myComment";
    }



 // 작성 글 보기 페이지로 이동 (GET 방식)
    @RequestMapping(value = "/myWrite", method = RequestMethod.GET)
    public String showMyWritePage(
            Authentication authentication, 
            Model model, 
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum, 
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) {
        
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/user/login";
        }

        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        String userId = userDetails.getUserId();

        // 게시글 목록 가져오기 (전체 목록)
        List<Board> postList = boardService.getBoardsByUserId(userId);

        // 전체 게시글 수
        int totalSize = postList.size();

        // 페이징 객체 생성 (blockSize는 페이지 네비게이션에 보여질 페이지 번호 개수, 예: 5)
        Pager pager = new Pager(pageNum, pageSize, totalSize, 5);

        // 시작 행과 끝 행을 계산하여 부분 리스트 추출
        List<Board> paginatedPostList = postList.subList(pager.getStartRow() - 1, Math.min(pager.getEndRow(), totalSize));

        // 모델에 게시글 목록 및 페이징 정보 추가
        model.addAttribute("postList", paginatedPostList);
        model.addAttribute("pager", pager);

        return "user/myWrite";
    }

    
    
 // 헤더에 사용자의 레벨, 경험치, 경험치 진행률을 표시하기 위한 메서드
    @RequestMapping("/someEndpoint")
    public String showHeaderInfo(Authentication authentication, Model model) {
        if (authentication != null) {
            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
            User loginUser = userService.getUser(userDetails.getUserId());

            // 현재 경험치 및 레벨 정보 계산
            int currentExperience = loginUser.getUserExperience();
            int userLevel = loginUser.getUserLevel();
            int experienceForNextLevel = ExperienceUtil.getExperienceForNextLevel(userLevel);
            int progressPercentage = ExperienceUtil.calculateProgressPercentage(currentExperience, experienceForNextLevel);

            // 로그 찍기 - 여기서 값이 제대로 나오는지 확인
            log.debug("User Level: " + userLevel);
            log.debug("Current Experience: " + currentExperience);
            log.debug("Experience for Next Level: " + experienceForNextLevel);
            log.debug("Progress Percentage: " + progressPercentage);

            // 모델에 값 추가
            model.addAttribute("userLevel", userLevel);
            model.addAttribute("currentExperience", currentExperience);
            model.addAttribute("experienceForNextLevel", experienceForNextLevel);
            model.addAttribute("progressPercentage", progressPercentage);
        }

        return "header"; 
    }
    // 사용자 정보를 AJAX로 제공하기 위한 메서드
    @RequestMapping(value = "/getUserInfo", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getUserInfo(Authentication authentication) {
        Map<String, Object> userInfo = new HashMap<>();

        if (authentication != null) {
            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
            User loginUser = userService.getUser(userDetails.getUserId());

            // 레벨 및 경험치 정보 계산
            int currentExperience = loginUser.getUserExperience();
            int userLevel = loginUser.getUserLevel();
            int experienceForNextLevel = ExperienceUtil.getExperienceForNextLevel(userLevel);
            int progressPercentage = ExperienceUtil.calculateProgressPercentage(currentExperience, experienceForNextLevel);

            // 사용자 정보를 map에 저장
            userInfo.put("userLevel", userLevel);
            userInfo.put("currentExperience", currentExperience);
            userInfo.put("experienceForNextLevel", experienceForNextLevel);
            userInfo.put("progressPercentage", progressPercentage);
        }
        return userInfo;
    }
    // 작성한 중고장터 게시물 보기 페이지로 이동 (GET 방식)
    @RequestMapping(value = "/myProducts", method = RequestMethod.GET)
    public String showMyProductsPage(
            Authentication authentication,
            Model model,
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) {

        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/user/login"; // 인증되지 않은 사용자는 로그인 페이지로 리다이렉트
        }

        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        String userId = userDetails.getUserId(); // 로그인한 사용자의 ID 가져오기

        // 게시물 목록 가져오기 (로그인된 사용자만)
        List<Product> productList = productService.getProductsByUserId(userId);

        // 전체 게시물 수
        int totalSize = productList != null ? productList.size() : 0;

        // 페이징 객체 생성 (blockSize는 페이지 네비게이션에 보여질 페이지 번호 개수, 예: 5)
        Pager pager = new Pager(pageNum, pageSize, totalSize, 5);

        // 시작 행과 끝 행을 계산하여 부분 리스트 추출
        List<Product> paginatedProductList = productList != null ? productList.subList(pager.getStartRow() - 1, Math.min(pager.getEndRow(), totalSize)) : Collections.emptyList();

        // 모델에 게시물 목록 및 페이징 정보 추가
        model.addAttribute("productList", paginatedProductList);
        model.addAttribute("pager", pager);

        return "user/myProduct";
    }

    // 중고장터 게시물 상세 페이지로 이동 (GET 방식)
    @RequestMapping(value = "/details", method = RequestMethod.GET)
    public String showMyProductDetail(
            @RequestParam("productIdx") int productIdx,
            Model model) {

        // 게시물 조회
        Product product = productService.getProductByNum(productIdx);
        if (product == null) {
            return "redirect:/user/myProducts";
        }

        // 모델에 게시물 정보 추가
        model.addAttribute("product", product);

        return "user/myProductDetail";
    }



    

    // 로그인 성공 후 세션에 userId 저장하는 부분 추가- 정해일
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@ModelAttribute User user, HttpSession session, Model model, Authentication authcation) {
        // loginAuth() 메서드를 사용해 로그인 처리
        User loggedInUser = userService.loginAuth(user);  // user 객체를 사용한 로그인 처리
      
        CustomUserDetails chatuser = (CustomUserDetails) authcation.getPrincipal();
        
        if (loggedInUser != null) {
            // 로그인 성공 시 userId를 세션에 저장
            session.setAttribute("userId", chatuser.getUserId());
            model.addAttribute("userId", chatuser.getUserId());  // 모델에도 저장 가능
            return "redirect:/main";  // 로그인 성공 후 리다이렉트
        } else {
            model.addAttribute("error", "로그인 정보가 올바르지 않습니다.");
            return "user/login";  // 로그인 실패 시 로그인 페이지로 다시 이동
        }
    
    
    
    }
}

