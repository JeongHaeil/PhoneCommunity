package xyz.itwill.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;



import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.CommentsDAO;
import xyz.itwill.dto.CBallot;
import xyz.itwill.dto.Comments;
import xyz.itwill.util.Pager;

@Service
@RequiredArgsConstructor
public class CommentsServiceImpl implements CommentsService{
	private final CommentsDAO commentsDAO;

	@Override
	public Map<String, Object> getCommentsList(int commentBoardIdx, int pageNum, int pagaSize) {
		Map<String, Object> getNumberMap=new HashMap<String, Object>();
		getNumberMap.put("commentBoardIdx", commentBoardIdx);
		int totalSize=commentsDAO.selectCommentsCounts(getNumberMap);
		
		int blockSize=5;
		Pager pager=new Pager(pageNum, pagaSize, totalSize, blockSize);
		Map<String, Object> pageMap=new HashMap<String, Object>();
		pageMap.put("startRow", pager.getStartRow());
		pageMap.put("endRow", pager.getEndRow());
		pageMap.put("commentBoardIdx", commentBoardIdx);
		List<Comments> commentsList=commentsDAO.selectCommentsList(pageMap);
		
		Map<String, Object> resultMap=new HashMap<String, Object>();
		resultMap.put("pager", pager);
		resultMap.put("commentsList", commentsList);	
		return resultMap;
	}
	/*
	@Override
	public List<Comments> getCommentsList(int freePostIdx) {
		Map<String, Object> getNumberMap=new HashMap<String, Object>();
		getNumberMap.put("commentBoardIdx", freePostIdx);
		return commentsDAO.selectCommentsList(getNumberMap);
	}*/

	@Override
	public int getCommentsCount(int boardPostIdx) {
		Map<String, Object> getNumberMap=new HashMap<String, Object>();
		getNumberMap.put("commentBoardIdx", boardPostIdx);
		return commentsDAO.selectCommentsCounts(getNumberMap);
	}

	@Override
	public int deleteComment(int commentIdx) {		
		return commentsDAO.deleteComment(commentIdx);
	}

	@Override
	public int insertComment(Comments comments) {		
		return commentsDAO.insertComment(comments);
	}

	@Override
	public Comments getCommentByNum(int commentIdx) {
		return commentsDAO.selectCommentByNum(commentIdx);
	}

	@Override
	public int getCommentNextNum() {
		return commentsDAO.selectCommentNextNum();
	}

	@Override
	public void updateCommentRef(Comments comments) {
		commentsDAO.updateCommentRestep(comments);
		
	}

	@Override
	public int gerCommentCountByRef(int commentRef) {
		return commentsDAO.selectCommentCountByRef(commentRef);
	}

	@Override
	public void deleterrComment(int commentIdx) {
		commentsDAO.deleterrComment(commentIdx);		
	}

	@Override
	public void updateCommentStar(int commentIdx) {
		commentsDAO.commentUpStar(commentIdx);		
	}

	@Override
	public void updatrCommentSpam(int commentIdx) {
		commentsDAO.commentSpam(commentIdx);	
	}

	@Override
	public void CBinsert(CBallot cBallot) {
		commentsDAO.CBinsert(cBallot);
	}

	@Override
	public void CBupdate(CBallot cBallot) {
		commentsDAO.CBupdate(cBallot);
	}

	@Override
	public CBallot selectCBallotByIdx(Map<String, Object> map) {
		return commentsDAO.selectCBallotByIdx(map);
	}

	

	// 사용자 ID를 사용하여 작성한 댓글을 조회하는 메서드 추가
    @Override
    public List<Comments> getCommentsByUserId(String userId) {
        return commentsDAO.selectCommentsByUserId(userId);
    }

	@Override
	public void CommentUpdateStatus3(int commentIdx) {
		commentsDAO.UpdatCommentStatus3(commentIdx);
	}
}
