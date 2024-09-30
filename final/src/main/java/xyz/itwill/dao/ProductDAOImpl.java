package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Product;
import xyz.itwill.mapper.ProductMapper;

@Repository
@RequiredArgsConstructor
public class ProductDAOImpl implements ProductDAO {
	private final SqlSession sqlSession;
	
	@Override
	public int insertProduct(Product product) {
		return sqlSession.getMapper(ProductMapper.class).insertProduct(product);
	}

	@Override
	public int updateProduct(Product product) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteProduct(int productIdx) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Product selectPoridctByNum(int productIdx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int selectProductCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Product> selectProductList(Map<String, Object> map) {
		return sqlSession.getMapper(ProductMapper.class).selectProductList(map);
	}

}
