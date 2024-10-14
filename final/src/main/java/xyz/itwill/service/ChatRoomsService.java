package xyz.itwill.service;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import xyz.itwill.dto.ChatRooms;

public interface ChatRoomsService {

	int getSellerIdByProductId(String productId);
	
	//void createChatRooms(ChatRooms chatRooms);
	
	ChatRooms getChatRooms(Map<String, Object> map);
	
	int getLastInsertedRoomId();

	
	int generateNewRoomId();
<<<<<<< HEAD
=======

	//int findExistingRoom(String buyerId, String sellerId, int productId);
	
	
	
	int createChatRooms(ChatRooms chatRooms); 
	
	int findExistingRoom(@Param("buyerId") String buyerId, @Param("sellerId") String sellerId);

	

	

	
>>>>>>> branch 'dev' of https://github.com/JeongHaeil/final.git
	
}
