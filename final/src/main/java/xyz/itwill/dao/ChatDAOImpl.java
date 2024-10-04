package xyz.itwill.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Chat;
import xyz.itwill.mapper.ChatMapper;

@RequiredArgsConstructor
public class ChatDAOImpl implements ChatDAO {
	private final SqlSession sqlSession;
	
	@Override
	public void insertChat(Chat chat) {
		sqlSession.getMapper(ChatMapper.class).insertChat(chat);
		
	}

	@Override
	public List<Chat> getChatByProductId(int productId) {
		
		return sqlSession.getMapper(ChatMapper.class).getChatByProductId(productId);
	}

}
