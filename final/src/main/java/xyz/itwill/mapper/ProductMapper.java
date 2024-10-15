package xyz.itwill.mapper;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.Product;

public interface ProductMapper {
	int insertProduct(Product product);
	int updateProduct(Product product);
	int updateProductStatus(int productIdx);
	Product selectProductByNum(int productIdx);
	int selectProductCount(Map<String, Object> map);
	List<Product> selectProductList(Map<String, Object> map);
	int updateProductCount(int productIdx);
	

}