package xyz.itwill.service;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import xyz.itwill.dto.ChatRooms;
import xyz.itwill.dto.Product;
import xyz.itwill.dto.User;

public interface ChatRoomsService {

	int getSellerIdByProductId(String productId);
	
	//void createChatRooms(ChatRooms chatRooms);
	
	ChatRooms getChatRooms(Map<String, Object> map);
	
	int getLastInsertedRoomId();

	
	int generateNewRoomId();

	//int findExistingRoom(String buyerId, String sellerId, int productId);
	
	
	
	int createChatRooms(ChatRooms chatRooms); 
	
	int findExistingRoom(@Param("buyerId") String buyerId, @Param("sellerId") String sellerId);

	void insertChatRoom(ChatRooms chatRoom);

	

	
	
}
