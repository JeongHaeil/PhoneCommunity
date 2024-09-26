package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

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
}
