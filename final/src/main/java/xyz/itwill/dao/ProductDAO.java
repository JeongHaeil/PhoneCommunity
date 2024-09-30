package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.Product;

public interface ProductDAO {
 int insertProduct(Product product);
 int updateProduct(Product product);
 int deleteProduct(int  productIdx);
 Product selectPoridctByNum(int productIdx);
 int selectProductCount(Map<String, Object> map);
 List<Product> selectProductList(Map<String, Object> map);
 
 
}
