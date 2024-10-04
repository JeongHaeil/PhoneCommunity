package xyz.itwill.controller;

import org.atmosphere.config.service.ManagedService;
import org.atmosphere.config.service.Message;
import org.atmosphere.cpr.AtmosphereResource;
import org.atmosphere.cpr.Broadcaster;

@ManagedService(path =  "/chat/websocket")
public class AtmosphereChatController {
	
	@Message
	public void onMessage(AtmosphereResource resource, String message) {
        Broadcaster broadcaster = resource.getBroadcaster(); // Broadcaster를 통해 메시지를 전송
        broadcaster.broadcast(message); // 모든 클라이언트에게 메시지를 브로드캐스트
    }
}
