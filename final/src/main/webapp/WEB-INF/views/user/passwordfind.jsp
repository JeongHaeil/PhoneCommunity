<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .password-reset-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .password-reset-container h3 {
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }
        .password-reset-container .btn-custom {
            background-color: #3C3D37 !important; /* 버튼 배경색을 #3C3D37로 설정 */
            color: white !important; /* 텍스트 색상을 흰색으로 설정 */
            border-radius: 10px; /* 둥근 모서리 크기를 줄임 */
            width: 100%;
            padding: 10px;
        }
        .password-reset-container .btn-custom:hover {
            background-color: #2E2F2A !important; /* hover 상태 배경색 */
        }
        .error-message {
            color: red;
            font-size: 0.9rem;
            margin-bottom: 10px;
            text-align: center;
        }
    </style>

    <script>
        window.onload = function() {
            var successMessage = "${successMessage}";
            if (successMessage) {
                alert(successMessage); // 팝업 띄우기
                window.location.href = "${pageContext.request.contextPath}/user/login"; // 로그인 페이지로 리다이렉트
            }
        };

        function validateForm() {
            var userId = document.getElementById("userId");
            var userName = document.getElementById("userName");
            var userEmail = document.getElementById("userEmail");
            var userIdError = document.getElementById("userIdError");
            var userNameError = document.getElementById("userNameError");
            var userEmailError = document.getElementById("userEmailError");

            // 모든 오류 메시지 숨김
            userIdError.style.display = "none";
            userNameError.style.display = "none";
            userEmailError.style.display = "none";

            // 아이디 검증
            if (userId.value.trim() === "") {
                userIdError.style.display = "block";
                userId.focus();
                return false;
            }

            // 이름 검증
            if (userName.value.trim() === "") {
                userNameError.style.display = "block";
                userName.focus();
                return false;
            }

            // 이메일 검증
            if (userEmail.value.trim() === "") {
                userEmailError.style.display = "block";
                userEmail.focus();
                return false;
            }

            return true;
        }
    </script>
</head>
<body>

<div class="password-reset-container">
    <h3>비밀번호 찾기</h3>

    <form action="/final/user/findPassword" method="post" onsubmit="return validateForm();">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <!-- 아이디 입력 필드 -->
        <div class="mb-3">
            <label for="userId" class="form-label">아이디</label>
            <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디를 입력하세요">
        </div>

        <!-- 이름 입력 필드 -->
        <div class="mb-3">
            <label for="userName" class="form-label">이름</label>
            <input type="text" class="form-control" id="userName" name="userName" placeholder="이름을 입력하세요">
        </div>

        <!-- 이메일 입력 필드 -->
        <div class="mb-3">
            <label for="userEmail" class="form-label">이메일</label>
            <input type="email" class="form-control" id="userEmail" name="userEmail" placeholder="이메일을 입력하세요">
        </div>

        <!-- 오류 메시지를 버튼 바로 위에 표시 -->
        <div id="userIdError" class="error-message" style="display: none;">아이디를 입력해주세요.</div>
        <div id="userNameError" class="error-message" style="display: none;">이름을 입력해주세요.</div>
        <div id="userEmailError" class="error-message" style="display: none;">이메일을 입력해주세요.</div>

        <!-- 서버에서 일치하지 않는 정보에 대한 오류 메시지 출력 -->
        <div id="errorMessage" class="error-message">${error}</div>

        <!-- 비밀번호 찾기 버튼 -->
        <button type="submit" class="btn btn-custom">비밀번호 찾기</button>
    </form>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
