package xyz.itwill.service;

import java.util.List;

import xyz.itwill.dto.Chat;

public interface ChatService {

	void insertChat(Chat chat);
	
	List<Chat> getChatByProductId(int productId);
}
