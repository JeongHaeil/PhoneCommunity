package xyz.itwill.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.ProductsDAO;
import xyz.itwill.dto.Products;

@Service
@RequiredArgsConstructor
public class ProductsServiceImpl implements ProductsService{

	private final ProductsDAO productsDAO;
	
	@Override
	public List<Products> getPhoneProducts() {
		
		return productsDAO.selectProductById();
	}

}
