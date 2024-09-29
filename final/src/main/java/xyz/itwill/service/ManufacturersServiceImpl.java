package xyz.itwill.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.ManufacturersDAO;
import xyz.itwill.dto.Manufacturers;

@Service
@RequiredArgsConstructor
public class ManufacturersServiceImpl implements ManufacturersService{
	
	private final ManufacturersDAO manufacturersDAO;
	
	@Override
	public List<Manufacturers> getManufacturersById() {
		
		return manufacturersDAO.selectManufacturerById();
	}

}
