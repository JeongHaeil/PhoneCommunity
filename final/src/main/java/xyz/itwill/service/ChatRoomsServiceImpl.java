package xyz.itwill.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.ChatRoomsDAO;
import xyz.itwill.dao.ProductDAO;
import xyz.itwill.dao.UserDAO;
import xyz.itwill.dto.ChatRooms;
import xyz.itwill.dto.Product;
import xyz.itwill.dto.User;

@Service
@RequiredArgsConstructor
public class ChatRoomsServiceImpl implements ChatRoomsService{
		
	
	private final ChatRoomsDAO chatRoomsDAO;
	private final UserDAO userDAO;  // 새로운 DAO 추가 (혹은 서비스)
    private final ProductDAO productDAO; 

	@Override
	public void createChatRooms(ChatRooms chatRooms) {
		chatRoomsDAO.createChatRooms(chatRooms);
		
	}

	@Override
	public ChatRooms getChatRooms(Map<String, Object> map) {
		// TODO Auto-generated method stub
		 return chatRoomsDAO.getChatRooms(map);
	}

	@Override
	public int getLastInsertedRoomId() {
		// TODO Auto-generated method stub
		return chatRoomsDAO.getLastInsertedRoomId();
	}

	@Override
	public int getSellerIdByProductId(String productId) {
		
		return chatRoomsDAO.getSellerIdByProductId(productId);
	}

	@Override
	public int generateNewRoomId() {
		
		return chatRoomsDAO.generateNewRoomId();
	}


	


   

}
