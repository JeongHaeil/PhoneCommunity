<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자동 로그인 관리</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .container {
            margin-top: 30px;
        }
        .header-title {
            font-weight: bold;
            font-size: 1.5rem;
            margin-bottom: 20px;
        }
        .login-table {
            width: 100%;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-collapse: collapse;
        }
        .login-table th, .login-table td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #dee2e6;
        }
        .login-table th {
            background-color: #f1f1f1;
            font-weight: bold;
        }
        .login-item {
            background-color: #fff;
            margin-bottom: 10px;
        }
        .login-item:hover {
            background-color: #f7f7f7;
        }
        .no-login-message {
            text-align: center;
            padding: 20px;
            font-size: 1rem;
        }
    </style>
</head>
<body>

<div class="container">
 <!-- 탭 include -->
    <jsp:include page="/WEB-INF/views/user/mypageTabs.jsp">
        <jsp:param name="activeTab" value="myRemember-me" />
    </jsp:include>
    <h3 class="header-title">자동 로그인 정보</h3>
    
    <table class="login-table">
        <thead>
            <tr>
                <th>No</th>
                <th>자동 로그인 정보</th>
                <th>등록시점 IP</th>
                <th>등록 시각</th>
                <th>최종 자동로그인</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty loginList}">
                    <tr>
                        <td colspan="5" class="no-login-message">자동 로그인 정보가 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="login" items="${loginList}" varStatus="status">
                        <tr class="login-item">
                            <td>${status.index + 1}</td>
                            <td>${login.loginInfo}</td>
                            <td>${login.ipAddress}</td>
                            <td>${login.registrationTime}</td>
                            <td>${login.lastLoginTime}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
