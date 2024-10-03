package xyz.itwill.service;

import java.util.Map;

import xyz.itwill.dto.BBallot;
import xyz.itwill.dto.Board;

public interface BoardService {
	Board getboard(int boardPostIdx);
	String getBoardCT(int boardCode);
	Map<String, Object> getBoardList(int boardCode, int pageNum,int pagaSize,String search, String keyword) throws Exception;
	void addFreeboard(Board board);
	void deleteFreeboard(int boardPostIdx);
	void updateFreeboard(Board board);
	void boardStarUp(int boardPostIdx);
	void boardStarDown(int boardPostIdx);
	void boardSpam(int boardPostIdx);
	void BBinsert(BBallot bBallot);
	void BBupdate(BBallot bBallot);
	BBallot selectBBallotByIdx(Map<String, Object> map);
	void boardViewCountUp(int boardPostIdx);
}
