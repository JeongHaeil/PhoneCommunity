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
            max-width: 400px; /* 가로 크기를<div class="header-with-tabs" style="text-align: center;"> <!-- 여기에 추가 --> 900px로 조정 */
            margin: 50px auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
          
        }
        .password-change-header {
            font-weight: bold;
            margin-bottom: 20px;
        }
        .password-change-btn {
            background-color: #3C3D37 !important; /* 요청한 버튼 색상 */
            color: white;
            border-radius: 10px; /* 끝이 둥근 모양 */
            padding: 10px 15px;
            width: 100%;
            border: none;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .password-change-btn:hover {
            background-color: #2e2f28 !important; /* 호버시 색상 */
        }
        .form-label {
            font-weight: bold;
        }
        .error-text {
            color: red;
            font-size: 0.9em;
            margin-top: 5px;
        }
        /* 필드 및 버튼 크기 동일하게 적용 */
        .form-control {
            max-width: 300px; /* 필드 가로 크기 조정 */
            margin: 0 auto; /* 가운데 정렬 */
        }
        .password-change-btn {
            max-width: 300px; /* 버튼 가로 크기 조정 */
            margin: 0 auto; /* 가운데 정렬 */
            display: block; /* 가운데 정렬을 위해 block 요소로 변경 */
        }
        .form-group {
            text-align: center; /* 입력 필드 및 버튼을 가운데 정렬 */
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

    <h3 class="password-change-header"style="text-align: center;">비밀번호 변경</h3>

    <!-- 비밀번호 변경 폼 -->
    <form id="passwordChangeForm" action="/final/user/passwordUpdate" method="post" onsubmit="return validateForm();">
        <!-- CSRF 토큰 추가 -->
        <sec:csrfInput />

        <!-- 새 비밀번호 입력 -->
        <div class="form-group mb-3">
            <label for="newPassword" class="form-label">새 비밀번호</label>
            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
        </div>

        <!-- 새 비밀번호 확인 -->
        <div class="form-group mb-3">
            <label for="confirmNewPassword" class="form-label">새 비밀번호 확인</label>
            <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" required>
        </div>

        <!-- 오류 메시지 표시 -->
        <div id="errorMessage" class="error-text"></div>

        <!-- 비밀번호 변경 버튼 -->
        <button type="submit" class="password-change-btn">비밀번호 변경</button>
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
