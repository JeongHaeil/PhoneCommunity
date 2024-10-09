package xyz.itwill.service;

import java.util.List;
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
	// 사용자가 작성한 게시글 목록을 가져오는 메서드
    List<Board> getBoardsByUserId(String userId);
    void BoardUpdateStatus3(int boardPostIdx);
    Board getBoardRNumber(Map<String, Object> map);
    Board getRnUp(Map<String, Object> map);
    Board getRnDown(Map<String, Object> map);
    List<Board> getNoiceBoardList();
    List<Board> getPopularBoardByViewCount();
    List<Board> getPopularBoardByStartUp();
}
