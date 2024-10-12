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
 // 비밀번호 업데이트 쿼리 추가
    int updatePassword(User user);
    
 // 경험치 업데이트 쿼리 추가
    int updateUserExperience(User user); // User 객체를 매개변수로 받도록 수정

 // 최근 로그인 시간 업데이트 쿼리 추가
    int updateLastLogin(@Param("userId") String userId);
 // 닉네임만 업데이트하는 쿼리 추가
    int updateNickname(@Param("userId") String userId, @Param("nickname") String nickname);
    // user_status 업데이트 (탈퇴 처리)
    int updateUserStatus(@Param("userId") String userId, @Param("status") int status);
   }

