package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.CBallot;
import xyz.itwill.dto.Comments;

public interface CommentsDAO {
	int selectCommentsCounts(Map<String, Object> map);//
	List<Comments> selectCommentsList(Map<String, Object> map);//
	int insertComment(Comments comments);
	int updateCommentRestep(Comments comments);	
	int updateComment(Comments comments);
	int deleteComment(int commentIdx);
	int deleterrComment(int commentIdx);
	int selectCommentNextNum();
	Comments selectCommentByNum(int commentIdx);
	int selectCommentCountByRef(int commentRef);
	int commentUpStar(int commentIdx);
	int commentSpam(int commentIdx);
	int CBinsert(CBallot cBallot);
	int CBupdate(CBallot cBallot);
	CBallot selectCBallotByIdx(Map<String, Object> map);
}
