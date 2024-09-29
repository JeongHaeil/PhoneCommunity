package xyz.itwill.dao;

import java.util.List;

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
    public List<Carriers> selectCarriersById() {
        
        return sqlSession.getMapper(CarriersMapper.class).selectCarriersById();
    }
}
