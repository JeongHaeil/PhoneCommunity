package xyz.itwill.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import xyz.itwill.dao.SecurityAuthDAO;
import xyz.itwill.dto.SecurityAuth;

@Service
public class SecurityAuthServiceImpl implements SecurityAuthService {
    
    @Autowired
    private SecurityAuthDAO securityAuthDAO;

    @Override
    public List<SecurityAuth> getSecurityAuthByUserid(String userid) {
        return securityAuthDAO.selectSecurityAuthByUserid(userid);
    }

    @Override
    @Transactional
    public void addSecurityAuth(SecurityAuth securityAuth) {
        securityAuthDAO.insertSecurityAuth(securityAuth);
    }

    @Override
    @Transactional
    public void removeSecurityAuth(String userid) {
        securityAuthDAO.deleteSecurityAuth(userid);
    }
}
