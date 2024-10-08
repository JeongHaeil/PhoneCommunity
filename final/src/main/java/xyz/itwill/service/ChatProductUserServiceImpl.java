package xyz.itwill.service;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.ChatProductUserDAO;
import xyz.itwill.dto.ChatProductUser;

@Service
@RequiredArgsConstructor
public class ChatProductUserServiceImpl implements ChatProductUserService{

	
	private final ChatProductUserDAO chatProductUserDAO;
	
	@Override
	public ChatProductUser getProductAndSellerInfo(int productIdx) {
		
		return chatProductUserDAO.getProductAndSellerInfo(productIdx);
	}

}
