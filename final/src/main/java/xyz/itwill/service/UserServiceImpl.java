package xyz.itwill.service;

import java.security.SecureRandom;
import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.UserDAO;
import xyz.itwill.dto.SecurityAuth;
import xyz.itwill.dto.User;
import xyz.itwill.util.ExperienceUtil;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserDAO userDAO;
    private final EmailService emailService; // 이메일 전송을 위한 서비스 추가
    private final SecurityAuthService securityAuthService; // 권한 부여를 위한 서비스 추가
    private final PasswordEncoder passwordEncoder; // PasswordEncoder 주입 추가

    @Transactional
    @Override
    public void addUser(User user) {
    	// PasswordEncoder를 사용하여 비밀번호 암호화 처리
        String hashedPassword = passwordEncoder.encode(user.getUserPassword());
        user.setUserPassword(hashedPassword);

        // 회원 정보 저장
        userDAO.insertUser(user);

        // 권한 추가 (회원가입 시 기본 권한을 부여)
        SecurityAuth securityAuth = new SecurityAuth();
        securityAuth.setAuthUserId(user.getUserId());
        securityAuth.setAuth("ROLE_USER"); // 기본 권한 설정
        securityAuthService.addSecurityAuth(securityAuth);
    }
    
    @Transactional
    @Override
    public void modifyUser(User user) {
        // 비밀번호가 입력된 경우 PasswordEncoder를 사용하여 암호화 처리 후 업데이트
        if (user.getUserPassword() != null && !user.getUserPassword().isEmpty()) {
            String hashedPassword = passwordEncoder.encode(user.getUserPassword());
            user.setUserPassword(hashedPassword);
        }

        userDAO.updateUser(user);
    }


    @Transactional
    @Override
    public void removeUser(String userId) {
        userDAO.deleteUser(userId);
    }

    @Override
    public User getUser(String userId) {
        return userDAO.selectUser(userId);
    }

    @Override
    public List<User> getUserList() {
        return userDAO.selectUserList();
    }

    @Override
    public User loginAuth(User user) {
        User authUser = userDAO.selectUser(user.getUserId());
        
        // 비밀번호 인증 실패 시 PasswordEncoder를 사용하여 비교
        if (authUser != null && !passwordEncoder.matches(user.getUserPassword(), authUser.getUserPassword())) {
            return null; // 인증 실패 처리
        }
        return authUser;
    }


    @Override
    public boolean isUserIdAvailable(String userId) {
        return userDAO.selectUser(userId) == null;
    }

    @Override
    public boolean isNicknameAvailable(String nickname) {
        return userDAO.selectUserByNickname(nickname) == null;
    }

    @Override
    public User getUserByNickname(String nickname) {
        return userDAO.selectUserByNickname(nickname);
    }

 
    @Override
    public String findUserIdByEmailAndName(String email, String name) {
        return userDAO.selectUserIdByEmailAndName(email, name);
    }

    // 새로운 비밀번호 찾기 메서드 추가
    @Override
    @Transactional
    public User findUserByIdNameAndEmail(String userId, String userName, String userEmail) {
        return userDAO.selectUserByIdNameAndEmail(userId, userName, userEmail);
    }

    @Override
    @Transactional
    public void updatePassword(User user) {
        // 8자리 임시 비밀번호 생성
        String temporaryPassword = generateRandomPassword(8); // 8자리 임시 비밀번호 생성
        String hashedPassword = passwordEncoder.encode(temporaryPassword); // PasswordEncoder를 사용한 암호화

        // 암호화된 비밀번호를 사용자 객체에 설정
        user.setUserPassword(hashedPassword);

        // 비밀번호 업데이트
        userDAO.updateUser(user);
        
        // 임시 비밀번호를 이메일로 전송
        emailService.sendTemporaryPassword(user.getUserEmail(), temporaryPassword); // 임시 비밀번호 이메일 전송
    }

    // 임시 비밀번호를 생성하는 메서드
    private String generateRandomPassword(int length) {
        String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()";
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder(length);

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(CHARACTERS.length());
            password.append(CHARACTERS.charAt(index));
        }

        return password.toString();
    }
 // 경험치 증가 메서드 구현
    @Override
    public void increaseExperience(String userId, int amount) {
        User user = userDAO.selectUser(userId);
        if (user != null) {
            // 현재 경험치에 추가할 경험치를 더함
            int newExperience = user.getUserExperience() + amount;
            
            // 경험치가 레벨업에 도달하는 경우 처리
            while (newExperience >= ExperienceUtil.getExperienceForNextLevel(user.getUserLevel())) {
                newExperience -= ExperienceUtil.getExperienceForNextLevel(user.getUserLevel());
                user.setUserLevel(user.getUserLevel() + 1);  // 레벨업
            }
            
            user.setUserExperience(newExperience);  // 경험치 갱신
            userDAO.updateUser(user);  // 변경된 사용자 정보 저장
        }
    }
    
    @Override
    @Transactional
    public void updateUserPassword(User user, String newPassword) {
        // 입력된 새 비밀번호를 암호화 처리
        String hashedPassword = passwordEncoder.encode(newPassword);

        // 암호화된 비밀번호를 사용자 객체에 설정
        user.setUserPassword(hashedPassword);

        // 비밀번호 업데이트
        userDAO.updateUser(user);
    }
    
    @Transactional
    @Override
    public void deactivateUser(String userId) {
        // 사용자 정보를 가져옴
        User user = userDAO.selectUser(userId);

        // user_status를 0으로 변경하여 비활성화 처리
        if (user != null) {
            user.setUserStatus(0);  // user_status를 0으로 설정
            userDAO.updateUser(user);  // 사용자 정보 업데이트
        }
    }
}