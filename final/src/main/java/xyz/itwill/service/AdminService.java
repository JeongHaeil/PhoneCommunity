package xyz.itwill.service;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.Map;

import xyz.itwill.dto.Admin;

public interface AdminService {
	Map<String, Object> getSpamBoardList(int pageNum, int pageSize, int totalSize, int blockSize, String search, String keyword);
	Map<String, Object> gettotalUserBoardList(int pageNum, int pageSize, int totalSize, int blockSize, String search, String keyword);
	
	Admin getSpamBoardByNum(int num);
	void updateUserStatusByUserNum(int userNum, int status, Date expiryDate);
	void updateBoardStatusByBoardPostIdx(int boardPostIdx, int status, Date expiryDate);
	
	void resetExpiredStatuses();
	void changeBoardExpiredStatuses();
	
}
