package xyz.itwill.service;

import java.util.List;
import xyz.itwill.dto.SecurityAuth;

public interface SecurityAuthService {
    List<SecurityAuth> getSecurityAuthByUserid(String userid);
    void addSecurityAuth(SecurityAuth securityAuth);
    void removeSecurityAuth(String userid);
}
