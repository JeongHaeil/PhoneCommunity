package xyz.itwill.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import xyz.itwill.dto.ChatRooms;

public interface ChatRoomsDAO {
	
	//void createChatRooms(ChatRooms chatRooms);
	//int findExistingRoom(Map<String, Object> params);
	
	ChatRooms getChatRooms(Map<String, Object> map); 
	
	int getLastInsertedRoomId();
	
	int generateNewRoomId();
	
	int getSellerIdByProductId(String productId);
	
	int createChatRooms(ChatRooms chatRooms);
	Integer findExistingRoom(@Param("buyerId") String buyerId, @Param("sellerId") String sellerId);
	
	
	void insertChatRoom(ChatRooms chatRoom);
}
