package xyz.itwill.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import xyz.itwill.dto.SecurityAuth;

@Repository
public class SecurityAuthDAOImpl implements SecurityAuthDAO {
    private static final String NAMESPACE = "xyz.itwill.dao.SecurityAuthDAO.";

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<SecurityAuth> selectSecurityAuthByUserid(String userid) {
        return sqlSession.selectList(NAMESPACE + "selectSecurityAuthByUserid", userid);
    }

    @Override
    public int insertSecurityAuth(SecurityAuth securityAuth) {
        return sqlSession.insert(NAMESPACE + "insertSecurityAuth", securityAuth);
    }

    @Override
    public int deleteSecurityAuth(String userid) {
        return sqlSession.delete(NAMESPACE + "deleteSecurityAuth", userid);
    }
}
