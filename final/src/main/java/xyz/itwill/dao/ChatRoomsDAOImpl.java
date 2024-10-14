package xyz.itwill.dao;

import java.util.HashMap;
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
	/*
	@Override
	public void createChatRooms(ChatRooms chatRooms) {
		sqlSession.getMapper(ChatRoomsMapper.class).createChatRooms(chatRooms);
		
	}
*/
	@Override
	public int createChatRooms(ChatRooms chatRooms) {
		sqlSession.insert("createChatRooms", chatRooms);
        return chatRooms.getRoomId();  // int 타입의 roomId 반환
		
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

/*
	@Override
	public int findExistingRoom(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(ChatRoomsMapper.class).findExistingRoom(params);
	}
*/
	@Override
	public Integer  findExistingRoom(String buyerId, String sellerId) {
		 Map<String, Object> params = new HashMap<>();
	        params.put("buyerId", buyerId);
	        params.put("sellerId", sellerId);
	        return sqlSession.selectOne("findExistingRoom", params);
	}
	

}
