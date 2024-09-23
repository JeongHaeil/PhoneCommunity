<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이메일 인증</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
    </style>
</head>
<body>

<div class="verification-container">
    <h4>이메일 인증</h4>
    <form action="${pageContext.request.contextPath}/email/verify" method="post">
        <div class="mb-3">
            <label for="verification_code" class="form-label">인증 코드</label>
            <input type="text" class="form-control" id="verification_code" name="emailCode" placeholder="이메일로 받은 인증 코드를 입력하세요" required pattern="\d*">
        </div>
        <button type="submit" class="btn btn-verify">인증하기</button>
    </form>

    <div class="mt-4 text-center">
        <p>이메일을 받지 못하셨나요?</p>
        <a href="${pageContext.request.contextPath}/email/resend" class="btn btn-link">인증 코드 재발송</a>
    </div>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
