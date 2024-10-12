<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .id-recovery-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h3 {
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }
        .btn-id-recovery {
            background-color: #f86d6d;
            color: white;
            border-radius: 20px;
            width: 100%;
            padding: 10px;
        }
        .btn-id-recovery:hover {
            background-color: #f75c5c;
        }
        .error-message {
            color: red;
            font-size: 0.9rem;
            margin-bottom: 10px;
            text-align: center; /* 가운데 정렬 */
            display: none; /* 기본으로 숨김 */
        }
    </style>
    
    <script>
        function validateForm() {
            var email = document.getElementById("email");
            var name = document.getElementById("name");
            var emailError = document.getElementById("emailError");
            var nameError = document.getElementById("nameError");
            
            // 모든 오류 메시지 숨김
            emailError.style.display = "none";
            nameError.style.display = "none";

            // 이메일 검증
            if (email.value.trim() === "") {
                emailError.style.display = "block"; // 이메일 오류 메시지 표시
                email.focus();
                return false; // 이메일이 없을 때 바로 반환하여 이름 검증 안 하도록 처리
            }

            // 이름 검증 (이메일이 정상일 때만)
            if (name.value.trim() === "") {
                nameError.style.display = "block"; // 이름 오류 메시지 표시
                name.focus();
                return false;
            }

            return true; // 모든 검증 통과 시 true 반환
        }
    </script>
</head>
<body>

<div class="id-recovery-container">
    <h3>아이디 찾기</h3>

    <form action="/final/user/displayUserId" method="post" onsubmit="return validateForm();">
        <!-- CSRF 토큰 추가 -->
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <!-- 이메일 입력 필드 -->
        <div class="mb-3">
            <label for="email" class="form-label">가입 시 사용한 이메일</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요">
        </div>

        <!-- 이름 입력 필드 -->
        <div class="mb-3">
            <label for="name" class="form-label">이름</label>
            <input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하세요">
        </div>

        <!-- 오류 메시지를 버튼 바로 위에 표시 -->
        <div id="emailError" class="error-message">이메일을 입력해주세요.</div>
        <div id="nameError" class="error-message">이름을 입력해주세요.</div>

        <!-- 아이디 찾기 버튼 -->
        <button type="submit" class="btn btn-id-recovery">아이디 찾기</button>
    </form>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
