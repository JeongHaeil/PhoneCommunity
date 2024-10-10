package xyz.itwill.dao;

import java.util.Map;

import xyz.itwill.dto.ChatRooms;

public interface ChatRoomsDAO {
	
	void createChatRooms(ChatRooms chatRooms);
	
	ChatRooms getChatRooms(Map<String, Object> map); 
	
	int getLastInsertedRoomId();
	
	int generateNewRoomId();
	
	int getSellerIdByProductId(String productId);

}
