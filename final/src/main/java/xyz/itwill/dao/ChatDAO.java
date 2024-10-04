package xyz.itwill.dao;

import java.util.List;

import xyz.itwill.dto.Chat;

public interface ChatDAO {
	
	void insertChat(Chat chat);
	
	List<Chat> getChatByProductId(int productId);
}
