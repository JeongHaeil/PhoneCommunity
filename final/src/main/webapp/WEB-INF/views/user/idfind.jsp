<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        .id-recovery-container { /* 컨테이너 스타일 변경 */
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
        .btn-id-recovery { /* 버튼 스타일 변경 */
            background-color: #f86d6d;
            color: white;
            border-radius: 20px;
            width: 100%;
            padding: 10px;
        }
        .btn-id-recovery:hover {
            background-color: #f75c5c;
        }
    </style>
</head>
<body>

<div class="id-recovery-container"> <!-- 컨테이너 클래스명 변경 -->
    <h3>아이디 찾기</h3>

    <form action="/find-id" method="post">
        <div class="mb-3">
            <label for="email" class="form-label">가입 시 사용한 이메일</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요" required>
        </div>
        <button type="submit" class="btn btn-id-recovery">아이디 찾기</button> <!-- 버튼 클래스명 변경 -->
    </form>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
