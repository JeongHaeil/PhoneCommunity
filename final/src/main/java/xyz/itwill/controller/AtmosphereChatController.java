package xyz.itwill.controller;

import javax.servlet.ServletContext;

import org.atmosphere.config.service.ManagedService;
import org.atmosphere.config.service.Message;
import org.atmosphere.cpr.AtmosphereResource;
import org.atmosphere.cpr.Broadcaster;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import xyz.itwill.dto.ChatMessages;
import xyz.itwill.service.ChatService;

@ManagedService(path ="/chat/websockets")
@Controller
public class AtmosphereChatController {
	
	/* private static final org.slf4j.Logger logger = LoggerFactory.getLogger(AtmosphereChatController.class);
	 private final ChatDAO chatDAO; // DAO를 사용해 DB 저장 처리

	    public AtmosphereChatController(ChatDAO chatDAO) {
	        this.chatDAO = chatDAO;
	    }
	
	    @Message
	    public void onMessage(AtmosphereResource resource, String message) {
	        // Get the broadcaster for this resource
	        Broadcaster broadcaster = resource.getBroadcaster();

	        // Log the received message
	        logger.info("Received message: " + message);
	        
	        // 메시지를 파싱하여 필요한 정보를 추출합니다.
	        // 메시지가 sender, roomId 등이 포함된 JSON 문자열이라고 가정합니다.
	        ChatMessages chatMessage = parseMessage(message);
	        
	        chatDAO.saveMessage(chatMessage);
	        
	        
	        
	        // Broadcast the message to all connected clients
	        broadcaster.broadcast(message);
	      */
	
	 private static final org.slf4j.Logger logger = LoggerFactory.getLogger(AtmosphereChatController.class);

	    @Autowired
	    private ChatService chatService;
	    	
	   
	    public void init() {
	        logger.info("AtmosphereChatController initialized, ChatService injected: " + (chatService != null));
	    }
	    
	    
	    
	    @Message
	    public void onMessage(AtmosphereResource resource, String message) {
	    	 if (chatService == null) {
	             logger.error("ChatService is null, unable to save message.");
	             return;
	         }
	    	
	    	
	        // Broadcaster 가져오기
	        Broadcaster broadcaster = resource.getBroadcaster();

	        // 메시지를 로그에 기록
	        logger.info("Received message: " + message);

	        // 메시지를 파싱하여 ChatMessageDTO로 변환
	        ChatMessages chatMessage = parseMessage(message);

	        // 데이터베이스에 메시지 저장
	        chatService.saveChatMessage(chatMessage);

	        // 연결된 모든 클라이언트에게 메시지 방송
	        broadcaster.broadcast(message, resource);
	    }

	    // JSON 메시지를 파싱하여 ChatMessageDTO로 변환하는 메서드
	    private ChatMessages parseMessage(String message) {
	        // JSON 파싱 로직을 추가하여 필요한 데이터를 추출합니다.
	        // 예: roomId, senderId, message
	    	ChatMessages chatMessage = new ChatMessages();
	        chatMessage.setRoomId(1); // 파싱한 값을 설정
	        chatMessage.setSenderId(1); // 파싱한 값을 설정
	        chatMessage.setMessage(message); // 메시지 설정
	        return chatMessage;
	    }

}
