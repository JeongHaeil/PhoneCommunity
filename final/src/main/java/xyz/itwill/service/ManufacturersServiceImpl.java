package xyz.itwill.service;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.ManufacturersDAO;

@Service
@RequiredArgsConstructor
public class ManufacturersServiceImpl implements ManufacturersService{
	
	private final ManufacturersDAO manufacturersDAO;
	
	@Override
	public int getManufacturersById(int manufacturerId) {
		
		return manufacturersDAO.selectManufacturerById(manufacturerId);
	}

}
