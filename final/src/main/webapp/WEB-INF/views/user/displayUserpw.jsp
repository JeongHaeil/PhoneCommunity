<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>임시 비밀번호 발급 완료</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .pw-reset-complete-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .pw-reset-complete-container h3 {
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }
        .pw-reset-complete-container .btn-custom {
            background-color: #f86d6d;
            color: white;
            border-radius: 20px;
            width: 100%;
            padding: 10px;
        }
        .pw-reset-complete-container .btn-custom:hover {
            background-color: #f75c5c;
        }
        .pw-reset-complete-container p {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="pw-reset-complete-container">
    <h3>비밀번호 찾기 완료</h3>
    <p>해당 이메일로 임시 비밀번호가 발급되었습니다.</p>

    <!-- 로그인 페이지로 이동하는 버튼 -->
    <form action="${pageContext.request.contextPath}/user/login" method="get">
        <button type="submit" class="btn btn-custom">로그인창으로 돌아가기</button>
    </form>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
