package xyz.itwill.dao;

import java.util.List;

import xyz.itwill.dto.Products;

public interface ProductsDAO {
	

	List<Products> selectProductById();
}
