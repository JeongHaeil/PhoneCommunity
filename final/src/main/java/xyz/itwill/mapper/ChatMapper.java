package xyz.itwill.mapper;

import java.util.List;

import xyz.itwill.dto.Chat;

public interface ChatMapper {

	void insertChat(Chat chat);
	
	List<Chat> getChatByProductId(int productId);
	
}
