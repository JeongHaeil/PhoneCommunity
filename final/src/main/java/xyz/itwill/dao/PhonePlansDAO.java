package xyz.itwill.dao;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.PhonePlans;

public interface PhonePlansDAO {
	List<PhonePlans> selectPhonePlans(Map<String, Object> map );
}
