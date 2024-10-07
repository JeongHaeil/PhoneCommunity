package xyz.itwill.dto;

import lombok.Data;

/*
create table CATEGORI(CATEGORI_CODE number PRIMARY key, CATEGORI_NAME VARCHAR2(20));
create table Board(board_post_idx number PRIMARY key, board_user_id VARCHAR2(50), FOREIGN KEY (board_user_id) REFERENCES users(USER_ID),board_title VARCHAR2(200), board_content VARCHAR2(4000), board_image VARCHAR2(400), BOARD_register_DATE date, board_update_date date, board_ip VARCHAR2(50), board_count number
            , board_starup number, board_stardown number, board_status number, board_code number, FOREIGN KEY (board_code) REFERENCES categori(CATEGORI_CODE), board_spam number);
create SEQUENCE Board_seq;
*/

@Data	
public class Board {
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
	private String userNickname;
}
