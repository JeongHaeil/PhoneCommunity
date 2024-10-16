<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .mypage-button-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            border-bottom: 2px solid #dee2e6;
        }
        .mypage-button {
            flex: 1;
            text-align: center;
            padding: 10px;
            background-color: #fff;
            border: none;
            color: #495057;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        .mypage-button.active {
            border-bottom: 2px solid #000;
            color: #000;
        }
        .mypage-button:hover {
            border-bottom: 2px solid #000;
            color: #000;
        }
    </style>
</head>
<body>

<div class="mypage-button-group">
    <!-- 회원정보 보기 -->
    <form action="/final/user/profile" method="GET">
        <button type="submit" class="mypage-button ${activeTab == 'profile' ? 'active' : ''}">회원정보 보기</button>
    </form>

    <!-- 작성 글 보기 -->
    <form action="/final/user/myWrite" method="GET">
        <button type="submit" class="mypage-button ${activeTab == 'myWrite' ? 'active' : ''}">작성 글 보기</button>
    </form>

    <!-- 작성 댓글 보기 -->
    <form action="/final/user/myComment" method="GET">
        <button type="submit" class="mypage-button ${activeTab == 'myComment' ? 'active' : ''}">작성 댓글 보기</button>
    </form>

    <!-- 중고장터 글 보기 -->
    <form action="/final/user/myProducts" method="GET">
        <button type="submit" class="mypage-button ${activeTab == 'myProducts' ? 'active' : ''}">중고장터 글 보기</button>
    </form>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
