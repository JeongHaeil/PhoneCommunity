package xyz.itwill.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.AdminDAO;
import xyz.itwill.dto.Admin;
import xyz.itwill.util.Pager;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {
	
	private final AdminDAO adminDAO;

	//SpamBoard List 구현과 페이징 처리
	@Override
	public Map<String, Object> getSpamBoardList(Map<String, Object> map) {
		
		int pageNum = 1;
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum = Integer.parseInt((String)map.get("pageNum")); 
		}
		
		int pageSize=5;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		
		int totalBoard = adminDAO.selectSpamBoardCount(map);
		
		int blockSize = 10;
		
		Pager pager = new Pager(pageNum, pageSize, totalBoard, blockSize);
		
		map.put("startRow", pager.getStartPage());
		map.put("endRow", pager.getEndRow());
		List<Admin> spamBoardList = adminDAO.selectSpamBoardList(map);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("pager", pager);
		resultMap.put("SpamBoardList", spamBoardList);
		
		
		return resultMap;
	}

	//SpamBoard 에서 글 조회
	@Transactional
	@Override
	public Admin getSpamBoardByNum(int num) {
		
		Admin admin = adminDAO.selectSpamBoardByNum(num);
		
		if(admin == null) {
			throw new RuntimeException("게시글을 찾을 수 없습니다.");
		}
		
		
		return admin;
	}

}
