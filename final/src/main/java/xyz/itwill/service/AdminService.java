package xyz.itwill.service;

import java.util.Map;

import xyz.itwill.dto.Admin;

public interface AdminService {
	Map<String, Object> getSpamBoardList(int pageNum, int pageSize, int totalSize, int blockSize, String search, String keyword);
	Map<String, Object> gettotalUserBoardList(int pageNum, int pageSize, int totalSize, int blockSize, String search, String keyword);
	
	Admin getSpamBoardByNum(int num);
	void updateUserStatusByUserId(int userNum, int status);
	void updateBoardStatusByBoardPostIdx(int boardPostIdx, int status);
	
}
