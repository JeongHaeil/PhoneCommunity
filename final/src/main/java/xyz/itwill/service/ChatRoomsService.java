package xyz.itwill.service;

import java.util.Map;

import xyz.itwill.dto.ChatRooms;

public interface ChatRoomsService {

	int getSellerIdByProductId(String productId);
	
	void createChatRooms(ChatRooms chatRooms);
	
	ChatRooms getChatRooms(Map<String, Object> map);
	
	int getLastInsertedRoomId();
	
	int generateNewRoomId();
	
}
