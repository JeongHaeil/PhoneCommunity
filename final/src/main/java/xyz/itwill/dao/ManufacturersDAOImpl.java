package xyz.itwill.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Manufacturers;
import xyz.itwill.mapper.ManufacturersMapper;

@Repository
@RequiredArgsConstructor
public class ManufacturersDAOImpl implements ManufacturersDAO{
	private final SqlSession sqlSession;
	@Override
	public int selectManufacturerById(int manufacturersId) {
		
		return sqlSession.getMapper(ManufacturersMapper.class).selectManufacturerById(manufacturersId);
	}

}
