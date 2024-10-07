package xyz.itwill.service;

import java.util.List;

import xyz.itwill.dto.Chat;
import xyz.itwill.dto.ChatMessages;

public interface ChatService {

	void insertChat(Chat chat);
	
	List<Chat> getChatByProductId(int productId);

	 void saveChatMessage(ChatMessages chatMessages);
}
