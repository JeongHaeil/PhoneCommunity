package xyz.itwill.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.User;
import xyz.itwill.mapper.UserMapper;

@Repository
@RequiredArgsConstructor
public class UserDAOImpl implements UserDAO {
    private final SqlSession sqlSession;
    
    
    @Override
    public int insertUser(User user) {
        return sqlSession.getMapper(UserMapper.class).insertUser(user);
    }
 
    @Override
    public int updateUser(User user) {
        return sqlSession.getMapper(UserMapper.class).updateUser(user);
    }

    // String 타입의 userId를 사용하도록 수정
    @Override
    public int deleteUser(String userId) {
        return sqlSession.getMapper(UserMapper.class).deleteUser(userId);
    }

    // String 타입의 userId를 사용하도록 수정
    @Override
    public User selectUser(String userId) {
        return sqlSession.getMapper(UserMapper.class).selectUser(userId);
    }

    @Override
    public List<User> selectUserList() {
        return sqlSession.getMapper(UserMapper.class).selectUserList();
    }
    @Override
    public User selectUserByNickname(String nickname) {
        return sqlSession.selectOne("UserMapper.selectUserByNickname", nickname);
    }
    @Override
    public User selectUserByUserId(String userId) {
        return sqlSession.getMapper(UserMapper.class).selectUserByUserId(userId);
    }
 
    @Override
    public String selectUserIdByEmailAndName(String email, String name) {
        Map<String, String> params = new HashMap<>();
        params.put("email", email);
        params.put("name", name);
        
        return sqlSession.selectOne("xyz.itwill.mapper.UserMapper.selectUserIdByEmailAndName", params);
    }
    
 // 새로 추가된 메서드: 아이디, 이름, 이메일로 사용자 조회
    @Override
    public User selectUserByIdNameAndEmail(String userId, String userName, String userEmail) {
        Map<String, String> params = new HashMap<>();
        params.put("userId", userId);
        params.put("userName", userName);
        params.put("userEmail", userEmail);
        
        return sqlSession.selectOne("xyz.itwill.mapper.UserMapper.selectUserByIdNameAndEmail", params);
    }
 // 비밀번호 업데이트를 위한 메서드 추가
    @Override
    public int updatePassword(User user) {
        return sqlSession.getMapper(UserMapper.class).updatePassword(user); // 단순 비밀번호 업데이트
    }
    // 새로 추가된 경험치 업데이트 메서드
    @Override
    public int updateUserExperience(User user) {
        return sqlSession.getMapper(UserMapper.class).updateUserExperience(user); // 경험치 업데이트 메서드
    }
    // 최근 로그인 시간 업데이트 구현
    @Override
    public int updateLastLogin(String userId) {
        return sqlSession.getMapper(UserMapper.class).updateLastLogin(userId);
    }
    @Override
    public int updateNickname(String userId, String nickname) {
        return sqlSession.getMapper(UserMapper.class).updateNickname(userId, nickname);
    }

}