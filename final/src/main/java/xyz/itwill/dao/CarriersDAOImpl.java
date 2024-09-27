package xyz.itwill.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import lombok.RequiredArgsConstructor;
import xyz.itwill.dto.Carriers;
import xyz.itwill.mapper.CarriersMapper;

@Repository
@RequiredArgsConstructor
public class CarriersDAOImpl implements CarriersDAO {

    private final SqlSession sqlSession;

    @Override
    public int selectCarriersById(int carrierId) {
        // Mapper를 통해 DB에서 통신사 정보 조회
        return sqlSession.getMapper(CarriersMapper.class).selectCarriersById(carrierId);
    }
}
