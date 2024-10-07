package xyz.itwill.dao;

import java.util.List;

import xyz.itwill.dto.Chat;
import xyz.itwill.dto.ChatMessages;

public interface ChatDAO {
	
	void insertChat(Chat chat);
	
	List<Chat> getChatByProductId(int productId);
	
	
	

	void saveChatMessage(ChatMessages chatMessages);
}
