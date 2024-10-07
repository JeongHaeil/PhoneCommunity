package xyz.itwill.dto;

import lombok.Data;

@Data
public class Admin {
	
	
	/*
	private User user;
	private Board board;
	private Comments comments;
	*/
	
	//User
	private int userNum;
    private String userId;
    private String userPassword;
    private String userEmail;
    private String userPhoneNum;
    private String userName;
    private String userUpdateDate;
    private String userLastLogin;
    private String userRegisterDate;
    private int userLevel =1;
    private int userStatus =1;

    //공통적으로 사용되는 userNickName
    //private String userNickName;
    private String userNickname;
	
    //Board
	private int boardPostIdx;
	private String boardUserId;
	private String boardTitle;
	private String boardContent;
	private String boardImage;
	private String boardRegisterDate;
	private String boardUpdateDate;
	private String boardIp;
	private int boardCount;
	private int boardStarup;
	private int boardStardown;
	private int boardStatus;
	private int boardCode;
	private int boardSpam;
	
	//Comment
	private int commentIdx;
	private int commentBoardIdx;
	private String commentUserId;
	private String content;	
	private String commentImage;
	private String commentRegDate;
	private String commentUpDate;
	private String commentUserIp;
	private int commentRef;
	private int commentRestep;
	private int commentLevel;
	private int commentStatus;
	private int commentStarup;
	private int commentStardown;
	private int commentSpam;
	private String commentReuser;
	
	 
}
