package xyz.itwill.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.BoardDAO;
import xyz.itwill.dto.BBallot;
import xyz.itwill.dto.Board;
import xyz.itwill.util.Pager;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	private final BoardDAO boardDAO;
	
	@Override 
	public Map<String, Object> getBoardList(int boardCode, int pageNum, int pagaSize, String search, String keyword) throws Exception {
		Map<String, Object> searchMap=new HashMap<String, Object>();
		searchMap.put("boardCode", boardCode);
		searchMap.put("search", search);
		searchMap.put("keyword", keyword);
		int totalSize=boardDAO.selectTotalBoard(searchMap);
		
		int blockSize=5;
		Pager pager=new Pager(pageNum, pagaSize, totalSize, blockSize);
		Map<String, Object> pageMap=new HashMap<String, Object>();
		pageMap.put("boardCode", boardCode);
		pageMap.put("startRow", pager.getStartRow());
		pageMap.put("endRow", pager.getEndRow());		
		List<Board> boardLists=boardDAO.selectBoardList(pageMap);
		List<Board> boardList=new ArrayList<Board>();
		if(boardLists!=null) {
			Date nowDate=new Date();
			SimpleDateFormat hourType=new SimpleDateFormat("HH:mm");
			SimpleDateFormat monthType=new SimpleDateFormat("MM-dd");			
			for(Board board : boardLists) {
				SimpleDateFormat getTime=new SimpleDateFormat("yyyy-MM-dd HH:mm");
				Date transGetTime=getTime.parse(board.getBoardResigsterDate());
				long minusMillis=nowDate.getTime()-transGetTime.getTime();
				long transMtoH=TimeUnit.MILLISECONDS.toHours(minusMillis);
				String insertDate;
				if (transMtoH < 24) {
					insertDate = hourType.format(transGetTime); // HH:mm 형식
		        } else {
		        	insertDate = monthType.format(transGetTime); // MM.dd 형식
		        }
				board.setBoardResigsterDate(insertDate);
				boardList.add(board);
			}	
		}
		Map<String, Object> boardCodeSource=new HashMap<String, Object>();
		boardCodeSource.put("boardCode", boardCode);
		String codeName=boardDAO.selectBoardCT(boardCodeSource);
		
		Map<String, Object> resultMap=new HashMap<String, Object>();		
		resultMap.put("boardTitle", codeName);
		resultMap.put("boardCode", boardCode);
		resultMap.put("pager", pager);
		resultMap.put("boardList", boardList);
	
		return resultMap;
	}

	@Override
	public String getBoardCT(int boardCode) {
		Map<String, Object> resultMap=new HashMap<String, Object>();		
		resultMap.put("boardCode", boardCode);
		return boardDAO.selectBoardCT(resultMap);
	}

	@Override
	public Board getboard(int boardPostIdx) {
		Map<String, Object> resultMap=new HashMap<String, Object>();		
		resultMap.put("boardPostIdx", boardPostIdx);
		return boardDAO.selectBoard(resultMap);
	}

	@Override
	public void addFreeboard(Board board) {
		boardDAO.insertBoard(board);		
	}


	@Override
	public void deleteFreeboard(int boardPostIdx) {
		boardDAO.deleteboard(boardPostIdx);
	}

	@Override
	public void updateFreeboard(Board board) {
		boardDAO.updateboard(board);
	}

	@Override
	public void boardStarUp(int boardPostIdx) {
		boardDAO.boardstarup(boardPostIdx);
	}

	@Override
	public void boardStarDown(int boardPostIdx) {
		boardDAO.boardstardown(boardPostIdx);
	}

	@Override
	public void boardSpam(int boardPostIdx) {
		boardDAO.boardspam(boardPostIdx);
	}

	@Override
	public void BBinsert(BBallot bBallot) {
		boardDAO.BBinsert(bBallot);		
	}

	@Override
	public void BBupdate(BBallot bBallot) {
		boardDAO.BBupdate(bBallot);
	}

	@Override
	public BBallot selectBBallotByIdx(Map<String, Object> map) {
		return boardDAO.selectBBallotByIdx(map);
	}

	@Override
	public void boardViewCountUp(int boardPostIdx) {
		boardDAO.boardViewCountUp(boardPostIdx);
	}
	/* 마이페이지 */
	@Override
	public List<Board> getBoardsByUserId(String userId) {
	    return boardDAO.selectBoardsByUserId(userId);
	}
	
	
}
