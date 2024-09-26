package xyz.itwill.dto;

import lombok.Data;

/*
create table comments(comment_idx number PRIMARY key, comment_board_idx NUMBER, FOREIGN KEY (comment_board_idx) REFERENCES Board(board_post_idx),comment_user_id VARCHAR2(50), FOREIGN KEY (comment_user_id) REFERENCES users(USER_ID),content VARCHAR2(4000),comment_image VARCHAR2(500),comment_reg_date date,comment_up_date date,comment_user_ip VARCHAR2(100),comment_ref NUMBER,
comment_restep NUMBER,comment_level NUMBER,comment_status NUMBER,comment_starup NUMBER,comment_stardown NUMBER,comment_spam NUMBER, comment_reuserid VARCHAR2(50));
create SEQUENCE comments_seq;
*/
@Data  
public class Comments {
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
	private String commentReuserid;
	private String userNickname;
	
}
