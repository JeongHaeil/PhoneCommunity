package xyz.itwill.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;



import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Board;
import xyz.itwill.dto.Comments;
import xyz.itwill.service.BoardService;
import xyz.itwill.service.CommentsService;
import xyz.itwill.util.Pager;

@RestController
@RequestMapping("/rest")
@RequiredArgsConstructor
public class BoardJsonController {
	private final BoardService boardService;
	private final CommentsService commentsService;
	private final WebApplicationContext context;
	
	@GetMapping("/commentsList/{boardCode}/{boardPostIdx}")
	public Map<String, Object> CommentsList(@PathVariable int boardCode,@PathVariable int boardPostIdx,@RequestParam(defaultValue = "1") int pageNum) {
		/* List<Comments> commentList=commentsService.getCommentsList(freePostIdx); */
		int pageSize=5;
		Map<String, Object> getcommentList=commentsService.getCommentsList(boardPostIdx, pageNum, pageSize);
		List<Comments> commentList=(List<Comments>)getcommentList.get("commentsList");
		Pager pager=(Pager)getcommentList.get("pager");
		int commentCount=commentsService.getCommentsCount(boardPostIdx);
		Board board=boardService.getboard(boardPostIdx);
		Map<String, Object> resultmap=new HashMap<String, Object>();
		resultmap.put("board", board);
		resultmap.put("boardCode", boardCode);
		resultmap.put("boardPostIdx", boardPostIdx);
		resultmap.put("commentCount", commentCount);
		resultmap.put("commentList", commentList);
		resultmap.put("pager", pager);
		return resultmap;
	}
	
	@PostMapping("/comment_insert/{commentBoardIdx}/{commentIdx}")
	public String commentInsert(@PathVariable int commentBoardIdx, @PathVariable int commentIdx, @RequestParam(value = "commentImage", required = false) MultipartFile commentImage,@RequestParam String content , HttpServletRequest request ) throws IllegalStateException, IOException {
		if(commentIdx!=0) {
			Comments getcomment=new Comments();
			getcomment=commentsService.getCommentByNum(commentIdx);
			commentsService.updateCommentRef(getcomment);
			int num=commentsService.getCommentNextNum();
			int restep=getcomment.getCommentRestep();
			int relevel=getcomment.getCommentLevel();
			int ref=getcomment.getCommentRef();			
			relevel++;
			restep++;
			
			Comments putcomment=new Comments();
			putcomment.setCommentIdx(num);
			putcomment.setCommentBoardIdx(commentBoardIdx);
			putcomment.setCommentUserId("abc123");//로그인 유저 다시 작성
			putcomment.setContent(content.replace("<","&lt;").replace(">","&gt;").replace("\n", "<br>"));
			if (commentImage != null && !commentImage.isEmpty()) {
				String uploadDirectory=context.getServletContext().getRealPath("/resources/uploadFile/comment_image");
				String uploadFilename=UUID.randomUUID().toString()+"_"+commentImage.getOriginalFilename();
				File file=new File(uploadDirectory, uploadFilename);
				commentImage.transferTo(file);
				putcomment.setCommentImage(uploadFilename);//이미지설정
			}
			
			putcomment.setCommentUserIp(request.getRemoteAddr());
			putcomment.setCommentRef(ref);
			putcomment.setCommentRestep(restep);
			putcomment.setCommentLevel(relevel);
			putcomment.setCommentReuserid(getcomment.getCommentUserId());//
			commentsService.insertComment(putcomment);															
		}else {	
			Comments putcomment=new Comments();
			int num=commentsService.getCommentNextNum();
			putcomment.setCommentIdx(num);
			putcomment.setCommentBoardIdx(commentBoardIdx);
			putcomment.setCommentUserId("abc123");//로그인 유저 다시 작성
			putcomment.setContent(content.replace("<","&lt;").replace(">","&gt;").replace("\n", "<br>"));
			if (commentImage != null && !commentImage.isEmpty()) {
				String uploadDirectory=context.getServletContext().getRealPath("/resources/uploadFile/freeboard_image");
				String uploadFilename=UUID.randomUUID().toString()+"_"+commentImage.getOriginalFilename();
				File file=new File(uploadDirectory, uploadFilename);
				commentImage.transferTo(file);
				putcomment.setCommentImage(uploadFilename);//이미지설정
			}
			putcomment.setCommentUserIp(request.getRemoteAddr());
			putcomment.setCommentRef(num);
			putcomment.setCommentRestep(0);
			putcomment.setCommentLevel(0);
			commentsService.insertComment(putcomment);	
		}
		return "success";
	}
	
	@PutMapping("/comment_delete/{commentIdx}")
	public String commentDelete(@PathVariable int commentIdx) {
		Comments getComment=new Comments();
		getComment=commentsService.getCommentByNum(commentIdx);	
		int refcount=commentsService.gerCommentCountByRef(getComment.getCommentRef());
		if(refcount>1) {
			//대댓글이 있으므로 삭제 불가 로 메세지 또는 alert 발생시키기
			commentsService.deleterrComment(commentIdx);
		}else {
			commentsService.deleteComment(commentIdx);			
		}
		return "success";
	}
	
	@PostMapping("/comment_starup/{commentIdx}")
	public String commentStarUp(@PathVariable int commentIdx) {
		//로그인 했을때 만  확인
		//계정당 1개 설정
		commentsService.updateCommentStar(commentIdx);
		return "success";
	}
	
	@PostMapping("/comment_commentspam/{commentIdx}")
	public String commentspam(@PathVariable int commentIdx) {
		//로그인 했을때 만  확인
		//계정당 1개 설정
		commentsService.updatrCommentSpam(commentIdx);
		return "success";
	}
	
	@PostMapping("/board_starup/{boardPostIdx}")
	public String boardStarUp(@PathVariable int boardPostIdx) {
		//로그인 했을때 만  확인
		//계정당 1개 설정
		boardService.boardStarUp(boardPostIdx);
		return "success";
	}
	
	@PostMapping("/board_stardown/{boardPostIdx}")
	public String boardStarDown(@PathVariable int boardPostIdx) {
		//로그인 했을때 만  확인
		//계정당 1개 설정
		boardService.boardStarDown(boardPostIdx);
		return "success";
	}
	
	@PostMapping("/board_spam/{boardPostIdx}")
	public String boardSpam(@PathVariable int boardPostIdx) {
		//로그인 했을때 만  확인
		//계정당 1개 설정
		boardService.boardSpam(boardPostIdx);
		return "success";
	}
}
