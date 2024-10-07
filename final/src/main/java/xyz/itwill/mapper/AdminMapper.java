package xyz.itwill.mapper;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.Admin;

public interface AdminMapper {
	List<Admin> selectSpamBoardList(Map<String, Object> map);
	Admin selectSpamBoardByNum(int num);
	
	int selectSpamBoardCount(Map<String, Object> map);
}
