<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h3 {
            font-weight: bold;
            margin-bottom: 20px;
        }
        .btn-custom {
            background-color: #f86d6d;
            color: white;
            border-radius: 5px;
            padding: 10px 15px;
            margin-right: 5px;
        }
        .btn-custom:hover {
            background-color: #f75c5c;
        }
        .form-label {
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container">
    <h3>비밀번호 변경</h3>
    <form action="/change-password" method="post">
        <!-- 이메일 -->
        <div class="mb-3">
            <label for="email" class="form-label">이메일</label>
            <input type="email" class="form-control" id="email" name="email" value="tosmreo@naver.com" readonly>
        </div>

        <!-- 현재 비밀번호 -->
        <div class="mb-3">
            <label for="currentPassword" class="form-label">현재 비밀번호</label>
            <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
        </div>

        <!-- 새 비밀번호 -->
        <div class="mb-3">
            <label for="newPassword" class="form-label">새 비밀번호</label>
            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
            <small class="form-text text-muted">비밀번호는 8자 이상이어야 하며, 영문과 숫자, 특수문자를 포함해야 합니다.</small>
        </div>

        <!-- 새 비밀번호 확인 -->
        <div class="mb-3">
            <label for="confirmNewPassword" class="form-label">새 비밀번호 확인</label>
            <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" required>
        </div>

        <!-- 등록 버튼 -->
        <button type="submit" class="btn btn-custom">등록</button>
    </form>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
