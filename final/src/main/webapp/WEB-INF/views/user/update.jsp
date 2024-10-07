<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 조회/수정</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
    <h3>회원정보 조회/수정</h3>
    <form action="/update-profile" method="post" enctype="multipart/form-data">
        <!-- 이메일 주소 -->
        <div class="mb-3">
            <label for="email" class="form-label">이메일 주소</label>
            <input type="email" class="form-control" id="email" name="email" value="tosmreo@naver.com" readonly>
        </div>

        <!-- 아이디 -->
        <div class="mb-3">
            <label for="userId" class="form-label">아이디</label>
            <input type="text" class="form-control" id="userId" name="userId" value="tosmreo" readonly>
        </div>

        <!-- 닉네임 -->
        <div class="mb-3">
            <label for="nickname" class="form-label">닉네임</label>
            <input type="text" class="form-control" id="nickname" name="nickname" value="김혜련" required>
        </div>

        <!-- 비밀번호 찾기 질문 -->
        <div class="mb-3">
            <label for="securityQuestion" class="form-label">비밀번호 찾기 질문</label>
            <select class="form-control" id="securityQuestion" name="securityQuestion">
                <option value="email">다른 이메일 주소는?</option>
            </select>
        </div>

        <!-- 프로필 사진 -->
        <div class="mb-3">
            <label for="profileImage" class="form-label">프로필 사진</label>
            <input type="file" class="form-control" id="profileImage" name="profileImage">
            <small class="form-text text-muted">가로 제한 길이: 100px, 세로 제한 길이: 100px</small>
        </div>

        <!-- 메일링 가입 -->
        <div class="mb-3">
            <label for="mailing" class="form-label">메일링 가입</label><br>
            <input type="radio" id="mailingYes" name="mailing" value="yes" checked> 예
            <input type="radio" id="mailingNo" name="mailing" value="no"> 아니요
        </div>

        <!-- 쪽지 수신 허용 -->
        <div class="mb-3">
            <label for="messageReceive" class="form-label">쪽지 수신 허용</label><br>
            <input type="radio" id="allMessages" name="messageReceive" value="all" checked> 전체 수신
            <input type="radio" id="friendsOnly" name="messageReceive" value="friends"> 친구만 허용
            <input type="radio" id="noMessages" name="messageReceive" value="no"> 거부
        </div>

        <!-- 수정 버튼 -->
        <button type="submit" class="btn btn-custom">수정</button>
    </form>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
