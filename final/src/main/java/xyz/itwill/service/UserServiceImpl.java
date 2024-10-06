package xyz.itwill.service;

import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.UserDAO;
import xyz.itwill.dto.User;
import xyz.itwill.util.ExperienceUtil;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserDAO userDAO;
    private final EmailService emailService; // 이메일 전송을 위한 서비스 추가

    @Transactional
    @Override
    public void addUser(User user) {
        // 비밀번호 암호화 처리
        String hashedPassword = BCrypt.hashpw(user.getUserPassword(), BCrypt.gensalt());
        user.setUserPassword(hashedPassword);

        userDAO.insertUser(user);
    }

    @Transactional
    @Override
    public void modifyUser(User user) {
        // 비밀번호가 입력된 경우 암호화 처리 후 업데이트
        if (user.getUserPassword() != null && !user.getUserPassword().isEmpty()) {
            String hashedPassword = BCrypt.hashpw(user.getUserPassword(), BCrypt.gensalt());
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
        // 비밀번호 인증 실패 시
        if (authUser != null && !BCrypt.checkpw(user.getUserPassword(), authUser.getUserPassword())) {
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
        // 비밀번호 암호화는 컨트롤러에서 처리되었으므로 그대로 업데이트
        userDAO.updatePassword(user);
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
}