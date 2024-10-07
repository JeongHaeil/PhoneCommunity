package xyz.itwill.service;

import java.util.Map;

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
	public ChatRooms getChatRooms(Map<String, Object> map) {
		 ChatRooms chatRoom = chatRoomsDAO.getChatRooms(map);
		    
		    if (chatRoom != null) {
		        return chatRoom;  // 기존 채팅방 반환
		    } else {
		        // 새 채팅방 생성
		        ChatRooms newChatRoom = new ChatRooms();
		        newChatRoom.setSellerId((Integer) map.get("sellerId"));
	            newChatRoom.setBuyerId((Integer) map.get("buyerId"));
	            newChatRoom.setProductId((Integer) map.get("productId"));
		        chatRoomsDAO.createChatRooms(newChatRoom);
		        return newChatRoom;
		    }
    }

	@Override
	public int getLastInsertedRoomId() {
		// TODO Auto-generated method stub
		 return chatRoomsDAO.getLastInsertedRoomId();
	}

}
