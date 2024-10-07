package xyz.itwill.dto;

import java.util.Date;

import lombok.Data;

/*
 	chat_id      NUMBER PRIMARY KEY,             -- 채팅 ID (PK)
    buyer_id     NUMBER,                         -- 구매자 ID (FK)
    seller_id    NUMBER,                         -- 판매자 ID (FK)
    product_id   NUMBER,                         -- 판매자 상품/게시글 ID (FK)
    message      VARCHAR2(3000),                 -- 대화 내용
    timestamp    DATE DEFAULT SYSTIMESTAMP,
*/

@Data
public class Chat {
	private int chatId;
	private int buyerId;
	private int sellerId;
	private int productId;
	private String message;
	private Date timestamp;
}
