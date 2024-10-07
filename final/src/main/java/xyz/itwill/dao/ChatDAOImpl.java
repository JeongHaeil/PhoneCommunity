package xyz.itwill.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Chat;
import xyz.itwill.dto.ChatMessages;
import xyz.itwill.mapper.ChatMapper;
@Repository
@RequiredArgsConstructor
public class ChatDAOImpl implements ChatDAO {
	private final SqlSession sqlSession;
	 private static final String NAMESPACE = "xyz.itwill.mapper.ChatMapper";
	 
	@Override
	public void insertChat(Chat chat) {
		sqlSession.getMapper(ChatMapper.class).insertChat(chat);
		
	}

	@Override
	public List<Chat> getChatByProductId(int productId) {
		
		return sqlSession.getMapper(ChatMapper.class).getChatByProductId(productId);
	}
	
	

	@Override
	public void saveChatMessage(ChatMessages chatMessages) {
		sqlSession.insert(NAMESPACE + ".insertChatMessage", chatMessages);
		
	}

	

}
