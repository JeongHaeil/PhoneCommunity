package xyz.itwill.controller;


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
		
	    @PostMapping("/start")
	    
	    public String startChat(@RequestBody Map<String, Object> requestData, Model model) {
	    	try {
	            System.out.println("Request Data: " + requestData);  // 요청 데이터 디버그 출력

	            int buyerId = Integer.parseInt(requestData.get("buyerId").toString());
	            int sellerId = Integer.parseInt(requestData.get("sellerId").toString());
	            Integer roomId = requestData.containsKey("roomId") ? Integer.parseInt(requestData.get("roomId").toString()) : null;	

	            System.out.println("buyerId: " + buyerId);
	            System.out.println("sellerId: " + sellerId);
	            System.out.println("roomId: " + roomId);

	            Map<String, Object> params = new HashMap<>();
	            params.put("buyerId", buyerId);
	            params.put("sellerId", sellerId);
	            params.put("roomId", roomId);

	            // 기존 채팅방 조회
	            ChatRooms chatRoom = chatRoomsService.getChatRooms(params);
	            
	            if (chatRoom == null) {
	                ChatRooms newChatRoom = new ChatRooms();
	                newChatRoom.setBuyerId(buyerId);
	                newChatRoom.setSellerId(sellerId);
	                chatRoomsService.createChatRooms(newChatRoom);

	                chatRoom = chatRoomsService.getChatRooms(params);  // 새로 생성된 방 다시 조회
	            }

	            // 채팅방으로 리다이렉트
	            return "redirect:/chatroom/room/" + chatRoom.getRoomId();

	        } catch (Exception e) {
	            e.printStackTrace();  // 예외 로그 출력
	            return "error";  // 오류 페이지로 리다이렉트하거나 오류 처리
	        }
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