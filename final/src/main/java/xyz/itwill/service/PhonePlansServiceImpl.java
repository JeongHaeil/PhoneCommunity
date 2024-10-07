package xyz.itwill.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import xyz.itwill.dao.PhonePlansDAO;
import xyz.itwill.dto.PhonePlans;

@Service
@RequiredArgsConstructor
public class PhonePlansServiceImpl implements PhonePlansService{

	private final PhonePlansDAO phonePlansDAO;
	
	@Override
	public List<PhonePlans> selectPhonePlans(Map<String, Object> map) {
		
		return phonePlansDAO.selectPhonePlans(map);
	}

}
