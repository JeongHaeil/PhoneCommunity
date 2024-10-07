package xyz.itwill.service;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.PhonePlans;

public interface PhonePlansService {
	List<PhonePlans> selectPhonePlans(Map<String, Object> map );
}
