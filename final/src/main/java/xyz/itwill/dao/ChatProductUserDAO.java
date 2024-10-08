package xyz.itwill.dao;

import xyz.itwill.dto.ChatProductUser;

public interface ChatProductUserDAO {
	ChatProductUser getProductAndSellerInfo(int productIdx);
}

