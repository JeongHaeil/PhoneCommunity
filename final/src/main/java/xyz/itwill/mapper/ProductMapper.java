package xyz.itwill.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import xyz.itwill.dto.Product;

public interface ProductMapper {
	int insertProduct(Product product);
	int updateProduct(Product product);
	int updateProductStatus(int productIdx);
	Product selectProductByNum(int productIdx);
	int selectProductCount(Map<String, Object> map);
	List<Product> selectProductList(Map<String, Object> map);
	int updateProductCount(int productIdx);
	int updateProductSoldStatus(@Param("productIdx") int productIdx, @Param("status") int status);
	List<Product> selectProductsByUserId(String userId);//마이페이지
	List<Product> selectLatestProducts();
    List<Product> selectLatestCountProducts();


}