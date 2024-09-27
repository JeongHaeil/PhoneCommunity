package xyz.itwill.service;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.ProductsDAO;

@Service
@RequiredArgsConstructor
public class ProductsServiceImpl implements ProductsService{

	private final ProductsDAO productsDAO;
	
	@Override
	public int getPhoneProducts(int productId) {
		
		return productsDAO.selectProductById(productId);
	}

}
