<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>EOMISAE</title>
    <style>
        .navbar { background-color: #343a40; padding: 0 20px; }
        .navbar-brand, .nav-link { color: #fff !important; }
        .btn-login { background-color: #f05d5e; color: #fff; }
        .card { margin-bottom: 20px; }
        .card-header { background-color: #f8f9fa; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="#">EOMISAE</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon" style="background-color: #fff;"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item"><a class="nav-link" href="#">자유게시판</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">질문답변</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">요금제비교</a></li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/product/product'/>">중고장터</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">플리마켓</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">서비스</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">운영관리</a></li>
                </ul>
                <div class="login-container" id="loginContainer">
                    <button class="btn btn-login" type="button" id="loginButton" >
                        로그인
                    </button>
                    <div class="login-form" id="loginForm">
                        <form class="px-4 py-3">
                            <div class="form-group">
                                <label for="exampleDropdownFormEmail1">이메일 주소</label>
                                <input type="email" class="form-control" id="exampleDropdownFormEmail1" placeholder="email@example.com">
                            </div>
                            <div class="form-group">
                                <label for="exampleDropdownFormPassword1">비밀번호</label>
                                <input type="password" class="form-control" id="exampleDropdownFormPassword1" placeholder="비밀번호">
                            </div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="dropdownCheck">
                                <label class="form-check-label" for="dropdownCheck">
                                    로그인 상태 유지
                                </label>
                            </div>
                            <button type="submit" class="btn btn-primary">로그인</button>
                        </form>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">새 계정 만들기</a>
                        <a class="dropdown-item" href="#">비밀번호를 잊으셨나요?</a>
                    </div>
                </div>
                <style>
                    .login-container {
                        position: relative;
                    }
                    .login-form {
                        display: none;
                        position: absolute;
                        right: 0;
                        background-color: #f9f9f9;
                        min-width: 300px;
                        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                        z-index: 1;
                    }
                    .login-container:hover .login-form {
                        display: block;
                    }
                </style>
            </div>
        </div>
    </nav>
   

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>