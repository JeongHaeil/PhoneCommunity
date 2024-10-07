package xyz.itwill.dto;

import lombok.Data;

/*
 create table comment_ballot(co_ba_idx number PRIMARY key,ballot_comment_idx NUMBER,FOREIGN KEY (ballot_comment_idx) REFERENCES comments(COMMENT_IDX),ballot_comment_user_id VARCHAR2(100),FOREIGN KEY (ballot_comment_user_id) REFERENCES users(USER_ID),ballot_comment_star VARCHAR2(10),ballot_comment_spam NUMBER);
create sequence comment_ballot_seq; 
  
 */

@Data
public class CBallot {
	private int coBaIdx;
	private int ballotCommentIdx;
	private String ballotCommentUserId;
	private String ballotCommentStar;
	private int ballotCommentSpam;
}
