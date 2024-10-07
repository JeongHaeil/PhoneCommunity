package xyz.itwill.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Chat;
import xyz.itwill.dto.ChatMessages;
import xyz.itwill.dto.ChatRooms;
import xyz.itwill.service.ChatMessageService;
import xyz.itwill.service.ChatRoomsService;
import xyz.itwill.service.ChatService;

@Controller
@RequiredArgsConstructor
	@RequestMapping("/chat")
	public class ChatController {

    private final ChatService chatService;
    private final ChatMessageService chatMessageService;
    private final ChatRoomsService chatRoomsService;

    @PostMapping("/send")
    public String sendChat(@ModelAttribute Chat chat) {
        chatService.insertChat(chat);
        // productId뿐만 아니라 buyerId와 sellerId도 전달하는 것이 필요할 수 있음
        return "redirect:/chat/chatroom/view?sellerId=" + chat.getSellerId() + "&buyerId=" + chat.getBuyerId();
    }
    /*
    // 새로운 sendMessage 메서드 - 메시지 전송 및 저장 처리
    @PostMapping("/sendMessage")
    @ResponseBody
    public Map<String, Object> sendMessage(@RequestParam int roomId, @RequestParam int senderId, @RequestParam String message) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 메시지 저장을 위한 ChatMessage 객체 생성
            ChatMessages chatMessage = new ChatMessages();
            chatMessage.setRoomId(roomId);
            chatMessage.setSenderId(senderId);
            chatMessage.setMessage(message);

            // 서비스 계층을 통해 메시지 저장
            chatMessageService.insertChatMessage(chatMessage);

            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("error", e.getMessage());
        }

        return result;
    }
    */
    @GetMapping("/view")
    public String viewChat(@RequestParam int productId, Model model) {
        List<Chat> chatList = chatService.getChatByProductId(productId);
        model.addAttribute("chatList", chatList);
        return "chat/chatroom"; // JSP 경로와 일치
    }

    @PostMapping("/chatroom/create")
    @ResponseBody
    public Map<String, Object> createChatRoom(@RequestParam int sellerId, @RequestParam int buyerId, @RequestParam int productId) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        
        params.put("sellerId", sellerId);
        params.put("buyerId", buyerId);
        params.put("productId", productId);

        try {
            // 기존 채팅방 확인
            ChatRooms existingChatRoom = chatRoomsService.getChatRooms(params);
            if (existingChatRoom != null) {
                result.put("roomId", existingChatRoom.getRoomId());
            } else {
                // 새 채팅방 생성
                ChatRooms newChatRoom = new ChatRooms();
                newChatRoom.setSellerId(sellerId);
                newChatRoom.setBuyerId(buyerId);
                newChatRoom.setProductId(productId);
                chatRoomsService.createChatRooms(newChatRoom);

                // 새로 생성된 채팅방의 roomId를 DB에서 다시 가져오기
                int generatedRoomId = chatRoomsService.getLastInsertedRoomId();
                if (generatedRoomId > 0) {
                    result.put("roomId", generatedRoomId);
                } else {
                    result.put("error", "Failed to retrieve roomId.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("error", e.getMessage());
        }

        return result;
    }

    
    
    @GetMapping("/chatroom/view")
    public String viewChatRoom(@RequestParam int sellerId, @RequestParam int buyerId,@RequestParam int productId, Model model) {
    	  Map<String, Object> map = new HashMap<>();
    	  map.put("sellerId", sellerId);
    	  map.put("buyerId", buyerId);
    	  map.put("productId", productId);
    	  
    	  
    	    ChatRooms chatRoom = chatRoomsService.getChatRooms(map);
    	    model.addAttribute("chatRooms", chatRoom);
    	    return "chat/chatroom"; // JSP 경로와 일치
    }
}
