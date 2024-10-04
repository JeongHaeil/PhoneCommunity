package xyz.itwill.service;

import xyz.itwill.dto.ChatRooms;

public interface ChatRoomsService {

	
	
	void createChatRooms(ChatRooms chatRooms);
	
	ChatRooms getChatRooms(int buyerId ,int sellerId );
}
