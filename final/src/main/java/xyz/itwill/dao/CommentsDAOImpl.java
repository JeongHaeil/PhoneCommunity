package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.CBallot;
import xyz.itwill.dto.Comments;
import xyz.itwill.mapper.CommentsMapper;

@Repository
@RequiredArgsConstructor
public class CommentsDAOImpl implements CommentsDAO{
	private final SqlSession sqlSession;

	@Override
	public List<Comments> selectCommentsList(Map<String, Object> map) {
		return sqlSession.getMapper(CommentsMapper.class).selectCommentsList(map);
	}

	@Override
	public int selectCommentsCounts(Map<String, Object> map) {		
		return sqlSession.getMapper(CommentsMapper.class).selectCommentsCounts(map);
	}

	@Override
	public int selectCommentNextNum() {
		return sqlSession.getMapper(CommentsMapper.class).selectCommentNextNum();
	}

	@Override
	public int insertComment(Comments comments) {
		return sqlSession.getMapper(CommentsMapper.class).insertComment(comments);
	}

	@Override
	public int updateCommentRestep(Comments comments) {
		return sqlSession.getMapper(CommentsMapper.class).updateCommentRestep(comments);
	}

	@Override
	public int updateComment(Comments comments) {
		return sqlSession.getMapper(CommentsMapper.class).updateComment(comments);
	}

	@Override
	public int deleteComment(int commentIdx) {
		return sqlSession.getMapper(CommentsMapper.class).deleteComment(commentIdx);
	}

	@Override
	public Comments selectCommentByNum(int commentIdx) {
		return sqlSession.getMapper(CommentsMapper.class).selectCommentByNum(commentIdx);
	}

	@Override
	public int selectCommentCountByRef(int commentRef) {
		return sqlSession.getMapper(CommentsMapper.class).selectCommentCountByRef(commentRef);
	}

	@Override
	public int deleterrComment(int commentIdx) {
		return sqlSession.getMapper(CommentsMapper.class).deleterrComment(commentIdx);
	}

	@Override
	public int commentUpStar(int commentIdx) {
		return sqlSession.getMapper(CommentsMapper.class).commentUpStar(commentIdx);
	}

	@Override
	public int commentSpam(int commentIdx) {
		return sqlSession.getMapper(CommentsMapper.class).commentSpam(commentIdx);
	}

	@Override
	public int CBinsert(CBallot cBallot) {
		return sqlSession.getMapper(CommentsMapper.class).CBinsert(cBallot);
	}

	@Override
	public int CBupdate(CBallot cBallot) {
		return sqlSession.getMapper(CommentsMapper.class).CBupdate(cBallot);
	}

	@Override
	public CBallot selectCBallotByIdx(Map<String, Object> map) {
		return sqlSession.getMapper(CommentsMapper.class).selectCBallotByIdx(map);
	}

	

	
}
