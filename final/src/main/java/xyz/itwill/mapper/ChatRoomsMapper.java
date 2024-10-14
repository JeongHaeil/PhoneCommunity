package xyz.itwill.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import xyz.itwill.dto.ChatRooms;

public interface ChatRoomsMapper {
	
	//void createChatRooms(ChatRooms chatRooms);
	
	ChatRooms getChatRooms(Map<String, Object> map); 
	
	int getLastInsertedRoomId();
	
	int getSellerIdByProductId(String productId);
	
	int generateNewRoomId();
	
	
	//int findExistingRoom(Map<String, Object> params);
	
	String findExistingRoom(@Param("buyerId") String buyerId, @Param("sellerId") String sellerId);
	int createChatRooms(ChatRooms chatRooms);
}
