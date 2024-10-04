package xyz.itwill.dao;

import org.apache.ibatis.session.SqlSession;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.ChatRooms;
import xyz.itwill.mapper.ChatRoomsMapper;

@RequiredArgsConstructor
public class ChatRoomsDAOImpl implements ChatRoomsDAO{

	private final SqlSession sqlSession;
	
	@Override
	public void createChatRooms(ChatRooms chatRooms) {
		sqlSession.getMapper(ChatRoomsMapper.class).createChatRooms(chatRooms);
		
	}

	@Override
	public ChatRooms getChatRooms(int buyerId, int sellerId) {
		
		return sqlSession.getMapper(ChatRoomsMapper.class).getChatRooms(buyerId, sellerId);
	}

}
