package xyz.itwill.dao;

import java.util.List;

import xyz.itwill.dto.User;

public interface UserDAO {
    int insertUser(User user);
    int updateUser(User user);
    int deleteUser(String userId);
    User selectUser(String userId);
    List<User> selectUserList();
    int updateUserAuth(User user);
    User selectUserByNickname(String nickname);
}
