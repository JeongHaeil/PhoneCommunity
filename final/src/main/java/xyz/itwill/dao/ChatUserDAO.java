package xyz.itwill.dao;

import java.util.Map;

import xyz.itwill.dto.User;

public interface ChatUserDAO {
	
	User getUserChatById(Map<String, Object> map );
}
