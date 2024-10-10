package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Admin;
import xyz.itwill.mapper.AdminMapper;

@Repository
@RequiredArgsConstructor
public class AdminDAOImpl implements AdminDAO {

	private final SqlSession sqlSession;

	@Override
	public List<Admin> selectSpamBoardList(Map<String, Object> map) {
		return sqlSession.getMapper(AdminMapper.class).selectSpamBoardList(map);
	}

	@Override
	public Admin selectSpamBoardByNum(int num) {
		return sqlSession.getMapper(AdminMapper.class).selectSpamBoardByNum(num);
	}

	@Override
	public int selectSpamBoardCount(Map<String, Object> map) {
		return sqlSession.getMapper(AdminMapper.class).selectSpamBoardCount(map);
	}

	@Override
	public Admin updateUserStatusByUserId(Map<String, Object> map) {
		return sqlSession.getMapper(AdminMapper.class).updateUserStatusByUserId(map);
	}

	@Override
	public Admin updateBoardStatusByBoardId(Map<String, Object> map) {
		return sqlSession.getMapper(AdminMapper.class).updateBoardStatusByBoardPostIdx(map);
	}


	
}
