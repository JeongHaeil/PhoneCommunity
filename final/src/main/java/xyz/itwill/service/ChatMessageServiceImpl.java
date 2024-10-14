package xyz.itwill.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.ChatMessageDAO;
import xyz.itwill.dto.ChatMessages;

@Service
@RequiredArgsConstructor
@Transactional
public class ChatMessageServiceImpl implements ChatMessageService{

	private final ChatMessageDAO chatMessageDAO;
	
	@Override
	public void insertChatMessage(ChatMessages chatMessages) {
		chatMessageDAO.insertChatMessage(chatMessages);
		
	}

	@Override
	public List<ChatMessages> getMessagesByRoomId(int roomId) {

		return chatMessageDAO.getMessagesByRoomId(roomId);
	}

	@Override
	public void saveChatMessage(ChatMessages messages) {
		chatMessageDAO.insertChatMessage(messages);
		
	}

}
