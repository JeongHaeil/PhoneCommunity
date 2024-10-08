package xyz.itwill.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.User;
import xyz.itwill.mapper.ChatUserMapper;
import xyz.itwill.mapper.UserMapper;

@Repository
@RequiredArgsConstructor
public class ChatUserDAOImpl implements ChatUserDAO{

	private final SqlSession sqlSession;
	
	@Override
	public User getUserChatById(Map<String, Object> map) {
		
		return sqlSession.getMapper(ChatUserMapper.class).getUserChatById(map);
	}

	
}
