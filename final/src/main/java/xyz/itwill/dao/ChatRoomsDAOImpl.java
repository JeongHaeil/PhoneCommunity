package xyz.itwill.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.ChatRooms;
import xyz.itwill.mapper.ChatRoomsMapper;
@Repository
@RequiredArgsConstructor
public class ChatRoomsDAOImpl implements ChatRoomsDAO{

	private final SqlSession sqlSession;
	
	@Override
	public void createChatRooms(ChatRooms chatRooms) {
		sqlSession.getMapper(ChatRoomsMapper.class).createChatRooms(chatRooms);
		
	}

	
	@Override
    public ChatRooms getChatRooms(Map<String, Object> map) {
        return sqlSession.getMapper(ChatRoomsMapper.class).getChatRooms(map);
    }


	@Override
	public int getLastInsertedRoomId() {
		
		return sqlSession.selectOne("xyz.itwill.mapper.ChatRoomsMapper.getLastInsertedRoomId");
	}


	@Override
	public int getSellerIdByProductId(String productId) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(ChatRoomsMapper.class).getSellerIdByProductId(productId);
	}


	@Override
	public int generateNewRoomId() {
		
		return sqlSession.getMapper(ChatRoomsMapper.class).generateNewRoomId();
	}


	

}
