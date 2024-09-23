<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .login-container {
            max-width: 380px;
            margin: 0 auto;
            padding-top: 80px;
        }
        .login-box {
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

        .form-floating {
            position: relative;
            margin-bottom: 1rem;
        }
        
        .form-floating input {
            border: none;
            border-bottom: 2px solid #ddd;
            border-radius: 0;
            box-shadow: none;
            padding: 10px 10px 10px 5px;
            width: 100%;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-floating input:focus {
            border-bottom: 2px solid #007bff;
            outline: none;
            box-shadow: none;
        }

        .form-floating label {
            position: absolute;
            top: 10px;
            left: 5px;
            font-size: 1rem;
            color: #999;
            pointer-events: none;
            transition: 0.3s ease all;
        }

        .form-floating input:focus ~ label,
        .form-floating input:not(:placeholder-shown) ~ label {
            top: -15px;
            font-size: 0.85rem;
            color: #007bff;
        }

        .underline-effect {
            position: relative;
            overflow: hidden;
        }

        .underline-effect::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 2px;
            background-color: #007bff;
            transition: width 0.3s ease, left 0.3s ease;
        }

        .form-floating input:focus ~ .underline-effect::after {
            width: 100%;
            left: 0;
        }

        .btn-login {
            background-color: #f86d6d;
            color: white;
            border-radius: 20px;
            width: 100%;
            padding: 10px;
            margin-top: 15px;
        }
        .btn-login:hover {
            background-color: #f75c5c;
        }
        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 30px 0;
        }
        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #ddd;
        }
        .divider::before {
            margin-right: .5em;
        }
        .divider::after {
            margin-left: .5em;
        }
        .remember-me {
            font-size: 0.9em;
        }
        .find-links {
            font-size: 0.9em;
            display: flex;
            justify-content: space-between;
            gap: 10px; /* 아이디 찾기와 비밀번호 찾기 사이 간격 조정 */
        }
        .find-links a {
            text-decoration: none;
            color: #555;
        }
        .find-links a:hover {
            text-decoration: underline;
            color: #333;
        }
        .register-link {
            color: #f86d6d;
            font-weight: bold;
        }
        .register-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="login-box">
        <h4 class="text-center">로그인</h4>
        <form action="${pageContext.request.contextPath}/user/login" method="post">
            <div class="form-floating">
                <input type="text" class="form-control" id="userId" name="userId" placeholder=" ">
                <label for="userId">아이디</label>
                <div class="underline-effect"></div>
            </div>
            <div class="form-floating">
                <input type="password" class="form-control" id="password" name="userPassword" placeholder=" ">
                <label for="password">비밀번호</label>
                <div class="underline-effect"></div>
            </div>
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="rememberMe">
                    <label class="form-check-label remember-me" for="rememberMe">로그인 상태 유지</label>
                </div>
            </div>
            <div class="find-links">
                <a href="${pageContext.request.contextPath}/user/findId">아이디 찾기</a>
                <a href="${pageContext.request.contextPath}/user/findPassword">비밀번호 찾기</a>
            </div>
            <button type="submit" class="btn btn-login">로그인</button>
        </form>
        <div class="text-center mt-3">
            <p>아직 회원이 아니신가요? <a href="${pageContext.request.contextPath}/user/register" class="register-link">회원가입 하기</a></p>
        </div>
    </div>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
