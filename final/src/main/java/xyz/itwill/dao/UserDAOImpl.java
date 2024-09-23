package xyz.itwill.dao;

import java.util.List;

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
    public int updateUserAuth(User user) {
        return sqlSession.getMapper(UserMapper.class).updateUserAuth(user);
    }
    
    @Override
    public User selectUserByNickname(String nickname) {
        return sqlSession.selectOne("UserMapper.selectUserByNickname", nickname);
    }
}
