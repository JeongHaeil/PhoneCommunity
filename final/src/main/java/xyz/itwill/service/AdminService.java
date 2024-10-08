package xyz.itwill.service;

import java.util.Map;

import xyz.itwill.dto.Admin;

public interface AdminService {
	Map<String, Object> getSpamBoardList(int pageNum, int pageSize, int totalSize, int blockSize, String search, String keyword);
	Admin getSpamBoardByNum(int num);
}
