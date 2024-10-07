package xyz.itwill.service;

import java.util.Map;

import xyz.itwill.dto.Admin;

public interface AdminService {
	Map<String, Object> getSpamBoardList(Map<String, Object> map);
	Admin getSpamBoardByNum(int num);
}
