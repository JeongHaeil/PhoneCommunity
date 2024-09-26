<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 부트스트랩 5.3 CSS 링크 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
                    <li class="nav-item"><a class="nav-link" href="#">요금제비교</a></li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/product/product'/>">중고장터</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">플리마켓</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">서비스</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">운영관리</a></li>
                </ul>
                <div class="login-container position-relative" id="loginContainer">
                    <a class="btn btn-login" id="loginButton" href ="<c:url value='/user/login'/>">로그인</a>
                    <div class="login-form position-absolute bg-light p-3 shadow" id="loginForm" style="display: none;">
                        <form>
                            <div class="mb-3">
                                <label for="email" class="form-label">이메일 주소</label>
                                <input type="email" class="form-control" id="email" placeholder="email@example.com">
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">비밀번호</label>
                                <input type="password" class="form-control" id="password" placeholder="비밀번호">
                            </div>
                            <div class="form-check mb-3">
                                <input type="checkbox" class="form-check-input" id="dropdownCheck">
                                <label class="form-check-label" for="dropdownCheck">로그인 상태 유지</label>
                            </div>
                            <button type="submit" class="btn btn-primary">로그인</button>
                        </form>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">새 계정 만들기</a>
                        <a class="dropdown-item" href="#">비밀번호를 잊으셨나요?</a>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <style>
        .login-container:hover .login-form {
            display: block !important;
        }
    </style>

    <!-- 부트스트랩 5.3 JS 링크 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
     
</body>
</html>
