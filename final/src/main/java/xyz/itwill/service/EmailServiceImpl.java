package xyz.itwill.service;

import java.util.Calendar;
import java.util.Date;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.EmailDAO;
import xyz.itwill.dto.Email;

@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService {
    private final EmailDAO emailDAO;
    private final JavaMailSender mailSender;  // JavaMailSender를 사용하여 이메일 전송

    @Transactional
    @Override
    public void addEmail(Email email) {
        email.setEmailExpiration(calculateExpirationDate());  // 이메일 만료 시간 설정
        emailDAO.insertEmail(email);  // 이메일 인증 정보 저장
    }

    @Override
    public Email getEmailByCode(int emailCode) {
        return emailDAO.selectEmailByCode(emailCode);  // 인증 코드로 이메일 정보 조회
    }

    @Override
    public void sendVerificationEmail(String toEmail, int emailCode) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setFrom("tosmreo@gmail.com", "관리자"); // 보낸 사람 이름 설정
            helper.setTo(toEmail);
            helper.setSubject("이메일 인증 코드");
            helper.setText("인증 코드는 다음과 같습니다: " + emailCode);

            mailSender.send(message);  // 이메일 전송
            System.out.println("이메일이 성공적으로 전송되었습니다.");
        } catch (Exception e) {
            System.err.println("이메일 전송에 실패했습니다: " + e.getMessage());
            throw new RuntimeException("이메일 전송 실패", e);
        }
    }

    @Transactional
    @Override
    public void updateEmail(Email email) {
        emailDAO.updateEmail(email);  // 이메일 인증 정보 업데이트
    }

    @Override
    public Date calculateExpirationDate() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MINUTE, 10);  // 만료 시간을 10분 후로 설정
        return calendar.getTime();
    }

    @Override
    public void sendTemporaryPassword(String toEmail, String temporaryPassword) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setFrom("tosmreo@gmail.com", "관리자"); // 보낸 사람 이름 설정
            helper.setTo(toEmail);
            helper.setSubject("임시 비밀번호 안내");
            helper.setText("임시 비밀번호는 다음과 같습니다: " + temporaryPassword);

            mailSender.send(message);  // 이메일 전송
            System.out.println("임시 비밀번호 이메일이 성공적으로 전송되었습니다.");
        } catch (Exception e) {
            System.err.println("임시 비밀번호 이메일 전송에 실패했습니다: " + e.getMessage());
            throw new RuntimeException("임시 비밀번호 이메일 전송 실패", e);
        }
    }
}
