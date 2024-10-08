package xyz.itwill.controller;


import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.ChatRooms;
import xyz.itwill.service.ChatRoomsService;



@Controller
@RequestMapping("/chat")
@RequiredArgsConstructor
public class ChatController  {
		private final ChatRoomsService chatRoomsService;
		 
		
		
		// 채팅 시작 버튼을 클릭하면 호출되는 메서드
	    @GetMapping("/start")
	    public String startChat(@RequestParam String productId, @RequestParam int buyerId) {
	        // 상품의 판매자 정보를 가져옴
	        int sellerId = chatRoomsService.getSellerIdByProductId(productId);
	    	// int sellerId = 123;
	        // 채팅방 조회를 위한 조건 설정
	        Map<String, Object> params = new HashMap<>();
	        params.put("buyerId", buyerId);
	        params.put("sellerId", sellerId);
	        params.put("productId", productId);

	        // 기존 채팅방을 조회
	        ChatRooms chatRoom = chatRoomsService.getChatRooms(params);

	        // 채팅방이 없으면 새로 생성
	        if (chatRoom == null) {
	            ChatRooms newChatRoom = new ChatRooms();
	            newChatRoom.setBuyerId(buyerId);
	            newChatRoom.setSellerId(sellerId);
	            newChatRoom.setProductId(productId);
	            chatRoomsService.createChatRooms(newChatRoom);

	            // 새로 생성한 채팅방을 다시 조회
	            chatRoom = chatRoomsService.getChatRooms(params);
	        }

	        // 채팅방으로 리다이렉트
	        return "redirect:/chat/room/" + chatRoom.getRoomId();
	    }

	    // 채팅방으로 이동
	    @GetMapping("/room/{roomId}")
	    public String chatRoom(@PathVariable int roomId, Model model) {
	        model.addAttribute("roomId", roomId);
	        return "chat/chat";  // 채팅방 JSP로 이동
	    }
    
		
		  // 방 번호를 받아 해당 채팅방을 로드하는 컨트롤러 (GET 요청 처리)
		/*  
		 @GetMapping("/room/{roomId}") public String loadChatRoom(@PathVariable int
		 roomId, Model model) { model.addAttribute("roomId", roomId); // JSP에 방 번호 전달
		  return "chat/chatRoom"; // 채팅방 JSP 반환 }
*/		
	   //완성본
	    // 새로운 방 번호 생성
	    @PostMapping("/createRoom")
	    @ResponseBody
	    public int createRoom() {
	    	// 새로운 방 번호를 생성하는 로직 (예: DB에서 고유 ID 생성)
	    	int newRoomId = chatRoomsService.generateNewRoomId();  // 서비스에서 새로운 방 번호 생성
	    	return newRoomId;  // 생성된 방 번호를 클라이언트로 반환
	    }
	   
	    /*
	    @PostMapping("/createRoom")
	    @ResponseBody
	    public int createRoom(@RequestParam int buyerId, @RequestParam int sellerId) {
	        // 상품 ID 없이 사용자들 간 채팅방 생성
	        ChatRooms newChatRoom = new ChatRooms();
	        newChatRoom.setBuyerId(buyerId);
	        newChatRoom.setSellerId(sellerId);

	        chatRoomsService.createChatRooms(newChatRoom);
	        return newChatRoom.getRoomId();  // 생성된 방 번호 반환
	    }
	    */
}
