package xyz.itwill.service;

import java.util.List;

import xyz.itwill.dto.ChatMessages;

public interface ChatMessageService {
	
	
	void insertChatMessage(ChatMessages chatMessages);
	
	List<ChatMessages> getMessagesByRoomId(int roomId);
	
	void saveChatMessage(ChatMessages messages);
	
}
