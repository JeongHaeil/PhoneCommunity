package xyz.itwill.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Email;

@Repository
@RequiredArgsConstructor
public class EmailDAOImpl implements EmailDAO {
    private final SqlSession sqlSession;

    @Override
    public void insertEmail(Email email) {
        sqlSession.insert("xyz.itwill09.mapper.EmailMapper.insertEmail", email);
    }

    @Override
    public Email selectEmailByCode(int emailCode) {
        return sqlSession.selectOne("xyz.itwill09.mapper.EmailMapper.selectEmailByCode", emailCode);
    }

    @Override
    public void updateEmail(Email email) {
        sqlSession.update("xyz.itwill09.mapper.EmailMapper.updateEmail", email);  // 이메일 인증 정보 업데이트
    }
}
