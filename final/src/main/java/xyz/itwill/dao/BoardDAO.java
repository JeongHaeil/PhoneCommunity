package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.BBallot;
import xyz.itwill.dto.Board;

public interface BoardDAO {
	String selectBoardCT(Map<String, Object> map);
	Board selectBoard(Map<String, Object> map);
	int selectTotalBoard(Map<String, Object> map);
	List<Board> selectBoardList(Map<String, Object> map);
	int insertBoard(Board board);
	int deleteboard(int boardPostIdx);
	int updateboard(Board board);
	int boardstarup(int boardPostIdx);
	int boardstardown(int boardPostIdx);
	int boardspam(int boardPostIdx);
	int BBinsert(BBallot bBallot);
	int BBupdate(BBallot bBallot);
	BBallot selectBBallotByIdx(Map<String, Object> map);
	int boardViewCountUp(int boardPostIdx);
	/* 마이페이지 작성글 보기*/
	List<Board> selectBoardsByUserId(String userId);
	int updateBoardStatus3(int boardPostIdx);
	Board getBoardRN(Map<String, Object> map);
	Board getRnUp(Map<String, Object> map);
	Board getRnDown(Map<String, Object> map);
	List<Board> selectNoticeList();
	List<Board> selectPopularView();
	List<Board> selectPopularStar();
}
