<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .password-change-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .password-change-header {
            font-weight: bold;
            margin-bottom: 20px;
        }
        .password-change-btn {
            background-color: #f86d6d;
            color: white;
            border-radius: 5px;
            padding: 10px 15px;
            margin-right: 5px;
        }
        .password-change-btn:hover {
            background-color: #f75c5c;
        }
        .form-label {
            font-weight: bold;
        }
        .error-text {
            color: red;
            font-size: 0.9em;
            margin-top: 5px;
        }
    </style>
    <script>
        // 비밀번호 확인 검증 함수
        function validateForm() {
            var newPassword = document.getElementById("newPassword").value;
            var confirmNewPassword = document.getElementById("confirmNewPassword").value;
            var errorMessage = document.getElementById("errorMessage");

            if (newPassword !== confirmNewPassword) {
                errorMessage.textContent = "비밀번호가 일치하지 않습니다.";
                return false; // 폼 제출 중단
            }
            return true; // 폼 제출 허용
        }

        // 비밀번호 변경 성공 후 팝업창 띄우기
        function showSuccessPopup() {
            alert("비밀번호가 성공적으로 변경되었습니다.");
            window.location.href = "/final/user/profile"; // 마이페이지로 리다이렉트
        }
    </script>
</head>
<body>

<div class="password-change-container">
    <h3 class="password-change-header">비밀번호 변경</h3>

    <!-- 비밀번호 변경 폼 -->
    <form id="passwordChangeForm" action="/final/user/passwordUpdate" method="post" onsubmit="return validateForm();">
        <!-- CSRF 토큰 추가 -->
        <sec:csrfInput />

        <!-- 새 비밀번호 입력 -->
        <div class="mb-3">
            <label for="newPassword" class="form-label">새 비밀번호</label>
            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
        </div>

        <!-- 새 비밀번호 확인 -->
        <div class="mb-3">
            <label for="confirmNewPassword" class="form-label">새 비밀번호 확인</label>
            <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" required>
        </div>

        <!-- 오류 메시지 표시 -->
        <div id="errorMessage" class="error-text"></div>

        <button type="submit" class="btn btn-primary">비밀번호 변경</button>
    </form>
</div>

<!-- 비밀번호 변경 성공 시 팝업창 -->
<c:if test="${not empty successMessage}">
    <script>
        showSuccessPopup(); // 성공 팝업창 띄우고 마이페이지로 리다이렉트
    </script>
</c:if>

</body>
</html>
