package xyz.itwill.dao;

import java.util.List;

import xyz.itwill.dto.User;

public interface UserDAO {
    int insertUser(User user);
    int updateUser(User user);
    int deleteUser(String userId);
    User selectUser(String userId);
    List<User> selectUserList();
    User selectUserByNickname(String nickname);
    User selectUserByUserId(String userId);
    
    String selectUserIdByEmailAndName(String email, String name); // 추가
    
    // 새로 추가된 메서드: 아이디, 이름, 이메일로 사용자 조회
    User selectUserByIdNameAndEmail(String userId, String userName, String userEmail);
    
    int updatePassword(User user); // 비밀번호만 변경하는 메서드 추가
    int updateUserExperience(User user);  // 경험치 업데이트 메서드 추가
    // 최근 로그인 시간 업데이트 메서드 추가
    int updateLastLogin(String userId);
    
    int updateNickname(String userId, String nickname);
    // 추가된 메서드: user_status 업데이트
    int updateUserStatus(String userId, int status);  // user_status를 0으로 변경하는 메서드 추가
    
    User selectUserByEmail(String email);
}