package xyz.itwill.dao;

import java.util.List;

import xyz.itwill.dto.ChatMessages;

public interface ChatMessageDAO {
	
	
void insertChatMessage(ChatMessages chatMessages);
	
	List<ChatMessages> getMessagesByRoomId(int roomId);
}
