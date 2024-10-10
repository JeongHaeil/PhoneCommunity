package xyz.itwill.mapper;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.Admin;

public interface AdminMapper {
	List<Admin> selectSpamBoardList(Map<String, Object> map);
	Admin selectSpamBoardByNum(int num);
	Admin updateUserStatusByUserId(Map<String, Object> map);
	Admin updateBoardStatusByBoardPostIdx(Map<String, Object> map);
	
	int selectSpamBoardCount(Map<String, Object> map);
}
