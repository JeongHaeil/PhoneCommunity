package xyz.itwill.service;

import java.util.List;

import xyz.itwill.dto.User;

public interface UserService {
    void addUser(User user); // 회원가입
    void modifyUser(User user); // 회원 정보 수정
    void removeUser(String userid); // 회원 삭제
    User getUser(String userid); // 특정 회원 조회
    List<User> getUserList(); // 모든 회원 조회
    User loginAuth(User user); // 로그인 인증
    void updateUserAuth(User user);
    User getUserByNickname(String nickname);
    boolean isUserIdAvailable(String userId); // 아이디 중복 확인
    boolean isNicknameAvailable(String nickname); // 닉네임 중복 확인
    
}
