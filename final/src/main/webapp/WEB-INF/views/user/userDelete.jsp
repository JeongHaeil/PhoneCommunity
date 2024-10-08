<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 탈퇴</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .withdraw-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .withdraw-header {
            font-weight: bold;
            margin-bottom: 20px;
        }
        .withdraw-btn-custom {
            background-color: #f86d6d;
            color: white;
            border-radius: 5px;
            padding: 10px 15px;
        }
        .withdraw-btn-custom:hover {
            background-color: #f75c5c;
        }
    </style>
</head>
<body>

<div class="withdraw-container">
    <h3 class="withdraw-header">회원 탈퇴</h3>
    <!-- 요청 경로를 /withdraw에서 /final/user/userDelete로 변경 -->
    <form id="withdrawForm" action="/final/user/userDelete" method="post">
        <!-- CSRF 토큰 추가 -->
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <!-- 이메일 -->
        <div class="mb-3">
            <label for="email" class="form-label">이메일</label>
            <input type="email" class="form-control" id="email" name="email" value="tosmreo@naver.com" readonly>
        </div>

        <!-- 비밀번호 -->
        <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>

        <!-- 탈퇴 버튼 -->
        <button type="submit" class="btn withdraw-btn-custom" onclick="return confirmWithdrawal()">탈퇴</button>
    </form>
</div>

<script>
    function confirmWithdrawal() {
        return confirm("정말로 탈퇴하겠습니까?");
    }
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
