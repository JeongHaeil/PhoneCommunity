package xyz.itwill.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.CarriersDAO;
import xyz.itwill.dto.Carriers;

@Service
@RequiredArgsConstructor
public class CarriersServiceImpl implements CarriersService{
	private final CarriersDAO carriersDAO;
	
	@Override
	public List<Carriers> getCarriersById() {
		
		return carriersDAO.selectCarriersById();
	}

}
