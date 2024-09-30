package xyz.itwill.mapper;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.Product;

public interface ProductMapper {
	int insertProduct(Product product);

	List<Product> selectProductList(Map<String, Object> map);

}
