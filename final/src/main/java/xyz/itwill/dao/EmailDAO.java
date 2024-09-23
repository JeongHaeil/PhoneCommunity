package xyz.itwill.dao;

import xyz.itwill.dto.Email;

public interface EmailDAO {
    void insertEmail(Email email);
    Email selectEmailByCode(int emailCode);
    void updateEmail(Email email);  // 이메일 인증 정보 업데이트 추가
}
