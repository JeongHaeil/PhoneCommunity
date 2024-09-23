package xyz.itwill.service;

import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.UserDAO;
import xyz.itwill.dto.User;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserDAO userDAO;

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
    public void updateUserAuth(User user) {
        userDAO.updateUserAuth(user);
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
}
