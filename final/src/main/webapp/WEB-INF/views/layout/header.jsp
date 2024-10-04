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
        .btn-login, .btn-logout { background-color: #f05d5e !important; color: #fff !important; }
        .btn-login:hover, .btn-logout:hover { background-color: #f75c5c !important; }
        .dropdown-menu { width: 300px; padding: 20px; }
        .dropdown-menu .user-info h4 { font-weight: bold; }
        .dropdown-menu .progress-bar { background-color: #f86d6d; }
        .dropdown-menu .menu-list a { display: flex; align-items: center; padding: 10px; text-decoration: none; color: #333; }
        .dropdown-menu .menu-list a:hover { background-color: #f1f1f1; }
        .dropdown-menu .logout-section { text-align: center; margin-top: 10px; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="/final">EOMISAE</a>
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

                <div class="dropdown">
                    <c:choose>
                        <c:when test="${not empty pageContext.request.userPrincipal}">
                            <!-- 드롭다운 버튼 -->
                            <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                                <sec:authentication property="principal.nickname"/> 님
                            </a>
                            <!-- 드롭다운 메뉴 -->
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuLink">
                                <li class="user-info text-center">
                                    <!-- 로그인한 회원의 닉네임과 이메일 -->
                                    <h4><sec:authentication property="principal.nickname"/></h4>
                                    <p class="email"><sec:authentication property="principal.userEmail"/></p>
                                </li>
                                <li>
                                    <!-- 로그인한 회원의 레벨 표시 -->
                                    <div class="level-bar text-center mt-2">
                                        <p>Level. <sec:authentication property="principal.userLevel"/></p>
                                        <div class="progress">
                                            <div class="progress-bar" role="progressbar" style="width: 75%;" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                        <p class="level-text mt-2">135/180 P (75%)</p>
                                    </div>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li class="menu-list">
                                    <a class="dropdown-item" href="<c:url value='/user/profile'/>"><i class="bi bi-person"></i> 마이페이지</a>
                                    <a class="dropdown-item" href="#"><i class="bi bi-bookmark"></i> 스크랩</a>
                                    <a class="dropdown-item" href="#"><i class="bi bi-pencil-square"></i> 작성글</a>
                                    <a class="dropdown-item" href="#"><i class="bi bi-chat-dots"></i> 작성 댓글</a>
                                    <a class="dropdown-item" href="#"><i class="bi bi-envelope"></i> 쪽지함</a>
                                    <a class="dropdown-item" href="#"><i class="bi bi-moon"></i> 다크모드</a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li class="logout-section">
                                    <form action="<c:url value='/logout'/>" method="post" style="display:inline;">
                                        <sec:csrfInput/>
                                        <button type="submit" class="btn btn-logout">로그아웃</button>
                                    </form>
                                </li>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <a class="btn btn-login" id="loginButton" href ="<c:url value='/user/login'/>">로그인</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
