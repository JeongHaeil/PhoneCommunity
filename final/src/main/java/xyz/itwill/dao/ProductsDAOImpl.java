package xyz.itwill.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Products;
import xyz.itwill.mapper.ProductsMapper;

@Repository
@RequiredArgsConstructor
public class ProductsDAOImpl implements ProductsDAO{

	private final SqlSession sqlSession;

	@Override
	public List<Products> selectProductById() {
		
		return sqlSession.getMapper(ProductsMapper.class).selectProductById();
	}
	
	
}
