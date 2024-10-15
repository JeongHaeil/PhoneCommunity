
package xyz.itwill.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.ChatRoomsDAO;
import xyz.itwill.dao.ProductDAO;
import xyz.itwill.dto.ChatRooms;
import xyz.itwill.dto.Product;
import xyz.itwill.mapper.ChatRoomsMapper;
import xyz.itwill.mapper.ProductMapper;
import xyz.itwill.util.Pager;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {
    private final ProductDAO productDAO;
    private final ChatRoomsDAO chatRoomsDAO;
    
    

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
    public Product getProductByNum(int productIdx) {
        return productDAO.selectProductByNum(productIdx);
    }

    @Transactional
    @Override
    public Map<String, Object> getProductList(Map<String, Object> map) {
        int pageNum = 1;
        if (map.get("pageNum") != null && !map.get("pageNum").equals("")) {
            pageNum = Integer.parseInt((String) map.get("pageNum"));
        }
        int pageSize = 12;
        if (map.get("pageSize") != null && !map.get("pageSize").equals("")) {
            pageSize = Integer.parseInt((String) map.get("pageSize"));
        }

        // 검색어 필터링 로직 추가
        String keyword = (String) map.get("keyword");
        String column = (String) map.get("column");

        if (keyword != null && !keyword.isEmpty()) {
            map.put("keyword", keyword); // 검색어가 있을 때만 추가
            map.put("column", column);
        }

        // 페이징 및 검색된 총 데이터 수 계산
        int totalBoard = productDAO.selectProductCount(map);
        int blockSize = 5;
        Pager pager = new Pager(pageNum, pageSize, totalBoard, blockSize);
        map.put("startRow", pager.getStartRow());
        map.put("endRow", pager.getEndRow());

        // 검색어에 맞는 상품 목록 조회
        List<Product> productList = productDAO.selectProductList(map);

        // 결과를 담은 Map 반환
        Map<String, Object> result = new HashMap<>();
        result.put("pager", pager);
        result.put("productList", productList);

        return result;
    }


    @Override
    @Transactional
    public void increaseProductCount(int productIdx) {
        productDAO.updateProductCount(productIdx);
    }


	@Override
	public void updateProductStatus(int productIdx) {
	productDAO.updateProductStatus(productIdx);
		
	}

	
	 @Override
	    public int createProductAndChatRoom(Product product) {
	        // 1. 상품 등록 (productIdx 자동 생성)
	        productDAO.insertProduct(product); // 상품 등록
	        int productIdx = product.getProductIdx();  // 생성된 productIdx 가져오기

	        // 2. 채팅방 생성, roomId를 productIdx로 설정
	        ChatRooms chatRoom = new ChatRooms();
	        chatRoom.setRoomId(productIdx);  // roomId를 productIdx와 동일하게 설정
	        chatRoom.setProductIdx(productIdx);  // 상품과 연동
	        chatRoom.setBuyerId(null);  // 아직 구매자가 없음
	        chatRoom.setSellerId(product.getProductUserid());  // 판매자 정보 추가
	        chatRoomsDAO.createChatRooms(chatRoom);  // 채팅방 생성

	        return productIdx;  // 생성된 productIdx 반환
	    }
	
}
