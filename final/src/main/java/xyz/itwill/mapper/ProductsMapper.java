package xyz.itwill.mapper;

import java.util.List;

import xyz.itwill.dto.Products;

public interface ProductsMapper {
	List<Products> selectProductById();
}
