package xyz.itwill.auth;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.SecurityAuthDAO;
import xyz.itwill.dao.UserDAO;
import xyz.itwill.dto.SecurityAuth;
import xyz.itwill.dto.User;

// 테이블에 저장된 사용자 정보 및 권한 정보를 검색하여 인증 처리 후 사용자 정보 및 권한 정보가
// 저장된 UserDetails 객체를 반환하는 메소드가 작성된 클래스
// => UserDetailsService 인터페이스를 상속받아 작성
@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
    private final UserDAO userDAO;
    private final SecurityAuthDAO securityAuthDAO;
    
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 사용자 정보 조회
        User user = userDAO.selectUserByUserId(username);
        
        if (user == null) {
            throw new UsernameNotFoundException(username);
        }
        
        // 사용자 권한 정보 조회
        List<SecurityAuth> securityAuthList = securityAuthDAO.selectSecurityAuthByUserid(username);
        
        // 사용자 정보 및 권한 정보를 결합하여 CustomUserDetails 객체 반환
        return new CustomUserDetails(user, securityAuthList);
    }
}
