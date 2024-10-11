package xyz.itwill.dao;

import java.util.List;
import java.util.Map;
import xyz.itwill.dto.Product;

public interface ProductDAO {
    int insertProduct(Product product);
    int updateProduct(Product product);
    int updateProductStatus(int productIdx);  // 삭제 메소드
    Product selectProductByNum(int productIdx);
    int selectProductCount(Map<String, Object> map);
    int updateProductCount(int productIdx);
    List<Product> selectProductList(Map<String, Object> map);
	
}
