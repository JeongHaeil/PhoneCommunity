package xyz.itwill.dto;

import java.sql.Date;
import lombok.Data;

@Data
public class Product {
    private int productIdx; // 글번호
    private String productUserid; // 작성자
    private String productSubject; // 제목
    private String productContent; // 내용
    private String productImage; // 이미지
    private Date productRegisterdate; // 작성일
    private Date productUpdatedate; // 수정일
    private String productUserip; // 작성자 아이피
    private int productCount; // 조회수 (오타 수정)
    private int productSold; // 판매상태 1: 판매중, 2: 예약중, 3: 판매완료 (숫자로 변경)
    private String productMode; // 거래방법 1: 직거래, 2: 안전거래, 3: 택배 (숫자로 변경)
    private int productStatus; // 글상태
    private int productPurchid; // 구매자 id
    private Date productSolddate; // 판매날짜
    private int productPrice; // 판매가격
    private String productModelStatus; // 상품상태
    private String productDelivery; // 배송비 별도, 포함 선택
    private String productCategory; // 상품 카테고리 설정
    private String productUsernickname; // 유저 이름
}
