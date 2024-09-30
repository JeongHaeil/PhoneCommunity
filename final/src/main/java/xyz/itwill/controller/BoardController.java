package xyz.itwill.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

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

import lombok.RequiredArgsConstructor;
import xyz.itwill.auth.CustomUserDetails;
import xyz.itwill.dto.Board;
import xyz.itwill.service.BoardService;
import xyz.itwill.service.CommentsService;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {
	private final BoardService boardService;
	private final CommentsService commentsService;
	private final WebApplicationContext context;
	
	
	@RequestMapping("/boardlist/{boardCode}")
	public String boardList(@PathVariable int boardCode, @RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue = "5") int pageSize
			, @RequestParam(defaultValue = "board_user_id") String search, @RequestParam(defaultValue = "") String keyword, Model model) {
		Map<String, Object> map=boardService.getBoardList(boardCode, pageNum, pageSize, search, keyword);
		String boardCodeTitle=boardService.getBoardCT(boardCode);
		model.addAttribute("boardCodeTitle", boardCodeTitle);
		model.addAttribute("search", search);
		model.addAttribute("keyword", keyword);
		model.addAttribute("boardCode", boardCode);
		model.addAttribute("pager", map.get("pager"));
		model.addAttribute("boardList", map.get("boardList"));
		return "board/boardList";
	}
	
	@RequestMapping("/boarddetail/{boardCode}/{boardPostIdx}")
	public String boarddetail(@PathVariable int boardPostIdx,@PathVariable int boardCode,@RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue = "5") int pageSize
			, @RequestParam(defaultValue = "board_user_id") String search, @RequestParam(defaultValue = "") String keyword, Model model) {
		int commentCount=commentsService.getCommentsCount(boardPostIdx);
		Board board=boardService.getboard(boardPostIdx);
		if(board.getBoardImage()!=null&&!board.getBoardImage().equals("")) {
			String list=board.getBoardImage().replaceAll("[\\[\\]]", "");;
			List<String> imageArray=Arrays.asList(list.split(","));
			model.addAttribute("imageArray", imageArray);								
		}
		model.addAttribute("board", board);		
		model.addAttribute("commentCount", commentCount);
		model.addAttribute("boardCode", boardCode);
		
		Map<String, Object> map=boardService.getBoardList(boardCode, pageNum, pageSize, search, keyword);
		String boardTitle=boardService.getBoardCT(boardCode);
		model.addAttribute("boardTitle", boardTitle);
		model.addAttribute("search", search);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pager", map.get("pager"));
		model.addAttribute("boardList", map.get("boardList"));
		return "board/boarddetail";
	}
	
	
	
	@RequestMapping(value ="/boardwrite/{boardCode}", method = RequestMethod.GET)
	public String boardwrite(@PathVariable int boardCode, Model model,Authentication authentication) {
		if(authentication == null) {
			return "redirect:/user/login";	
		}
		model.addAttribute("boardCode", boardCode);				
		return "board/boardwrite";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_USER','ROLE_SUPER_ADMIN')")
	@RequestMapping(value ="/boardwrite/{boardCode}", method = RequestMethod.POST)
	public String boardwrite(@PathVariable int boardCode, @ModelAttribute Board board, List<MultipartFile> uploaderFileList,HttpServletRequest request,Authentication authentication) throws IllegalStateException, IOException {
		if(authentication != null) {			
			CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
			board.setBoardUserId(user.getUserId());
			
			String uploadDirectory=context.getServletContext().getRealPath("/resources/uploadFile/freeboard_image");
			List<String> filenameList=new ArrayList<String>();
			for(MultipartFile multipartFile : uploaderFileList) {
				if(!multipartFile.isEmpty()) {
					String uploadFilename=UUID.randomUUID().toString()+"_"+multipartFile.getOriginalFilename();
					File file=new File(uploadDirectory,uploadFilename);
					multipartFile.transferTo(file);
					filenameList.add(uploadFilename);
				}			
			}
			if(!filenameList.isEmpty()) {			
				board.setBoardImage(filenameList.toString());
			}
			board.setBoardIp(request.getRemoteAddr());
			board.setBoardCode(boardCode);
			board.setBoardContent(board.getBoardContent().replace("<","&lt;").replace(">","&gt;").replace("\n", "<br>"));
			board.setBoardTitle(board.getBoardTitle().replace("<","&lt;").replace(">","&gt;"));
			boardService.addFreeboard(board);			
		}else {
			return "redirect:/user/login";	
		}
		return "redirect:/board/boardlist/"+boardCode;
	}
	
	//@PreAuthorize("hasRole('ROLE_USER') or principal.userid eq #map['writer'] ")
	@RequestMapping(value ="/boardModify/{boardCode}/{boardPostIdx}", method = RequestMethod.GET)
	public String boardModify(@PathVariable int boardCode, @PathVariable int boardPostIdx, Model model,Authentication authentication) {	
		if(authentication != null) {
			CustomUserDetails user=(CustomUserDetails)authentication.getPrincipal();
			Board board=boardService.getboard(boardPostIdx);
			if(board.getBoardUserId().equals(user.getUserId().toString())) {
				model.addAttribute("board", board);				
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
	public String boardModify(@PathVariable int boardCode, @PathVariable int boardPostIdx,@ModelAttribute Board board,List<MultipartFile> uploaderFileList,HttpServletRequest request) throws IllegalStateException, IOException {
		Board oldboard=boardService.getboard(boardPostIdx);	
		String uploadDirectory=context.getServletContext().getRealPath("/resources/uploadFile/freeboard_image");
	
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
				board.setBoardImage(filenameList.toString());
			}
		}
		boardService.updateFreeboard(board);	
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
}
