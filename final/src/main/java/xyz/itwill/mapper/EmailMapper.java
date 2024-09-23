package xyz.itwill.mapper;

import xyz.itwill.dto.Email;

public interface EmailMapper {
    int insertEmail(Email email);               // 이메일 인증 정보 삽입
    int updateEmail(Email email);               // 이메일 인증 정보 업데이트
    Email selectEmailByUserNum(int emailUserNum); // 사용자 번호로 이메일 인증 정보 조회
    Email selectEmailByCode(int emailCode);     // 인증 코드로 이메일 인증 정보 조회
}
