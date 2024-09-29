package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;


import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.PhonePlans;
import xyz.itwill.mapper.PhonePlansMapper;

@Repository
@RequiredArgsConstructor
public class PhonePlansDAOImpl implements PhonePlansDAO{
	
	private final SqlSession sqlSession;
	
	@Override
	public List<PhonePlans> selectPhonePlans(Map<String, Object> map) {
		
		return sqlSession.getMapper(PhonePlansMapper.class).selectPhonePlans(map);
	}

}
