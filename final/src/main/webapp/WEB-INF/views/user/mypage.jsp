<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .container {
            max-width: 900px;
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
        .nav-tabs {
            border-bottom: 2px solid #ddd;
        }
        .nav-tabs .nav-link {
            color: #f86d6d;
        }
        .nav-tabs .nav-link.active {
            color: #f75c5c;
            border-color: #f75c5c #f75c5c #fff;
        }
        .info-section {
            margin-top: 30px;
        }
        .info-section .label {
            font-weight: bold;
        }
        .info-section .value {
            margin-left: 10px;
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
    </style>
</head>
<body>

<div class="container">
    <!-- 네비게이션 탭 -->
    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link active" href="#">회원정보 보기</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">스크랩 보기</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">저장한 글 보기</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">작성 글 보기</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">자동 로그인 관리</a>
        </li>
        <!-- 필요한 탭 추가 -->
    </ul>

    <!-- 회원 정보 섹션 -->
    <div class="info-section">
        <h3>회원 정보</h3>

        <div class="row mb-3">
            <div class="col-md-3 label">이메일 주소</div>
            <div class="col-md-9 value">tosmreo@naver.com</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 label">아이디</div>
            <div class="col-md-9 value">tosmreo</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 label">닉네임</div>
            <div class="col-md-9 value">김혜련</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 label">프로필 사진</div>
            <div class="col-md-9 value">...</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 label">포인트</div>
            <div class="col-md-9 value">120 P</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 label">레벨</div>
            <div class="col-md-9 value">Lv.1 (66%) / 17</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 label">회원 그룹</div>
            <div class="col-md-9 value">신입</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 label">가입일</div>
            <div class="col-md-9 value">2024-09-17</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 label">최근 로그인</div>
            <div class="col-md-9 value">2024-09-17</div>
        </div>
    </div>

    <!-- 버튼 섹션 -->
    <div class="mt-4">
        <button type="button" class="btn btn-custom">이메일 주소 변경</button>
        <button type="button" class="btn btn-custom">회원정보 변경</button>
        <button type="button" class="btn btn-custom">비밀번호 변경</button>
        <button type="button" class="btn btn-custom">탈퇴</button>
    </div>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
