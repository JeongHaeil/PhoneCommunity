<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 탈퇴</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body#withdraw-body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        div#withdraw-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h3#withdraw-header {
            font-weight: bold;
            margin-bottom: 20px;
        }
        button#withdraw-btn {
            background-color: #f86d6d;
            color: white;
            border-radius: 5px;
            padding: 10px 15px;
            margin-right: 5px;
        }
        button#withdraw-btn:hover {
            background-color: #f75c5c;
        }
        label#withdraw-label {
            font-weight: bold;
        }
    </style>
    <script>
        // 탈퇴 버튼을 눌렀을 때 실행되는 함수
        function confirmWithdrawal() {
            return confirm("정말로 탈퇴하시겠습니까?");
        }
    </script>
</head>
<body id="withdraw-body">

<div id="withdraw-container">
    <h3 id="withdraw-header">회원 탈퇴</h3>
    <form action="/userDelete" method="post" onsubmit="return confirmWithdrawal();">
        <div class="mb-3">
            <label for="userId" id="withdraw-label" class="form-label">아이디</label>
            <!-- 로그인된 사용자의 아이디 표시 및 수정 불가능하게 설정 -->
            <input type="text" class="form-control" id="userId" name="userId" value="${userId}" readonly>
        </div>

        <div class="mb-3">
            <label for="password" id="withdraw-label" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
        </div>

        <button type="submit" class="btn" id="withdraw-btn">탈퇴</button>
    </form>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
