package xyz.itwill.mapper;

import xyz.itwill.dto.ChatRooms;

public interface ChatRoomsMapper {
	void createChatRooms(ChatRooms chatRooms);
	
	ChatRooms getChatRooms(int buyerId ,int sellerId );
}
