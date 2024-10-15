package xyz.itwill.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.controller.ChatWebSocketHandler;
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
    private final ChatWebSocketHandler chatWebSocketHandler;
/*
	@Override
	public void createChatRooms(ChatRooms chatRooms) {
		chatRoomsDAO.createChatRooms(chatRooms);
	}
*/
    /*
    @Override
    public int createChatRooms(ChatRooms chatRooms) {
    	 return chatRoomsDAO.createChatRooms(chatRooms);  
    }
    */
    @Override
    public int createChatRooms(ChatRooms chatRooms) {
        // 이미 존재하는 채팅방이 있는지 확인
        Integer existingRoomId = chatRoomsDAO.findExistingRoom(chatRooms.getBuyerId(), chatRooms.getSellerId());
        
        if (existingRoomId != null) {
            return existingRoomId;  // 이미 존재하는 방이 있으면 그 방 번호를 반환
        } else {
            // 없으면 새 방을 생성하고 시퀀스를 사용하여 방 번호 생성
            int newRoomId = chatRoomsDAO.getLastInsertedRoomId();
            chatRooms.setRoomId(newRoomId);
            chatRoomsDAO.createChatRooms(chatRooms);
            return newRoomId;
        }
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





	@Override
	public void insertChatRoom(ChatRooms chatRoom) {
		chatRoomsDAO.insertChatRoom(chatRoom);
		
	}
   

}
