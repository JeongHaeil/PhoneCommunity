package xyz.itwill.auth;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;
import xyz.itwill.dto.SecurityAuth;
import xyz.itwill.dto.User;

@Data
public class CustomUserDetails implements UserDetails {
    private static final long serialVersionUID = 1L;

    // 인증된 사용자 정보가 저장될 필드
    private String userId;
    private String userPassword;
    private String userName;
    private String userEmail;
    private String nickname; // 닉네임 필드 추가
    private int userStatus;

    // 인증된 사용자의 모든 권한 정보가 저장될 필드
    private List<GrantedAuthority> authorities;

    // 매개변수로 전달받은 User 객체와 권한 리스트를 CustomUserDetails 객체의 필드에 저장
    public CustomUserDetails(User user, List<SecurityAuth> securityAuthList) {
        this.userId = user.getUserId();
        this.userPassword = user.getUserPassword();
        this.userName = user.getUserName();
        this.userEmail = user.getUserEmail();
        this.nickname = user.getUserNickName(); // 닉네임 초기화
        this.userStatus = user.getUserStatus();

        this.authorities = new ArrayList<>();
        for (SecurityAuth auth : securityAuthList) {
            this.authorities.add(new SimpleGrantedAuthority(auth.getAuth()));
        }
    }
    // 인증된 사용자의 권한 정보를 반환하는 메소드

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }
    // 인증된 사용자의 비밀번호를 반환하는 메소드

    @Override
    public String getPassword() {
        return userPassword;
    }
    // 인증된 사용자의 아이디를 반환하는 메소드

    @Override
    public String getUsername() {
        return userId;
    }

    // 추가적으로 사용자 이름을 반환하는 메서드
    public String getName() {
        return userName;
    }
    // 추가적으로 닉네임을 반환하는 메서드
    public String getNickname() {
        return nickname;
    }
    
    // 인증된 사용자의 유효기간 상태를 반환하는 메소드

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }
    // 인증된 사용자의 잠금 상태를 반환하는 메소드

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    // 인증된 사용자 비밀번호의 유효기간 상태를 반환하는 메소드

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    // 인증된 사용자의 활성화 상태를 반환하는 메소드
    // => `userStatus`가 1이면 활성화된 사용자, 0이면 비활성화된 사용자로 처리
    @Override
    public boolean isEnabled() {
        return userStatus == 1;
    }
}
