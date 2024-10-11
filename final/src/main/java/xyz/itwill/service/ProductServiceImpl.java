package xyz.itwill.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.ProductDAO;
import xyz.itwill.dto.Product;
import xyz.itwill.util.Pager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {
    private final ProductDAO productDAO;

    @Transactional
    @Override
    public void addProduct(Product product) {
        productDAO.insertProduct(product);
    }

    @Transactional
	@Override
	public void modifyProduct(Product product) {
		productDAO.updateProduct(product);
		
	}
     
    @Transactional
	@Override
	public void removeProduct(int productIdx) {
		productDAO.deleteProduct(productIdx);
		
	}

    @Transactional
	@Override
	public Product getProductByNum(int productIdx) {
		Product product = productDAO.selectPoridctByNum(productIdx);
		return product;
	}

    @Transactional    
	@Override
	public Map<String, Object> getProductList(Map<String, Object> map) {
    	int pageNum=1;
		if(map.get("pageNum") != null && !map.get("pageNum").equals("")) {
			pageNum=Integer.parseInt((String)map.get("pageNum"));
		}
		
		int pageSize=12;
		if(map.get("pageSize") != null && !map.get("pageSize").equals("")) {
			pageSize=Integer.parseInt((String)map.get("pageSize"));
		}
		 
		int totalBoard=productDAO.selectProductCount(map);
		
		int blockSize=5;
		
		Pager pager=new Pager(pageNum, pageSize, totalBoard, blockSize);
		
		map.put("startRow", pager.getStartRow());
		map.put("endRow", pager.getEndRow());
		List<Product>productList =productDAO.selectProductList(map);
		
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("pager", pager);
		result.put("productList", productList);
		
		return result;
	}

    @Override
    @Transactional
    public void increaseProductCount(int productIdx) {
        productDAO.updateProductCount(productIdx);
    }

	
 
}
