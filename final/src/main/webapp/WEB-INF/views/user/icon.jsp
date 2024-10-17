<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Badge Display</title>
</head>
<body>

<%
    // 유저의 레벨과 여러 권한을 세션에서 가져옴
    Integer userLevel = (Integer) session.getAttribute("userLevel"); // 유저의 레벨
    String[] userRoles = (String[]) session.getAttribute("roleNames"); // 유저의 권한 배열


    // userLevel이 null일 경우 기본값 설정 (예: 1로 설정)
    if (userLevel == null) {
        userLevel = 1;
    }

    // 유저 권한을 배열로 받아서 최고 관리자, 게시판 관리자 우선으로 체크
    boolean isSuperAdmin = false;
    boolean isBoardAdmin = false;

    if (userRoles != null) {
        for (String role : userRoles) {
            if ("ROLE_SUPER_ADMIN".equals(role)) {
                isSuperAdmin = true;
                break; // 최고 관리자면 바로 나감
            } else if ("ROLE_BOARD_ADMIN".equals(role)) {
                isBoardAdmin = true;
            }
        }
    }

    // 권한에 따른 아이콘 우선 적용
    String iconPath; // 아이콘 경로를 선언
    if (isSuperAdmin) {
        iconPath = request.getContextPath() + "/resources/images/crown.png"; // 최고 관리자
    } else if (isBoardAdmin) {
        iconPath = request.getContextPath() + "/resources/images/rainbow.png"; // 게시판 관리자
    } else {
        // 유저의 레벨에 따른 아이콘 선택 (관리자가 아닌 경우)
        if (userLevel >= 1 && userLevel <= 5) {
            iconPath = request.getContextPath() + "/resources/images/bronze.png";
        } else if (userLevel >= 6 && userLevel <= 10) {
            iconPath = request.getContextPath() + "/resources/images/silver.png";
        } else if (userLevel >= 11 && userLevel <= 15) {
            iconPath = request.getContextPath() + "/resources/images/gold.png";
        } else if (userLevel >= 16 && userLevel <= 19) {
            iconPath = request.getContextPath() + "/resources/images/emerald.png";
        } else if (userLevel >= 20) {
            iconPath = request.getContextPath() + "/resources/images/diamond.png"; // 다이아몬드 아이콘
        } else {
            iconPath = request.getContextPath() + "/resources/images/default.png"; // 기본 아이콘 추가
        }
    }
%>

<!-- 유저의 아이콘을 표시하는 부분 -->
<img src="<%= iconPath %>" alt="User Badge" style="width: 1em; height: auto; vertical-align: middle;" />
</body>
</html>
