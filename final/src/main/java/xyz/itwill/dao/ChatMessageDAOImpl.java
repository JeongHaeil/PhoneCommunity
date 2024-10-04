package xyz.itwill.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.ChatMessages;
import xyz.itwill.mapper.ChatMessageMapper;

@RequiredArgsConstructor
public class ChatMessageDAOImpl implements ChatMessageDAO{

	private final SqlSession sqlSession;
	
	@Override
	public void insertChatMessage(ChatMessages chatMessages) {
		sqlSession.getMapper(ChatMessageMapper.class).insertChatMessage(chatMessages);
		
	}

	@Override
	public List<ChatMessages> getMessagesByRoomId(int roomId) {
		
		return sqlSession.getMapper(ChatMessageMapper.class).getMessagesByRoomId(roomId);
	}

}
