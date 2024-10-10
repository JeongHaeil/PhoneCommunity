package xyz.itwill.controller;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import xyz.itwill.dto.ChatMessages;

public class ChatWebSocketHandler extends TextWebSocketHandler {

    private Map<String, Map<String, WebSocketSession>> roomSessionMap = new ConcurrentHashMap<>();

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        
        
        // WebSocketSession에서 사용자 ID 가져오기 (session.getAttributes())
        String senderId = (String) session.getAttributes().get("userId");
        String sellerId = (String) session.getAttributes().get("sellerId");
        String buyerId = (String) session.getAttributes().get("buyerId");
        String roomId = (String) session.getAttributes().get("roomId");
        // 사용자 ID가 제대로 세션에 저장되었는지 확인
        if (senderId == null || sellerId == null || buyerId == null) {
            System.out.println("필수 사용자 정보가 누락되었습니다. senderId: " + senderId + ", sellerId: " + sellerId + ", buyerId: " + buyerId);
            return;
        }

        // 메시지 전송 후 로그 출력
        System.out.println("메시지 전송: roomId = " + roomId + ", senderId = " + senderId);

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
        

      

        // URL 쿼리 파라미터에서 buyerId와 sellerId를 추출
        String userId = extractQueryParam(session.getUri().toString(), "userId");
        String buyerId = extractQueryParam(session.getUri().toString(), "buyerId");
        String sellerId = extractQueryParam(session.getUri().toString(), "sellerId");
        String roomId = extractQueryParam(session.getUri().toString(), "roomId");  // roomId 추가
        // 필수 값 확인
        if (userId == null || buyerId == null || sellerId == null || roomId == null) {
            System.out.println("Buyer ID 또는 Seller ID가 누락되었습니다.");
            return;
        }

        // 세션에 사용자 정보 저장
        session.getAttributes().put("userId", userId);
        session.getAttributes().put("buyerId", buyerId);
        session.getAttributes().put("sellerId", sellerId);
        session.getAttributes().put("roomId", roomId);
        
        System.out.println("roomId: " + roomId + ", buyerId: " + buyerId + ", sellerId: " + sellerId);
        
        // 채팅방에 사용자 세션 추가
        roomSessionMap.computeIfAbsent(roomId, k -> new ConcurrentHashMap<>()).put(session.getId(), session);
    }
	/*
	 * @Override public void afterConnectionClosed(WebSocketSession session,
	 * CloseStatus status) throws Exception { String roomId =
	 * getRoomIdFromUrl(session);
	 * 
	 * // 채팅방에서 사용자 세션 제거 if (roomSessionMap.containsKey(roomId)) {
	 * roomSessionMap.get(roomId).remove(session.getId()); } }
	 */

    private void saveChatMessage(String roomId, String message, String senderId) {
        // DB에 메시지 저장 로직 구현
        ChatMessages chatMessage = new ChatMessages();
        chatMessage.setRoomId(Integer.parseInt(roomId));
        chatMessage.setMessage(message);
        chatMessage.setSenderId(Integer.parseInt(senderId));  // String으로 받은 senderId 설정
        // chatMessageService.insertChatMessage(chatMessage); // 서비스 호출
    }

	/*
	 * private String getRoomIdFromUrl(WebSocketSession session) { String uri =
	 * session.getUri().toString(); // URI를 문자열로 가져옴 return
	 * uri.substring(uri.lastIndexOf("/") + 1); // URL의 마지막 부분을 roomId로 추출 }
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
