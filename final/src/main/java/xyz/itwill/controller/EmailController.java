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

    // 이메일 인증 페이지로 이동
    @RequestMapping(value = "/verify", method = RequestMethod.GET)
    public String showEmailVerificationForm() {
        return "email/emailVerification"; // 이메일 인증 JSP 파일 경로
    }

    // 이메일 인증 코드 검증 및 회원가입 완료 처리
    @RequestMapping(value = "/verify", method = RequestMethod.POST)
    public String verifyEmail(@RequestParam("emailCode") int emailCode, HttpSession session, Model model) {
        User user = (User) session.getAttribute("tempUser");

        if (user == null) {
            return "redirect:/user/register"; // 세션에 사용자 정보가 없으면 회원가입 페이지로 이동
        }

        Email emailVerification = emailService.getEmailByCode(emailCode);

        if (emailVerification == null || emailVerification.isExpired()) {
            model.addAttribute("error", "유효하지 않은 인증 코드입니다. 다시 시도하세요.");
            return "email/emailVerification"; // 인증 실패 시 다시 인증 페이지로 이동
        }

        // 이메일 인증이 성공했으므로 회원 정보를 데이터베이스에 저장
        userService.addUser(user);

        // 방금 저장된 user_num을 가져오기 위해 다시 조회
        User savedUser = userService.getUser(user.getUserId());

        // 방금 저장된 user_num을 사용하여 이메일 인증 정보 업데이트
        emailVerification.setEmailUserNum(savedUser.getUserNum());
        emailVerification.setEmailAuth(true);
        emailService.updateEmail(emailVerification);

        // 세션에서 임시 사용자 정보 삭제
        session.removeAttribute("tempUser");

        return "redirect:/user/login"; // 인증 성공 후 로그인 페이지로 이동
    }
}
