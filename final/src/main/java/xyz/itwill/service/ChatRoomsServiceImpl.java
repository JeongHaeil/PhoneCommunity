package xyz.itwill.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.ChatRoomsDAO;
import xyz.itwill.dao.ProductDAO;
import xyz.itwill.dao.UserDAO;
import xyz.itwill.dto.ChatRooms;

@Service
@RequiredArgsConstructor
public class ChatRoomsServiceImpl implements ChatRoomsService{
		
	
	private final ChatRoomsDAO chatRoomsDAO;
	private final UserDAO userDAO;  // 새로운 DAO 추가 (혹은 서비스)
    private final ProductDAO productDAO; 
/*
	@Override
	public void createChatRooms(ChatRooms chatRooms) {
		chatRoomsDAO.createChatRooms(chatRooms);
	}
*/
    @Override
    public int createChatRooms(ChatRooms chatRooms) {
    	 return chatRoomsDAO.createChatRooms(chatRooms);  
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
/*
	@Override
	public int findExistingRoom(String buyerId, String sellerId, int productId) {
        Map<String, Object> params = new HashMap<>();
        params.put("buyerId", buyerId);
        params.put("sellerId", sellerId);
        params.put("productId", productId);
        return chatRoomsDAO.findExistingRoom(params);
	}
*/
	@Override
	public int findExistingRoom(String buyerId, String sellerId) {
		Integer roomId = chatRoomsDAO.findExistingRoom(buyerId, sellerId); 
        return roomId != null ? roomId : 0;
		
		
		//return chatRoomsDAO.findExistingRoom(buyerId, sellerId);
	}
   

}
