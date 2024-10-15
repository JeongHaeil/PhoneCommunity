<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .login-container-custom {
            max-width: 400px;
            margin: 0 auto;
            padding-top: 80px;
        }
        .login-box-custom {
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h4 {
            margin-bottom: 30px;
            font-weight: bold;
            color: #333;
        }

        .form-floating-custom {
            position: relative;
            margin-bottom: 1rem;
        }
        
        .form-floating-custom input {
            border: none;
            border-bottom: 2px solid #ddd;
            border-radius: 0;
            box-shadow: none;
            padding: 10px 10px 10px 5px;
            width: 100%;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-floating-custom input:focus {
            border-bottom: 2px solid #007bff;
            outline: none;
            box-shadow: none;
        }

        .form-floating-custom label {
            position: absolute;
            top: 10px;
            left: 5px;
            font-size: 1rem;
            color: #999;
            pointer-events: none;
            transition: 0.3s ease all;
        }

        .form-floating-custom input:focus ~ label,
        .form-floating-custom input:not(:placeholder-shown) ~ label {
            top: -15px;
            font-size: 0.85rem;
            color: #007bff;
        }

        .underline-effect-custom {
            position: relative;
            overflow: hidden;
        }

        .underline-effect-custom::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 2px;
            background-color: #007bff;
            transition: width 0.3s ease, left 0.3s ease;
        }

        .form-floating-custom input:focus ~ .underline-effect-custom::after {
            width: 100%;
            left: 0;
        }

        /* 로그인 버튼 스타일 */
        .btn-login-custom {
            background-color: #f86d6d;
            color: white;
            border-radius: 30px;
            font-weight: bold;
            width: 100%;
            padding: 10px;
            font-size: 18px;
            margin-top: 15px;
            text-align: center;
            border: none;
        }

        .btn-login-custom:hover {
            background-color: #f75c5c;
        }

        /* 네이버 로그인 버튼 스타일 */
        .naver-login-btn {
            background-color: #03C75A;
            color: white;
            font-weight: bold;
            text-align: center;
            border-radius: 30px;
            padding: 10px;
            font-size: 18px;
            display: block;
            text-decoration: none;
            margin-top: 10px;
            width: 100%;
            position: relative;
            border: none;
        }

        .naver-login-btn img {
            width: 20px;
            height: 20px;
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
        }

        .naver-login-btn:hover {
            background-color: #02b153;
        }

        .divider-custom {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 30px 0;
        }
        .divider-custom::before,
        .divider-custom::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #ddd;
        }
        .divider-custom::before {
            margin-right: .5em;
        }
        .divider-custom::after {
            margin-left: .5em;
        }

        /* 아이디 찾기와 비밀번호 찾기 좌우 배치 */
        .find-links-custom {
            font-size: 0.9em;
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }
        .find-links-custom a {
            text-decoration: none;
            color: #555;
        }
        .find-links-custom a:hover {
            text-decoration: underline;
            color: #333;
        }

       .register-container {
            margin-top: 15px;
            text-align: center;
        }

        .register-container a {
            color: red;
            text-decoration: underline;
            font-weight: bold;
        }

        /* 로그인 실패 메시지 스타일 */
        .alert-custom {
            color: red;
            margin-bottom: 20px;
            text-align: center;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<div class="login-container-custom">
    <div class="login-box-custom">
        <h4 class="text-center">로그인</h4>

        <form id="loginForm" action="${pageContext.request.contextPath}/user/login" method="post" onsubmit="return validateForm();">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            
            <!-- 아이디 입력 필드 -->
            <div class="form-floating-custom">
                <input type="text" class="form-control" id="userId" name="userid" placeholder=" " autofocus>
                <label for="userId">아이디</label>
                <div class="underline-effect-custom"></div>
            </div>

            <!-- 비밀번호 입력 필드 -->
            <div class="form-floating-custom">
                <input type="password" class="form-control" id="password" name="passwd" placeholder=" ">
                <label for="password">비밀번호</label>
                <div class="underline-effect-custom"></div>

                <!-- 로그인 실패 시 메시지 출력 -->
                <c:if test="${not empty sessionScope.loginError}">
                    <div class="alert-custom">
                        ${sessionScope.loginError}
                    </div>
                    <%
                        // 메시지를 한 번 표시한 후 세션에서 제거
                        session.removeAttribute("loginError");
                    %>
                </c:if>
            </div>

            <!-- 오류 메시지 영역 -->
            <div id="error-message" class="alert-custom"></div>

            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="rememberMe" name="remember-me">
                   <label class="form-check-label remember-me-custom" for="rememberMe">로그인 상태 유지</label>
                </div>
            </div>
            
            <!-- 아이디 찾기와 비밀번호 찾기 좌우 배치 -->
            <div class="find-links-custom">
                <a href="${pageContext.request.contextPath}/user/idfind">아이디 찾기</a>
                <a href="${pageContext.request.contextPath}/user/passwordfind">비밀번호 찾기</a>
            </div>

            <!-- 로그인 버튼 -->
            <button type="submit" class="btn-login-custom">로그인</button>

            <div class="register-container">
            아직 회원이 아니신가요? <a href="${pageContext.request.contextPath}/user/terms">회원가입 하기</a>
        </div>

        <!-- 네이버 로그인 버튼 -->
        <div class="divider-custom">또는</div>
        <a href="<c:url value='/naver/login'/>" class="naver-login-btn">N</a>
    </div>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- JavaScript validation function -->
<script>
    function validateForm() {
        var userId = document.getElementById("userId").value.trim();
        var password = document.getElementById("password").value.trim();
        var errorMessage = document.getElementById("error-message");

        // 오류 메시지 초기화
        errorMessage.innerHTML = "";

        if (userId === "") {
            errorMessage.innerHTML = "아이디를 입력해주세요.";
            document.getElementById("userId").focus();
            return false;
        }
        
        if (password === "") {
            errorMessage.innerHTML = "비밀번호를 입력해주세요.";
            document.getElementById("password").focus();
            return false;
        }

        return true;
    }
</script>

</body>
</html>
