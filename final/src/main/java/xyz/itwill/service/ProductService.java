package xyz.itwill.service;

import xyz.itwill.dto.Product;
import java.util.List;
import java.util.Map;

public interface ProductService {
    void addProduct(Product product);
   void modifyProduct(Product product);
   void increaseProductCount(int productIdx);
   Product getProductByNum(int productIdx);
   Map<String, Object> getProductList(Map<String, Object> map);
void updateProductStatus(int productIdx);
int createProductAndChatRoom(Product product);
List<Product> getProductsByUserId(String userId);
}