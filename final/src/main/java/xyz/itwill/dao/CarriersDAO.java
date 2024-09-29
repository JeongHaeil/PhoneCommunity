package xyz.itwill.dao;

import java.util.List;

import xyz.itwill.dto.Carriers;

public interface CarriersDAO {
	List<Carriers> selectCarriersById();
}
