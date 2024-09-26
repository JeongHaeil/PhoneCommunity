<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            background-color: #f86d6d;
            color: white;
            border-radius: 20px;
            width: 100%;
            padding: 10px;
        }
        .password-reset-container .btn-custom:hover {
            background-color: #f75c5c;
        }
    </style>
</head>
<body>

<div class="password-reset-container">
    <h3>비밀번호 찾기</h3>

    <form action="/find-password" method="post">
        <div class="mb-3">
            <label for="userId" class="form-label">아이디</label>
            <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디를 입력하세요" required>
        </div>
        <div class="mb-3">
            <label for="emailForPassword" class="form-label">가입 시 사용한 이메일</label>
            <input type="email" class="form-control" id="emailForPassword" name="emailForPassword" placeholder="이메일을 입력하세요" required>
        </div>
        <button type="submit" class="btn btn-custom">비밀번호 찾기</button>
    </form>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
