package xyz.itwill.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.ChatMessages;
import xyz.itwill.service.ChatMessageService;

@RequiredArgsConstructor
@Component
public class ChatWebSocketHandler extends TextWebSocketHandler {

    private Map<String, Map<String, WebSocketSession>> roomSessionMap = new ConcurrentHashMap<>();
    private final ChatMessageService chatMessageService;
    private Map<String, WebSocketSession> sellerSessions = new ConcurrentHashMap<>();
    
    
    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        
        
       
    	 
    	 String buyerId = (String) session.getAttributes().get("buyerId");
    	 String sellerId = (String) session.getAttributes().get("sellerId");
    	 String roomId = (String) session.getAttributes().get("roomId");
    	 String senderId = (String) session.getAttributes().get("userId");
    	if (buyerId == null || sellerId == null || roomId == null) {
         
            return;
        }

    	 
         session.getAttributes().put("buyerId", buyerId);
         session.getAttributes().put("sellerId", sellerId);
         session.getAttributes().put("roomId", roomId);
        
        
        
        String payload = message.getPayload();
        Map<String, Object> messageData = new HashMap<>();
        messageData.put("message", payload);
        messageData.put("senderId", senderId);
        
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonMessage = objectMapper.writeValueAsString(messageData);

        ChatMessages chatMessage = new ChatMessages();
        chatMessage.setRoomId(Integer.parseInt(roomId));
        try {
           
            chatMessage.setSenderId(senderId); 
        } catch (NumberFormatException e) {
            System.out.println("Error converting senderId: " + senderId);
            return;  // 저장 중단
        }
        chatMessage.setMessage(message.getPayload());
        chatMessageService.saveChatMessage(chatMessage); 
        
  

        // 채팅방에 있는 사용자들에게 메시지 전달
        if (roomSessionMap.containsKey(roomId)) {
            for (WebSocketSession s : roomSessionMap.get(roomId).values()) {
                s.sendMessage(new TextMessage(message.getPayload()));
            }
            
        }
    }


    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	
       
        String buyerId = extractQueryParam(session.getUri().toString(), "buyerId");
        String sellerId = extractQueryParam(session.getUri().toString(), "sellerId");
        String roomId = extractQueryParam(session.getUri().toString(), "roomId");  // roomId 추가
        String senderId = extractQueryParam(session.getUri().toString(), "userId");
        // 필수 값 확인
        
     
        
        
        if (buyerId == null || sellerId == null || roomId == null || senderId == null) {
            System.out.println("Buyer ID, Seller ID 또는 Sender ID가 누락되었습니다.");
            return;
        }

        // 세션에 사용자 정보 저장
       // session.getAttributes().put("userId", userId);
        session.getAttributes().put("buyerId", buyerId);
        session.getAttributes().put("sellerId", sellerId);
        session.getAttributes().put("roomId", roomId);
        session.getAttributes().put("userId", senderId);
        
        // 판매자 세션 저장
        if (buyerId.equals(senderId)) {
            // 구매자의 WebSocket 세션
            roomSessionMap.computeIfAbsent(roomId, k -> new ConcurrentHashMap<>()).put(session.getId(), session);
        } else if (sellerId.equals(senderId)) {
            // 판매자의 WebSocket 세션
            sellerSessions.put(sellerId, session);
        }

 
    }
	
    private String extractQueryParam(String uri, String paramName) {
          String[] queryParams = uri.split("\\?");
        if (queryParams.length > 1) {
            String[] params = queryParams[1].split("&");
            for (String param : params) {
                String[] pair = param.split("=");
                if (pair.length > 1 && pair[0].equals(paramName)) {
                    return pair[1];
                }
            }
        }
        return null;
    }
    
    public void notifySeller(String sellerId, String roomId) throws Exception {
        WebSocketSession sellerSession = sellerSessions.get(sellerId);
        if (sellerSession != null && sellerSession.isOpen()) {
            sellerSession.sendMessage(new TextMessage("New Chat Room: " + roomId));
        }
    }

  

}