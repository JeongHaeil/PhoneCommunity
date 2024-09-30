package xyz.itwill.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.ProductDAO;
import xyz.itwill.dto.Product;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {
    private final ProductDAO productDAO;

    @Transactional
    @Override
    public void addProduct(Product product) {
        productDAO.insertProduct(product);
    }

    @Override
    public List<Product> getProductList() {
        return productDAO.selectProductList(null); // 모든 상품 가져오기
    }
}
