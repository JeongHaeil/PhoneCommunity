package xyz.itwill.controller;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import javax.servlet.http.HttpSession;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;
import xyz.itwill.dto.ChatMessages;

public class ChatWebSocketHandler extends TextWebSocketHandler {

    private Map<String, Map<String, WebSocketSession>> roomSessionMap = new ConcurrentHashMap<>();

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String roomId = getRoomIdFromUrl(session);

        // WebSocketSession에서 사용자 ID 가져오기 (session.getAttributes())
        String senderId = (String) session.getAttributes().get("userId");

        // 메시지를 받은 후 DB에 저장 (DB 처리 로직 추가)
        saveChatMessage(roomId, message.getPayload(), senderId);

        // 채팅방에 있는 사용자들에게 메시지 전달
        if (roomSessionMap.containsKey(roomId)) {
            for (WebSocketSession s : roomSessionMap.get(roomId).values()) {
                s.sendMessage(new TextMessage(message.getPayload()));
            }
        }
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    
        String roomId = getRoomIdFromUrl(session);

        // HTTP 세션에서 사용자 정보를 WebSocketSession에 저장
        Map<String, Object> attributes = session.getAttributes();
        HttpSession httpSession = (HttpSession) session.getAttributes().get("HTTP.SESSION");
        //String userId = (String) httpSession.getAttribute("userId");
        String userId = (String) session.getAttributes().get("userId");
        // WebSocketSession에 사용자 정보 저장
        session.getAttributes().put("userId", userId);
        System.out.println("roomId: " + roomId); // 콘솔에서 roomId 값을 확인
        // 채팅방에 사용자 세션 추가
       
        Integer buyerId = (Integer) httpSession.getAttribute("buyerId");
        Integer sellerId = (Integer) httpSession.getAttribute("sellerId");
        session.getAttributes().put("buyerId", buyerId);
        session.getAttributes().put("sellerId", sellerId);
        System.out.println("roomId: " + roomId);
        System.out.println("buyerId: " + buyerId);
        System.out.println("sellerId: " + sellerId);
        
        roomSessionMap.computeIfAbsent(roomId, k -> new ConcurrentHashMap<>()).put(session.getId(), session);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String roomId = getRoomIdFromUrl(session);

        // 채팅방에서 사용자 세션 제거
        if (roomSessionMap.containsKey(roomId)) {
            roomSessionMap.get(roomId).remove(session.getId());
        }
    }

    private void saveChatMessage(String roomId, String message, String senderId) {
        // DB에 메시지 저장 로직 구현
        ChatMessages chatMessage = new ChatMessages();
        chatMessage.setRoomId(Integer.parseInt(roomId));
        chatMessage.setMessage(message);
        chatMessage.setSenderId(Integer.parseInt(senderId));  // String으로 받은 senderId 설정
        // chatMessageService.insertChatMessage(chatMessage); // 서비스 호출
    }

    private String getRoomIdFromUrl(WebSocketSession session) {
        String uri = session.getUri().toString();  // URI를 문자열로 가져옴
        return uri.substring(uri.lastIndexOf("/") + 1);  // URL의 마지막 부분을 roomId로 추출
    }
}
