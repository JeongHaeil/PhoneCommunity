package xyz.itwill.dao;

import java.util.List;
import xyz.itwill.dto.SecurityAuth;
import xyz.itwill.dto.User;

public interface SecurityAuthDAO {
    // 사용자의 ID로 권한 목록 조회
    List<SecurityAuth> selectSecurityAuthByUserid(String userid);
    
    // 새로운 권한 추가
    int insertSecurityAuth(SecurityAuth securityAuth);

    // 기존 권한 삭제
    int deleteSecurityAuth(String userid);

	
}
