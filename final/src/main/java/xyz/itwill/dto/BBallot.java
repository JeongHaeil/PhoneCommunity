package xyz.itwill.dto;

import lombok.Data;

/*
create table board_ballot(bo_ba_idx number PRIMARY key,ballot_board_idx NUMBER,FOREIGN KEY (ballot_board_idx) REFERENCES Board(board_post_idx),ballot_board_user_id VARCHAR2(100),FOREIGN KEY (ballot_board_user_id) REFERENCES users(USER_ID),ballot_board_star VARCHAR2(10),ballot_board_spam NUMBER);
create sequence board_ballot_seq;
*/

@Data
public class BBallot {
	private int boBaIdx;
	private int ballotBoardIdx;
	private int ballotBoardUserId;
	private int ballotBoardStar;
	private int ballotBoardSpam;
	
}
