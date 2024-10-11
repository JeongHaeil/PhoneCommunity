package xyz.itwill.dto;

import java.sql.Date;
import lombok.Data;

@Data
public class Product {
    private int productIdx; 
    private String productUserid; 
    private String productSubject; 
    private String productContent; 
    private String productImage; // 콤마로 구분된 여러 이미지 파일명
    private Date productRegisterdate; 
    private Date productUpdatedate; 
    private int productCount; 
    private int productSold; 
    private String productMode; 
    private int productStatus;  // 1일반,2삭제
    private int productPurchid; 
    private Date productSolddate; 
    private int productPrice; 
    private String productModelStatus; 
    private String productDelivery; 
    private String productCategory; 
    private String productUsernickname; 
}
