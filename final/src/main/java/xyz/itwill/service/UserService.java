package xyz.itwill.service;

import java.util.List;

import org.springframework.stereotype.Service;

import xyz.itwill.dto.User;

@Service
public interface UserService {
    void addUser(User user); // 회원가입
    void modifyUser(User user); // 회원 정보 수정
    void removeUser(String userid); // 회원 삭제
    User getUser(String userid); // 특정 회원 조회
    List<User> getUserList(); // 모든 회원 조회
    User loginAuth(User user); // 로그인 인증
    User getUserByNickname(String nickname);
    boolean isUserIdAvailable(String userId); // 아이디 중복 확인
    boolean isNicknameAvailable(String nickname); // 닉네임 중복 확인
    User getUserByEmail(String email);
    String findUserIdByEmailAndName(String email, String name);
    User findUserByIdNameAndEmail(String userId, String userName, String userEmail); // ID, 이름, 이메일로 사용자 찾기
    void updatePassword(User user); // 비밀번호 업데이트
    void increaseExperience(String userId, int amount); // 경험치 증가
    void updateUserPassword(User user, String newPassword); // 회원이 입력한 비밀번호 업데이트
    void updateLastLoginTime(String userId); // 최근 로그인 시간 업데이트
    void modifyUserNickname(String userId, String newNickname); // 닉네임 변경 추가
    void updateUserStatus(String userId, int status); // user_status 업데이트 (탈퇴 처리)
   
}