package xyz.itwill.mapper;

import java.util.Map;

import xyz.itwill.dto.ChatRooms;

public interface ChatRoomsMapper {
	
	void createChatRooms(ChatRooms chatRooms);
	
	ChatRooms getChatRooms(Map<String, Object> map); 
	
	int getLastInsertedRoomId();
	
	int getSellerIdByProductId(String productId);
	
	int generateNewRoomId();
}
