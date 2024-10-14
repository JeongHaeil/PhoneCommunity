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

        .btn-login-custom {
            background-color: #f86d6d;
            color: white;
            border-radius: 20px;
            width: 100%;
            padding: 10px;
            margin-top: 15px;
        }
        .btn-login-custom:hover {
            background-color: #f75c5c;
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
        .remember-me-custom {
            font-size: 0.9em;
        }
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
        .register-link-custom {
            color: #f86d6d;
            font-weight: bold;
        }
        .register-link-custom:hover {
            text-decoration: underline;
        }

        /* 로그인 실패 메시지 스타일 */
        .alert-custom {
            color: red;
            margin-bottom: 20px;
            text-align: center; /* 가운데 정렬 */
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

                <!-- 로그인 실패 시 메시지 출력 (가운데 정렬 및 줄 바꿈 적용) -->
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

            <!-- 오류 메시지가 여기에 나타날 부분 -->
            <div id="error-message" class="alert-custom"></div>

            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="rememberMe" name="remember-me">
                    <label class="form-check-label remember-me-custom" for="rememberMe">로그인 상태 유지</label>
                </div>
            </div>
            <div class="find-links-custom">
                <a href="${pageContext.request.contextPath}/user/idfind">아이디 찾기</a>
                <a href="${pageContext.request.contextPath}/user/passwordfind">비밀번호 찾기</a>
            </div>
            <button type="submit" class="btn btn-login-custom">로그인</button>
        </form>
        
			<a href="<c:url value="/naver/login"/>">
				<img alt="네이버 로그인" src="<c:url value="/resources/images/btnW_naver.png"/>" style="width: 340px; height: 60px;">
			</a>	

        <div class="text-center mt-3">
            <p>아직 회원이 아니신가요? <a href="${pageContext.request.contextPath}/user/terms" class="register-link-custom">회원가입 하기</a></p>
        </div>
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
            document.getElementById("userId").focus(); // 아이디 필드에 포커스
            return false; // 로그인 폼 제출 중단
        }
        
        if (password === "") {
            errorMessage.innerHTML = "비밀번호를 입력해주세요.";
            document.getElementById("password").focus(); // 비밀번호 필드에 포커스
            return false; // 로그인 폼 제출 중단
        }

        return true; // 모든 조건 만족 시 폼 제출
    }
</script>

</body>
</html>
