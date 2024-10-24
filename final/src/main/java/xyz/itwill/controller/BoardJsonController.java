package xyz.itwill.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
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
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.dto.BBallot;
import xyz.itwill.dto.Board;
import xyz.itwill.dto.CBallot;
import xyz.itwill.dto.Comments;
import xyz.itwill.service.BoardService;
import xyz.itwill.service.CommentsService;
import xyz.itwill.service.UserService;
import xyz.itwill.util.Pager;

@RestController
@RequestMapping("/rest")
@RequiredArgsConstructor
public class BoardJsonController {
	private final BoardService boardService;
	private final CommentsService commentsService;
	private final WebApplicationContext context;
    private final UserService userService; // 사용자 서비스 추가

	
	@SuppressWarnings("unchecked")
	@GetMapping("/commentsList/{boardCode}/{boardPostIdx}")
	public Map<String, Object> CommentsList(@PathVariable int boardCode,@PathVariable int boardPostIdx,@RequestParam(defaultValue = "1") int pageNum,Authentication authentication) {
		Map<String, Object> resultmap=new HashMap<String, Object>();
		if(authentication!=null) {
			CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
			List<GrantedAuthority> authorities=(List<GrantedAuthority>) user.getAuthorities();
			for(GrantedAuthority authority : authorities) {
				 if (authority.getAuthority().equals("ROLE_BOARD_ADMIN")) {
					 resultmap.put("boardAdmin", user.getUserId());
				 }
			}
			resultmap.put("userId",user.getUserId());
		}
		
		int pageSize=10;
		Map<String, Object> getcommentList=commentsService.getCommentsList(boardPostIdx, pageNum, pageSize);
		List<Comments> commentList=(List<Comments>)getcommentList.get("commentsList");
		Pager pager=(Pager)getcommentList.get("pager");
		int commentCount=commentsService.getCommentsCount(boardPostIdx);
		Board board=boardService.getboard(boardPostIdx);
		resultmap.put("board", board);
		resultmap.put("boardCode", boardCode);
		resultmap.put("boardPostIdx", boardPostIdx);
		resultmap.put("commentCount", commentCount);
		resultmap.put("commentList", commentList);
		resultmap.put("pager", pager);
		return resultmap;
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/comment_insert/{commentBoardIdx}/{commentIdx}")
	public String commentInsert(@PathVariable int commentBoardIdx, @PathVariable int commentIdx, 
	    @RequestParam(value = "commentImage", required = false) MultipartFile commentImage,
	    @RequestParam String content, HttpServletRequest request, Authentication authentication) 
	    throws IllegalStateException, IOException {		

	    // 사용자 정보는 블록 외부에서 선언
	    CustomUserDetails user = (CustomUserDetails)authentication.getPrincipal();
	    if(user.getUserStatus()>1) {
	    	return "pass";
	    }
	    if(commentIdx != 0) {
	        Comments getcomment = commentsService.getCommentByNum(commentIdx);
	        commentsService.updateCommentRef(getcomment);
	        int num = commentsService.getCommentNextNum();
	        int restep = getcomment.getCommentRestep();
	        int relevel = getcomment.getCommentLevel();
	        int ref = getcomment.getCommentRef();			
	        relevel++;
	        restep++;

	        Comments putcomment = new Comments();
	        putcomment.setCommentIdx(num);
	        putcomment.setCommentBoardIdx(commentBoardIdx);
	        putcomment.setCommentUserId(user.getUserId());	
	        putcomment.setContent(content.replace("<", "&lt;").replace(">", "&gt;").replace("\n", "<br>"));
	        if (commentImage != null && !commentImage.isEmpty()) {
	            String uploadDirectory = context.getServletContext().getRealPath("/resources/images/uploadFile/comment");
	            String uploadFilename = UUID.randomUUID().toString() + "_" + commentImage.getOriginalFilename();
	            File file = new File(uploadDirectory, uploadFilename);
	            commentImage.transferTo(file);
	            putcomment.setCommentImage(uploadFilename);
	        }

	        putcomment.setCommentUserIp(request.getRemoteAddr());
	        putcomment.setCommentRef(ref);
	        putcomment.setCommentRestep(restep);
	        putcomment.setCommentLevel(relevel);
	        putcomment.setCommentReuser(getcomment.getUserNickname());
	        commentsService.insertComment(putcomment);
	    } else {
	        Comments putcomment = new Comments();
	        int num = commentsService.getCommentNextNum();
	        putcomment.setCommentIdx(num);
	        putcomment.setCommentBoardIdx(commentBoardIdx);
	        putcomment.setCommentUserId(user.getUserId());
	        putcomment.setContent(content.replace("<", "&lt;").replace(">", "&gt;").replace("\n", "<br>"));
	        if (commentImage != null && !commentImage.isEmpty()) {
	            String uploadDirectory = context.getServletContext().getRealPath("/resources/images/uploadFile/comment");
	            String uploadFilename = UUID.randomUUID().toString() + "_" + commentImage.getOriginalFilename();
	            File file = new File(uploadDirectory, uploadFilename);
	            commentImage.transferTo(file);
	            putcomment.setCommentImage(uploadFilename);  // 이미지 설정
	        }
	        putcomment.setCommentUserIp(request.getRemoteAddr());
	        putcomment.setCommentRef(num);
	        putcomment.setCommentRestep(0);
	        putcomment.setCommentLevel(0);
	        commentsService.insertComment(putcomment);
	    }

	    // 댓글 작성 후 경험치 추가
	    if (user != null) {
	        userService.increaseExperience(user.getUserId(), 5);
	       
	    }

	    return "success";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PutMapping("/comment_delete/{commentIdx}")
	public String commentDelete(@PathVariable int commentIdx,Authentication authentication) {
		CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		Comments getComment=new Comments();
		getComment=commentsService.getCommentByNum(commentIdx);
		if(user.getUserId().equals(getComment.getCommentUserId())||user.getAuthorities().stream().anyMatch(grantedAuthority -> grantedAuthority.getAuthority().equals("ROLE_BOARD_ADMIN"))) {
			int refcount=commentsService.gerCommentCountByRef(getComment.getCommentRef());
			if(refcount>1) {
				commentsService.deleterrComment(commentIdx);
			}else {
				commentsService.deleteComment(commentIdx);			
			}			
		}		
		return "success";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/comment_starup/{commentIdx}")
	public String commentStarUp(@PathVariable int commentIdx, Authentication authentication,HttpServletResponse response,HttpServletRequest request) throws IOException {
		if(authentication==null) {
			response.sendRedirect(request.getContextPath()+"/user/login");
		}
		CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("ballotCommentIdx", commentIdx);
		map.put("ballotCommentUserId", user.getUserId());
		CBallot cBallot=commentsService.selectCBallotByIdx(map);
		if(cBallot==null) {
			cBallot=new CBallot();
			cBallot.setBallotCommentIdx(commentIdx);
			cBallot.setBallotCommentUserId(user.getUserId());
			cBallot.setBallotCommentStar("up");
			
			commentsService.CBinsert(cBallot);
			commentsService.updateCommentStar(commentIdx);
			
		}else if(cBallot.getBallotCommentStar()==null){
			cBallot.setBallotCommentStar("up");			
			
			commentsService.CBupdate(cBallot);
			commentsService.updateCommentStar(commentIdx);
		}else {
			return "pass";
		}
		
		return "success";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/comment_commentspam/{commentIdx}")
	public String commentspam(@PathVariable int commentIdx, Authentication authentication,HttpServletResponse response,HttpServletRequest request) throws IOException {
		if(authentication==null) {
			response.sendRedirect(request.getContextPath()+"/user/login");
		}
		CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("ballotCommentIdx", commentIdx);
		map.put("ballotCommentUserId", user.getUserId());
		CBallot cBallot=commentsService.selectCBallotByIdx(map);
		if(cBallot==null) {
			cBallot=new CBallot();
			cBallot.setBallotCommentIdx(commentIdx);
			cBallot.setBallotCommentUserId(user.getUserId());
			cBallot.setBallotCommentSpam(1);
			
			commentsService.CBinsert(cBallot);	
			commentsService.updatrCommentSpam(commentIdx);
			
		}else if(cBallot.getBallotCommentSpam()==0){			
			cBallot.setBallotCommentSpam(1);			
			commentsService.CBupdate(cBallot);
			commentsService.updatrCommentSpam(commentIdx);
		}else {
			return "pass";
		}
		Comments comments=commentsService.getCommentByNum(commentIdx);
		if(comments.getCommentSpam()==10) {
			commentsService.CommentUpdateStatus3(commentIdx);
		}
		return "success";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/board_starup/{boardPostIdx}")
	public String boardStarUp(@PathVariable int boardPostIdx, Authentication authentication,HttpServletResponse response,HttpServletRequest request) throws IOException {
		if(authentication==null) {
			response.sendRedirect(request.getContextPath()+"/user/login");
		}
		CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("ballotBoardIdx", boardPostIdx);
		map.put("ballotBoardUserId", user.getUserId());
		
		BBallot bBallot=boardService.selectBBallotByIdx(map);
		if(bBallot==null) {
			bBallot=new BBallot();
			bBallot.setBallotBoardIdx(boardPostIdx);
			bBallot.setBallotBoardUserId(user.getUserId());
			bBallot.setBallotBoardStar("up");
			
			boardService.BBinsert(bBallot);
			boardService.boardStarUp(boardPostIdx);
		}else if(bBallot.getBallotBoardStar()==null){
			bBallot.setBallotBoardStar("up");
			boardService.BBupdate(bBallot);
			boardService.boardStarUp(boardPostIdx);
		}else {
			return "pass";
		}
		
		
		return "success";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/board_stardown/{boardPostIdx}")
	public String boardStarDown(@PathVariable int boardPostIdx, Authentication authentication,HttpServletResponse response,HttpServletRequest request) throws IOException {
		if(authentication==null) {
			response.sendRedirect(request.getContextPath()+"/user/login");
		}
		CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("ballotBoardIdx", boardPostIdx);
		map.put("ballotBoardUserId", user.getUserId());
		BBallot bBallot=boardService.selectBBallotByIdx(map);
		if(bBallot==null) {
			bBallot=new BBallot();
			bBallot.setBallotBoardIdx(boardPostIdx);
			bBallot.setBallotBoardUserId(user.getUserId());
			bBallot.setBallotBoardStar("down");
			
			boardService.BBinsert(bBallot);
			boardService.boardStarDown(boardPostIdx);
		}else if(bBallot.getBallotBoardStar()==null){
			bBallot.setBallotBoardStar("down");
			boardService.BBupdate(bBallot);
			boardService.boardStarDown(boardPostIdx);
		}else {
			return "pass";
		}
		
		boardService.boardStarDown(boardPostIdx);
		return "success";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/board_spam/{boardPostIdx}")
	public String boardSpam(@PathVariable int boardPostIdx, Authentication authentication,HttpServletResponse response,HttpServletRequest request) throws IOException {
		if(authentication==null) {
			response.sendRedirect("");//로그인 페이지로
		}
		CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("ballotBoardIdx", boardPostIdx);
		map.put("ballotBoardUserId", user.getUserId());
		BBallot bBallot=boardService.selectBBallotByIdx(map);
		if(bBallot==null) {
			bBallot=new BBallot();
			bBallot.setBallotBoardIdx(boardPostIdx);
			bBallot.setBallotBoardUserId(user.getUserId());
			bBallot.setBallotBoardSpam(1);
			
			boardService.BBinsert(bBallot);
			boardService.boardSpam(boardPostIdx);
		}else if(bBallot.getBallotBoardSpam()==0){
			bBallot.setBallotBoardSpam(1);
			boardService.BBupdate(bBallot);
			boardService.boardSpam(boardPostIdx);
		}else {
			return "pass";
		}
		Board board=boardService.getboard(boardPostIdx);	
		if(board.getBoardSpam()==10) {
			boardService.BoardUpdateStatus3(boardPostIdx);
		}
		return "success";
	}
	
	@GetMapping("/popular_side_board")
	public Map<String, Object> popularBoardListByStar() {
		Map<String, Object> resultMap=new HashMap<String, Object>();
		resultMap.put("popularBoardList", boardService.getPopularBoardByStartUp());
		return resultMap;
	}
	
	
	@GetMapping("/main_board_view")
	public Map<String, Object> ViewBoardListByNew() {
		Map<String, Object> resultMap=new HashMap<String, Object>();
		resultMap.put("NewBoardList", boardService.getPopularBoardByViewCount());
		return resultMap;
	}
	
	@GetMapping("/main_board_notice")
	public Map<String, Object> NoticeBoardList() {
		Map<String, Object> resultMap=new HashMap<String, Object>();
		resultMap.put("NoticeBoardList", boardService.getNoiceBoardList());
		return resultMap;
	}
	
}
