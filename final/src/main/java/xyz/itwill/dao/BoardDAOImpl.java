package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.BBallot;
import xyz.itwill.dto.Board;
import xyz.itwill.mapper.BoardMapper;

@Repository
@RequiredArgsConstructor
public class BoardDAOImpl implements BoardDAO{
	private final SqlSession sqlSession;
	
	@Override
	public int selectTotalBoard(Map<String, Object> map) {
		return sqlSession.getMapper(BoardMapper.class).selectTotalBoard(map);
	}

	@Override
	public List<Board> selectBoardList(Map<String, Object> map) {
		return sqlSession.getMapper(BoardMapper.class).selectBoardList(map);
	}

	@Override
	public String selectBoardCT(Map<String, Object> map) {
		return sqlSession.getMapper(BoardMapper.class).selectBoardCT(map);
	}
	
	@Override
	public Board selectBoard(Map<String, Object> map) {
		return sqlSession.getMapper(BoardMapper.class).selectBoard(map);
	}

	@Override
	public int insertBoard(Board board) {
		return sqlSession.getMapper(BoardMapper.class).insertBoard(board);
	}

	@Override
	public int deleteboard(int boardPostIdx) {
		return sqlSession.getMapper(BoardMapper.class).deleteboard(boardPostIdx);
	}

	@Override
	public int updateboard(Board board) {
		return sqlSession.getMapper(BoardMapper.class).updateboard(board);
	}

	@Override
	public int boardstarup(int boardPostIdx) {
		return sqlSession.getMapper(BoardMapper.class).boardstarup(boardPostIdx);
	}

	@Override
	public int boardstardown(int boardPostIdx) {
		return sqlSession.getMapper(BoardMapper.class).boardstardown(boardPostIdx);
	}

	@Override
	public int boardspam(int boardPostIdx) {
		return sqlSession.getMapper(BoardMapper.class).boardspam(boardPostIdx);
	}

	@Override
	public int BBinsert(BBallot bBallot) {
		return sqlSession.getMapper(BoardMapper.class).BBinsert(bBallot);
	}

	@Override
	public int BBupdate(BBallot bBallot) {
		return sqlSession.getMapper(BoardMapper.class).BBupdate(bBallot);
	}

	@Override
	public BBallot selectBBallotByIdx(Map<String, Object> map) {
		return sqlSession.getMapper(BoardMapper.class).selectBBallotByIdx(map);
	}

	@Override
	public int boardViewCountUp(int boardPostIdx) {
		return sqlSession.getMapper(BoardMapper.class).boardViewCountUp(boardPostIdx);
	}	
		
	/*마이페이지*/
	@Override
	public List<Board> selectBoardsByUserId(String userId) {
	    return sqlSession.getMapper(BoardMapper.class).selectBoardsByUserId(userId);
	}

	@Override
	public int updateBoardStatus3(int boardPostIdx) {
		return sqlSession.getMapper(BoardMapper.class).updateBoardStatus3(boardPostIdx);
	}

	@Override
	public Board getBoardRN(Map<String, Object> map) {
		return sqlSession.getMapper(BoardMapper.class).getBoardRN(map);
	}

	@Override
	public Board getRnUp(Map<String, Object> map) {
		return sqlSession.getMapper(BoardMapper.class).getRnUp(map);
	}

	@Override
	public Board getRnDown(Map<String, Object> map) {
		return sqlSession.getMapper(BoardMapper.class).getRnDown(map);
	}

	@Override
	public List<Board> selectNoticeList() {
		return sqlSession.getMapper(BoardMapper.class).selectNoticeList();
	}

	@Override
	public List<Board> selectPopularView() {
		return sqlSession.getMapper(BoardMapper.class).selectPopularView();
	}

	@Override
	public List<Board> selectPopularStar() {
		return sqlSession.getMapper(BoardMapper.class).selectPopularStar();
	}
}
