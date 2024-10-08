package xyz.itwill.dto;

import lombok.Data;

@Data
public class ChatProductUser {
	 private int productId;           // 상품 ID
	 private String productUserId;    // 판매자 ID (문자열)
	 private String productSubject;   // 상품 제목
	 private double productPrice;     // 상품 가격
	 private String productCategory;  // 상품 카테고리
	 private Long sellerId;           // 판매자의 숫자형 ID (SELLER_ID)
}
