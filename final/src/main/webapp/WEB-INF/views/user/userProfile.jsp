<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .mypage-sidebar {
            width: 300px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .user-info {
            text-align: center;
            margin-bottom: 30px;
        }
        .user-info h4 {
            font-weight: bold;
        }
        .user-info .email {
            color: #999;
            font-size: 0.9em;
        }
        .level-bar {
            margin-top: 10px;
            text-align: center;
        }
        .progress {
            height: 8px;
            border-radius: 5px;
        }
        .progress-bar {
            background-color: #f86d6d;
        }
        .level-text {
            margin-top: 5px;
            font-size: 0.8em;
            color: #999;
        }
        .penalty-info {
            margin-top: 10px;
            text-align: center;
            font-size: 0.9em;
        }
        .penalty-info .penalty-link {
            color: #f75c5c;
            font-weight: bold;
        }
        .menu-list {
            margin-top: 30px;
        }
        .menu-list a {
            display: flex;
            align-items: center;
            padding: 10px;
            color: #333;
            text-decoration: none;
            border-bottom: 1px solid #eee;
        }
        .menu-list a:hover {
            background-color: #f1f1f1;
        }
        .menu-list a i {
            margin-right: 10px;
        }
        .logout-section {
            text-align: center;
            margin-top: 20px;
        }
        .logout-section i {
            margin-right: 5px;
        }
    </style>
</head>
<body>

<div class="mypage-sidebar">
    <!-- 사용자 정보 -->
    <div class="user-info">
        <h4>김혜련</h4>
        <p class="email">tosmreo@naver.com</p>
    </div>

    <!-- 레벨 정보 -->
    <div class="level-bar">
        <p>Level. 1</p>
        <div class="progress">
            <div class="progress-bar" role="progressbar" style="width: 75%;" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
        </div>
        <p class="level-text">135/180 P (75%)</p>
    </div>

    <!-- 메뉴 리스트 -->
    <div class="menu-list">
        <a href="#"><i class="bi bi-person"></i> 마이페이지</a>
        <a href="#"><i class="bi bi-bookmark"></i> 스크랩</a>
        <a href="#"><i class="bi bi-pencil-square"></i> 작성글</a>
        <a href="#"><i class="bi bi-chat-dots"></i> 작성 댓글</a>
        <a href="#"><i class="bi bi-envelope"></i> 쪽지함</a>
        <a href="#"><i class="bi bi-moon"></i> 다크모드</a>
    </div>

    <!-- 로그아웃 -->
    <div class="logout-section">
        <a href="#"><i class="bi bi-box-arrow-right"></i> 로그아웃</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
