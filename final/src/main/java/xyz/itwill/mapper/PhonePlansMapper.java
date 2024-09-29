package xyz.itwill.mapper;

import java.util.List;
import java.util.Map;

import xyz.itwill.dto.PhonePlans;

public interface PhonePlansMapper {
	  List<PhonePlans> selectPhonePlans(Map<String, Object> map ); 
}
