package xyz.itwill.controller;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.password.PasswordEncoder;
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
import xyz.itwill.dto.User;
import xyz.itwill.service.ChatRoomsService;
import xyz.itwill.service.UserService;



@Controller
@RequestMapping("/chatroom")
@RequiredArgsConstructor
public class ChatController  {
		private final ChatRoomsService chatRoomsService;
		private final UserService userService;
		private final PasswordEncoder passwordEncoder;
		
/*
		@PostMapping("/start")
		@ResponseBody
		public Map<String, Object> startChat(@RequestBody Map<String, Object> requestData) {
		    Map<String, Object> response = new HashMap<>();
		    try {
		        String buyerId = requestData.get("buyerId").toString();
		        String sellerId = requestData.get("sellerId").toString();
		        
		        // 임시 구매자를 DB에서 확인 후 없으면 추가
		        User tempUser = userService.findUserByIdNameAndEmail("phone123", "테스트용", "tosmreo11@naver.com");
		        
		        if (buyerId.equals(sellerId)) {
		            buyerId = "phone123";  // 임시 구매자 ID 설정
		            System.out.println("임시 구매자 ID가 설정되었습니다: " + buyerId);
		        }
		        
		        if (tempUser == null) {
		            response.put("error", "임시 구매자 정보를 찾을 수 없습니다.");
		            return response;  // 사용자 정보가 없으면 에러 응답
		        }

		        if (buyerId == null || buyerId.isEmpty() || buyerId.equals(sellerId)) {
		            buyerId = tempUser.getUserId();
		            System.out.println("임시 구매자 ID가 설정되었습니다: " + buyerId);
		        }

		        Integer roomId = chatRoomsService.findExistingRoom(buyerId, sellerId);

		        if (roomId == null || roomId == 0) {
		            ChatRooms chatRoom = new ChatRooms();
		            chatRoom.setSellerId(sellerId);
		            chatRoom.setBuyerId(buyerId);
		            roomId = chatRoomsService.createChatRooms(chatRoom);
		        }

		        response.put("buyerId", buyerId);
		        response.put("sellerId", sellerId);
		        response.put("roomId", roomId);
		    } catch (Exception e) {
		        e.printStackTrace();
		        response.put("error", "An error occurred.");
		    }
		    return response;
		}
*/
		@PostMapping("/start")
		@ResponseBody
		public Map<String, Object> startChat(@RequestBody Map<String, Object> requestData) {
		    Map<String, Object> response = new HashMap<>();
		    try {
		        String buyerId = requestData.get("buyerId").toString();
		        String sellerId = requestData.get("sellerId").toString();

		       
		        User tempUser = userService.findUserByIdNameAndEmail("phone123", "테스트용", "tosmreo11@naver.com");


		        if (buyerId == null || buyerId.isEmpty() || buyerId.equals(sellerId)) {
		            if (tempUser != null) {
		                buyerId = tempUser.getUserId();  // 임시 구매자 ID 설정
		            } else {
		                buyerId = "phone123";  // fallback 임시 구매자 ID 설정
		            }
		            System.out.println("임시 구매자 ID가 설정되었습니다: " + buyerId);
		        }

		             
		        
		        if (tempUser == null) {
		            response.put("error", "임시 구매자 정보를 찾을 수 없습니다.");
		            return response;  // 사용자 정보가 없으면 에러 응답
		        }
		       

		        // DB에서 이미 존재하는 방이 있는지 확인
		        Integer roomId = chatRoomsService.findExistingRoom(buyerId, sellerId);

		        // 방이 없으면 새로 생성
		        if (roomId == null || roomId == 0) {
		            ChatRooms chatRoom = new ChatRooms();
		            chatRoom.setSellerId(sellerId);
		            chatRoom.setBuyerId(buyerId);
		            roomId = chatRoomsService.createChatRooms(chatRoom);  // 방 생성
		        }

		        // 응답 데이터 설정
		        response.put("buyerId", buyerId != null ? buyerId : "unknown");
		        response.put("sellerId", sellerId != null ? sellerId : "unknown");
		        response.put("roomId", roomId);
		    } catch (Exception e) {
		        e.printStackTrace();
		        response.put("error", "An error occurred.");
		    }
		    return response;
		}

	    	
	    	
		// 채팅방으로 이동
		    @GetMapping("/room/{roomId}")
		    //public String chatRoom(@PathVariable int roomId, Model model) {
		    public String chatRoom(
		    	    @PathVariable int roomId, 
		    	    @RequestParam(value = "buyerId", required = false, defaultValue = "unknown") String buyerId, 
		    	    @RequestParam(value = "sellerId", required = false, defaultValue = "unknown") String sellerId,  
		    	    Model model
		    	) {
		    	    model.addAttribute("buyerId", buyerId);
		    	    model.addAttribute("roomId", roomId);
		    	    model.addAttribute("sellerId", sellerId);
		    	    
		    	  
		         return "chat";  // 채팅방 JSP로 이동
		    }

		@PostMapping("/createRoom")
		@ResponseBody
	    public int createRoom(@RequestBody Map<String, Object> requestData) {
		//public Map<String, Object> createChatRoom(@RequestBody Map<String, Object> requestData) {
	    	//int newRoomId = chatRoomsService.generateNewRoomId();  // 서비스에서 새로운 방 번호 생성
	    	//return newRoomId;  // 생성된 방 번호를 클라이언트로 반환
			 String buyerId = requestData.get("buyerId").toString();
			 String sellerId = requestData.get("sellerId").toString();
			 ChatRooms newRoom = new ChatRooms();
			    newRoom.setBuyerId(buyerId);
			    newRoom.setSellerId(sellerId);
			    int roomId = chatRoomsService.createChatRooms(newRoom);  // 방을 생성하고 방 번호 반환
			  
			  
			    return roomId;
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
	        return "chat"; // 채팅 페이지로 이동
	    }
	    
	    
	    @GetMapping("/loadChat")
	    public String loadChat(Model model) {
	      // 필요한 모델 속성 추가
	      return "chat";  // chat.jsp 반환
	    }

	
}