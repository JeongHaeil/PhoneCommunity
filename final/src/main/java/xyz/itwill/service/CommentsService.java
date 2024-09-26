package xyz.itwill.service;

import java.util.Map;

import xyz.itwill.dto.Comments;

public interface CommentsService {
	Map<String, Object> getCommentsList(int commentBoardIdx, int pageNum,int pagaSize);
	int getCommentsCount(int boardPostIdx);
	int deleteComment(int commentIdx);
	void deleterrComment(int commentIdx);
	int insertComment(Comments comments);
	Comments getCommentByNum(int commentIdx);
	void updateCommentRef(Comments comments);
	int getCommentNextNum();
	int gerCommentCountByRef(int commentRef);
	void updateCommentStar(int commentIdx);
	void updatrCommentSpam(int commentIdx);
}
