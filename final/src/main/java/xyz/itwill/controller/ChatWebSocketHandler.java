package xyz.itwill.controller;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.ChatMessages;
import xyz.itwill.service.ChatMessageService;

@RequiredArgsConstructor
public class ChatWebSocketHandler extends TextWebSocketHandler {

    private Map<String, Map<String, WebSocketSession>> roomSessionMap = new ConcurrentHashMap<>();
    private final ChatMessageService chatMessageService;
    
    
    
    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        
        
       
    	 //String userId = (String) session.getAttributes().get("userId");
    	 String buyerId = (String) session.getAttributes().get("buyerId");
    	 String sellerId = (String) session.getAttributes().get("sellerId");
    	 String roomId = (String) session.getAttributes().get("roomId");
    	 String senderId = (String) session.getAttributes().get("userId");
    	if (buyerId == null || sellerId == null || roomId == null) {
            System.out.println("Buyer ID 또는 Seller ID가 누락되었습니다.");
            return;
        }

    	 //session.getAttributes().put("userId", userId);
         session.getAttributes().put("buyerId", buyerId);
         session.getAttributes().put("sellerId", sellerId);
         session.getAttributes().put("roomId", roomId);
        // 메시지 전송 후 로그 출력
        System.out.println("메시지 전송: roomId = " + roomId + ", sellerId = " + sellerId);
        System.out.println("Buyer ID: " + buyerId);
        System.out.println("Seller ID: " + sellerId);

        ChatMessages chatMessage = new ChatMessages();
        chatMessage.setRoomId(Integer.parseInt(roomId));
        try {
            // senderId가 숫자인지 확인하고 변환, 예외가 발생하면 저장 안함
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
            System.out.println("메시지 전송: roomId = " + roomId + ", sellerId = " + sellerId);
        }
    }


    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	System.out.println("WebSocket 연결이 성공적으로 수립되었습니다.");
        // URL 쿼리 파라미터에서 buyerId와 sellerId를 추출
    	//String userId = (String) session.getAttributes().get("userId");
    	//String userId = extractQueryParam(session.getUri().toString(), "userId");
        String buyerId = extractQueryParam(session.getUri().toString(), "buyerId");
        String sellerId = extractQueryParam(session.getUri().toString(), "sellerId");
        String roomId = extractQueryParam(session.getUri().toString(), "roomId");  // roomId 추가
        String senderId = extractQueryParam(session.getUri().toString(), "userId");
        // 필수 값 확인
        
        System.out.println("WebSocketSession URI: " + session.getUri().toString());
        System.out.println("Buyer ID: " + buyerId);
        System.out.println("Seller ID: " + sellerId);
        System.out.println("Room ID: " + roomId);
        System.out.println("userId ID: " + senderId);
        //System.out.println("User ID: " + userId);
        
        
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
        System.out.println("WebSocket 연결 시 URL: " + session.getUri().toString());

        //System.out.println("WebSocket 연결된 userId: " + userId);
        System.out.println("roomId: " + roomId + ", buyerId: " + buyerId + ", sellerId: " + sellerId + ", senderId: " + senderId);
        
        // 채팅방에 사용자 세션 추가
        roomSessionMap.computeIfAbsent(roomId, k -> new ConcurrentHashMap<>()).put(session.getId(), session);
    }
	/*
    private void saveChatMessage(String roomId, String message, String senderId) {
        ChatMessages chatMessage = new ChatMessages();
        chatMessage.setRoomId(Integer.parseInt(roomId));
        try {
            // senderId가 숫자인지 확인하고 변환, 예외가 발생하면 로그 출력
            chatMessage.setSenderId(Integer.parseInt(senderId));  
        } catch (NumberFormatException e) {
            System.out.println("Error converting senderId: " + senderId);
            // 예외가 발생한 경우 DB에 저장하지 않거나, 기본값을 설정할 수 있습니다.
            return;  // 또는 기본값 설정: chatMessage.setSenderId(0);
        }
        chatMessage.setMessage(message);
        chatMessageService.saveChatMessage(chatMessage);  // DB에 저장
    }
	*/
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
    
  

}
