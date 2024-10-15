<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // 전달받은 작성자의 레벨과 역할 정보
    Integer userLevel = (Integer) request.getAttribute("userLevel");
    String userRole = (String) request.getAttribute("userRole");

    // userLevel이 null일 경우 기본값 설정 (예: 1로 설정)
    if (userLevel == null) {
        userLevel = 1;
    }

    // 권한에 따른 아이콘 우선 적용
    String iconPath; // 아이콘 경로를 선언
    if ("ROLE_SUPER_ADMIN".equals(userRole)) {
        iconPath = request.getContextPath() + "/resources/images/crown.png"; // 최고 관리자
    } else if ("ROLE_BOARD_ADMIN".equals(userRole)) {
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
        } else if (userLevel == 20) {
            iconPath = request.getContextPath() + "/resources/images/diamond.png"; // 다이아몬드 아이콘
        } else {
            iconPath = request.getContextPath() + "/resources/images/default.png"; // 기본 아이콘 추가
        }
    }
%>

<!-- 유저의 아이콘을 표시하는 부분 -->
<img src="<%= iconPath %>" alt="User Badge" style="width: 1em; height: auto; vertical-align: middle;" />
