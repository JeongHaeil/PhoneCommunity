package xyz.itwill.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Email;
import xyz.itwill.dto.User;
import xyz.itwill.service.EmailService;
import xyz.itwill.service.UserService;

@Controller
@RequestMapping("/email")
@RequiredArgsConstructor
public class EmailController {
    private final UserService userService;
    private final EmailService emailService;

    // 회원가입 후 이메일 인증을 위한 로직
    @RequestMapping(value = "/sendVerification", method = RequestMethod.GET)
    public String sendVerificationEmail(HttpSession session, Model model) {
        User user = (User) session.getAttribute("pendingUser");
        
        if (user == null) {
            return "redirect:/user/register"; // 회원가입 정보가 없으면 다시 회원가입 페이지로 이동
        }

        // 인증 코드 생성 후 이메일로 전송
        int emailCode = (int) (Math.random() * 1000000); // 6자리 인증 코드 생성
        emailService.sendVerificationEmail(user.getUserEmail(), emailCode);

        // 이메일 인증 정보를 저장
        Email emailVerification = new Email();
        emailVerification.setEmailUserNum(user.getUserNum());
        emailVerification.setEmailCode(emailCode);
        emailVerification.setEmailExpirationDate(emailService.calculateExpirationDate()); // 만료 시간 설정
        emailService.addEmail(emailVerification);

        model.addAttribute("message", "인증 이메일이 발송되었습니다.");
        return "email/emailVerification"; // 이메일 인증 페이지로 이동
    }

    // 이메일 인증 페이지 이동
    @RequestMapping(value = "/verify", method = RequestMethod.GET)
    public String showEmailVerificationForm() {
        return "email/emailVerification"; // 이메일 인증 JSP 파일 경로
    }

    // 이메일 인증 처리
    @RequestMapping(value = "/verify", method = RequestMethod.POST)
    public String verifyEmail(@RequestParam("emailCode") int emailCode, Model model, HttpSession session) {
        Email email = emailService.getEmailByCode(emailCode);

        if (email != null && !email.isExpired()) { // 인증 코드 확인 및 만료 여부 확인
            // 인증 성공 처리
            User pendingUser = (User) session.getAttribute("pendingUser");
            if (pendingUser != null) {
                userService.addUser(pendingUser);  // 인증 성공 시 회원 정보 저장
                session.removeAttribute("pendingUser");  // 임시 사용자 정보 삭제
            }
            
            model.addAttribute("message", "이메일 인증에 성공했습니다.");
            return "redirect:/user/login"; // 인증 성공 후 로그인 페이지로 이동
        } else {
            model.addAttribute("error", "인증 코드가 유효하지 않거나 만료되었습니다.");
            return "email/emailVerification"; // 인증 실패 시 다시 인증 페이지로 이동
        }
    }
}
