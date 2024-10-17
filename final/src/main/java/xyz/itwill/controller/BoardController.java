package xyz.itwill.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.dto.Board;
import xyz.itwill.dto.Comments;
import xyz.itwill.service.BoardService;
import xyz.itwill.service.CommentsService;
import xyz.itwill.service.UserService;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {
	
    private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	private final BoardService boardService;
	private final CommentsService commentsService;
	private final WebApplicationContext context;
	private final UserService userService;
	
	
	@RequestMapping("/boardlist/{boardCode}")
	public String boardList(@PathVariable int boardCode, 
	                        @RequestParam(defaultValue = "1") int pageNum, 
	                        @RequestParam(defaultValue = "20") int pageSize,
	                        @RequestParam(defaultValue = "") String search, 
	                        @RequestParam(defaultValue = "") String keyword, 
	                        Model model,Authentication authentication) throws Exception {
		
	    // 게시글 목록 조회
	    Map<String, Object> map = boardService.getBoardList(boardCode, pageNum, pageSize, search, keyword);

	    // 타입 안전한 방식으로 List<Board> 캐스팅
	    List<?> listObject = (List<?>) map.get("boardList");

	    List<Board> boardList = new ArrayList<>();
	    for (Object obj : listObject) {
	        if (obj instanceof Board) {
	            boardList.add((Board) obj);
	        }
	    }

	    // 게시글 작성자의 레벨 및 권한 정보 출력
	    for (Board board : boardList) {
	        logger.info("게시글 ID: {}, 작성자: {}, 레벨: {}, 권한: {}", 
	                    board.getBoardPostIdx(), board.getBoardUserId(), board.getUserLevel(), board.getAuth());
	    }

	    // 게시판 코드에 따른 타이틀 설정
	    String boardCodeTitle = boardService.getBoardCT(boardCode);

	    // 모델에 데이터 추가
	    model.addAttribute("boardCodeTitle", boardCodeTitle);
	    model.addAttribute("search", search);
	    model.addAttribute("keyword", keyword);
	    model.addAttribute("boardCode", boardCode);
	    model.addAttribute("pager", map.get("pager"));
	    model.addAttribute("boardList", boardList);
	    if(authentication!=null) {
			CustomUserDetails userDetails=(CustomUserDetails)authentication.getPrincipal();
			model.addAttribute("userDetails", userDetails);
		}
	    return "board/boardList";
	}

	
	@RequestMapping("/boarddetail/{boardCode}/{boardPostIdx}")
	public String boarddetail(@PathVariable int boardPostIdx, @PathVariable int boardCode,
	                          @RequestParam(defaultValue = "1") int pageNum, 
	                          @RequestParam(defaultValue = "20") int pageSize,
	                          @RequestParam(defaultValue = "") String search, 
	                          @RequestParam(defaultValue = "") String keyword, 
	                          Model model, HttpServletRequest request, HttpServletResponse response,Authentication authentication) throws Exception {
		if(boardCode==3) {
			if(authentication!=null) {
				CustomUserDetails userDetails=(CustomUserDetails)authentication.getPrincipal();
				Board board=boardService.getboard(boardPostIdx);
				if(board.getBoardUserId().equals(userDetails.getUserId())||userDetails.getAuthorities().stream().anyMatch(grantedAuthority -> grantedAuthority.getAuthority().equals("ROLE_BOARD_ADMIN"))) {			
				}else {
					return "redirect:/board/boardlist/"+boardCode+"?search="+search+"&keyword="+keyword+"&pageNum="+pageNum;	
				}
			}else {
				return "redirect:/user/login";	
			}
		}
	    // 쿠키 저장 	   
	    Cookie[] cookies = request.getCookies();
	    String oldCookiesValue = null;
	    Cookie oldCookies = null;
	    List<String> cookieList = new ArrayList<String>();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ("viewCountCookie".equals(cookie.getName())) {
	                oldCookies = cookie;
	                oldCookiesValue = cookie.getValue();
	                oldCookiesValue = oldCookiesValue.replaceAll("[\\[\\]]", ",");
	                String[] cookieArray = oldCookiesValue.split(",");
	                
	                cookieList.addAll(Arrays.asList(cookieArray));
	                break;
	            }
	        }
	    }
	    if (oldCookies != null) {
	        if (!cookieList.contains(String.valueOf(boardPostIdx))) {
	            oldCookies.setValue(oldCookies.getValue() + "[" + boardPostIdx + "]");
	            oldCookies.setPath("/final/board/");
	            oldCookies.setMaxAge(60 * 60 * 24);
	            response.addCookie(oldCookies);
	            boardService.boardViewCountUp(boardPostIdx);
	            logger.info("쿠키 업데이트 및 조회수 증가 처리 완료 - 게시글 번호: {}", boardPostIdx);
	        }
	    } else {
	        Cookie newCookie = new Cookie("viewCountCookie", "[" + boardPostIdx + "]");
	        newCookie.setPath("/final/board/");
	        newCookie.setMaxAge(60 * 60 * 24);
	        response.addCookie(newCookie);
	        boardService.boardViewCountUp(boardPostIdx);
	        logger.info("새 쿠키 생성 및 조회수 증가 처리 완료 - 게시글 번호: {}", boardPostIdx);
	    }

	    // 댓글 수 계산
	    int commentCount = commentsService.getCommentsCount(boardPostIdx);
	    logger.info("댓글 수 계산 완료 - 게시글 번호: {}, 댓글 수: {}", boardPostIdx, commentCount);

	    // 게시글 정보 가져오기
	    Map<String, Object> insertmap = new HashMap<String, Object>();
	    insertmap.put("boardPostIdx", boardPostIdx);
	    insertmap.put("boardCode", boardCode);
	    Board board = boardService.getBoardRNumber(insertmap);
	    logger.info("게시글 정보 가져오기 완료 - 게시글 번호: {}", boardPostIdx);

	    // 이전글/다음글 정보 가져오기
	    Map<String, Object> boardmap = new HashMap<String, Object>();
	    boardmap.put("boardCode", boardCode);
	    boardmap.put("rn", board.getRn());
	    Board upboard = boardService.getRnUp(boardmap);
	    Board downboard = boardService.getRnDown(boardmap);
	  //Board boards=boardService.getboard(boardPostIdx);
	    if (upboard == null) {
	        model.addAttribute("upboard", 0);
	        logger.info("이전글 없음");
	    } else {
	        model.addAttribute("upboard", upboard.getBoardPostIdx());
	        logger.info("이전글 정보 가져오기 완료 - 이전글 번호: {}", upboard.getBoardPostIdx());
	    }

	    if (downboard == null) {
	        model.addAttribute("downboard", 0);
	        logger.info("다음글 없음");
	    } else {
	        model.addAttribute("downboard", downboard.getBoardPostIdx());
	        logger.info("다음글 정보 가져오기 완료 - 다음글 번호: {}", downboard.getBoardPostIdx());
	    }

	    // 이미지가 있는 경우 처리
	    if (board.getBoardImage() != null && !board.getBoardImage().equals("")) {
	        String list = board.getBoardImage().replaceAll("[\\[\\]]", "");
	        List<String> imageArray = Arrays.asList(list.split(","));
	        model.addAttribute("imageArray", imageArray);
	        logger.info("이미지 정보 처리 완료 - 이미지 개수: {}", imageArray.size());
	    }

	    // **레벨과 권한 정보 추가** 
	    logger.info("게시글 작성자의 레벨: {}, 권한: {}", board.getUserLevel(), board.getAuth());
	    model.addAttribute("board", board);
	    model.addAttribute("commentCount", commentCount);
	    model.addAttribute("boardCode", boardCode);

	    // 게시판 목록 및 검색 정보 가져오기
	    Map<String, Object> map = boardService.getBoardList(boardCode, pageNum, pageSize, search, keyword);
	    String boardTitle = boardService.getBoardCT(boardCode);
	    model.addAttribute("boardTitle", boardTitle);
	    model.addAttribute("search", search);
	    model.addAttribute("keyword", keyword);
	    model.addAttribute("pager", map.get("pager"));
	    model.addAttribute("boardList", map.get("boardList"));
	    logger.info("게시판 목록 및 검색 정보 가져오기 완료 - 게시판 코드: {}", boardCode);

	    return "board/boarddetail";
	}

	
	
	@RequestMapping(value ="/boardwrite/{boardCode}", method = RequestMethod.GET)
	public String boardwrite(@PathVariable int boardCode, Model model,Authentication authentication,RedirectAttributes redirectAttributes) throws ParseException {
		if(authentication == null) {
			return "redirect:/user/login";	
		}
		if(boardCode==3){
			CustomUserDetails details=(CustomUserDetails)authentication.getPrincipal();
			if(details.getUserStatus()<=4&&details.getUserStatus()>=1) {
				
			}else {
				return "redirect:/user/login";
			}
		}else if(boardCode>=10) {
			CustomUserDetails details=(CustomUserDetails)authentication.getPrincipal();
			if(details.getUserStatus()!=1) {
				CustomUserDetails userDetails=(CustomUserDetails)authentication.getPrincipal();
				if(userDetails.getStatusExpiryDate()!=null) {
					String rExpiryDate=userDetails.getStatusExpiryDate();
					SimpleDateFormat in=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS");
					SimpleDateFormat out=new SimpleDateFormat("yyyy년 MM월 dd일");
					Date date=in.parse(rExpiryDate);
					String userExpiryDate=out.format(date);
					redirectAttributes.addFlashAttribute("userExpiryDate",userExpiryDate);				
				}
				redirectAttributes.addFlashAttribute("message","정지된 사용자 입니다.");
				return "redirect:/board/boardlist/3";
			}
		}
		model.addAttribute("boardCode", boardCode);				
		return "board/boardwrite";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_USER','ROLE_SUPER_ADMIN')")
	@RequestMapping(value ="/boardwrite/{boardCode}", method = RequestMethod.POST)
	public String boardwrite(@PathVariable int boardCode, @ModelAttribute Board board, @RequestParam String boardtag, List<MultipartFile> uploaderFileList, HttpServletRequest request, Authentication authentication, RedirectAttributes attributes) throws IllegalStateException, IOException {
	    if (authentication != null) {            
	        CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
	        board.setBoardUserId(user.getUserId());
	        
	        String uploadDirectory = context.getServletContext().getRealPath("/resources/images/uploadFile/board");
	        List<String> filenameList = new ArrayList<String>();
	        for (MultipartFile multipartFile : uploaderFileList) {
	            if (!multipartFile.isEmpty()) {
	                String uploadFilename = UUID.randomUUID().toString() + "_" + multipartFile.getOriginalFilename();
	                File file = new File(uploadDirectory, uploadFilename);
	                multipartFile.transferTo(file);
	                filenameList.add(uploadFilename);
	            }            
	        }
	        if (!filenameList.isEmpty()) {            
	            board.setBoardImage(filenameList.toString());
	        }
	        board.setBoardIp(request.getRemoteAddr());
	        board.setBoardCode(boardCode);
			//board.setBoardContent(board.getBoardContent().replace("<","&lt;").replace(">","&gt;").replace("\n", "<br>"));
	        board.setBoardTitle(boardtag + " " + board.getBoardTitle().replace("<", "&lt;").replace(">", "&gt;"));
	        if (board.getBoardContent().length() <= 1300) {
	            boardService.addFreeboard(board); // 게시글 추가 로직
	            
	            // 게시글 작성 후 경험치 추가
	            userService.increaseExperience(user.getUserId(), 10); // 경험치 10점 추가	           	            
	        } else {
	            attributes.addFlashAttribute("regetmessage", "최대 허용 글자수를 초과하였습니다.");
	            return "redirect:/board/boardwrite/" + boardCode;
	        }
	    } else {
	        return "redirect:/user/login";    
	    }
	    return "redirect:/board/boardlist/" + boardCode;
	}
	
	
	@RequestMapping(value ="/boardModify/{boardCode}/{boardPostIdx}", method = RequestMethod.GET)
	public String boardModify(@PathVariable int boardCode, @PathVariable int boardPostIdx, Model model,Authentication authentication,@RequestParam(defaultValue = "") String regetmessage) {	
		if(authentication != null) {
			CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
			Board board=boardService.getboard(boardPostIdx);
			if(board.getBoardUserId().equals(user.getUserId().toString())) {
				String fulltitle=board.getBoardTitle();
				int index=fulltitle.indexOf("[");
				int indexs=fulltitle.indexOf("]");
				if(index != -1 && indexs!= -1) {
					String boardtag=fulltitle.substring(fulltitle.indexOf("[")+1,fulltitle.indexOf("]"));
					String title=fulltitle.substring(fulltitle.indexOf("]")+1).trim();
					board.setBoardTitle(title);					
					model.addAttribute("boardtag", boardtag);				
				}				
				model.addAttribute("board", board);				
				model.addAttribute("regetmessage", regetmessage);											
				model.addAttribute("boardCode", boardCode);											
			}else {
				return "redirect:/user/login";
			}
		}else {
			return "redirect:/user/login";			
		}
					
		return "board/boardwrite";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_USER','ROLE_SUPER_ADMIN')")
	@RequestMapping(value ="/boardModify/{boardCode}/{boardPostIdx}", method = RequestMethod.POST)
	public String boardModify(@PathVariable int boardCode, @PathVariable int boardPostIdx,@RequestParam String boardtag,@ModelAttribute Board board,List<MultipartFile> uploaderFileList,HttpServletRequest request,RedirectAttributes attributes) throws IllegalStateException, IOException {
		Board oldboard=boardService.getboard(boardPostIdx);
		if(uploaderFileList!=null) {
			String uploadDirectory=context.getServletContext().getRealPath("/resources/images/uploadFile/board");		
			List<String> filenameList=new ArrayList<String>();
			if(uploaderFileList!=null&&!uploaderFileList.isEmpty()) {
				for(MultipartFile multipartFile : uploaderFileList) {
					if(!multipartFile.isEmpty()) {
						String uploadFilename=UUID.randomUUID().toString()+"_"+multipartFile.getOriginalFilename();
						File file=new File(uploadDirectory,uploadFilename);
						multipartFile.transferTo(file);
						filenameList.add(uploadFilename);
					}			
				}
				if(!filenameList.isEmpty()) {			
					oldboard.setBoardImage(filenameList.toString());
				}
			}
		}
		oldboard.setBoardTitle(boardtag+" "+board.getBoardTitle().replace("<","&lt;").replace(">","&gt;"));			
		if(oldboard.getBoardContent().length()<=1300) {
			oldboard.setBoardContent(board.getBoardContent());
		}else {
			attributes.addAttribute("regetmessage","최대 허용 글자수를 초과하였습니다.");
			return "redirect:/board/boardModify/"+boardCode+"/"+boardPostIdx;
		}
		boardService.updateFreeboard(oldboard);	
		return "redirect:/board/boarddetail/"+boardCode+"/"+boardPostIdx;
	}
	
	@RequestMapping(value = "/boardDeleteBoard/{boardCode}/{boardPostIdx}")
	public String boardDelete(@PathVariable int boardCode,@PathVariable int boardPostIdx,Authentication authentication) {
		if(authentication != null) {
			CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
			Board board=boardService.getboard(boardPostIdx);
			if(board.getBoardUserId().toString().equals(user.getUserId().toString())) {
				boardService.deleteFreeboard(boardPostIdx);						
			}else {
				//관리자 일때 처리										
			}
		}else {
			return "redirect:/user/login";		
		}
		return "redirect:/board/boardlist/"+boardCode;
	}
	
	// 마이페이지 작성 글 제목 클릭시 이동 경로 수정
	@RequestMapping("/post/{boardCode}/{boardPostIdx}")
	public String showPostDetail(@PathVariable int boardCode, @PathVariable int boardPostIdx, Model model) {
	    // boardCode가 0일 경우 기본값 설정
	    if (boardCode == 0) {
	        boardCode = 10; // 예시로 기본값 설정
	    }

	    // 게시물 정보를 가져옵니다.
	    Board post = boardService.getboard(boardPostIdx);

	    // 게시물이 없을 경우 NullPointerException 방지
	    if (post == null) {
	        return "redirect:/error"; // 게시물이 없을 경우 에러 페이지로 리다이렉트
	    }

	    model.addAttribute("post", post);
	    model.addAttribute("boardCode", boardCode);

	    return "board/boarddetail"; // 게시물 상세보기로 이동
	}
	
	// 댓글 클릭 시 게시글로 이동하는 메소드 수정
	@RequestMapping("/comment/{commentIdx}")
	public String viewCommentPost(@PathVariable int commentIdx, Model model) {
	    // 댓글 정보를 가져옵니다.
	    Comments comment = commentsService.getCommentByNum(commentIdx);
	    
	    // 댓글이 존재하지 않으면 에러 페이지로 리다이렉트
	    if (comment == null) {
	        return "redirect:/error";
	    }

	    // 댓글이 달린 게시글의 번호를 가져옵니다.
	    int boardPostIdx = comment.getCommentBoardIdx();

	    // 게시글의 boardCode를 가져옵니다.
	    Board board = boardService.getboard(boardPostIdx);

	    // 게시글이 존재하지 않으면 에러 페이지로 리다이렉트
	    if (board == null) {
	        return "redirect:/error"; // 게시글이 없을 경우 에러 페이지로 이동
	    }

	    // 여기서 부모 댓글의 상태를 무시하고 계속 진행
	    int boardCode = board.getBoardCode();

	    // 게시글 상세 페이지로 리다이렉트
	    return "redirect:/board/boarddetail/" + boardCode + "/" + boardPostIdx;
	}



}
