<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <style>
    .admin-container {
        display: flex;
        flex-direction: column;
        height: 110vh;
        
    }
    .admin-title {
        text-align: center;
        padding: 20px 0;
    }
    .admin-buttons {
        display: flex;
        flex: 1;
    }
    .admin-button {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;
        text-decoration: none;
        color: white;
        font-size: 1.2em;
        font-weight: bold;
        transition: background-color 0.3s;
    }
    .admin-button:nth-child(1) { background-color: #f05d5e; }
    .admin-button:nth-child(2) { background-color: #343a40; }
    .admin-button:nth-child(3) { background-color: #3C3D37 ; }
    .admin-button:hover { opacity: 0.8; }
</style>
</head>
<body>
<div class="admin-container">
    <h2 class="admin-title">관리 구역</h2>
    <div class="admin-buttons">
        <a href="<c:url value='/super_admin/userList'/>" class="admin-button">회원 관리</a>
        <a href="<c:url value='/super_admin/admin'/>" class="admin-button">블라인드 게시글</a>
        <a href="<c:url value='/board/boardlist/3'/>" class="admin-button">건의 게시글</a>
    </div>
</div>
</body>
</html>