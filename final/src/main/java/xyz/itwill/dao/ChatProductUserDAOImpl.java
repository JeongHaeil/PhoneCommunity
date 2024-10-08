package xyz.itwill.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.ChatProductUser;
import xyz.itwill.mapper.ChatProductUserMapper;

@RequiredArgsConstructor
@Repository
public class ChatProductUserDAOImpl implements ChatProductUserDAO{
	
	private final SqlSession sqlSession;
	
	
	
	public ChatProductUser getProductAndSellerInfo(int productIdx) {
		
		/*
		 return
		  sqlSession.getMapper(ChatProductUserMapper.class).getProductAndSellerInfo(
		 productIdx);
		 */
		
		 return sqlSession.selectOne("getProductAndSellerInfo", productIdx);
	}

}
