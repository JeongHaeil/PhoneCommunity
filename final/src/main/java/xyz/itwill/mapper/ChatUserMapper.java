package xyz.itwill.mapper;

import java.util.Map;

import xyz.itwill.dto.User;

public interface ChatUserMapper {
	User getUserChatById(Map<String, Object> map );
}
