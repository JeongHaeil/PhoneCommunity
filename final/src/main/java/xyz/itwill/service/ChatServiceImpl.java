package xyz.itwill.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.ChatDAO;
import xyz.itwill.dto.Chat;

@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService{

	private final ChatDAO chatDAO;
	
	@Override
	public void insertChat(Chat chat) {
		chatDAO.insertChat(chat);
		
	}

	@Override
	public List<Chat> getChatByProductId(int productId) {
		 try {
		       
			 return chatDAO.getChatByProductId(productId);
			 
		    } catch (Exception e) {
		        // 로깅 또는 예외 처리
		        throw new RuntimeException("채팅 목록을 불러오는 중 오류 발생", e);
		    }
		
	}

}
