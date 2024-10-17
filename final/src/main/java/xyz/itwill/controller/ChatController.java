package xyz.itwill.controller;


import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
import xyz.itwill.service.ChatService;
import xyz.itwill.service.ProductService;



@Controller
@RequestMapping("/chatroom")
@RequiredArgsConstructor
public class ChatController  {
		private final ChatRoomsService chatRoomsService;
		//private final ProductService productService;
		//private final ChatService chatService;
		
	
		// 채팅 시작 버튼을 클릭하면 호출되는 메서드
		
	    @PostMapping("/start")
	    public String startChat(@RequestBody Map<String, Object> requestData, Model model) {
	    
	    	 try {
	    	        
	    	        

	    	        // 데이터 추출
	    	        String buyerId = requestData.get("buyerId").toString();
	    	        String sellerId = requestData.get("sellerId").toString();
	    	        //Integer roomId = requestData.containsKey("roomId") ? Integer.parseInt(requestData.get("roomId").toString()) : null;
	    	        Integer  roomId = chatRoomsService.findExistingRoom(buyerId, sellerId);
	    	        //Integer roomId = 100;
	    	        System.out.println("buyerId: " + buyerId);
	    	        System.out.println("sellerId: " + sellerId);
	    	        System.out.println("roomId: " + roomId);
	    	        if (roomId == null || roomId == 0) {
	    	            // ChatRooms 객체를 생성하고 buyerId, sellerId 설정
	    	            ChatRooms chatRoom = new ChatRooms();
	    	            chatRoom.setSellerId(sellerId);  // String으로 설정
	    	            chatRoom.setBuyerId(buyerId);  // String으로 설정
	    	            //roomId = chatRoomsService.createChatRooms(chatRoom);  // ChatRooms 객체를 사용하여 생성
	    	            roomId = chatRoomsService.createChatRooms(chatRoom);  // ChatRooms 객체를 사용하여 생성
	    	        }

	    	        // Model에 데이터 추가
	    	        model.addAttribute("buyerId", buyerId);
	    	        model.addAttribute("sellerId", sellerId);
	    	        model.addAttribute("roomId", roomId);
	    	        //return "redirect:/chatroom/room/" + roomId + "?buyerId=" + buyerId + "&sellerId=" + sellerId;
	    	       return "chat";  // JSP로 이동

	    	    } catch (NumberFormatException e) {
	    	        e.printStackTrace();
	    	        return "error";
	    	    }
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