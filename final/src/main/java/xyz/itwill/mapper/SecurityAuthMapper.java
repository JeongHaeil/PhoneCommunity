package xyz.itwill.mapper;

import java.util.List;
import xyz.itwill.dto.SecurityAuth;

public interface SecurityAuthMapper {
    // 사용자 ID로 권한 목록을 조회하는 메소드
    List<SecurityAuth> selectSecurityAuthByUserid(String userid);
    
    // 새로운 권한을 추가하는 메소드
    int insertSecurityAuth(SecurityAuth securityAuth);
    
    // 사용자 ID로 권한을 삭제하는 메소드
    int deleteSecurityAuth(String userid);
}
