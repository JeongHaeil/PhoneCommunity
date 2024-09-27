package xyz.itwill.service;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.CarriersDAO;

@Service
@RequiredArgsConstructor
public class CarriersServiceImpl implements CarriersService{
	private final CarriersDAO carriersDAO;
	
	@Override
	public int getCarriersById(int carrierId) {
		
		return carriersDAO.selectCarriersById(carrierId);
	}

}
