package xyz.itwill.dao;

import xyz.itwill.dto.ChatRooms;

public interface ChatRoomsDAO {
	
	void createChatRooms(ChatRooms chatRooms);
	
	ChatRooms getChatRooms(int buyerId ,int sellerId );
}
