package xyz.itwill.controller;


import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.ChatRooms;
import xyz.itwill.service.ChatRoomsService;



@Controller
@RequestMapping("/chatroom")
@RequiredArgsConstructor
public class ChatController  {
		private final ChatRoomsService chatRoomsService;
		 
		
		
		// 채팅 시작 버튼을 클릭하면 호출되는 메서드
	    @GetMapping("/start")
	    public String startChat(@RequestParam String productId, @RequestParam int buyerId,@RequestParam int roomId,@RequestBody ChatRooms requset) {
	    	System.out.println("Received buyerId: " + buyerId);
	    
	        // 상품의 판매자 정보를 가져옴
	        int sellerId = chatRoomsService.getSellerIdByProductId(productId);
	    	// int sellerId = 123;
	        // 채팅방 조회를 위한 조건 설정
	        Map<String, Object> params = new HashMap<>();
	        params.put("buyerId", buyerId);
	        params.put("sellerId", sellerId);
	        params.put("productId", productId);
	        params.put("roomId", roomId);
	        
	        
	        System.out.println("buyerId: " + buyerId);
	        System.out.println("sellerId: " + sellerId);

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
	    	System.out.println("Loaded roomId: " + roomId); // 디버그 출력
	        model.addAttribute("roomId", roomId);
	        
	        return "chat/chat";  // 채팅방 JSP로 이동
	    }
    
		
		  
	
	    // 새로운 방 번호 생성
	    @PostMapping("/createRoom")
	    @ResponseBody
	    public int createRoom() {
	    	
	    	// 새로운 방 번호를 생성하는 로직 (예: DB에서 고유 ID 생성)
	    	int newRoomId = chatRoomsService.generateNewRoomId();  // 서비스에서 새로운 방 번호 생성
	    	return newRoomId;  // 생성된 방 번호를 클라이언트로 반환
	    }
	   
	    @GetMapping("/chat")
	    public String getChatPage(HttpSession session, Model model, @RequestParam String sellerId) {
	        // 로그인된 사용자 정보 세션에서 가져오기
	        String loggedInUserId = (String) session.getAttribute("userId");

	        if (loggedInUserId == null) {
	            model.addAttribute("error", "로그인된 사용자 정보가 없습니다.");
	            return "error"; // 로그인 정보가 없을 때 오류 페이지로 이동
	        }

	        model.addAttribute("sellerId", sellerId);
	        model.addAttribute("loggedInUserId", loggedInUserId);
	        return "chat/chat"; // 채팅 페이지로 이동
	    }
	
}