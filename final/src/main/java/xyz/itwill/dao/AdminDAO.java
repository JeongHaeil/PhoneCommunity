package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.Admin;

public interface AdminDAO {
	
	List<Admin> selectSpamBoardList(Map<String, Object> map);
	List<Admin> selecttotalUserBoardList(Map<String, Object> map);
	Admin selectSpamBoardByNum(int num);
	void updateUserStatusByUserId(Map<String, Object> map);
	void updateBoardStatusByBoardId(Map<String, Object> map);
	int selectSpamBoardCount(Map<String, Object> map);
	int selecttotalUserBoardListCount(Map<String, Object> map);
	
}
