package xyz.itwill.mapper;

import java.util.List;

import xyz.itwill.dto.ChatMessages;

public interface ChatMessageMapper {
	
	
	void insertChatMessage(ChatMessages chatMessages);
	
	List<ChatMessages> getMessagesByRoomId(int roomId);
}
