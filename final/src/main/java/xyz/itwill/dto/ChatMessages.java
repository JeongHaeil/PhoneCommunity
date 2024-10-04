package xyz.itwill.dto;

import java.util.Date;

import lombok.Data;

/*
	 message_id  NUMBER PRIMARY KEY,               -- 메시지 ID (PK)
    room_id     NUMBER,                           -- 채팅방 ID (FK)
    sender_id   NUMBER,                           -- 메시지를 보낸 사람 ID (FK)
    message     VARCHAR2(4000),                   -- 메시지 내용
    sent_at     DATE DEFAULT SYSDATE,             -- 메시지 전송 시간
*/

@Data
public class ChatMessages {
	private int messageId;
	private int roomId;
	private int senderId;
	private String message;
	private Date sentAt;
}
