package xyz.itwill.service;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.ChatRoomsDAO;
import xyz.itwill.dto.ChatRooms;

@Service
@RequiredArgsConstructor
public class ChatRoomsServiceImpl implements ChatRoomsService{
		
	private final ChatRoomsDAO chatRoomsDAO;
	
	@Override
	public void createChatRooms(ChatRooms chatRooms) {
		chatRoomsDAO.createChatRooms(chatRooms);
		
	}

	@Override
	public ChatRooms getChatRooms(int buyerId, int sellerId) {
	
		return chatRoomsDAO.getChatRooms(buyerId, sellerId);
	}

}
