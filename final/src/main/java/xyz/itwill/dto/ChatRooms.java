package xyz.itwill.dto;

import java.util.Date;

import lombok.Data;

/*
 	 room_id            NUMBER PRIMARY KEY,        -- 채팅방 ID (PK)
    seller_id          NUMBER,                    -- 판매자 ID (FK)
    buyer_id           NUMBER,                    -- 구매자 ID (FK)
    created_at         DATE DEFAULT SYSDATE,      -- 채팅방 생성일
    chat_status VARCHAR2(20),  
  */

@Data
public class ChatRooms {
	private int roomId;
	private int productIdx;
	private String sellerId;
	private String buyerId;
	private String productId;
	private Date createdAt;
	private String chatStatus;
}
