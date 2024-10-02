package xyz.itwill.service;

import xyz.itwill.dto.Email;
import java.util.Date;

public interface EmailService {
    void addEmail(Email email);  // 이메일 인증 정보 저장
    Email getEmailByCode(int emailCode);  // 인증 코드로 이메일 정보 조회
    void sendVerificationEmail(String email, int emailCode);  // 인증 이메일 전송
    void updateEmail(Email email);  // 이메일 인증 정보 업데이트
    Date calculateExpirationDate();  // 이메일 인증 만료 시간 계산
    void sendTemporaryPassword(String email, String temporaryPassword); // 임시 비밀번호 전송
    
}
