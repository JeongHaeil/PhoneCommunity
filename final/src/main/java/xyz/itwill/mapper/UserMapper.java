package xyz.itwill.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import xyz.itwill.dto.User;

public interface UserMapper {
    int insertUser(User user);
    int updateUser(User user);
    int deleteUser(String userId);
    User selectUser(String userId);
    List<User> selectUserList();
    User selectUserByNickname(String nickname);
    User selectUserByUserId(String userId);
    String selectUserIdByEmailAndName(@Param("email") String email, @Param("name") String name);
 // 아이디, 이메일, 이름으로 사용자 조회
    User selectUserByIdAndEmailAndName(@Param("userId") String userId, 
                                       @Param("userEmail") String userEmail,
                                       @Param("userName") String userName);
}
