package xyz.itwill.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.ChatUserDAO;
import xyz.itwill.dto.User;

@Service
@RequiredArgsConstructor
public class ChatUserSerivceImpl implements ChatUserSerivce{
	
	private final ChatUserDAO chatUserDAO;
	
	@Override
	public User getUserChatById(Map<String, Object> map) {
		
		return chatUserDAO.getUserChatById(map);
	}

}
