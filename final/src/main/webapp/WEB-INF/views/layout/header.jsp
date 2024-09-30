<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 부트스트랩 5.3 CSS 링크 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>EOMISAE</title>
    <style>
        .navbar { background-color: #343a40; padding: 0 20px; }
        .navbar-brand, .nav-link { color: #fff !important; }
        .btn-login { background-color: #f05d5e !important; color: #fff !important; }
        .card { margin-bottom: 20px; }
        .card-header { background-color: #f8f9fa; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">EOMISAE</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/board/boardlist/10'/>">자유게시판</a></li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/board/boardlist/11'/>">질문답변</a></li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/phone/phone'/>">요금제비교</a></li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/product/product'/>">중고장터</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">플리마켓</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">서비스</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">운영관리</a></li>
                </ul>
				<div class="login-container position-relative" id="loginContainer">
				    <c:choose>
				        <c:when test="${not empty pageContext.request.userPrincipal}">
				            <span style="color: white;"> <sec:authentication property="principal.nickname"/> 님</span>
				            <!-- 로그아웃을 POST 방식으로 처리 -->
				           	 <sec:authorize access="isAuthenticated()">
				            <form action="<c:url value='/user/logout'/>" method="post" style="display:inline;">
                                
                                <sec:csrfInput/>
                              <!-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/-->
                                <button type="submit" class="btn btn-link">로그아웃</button>
                            
                            </form>
                            </sec:authorize>
				        </c:when>
				        <c:otherwise>
				            <a class="btn btn-login" id="loginButton" href ="<c:url value='/user/login'/>">로그인</a>
				        </c:otherwise>
				    </c:choose>
				</div>
            </div>
        </div>
    </nav>
</body>
</html>
