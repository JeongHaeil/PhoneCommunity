package xyz.itwill.mapper;

import java.util.List;

import xyz.itwill.dto.Chat;
import xyz.itwill.dto.ChatMessages;

public interface ChatMapper {

	void insertChat(Chat chat);
	
	List<Chat> getChatByProductId(int productId);
	
	
	
	
}
