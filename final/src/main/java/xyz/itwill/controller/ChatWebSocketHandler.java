package xyz.itwill.controller;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatWebSocketHandler extends TextWebSocketHandler {
	// 모든 세션을 저장할 리스트
    private List<WebSocketSession> sessions = new ArrayList<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // 연결이 완료되었을 때 세션을 추가
        sessions.add(session);
    }

    
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        System.out.println("Received message: " + payload);

        // 받은 메시지를 연결된 모든 클라이언트에게 브로드캐스팅
        for (WebSocketSession s : sessions) {
            s.sendMessage(new TextMessage("Message from server: " + payload));
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, org.springframework.web.socket.CloseStatus status) throws Exception {
        // 연결이 종료되었을 때 세션을 제거
        sessions.remove(session);
    }
}
