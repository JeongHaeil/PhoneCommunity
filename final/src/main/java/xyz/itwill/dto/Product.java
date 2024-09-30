package xyz.itwill.dto;

import java.sql.Date;

import lombok.Data;

//create table product(product_idx number primary key , product_user_id varchar2(50), FOREIGN KEY (product_user_id) REFERENCES users(user_id), product_subject varchar2(200), product_conent varchar2(4000), product_image varchar2(400),
//product_register_date date, product_update_date date, product_user_ip varchar2(50), product_count number, product_sold number, product_mode number, product_status number, product_purchase_id number,
//product_sold_date date, product_price number, product_model_status varchar2(50), product_delivery varchar2(50));

//create SEQUENCE product_seq; 

@Data
public class Product {
	private int productIdx; //글번호
	private String productUserid; // 작성자
	private String procutSubject; //제목
	private String procutContent; // 내용
	private String productImage; // 이미지
	private Date procutRegisterdate; // 작성일
	private Date productUpdatedate; // 수정일
	private String procutUserip; // 작성자 아이피
	private int prodcutCount; // 조회수
	private int prodcutSold; // 판매상태 1: 판매중, 2: 예약중 , 3: 판매완료
	private int prodcutMode; // 거래방법 1:직거래, 2:안전거래, 3: 택배
	private int prodcutStatus; // 글상태
	private int prodcutPurchid; // 구매자 id
	private Date prodcutSolddate; // 판매날짜
	private int productPrice; // 판매가격
	private String product_model_status; //상품상태
	private String product_delivery; // 배송비 별도,포함 선택
	private String product_category; // 상품 카테고리 설정
	
	

}
