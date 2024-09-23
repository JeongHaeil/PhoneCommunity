package xyz.itwill.dto;

import lombok.Data;

@Data
public class User {
	private int userNum;
    private String userId;
    private String userPassword;
    private String userEmail;
    private String userPhoneNumber;
    private String userName;
    private String userUpdateDate;
    private String userLastLogin;
    private String userRegisterDate;
    private int userAuth;
    private int userLevel;
    private int userStatus;
    private String userNickName;
}
