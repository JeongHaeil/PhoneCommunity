package xyz.itwill.service;

import java.util.Map;

import xyz.itwill.dto.ChatRooms;

public interface ChatRoomsService {

	
	
	void createChatRooms(ChatRooms chatRooms);
	
	ChatRooms getChatRooms(Map<String, Object> map);
	
	int getLastInsertedRoomId();
}
