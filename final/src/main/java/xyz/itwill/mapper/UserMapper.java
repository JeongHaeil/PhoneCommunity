package xyz.itwill.mapper;

import java.util.List;
import xyz.itwill.dto.User;

public interface UserMapper {
    int insertUser(User user);
    int updateUser(User user);
    int deleteUser(String userId);
    User selectUser(String userId);
    List<User> selectUserList();
    User selectUserByNickname(String nickname);
    User selectUserByUserId(String userId);
    User selectUserByEmail(String userEmail);

}
