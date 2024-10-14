<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이메일 인증</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .verification-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h4 {
            margin-bottom: 30px;
            font-weight: bold;
            color: #333;
            text-align: center;
        }
        .form-control {
            border-radius: 10px;
            padding: 10px;
        }
        .btn-verify {
            background-color: #f86d6d;
            color: white;
            border-radius: 20px;
            width: 100%;
            padding: 10px;
            margin-top: 20px;
        }
        .btn-verify:hover {
            background-color: #f75c5c;
        }
        .error-message {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="verification-container">
    <h4>이메일 인증</h4>

    <form action="${pageContext.request.contextPath}/user/verify" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="mb-3">
            <label for="verification_code" class="form-label">인증 코드</label>
            <input type="text" class="form-control" id="verification_code" name="emailCode" placeholder="이메일로 받은 인증 코드를 입력하세요" required pattern="\d*">
            <!-- 오류 메시지 필드 아래 출력 -->
            <c:if test="${not empty errorMessage}">
                <span class="error-message">${errorMessage}</span> <!-- 여기에서 오류 메시지만 출력 -->
            </c:if>
        </div>
        <button type="submit" class="btn btn-verify">인증하기</button>
    </form>

    <div class="mt-4 text-center">
        <p>이메일을 받지 못하셨나요?</p>
        <form action="${pageContext.request.contextPath}/user/email/resend" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-link">인증 코드 재발송</button>
        </form>
    </div>
</div>

<!-- 성공 또는 오류 메시지를 팝업으로 표시하는 스크립트 -->
<script>
    window.onload = function() {
        // 성공 메시지가 있을 때 (회원가입 성공 시 로그인 페이지로 이동)
        <c:if test="${not empty successMessage}">
            alert("${successMessage}"); // 성공 팝업 띄우기
            window.location.href = "${pageContext.request.contextPath}/user/login"; // 팝업 후 로그인 페이지로 리다이렉트
        </c:if>
        
        // 인증 코드 재발송 성공 메시지 있을 때
        <c:if test="${not empty resendMessage}">
            alert("${resendMessage}"); // 재발송 성공 팝업 띄우기
        </c:if>
    };
</script>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
