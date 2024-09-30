package xyz.itwill.service;

import xyz.itwill.dto.Product;
import java.util.List;

public interface ProductService {
    void addProduct(Product product);
    List<Product> getProductList(); // 상품 목록을 가져오는 메서드 추가
}
