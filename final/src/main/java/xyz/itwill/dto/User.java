package xyz.itwill.dto;

import lombok.Data;

@Data
public class User {
	private int userNum;
    private String userId;
    private String userPassword;
    private String userEmail;
    private String userPhoneNum;
    private String userName;
    private String userUpdateDate;
    private String userLastLogin;
    private String userRegisterDate;
    private int userLevel =1;
    private int userStatus =1;
    private String userNickName;
}
