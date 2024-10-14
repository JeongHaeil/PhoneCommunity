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
	public Map<String, Object> getSpamBoardList(int pageNum, int pageSize, int totalSize, int blockSize, String search,
			String keyword) {		
		
		// 검색 조건 설정
	    Map<String, Object> searchMap = new HashMap<>();
	    searchMap.put("search", search);
	    searchMap.put("keyword", keyword);

	    // 전체 게시글 수 계산 (검색 조건을 포함하여)
	    totalSize = adminDAO.selectSpamBoardCount(searchMap);

	    // 페이저 객체 생성 (totalSize를 갱신한 후에 생성)
	    Pager pager = new Pager(pageNum, pageSize, totalSize, blockSize);

	    // 검색 조건과 페이징 정보를 사용하여 게시글 목록 조회
	    searchMap.put("startRow", pager.getStartRow());
	    searchMap.put("endRow", pager.getEndRow());
	    
	    List<Admin> spamBoardList = adminDAO.selectSpamBoardList(searchMap);

	    // 결과를 저장할 맵 생성
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("pager", pager);
	    resultMap.put("spamBoardList", spamBoardList);

	    return resultMap;
	}
	
	//SpamBoard 에서 글 조회
	@Override
	public Admin getSpamBoardByNum(int num) {
		
		Admin admin = adminDAO.selectSpamBoardByNum(num);
		
		if(admin == null) {
			throw new RuntimeException("게시글을 찾을 수 없습니다.");
		}
		
		
		return admin;
	}
	
	@Override
	public Map<String, Object> gettotalUserBoardList(int pageNum, int pageSize, int totalSize, int blockSize,
			String search, String keyword) {
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("search", search);
		searchMap.put("keyword", keyword);
		
		totalSize = adminDAO.selecttotalUserBoardListCount(searchMap);
		
		Pager pager = new Pager(pageNum, pageSize, totalSize, blockSize);
		
		searchMap.put("startRow", pager.getStartRow());
		searchMap.put("endRow", pager.getEndRow());	
		
		List<Admin> totalUserBoardList = adminDAO.selecttotalUserBoardList(searchMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("pager", pager);
		resultMap.put("totalUserBoardList", totalUserBoardList);
		 
		return resultMap;
		
		
		
	}
	
	@Override
	public void updateUserStatusByUserId(int userNum, int status) {
		Map<String, Object> params  = new HashMap<String, Object>();
		params.put("userNum", userNum);
		params.put("status", status);
		
		adminDAO.updateUserStatusByUserId(params);
	}
	
	@Override
	public void updateBoardStatusByBoardPostIdx(int boardPostIdx, int status) {
		Map<String, Object> params  = new HashMap<String, Object>();
		params.put("boardPostIdx", boardPostIdx);
		params.put("status", status);
		
		adminDAO.updateBoardStatusByBoardId(params);
		
	}


	







	




}
