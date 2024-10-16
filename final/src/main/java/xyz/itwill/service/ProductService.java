package xyz.itwill.service;

import xyz.itwill.dto.Product;
import java.util.List;
import java.util.Map;

public interface ProductService {
    void addProduct(Product product);

    void modifyProduct(Product product);

    void increaseProductCount(int productIdx);

    Product getProductByNum(int productIdx);

    Map<String, Object> getProductList(Map<String, Object> map);

    void updateProductStatus(int productIdx);

    int createProductAndChatRoom(Product product);
    
    // 판매 상태 업데이트 메서드 추가
    void updateProductSoldStatus(int productIdx, int status);
    
    List<Product> getPopularProducts(); // 인기 게시글을 가져오는 메소드
    
    List<Product> getProductsByUserId(String userId);//마이페이지
}
