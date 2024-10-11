package xyz.itwill.controller;


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
import xyz.itwill.service.ChatService;
import xyz.itwill.service.ProductService;



@Controller
@RequestMapping("/chatroom")
@RequiredArgsConstructor
public class ChatController  {
		private final ChatRoomsService chatRoomsService;
		private final ProductService productService;
		private final ChatService chatService;
		
	
		// 채팅 시작 버튼을 클릭하면 호출되는 메서드
		
	    @PostMapping("/start")
	    public String startChat(@RequestBody Map<String, Object> requestData, Model model) {
	    	try {
	            // 요청 데이터 출력
	            System.out.println("Request Data: " + requestData);

	            // 데이터 추출
	            String buyerId = requestData.get("buyerId").toString();
	            String sellerId = requestData.get("sellerId").toString();
	            Integer roomId = requestData.containsKey("roomId") ? Integer.parseInt(requestData.get("roomId").toString()) : null;
	            
	            System.out.println("buyerId222: " + buyerId);
	            System.out.println("sellerId222아니한글인데?: " + sellerId);
	            System.out.println("roomId222: " + roomId);
	            
	            
	            
	            
	            // Model에 데이터 추가
	            model.addAttribute("buyerId", buyerId);
	            model.addAttribute("sellerId", sellerId);
	            model.addAttribute("roomId", roomId);
	            
	            return "chat/chat";  // JSP로 이동

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
		    	    
		    	    System.out.println("Loaded2323123 roomId: " + roomId); // 디버그 출력
		    	    System.out.println("Buyer 123213ID: " + buyerId);
		    	    System.out.println("Seller12312312 ID: " + sellerId);   
		       
		         return "chat/chat";  // 채팅방 JSP로 이동
		    }
		  
		    
	    
	    // 새로운 방 번호 생성
	    @PostMapping("/createRoom")
	    @ResponseBody
	    public int createRoom() {
	    	int newRoomId = chatRoomsService.generateNewRoomId();  // 서비스에서 새로운 방 번호 생성
	    	return newRoomId;  // 생성된 방 번호를 클라이언트로 반환
	    }
	  /*
		 // 새로운 방을 생성하거나 기존 방을 찾는 메서드
		    @PostMapping("/createRoom")
		    @ResponseBody
		    public int createRoom(@RequestParam("buyerId") String buyerId, 
		                          @RequestParam("sellerId") String sellerId, 
		                          @RequestParam("productId") int productId) {

		        // 기존 방이 있는지 확인
		        int existingRoomId = chatRoomsService.findExistingRoom(buyerId, sellerId, productId);

		        if (existingRoomId != 0) {
		            // 기존 방이 존재하면 해당 방 번호를 반환
		            return existingRoomId;
		        } else {
		            // 방이 없으면 새 방 생성
		            ChatRooms newChatRoom = new ChatRooms();
		            newChatRoom.setBuyerId(Integer.parseInt(buyerId));
		            newChatRoom.setSellerId(Integer.parseInt(sellerId));
		            newChatRoom.setProductId(String.valueOf(productId));  // int 값을 String으로 변환

		            
		            chatRoomsService.createChatRooms(newChatRoom);
		            
		            // 생성된 방의 ID 반환
		            return chatRoomsService.getLastInsertedRoomId();
		        }
		    }
		    */
	    

	    
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