package xyz.itwill.dto;

import lombok.Data;
import java.util.Date;

@Data
public class Email {
    private int emailVerification;    // 이메일 인증 번호 (Primary Key)
    private int emailUserNum;         // 사용자 번호 (Foreign Key)
    private Date emailExpiration; // 이메일 만료 날짜 
    private boolean emailAuth;        // 이메일 인증 여부 (false: 미인증, true: 인증됨)
    private Date emailRequestDate;    // 이메일 요청 날짜
    private int emailCode;            // 이메일 코드 (인증에 사용되는 숫자 코드)

    // 이메일 만료 여부를 확인하는 메소드 (현재 시간과 만료 시간을 비교)
    public boolean isExpired() {
        return new Date().after(this.emailExpiration);
    }

    // 이메일 만료 시간을 설정하는 메소드 (10분)
    public void setEmailExpiration() {
        long expirationTime = 10 * 60 * 1000; // 10분(밀리초 단위)
        this.emailExpiration = new Date(this.emailRequestDate.getTime() + expirationTime);
    }
}
