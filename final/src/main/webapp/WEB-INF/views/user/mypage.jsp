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
        .mypage-container {
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
        .mypage-nav-tabs {
            border-bottom: 2px solid #ddd;
            margin-bottom: 20px;
        }
        .mypage-nav-tabs .nav-link {
            color: #f86d6d;
            padding: 8px 16px;
        }
        .mypage-nav-tabs .nav-link.active {
            color: #f75c5c;
            border-color: #f75c5c #f75c5c #fff;
            border-bottom: 2px solid #f75c5c;
        }
        .mypage-info-section {
            margin-top: 20px;
        }
        .mypage-info-section .label {
            font-weight: bold;
        }
        .mypage-info-section .value {
            margin-left: 10px;
        }
        .mypage-btn-custom {
            background-color: #f86d6d;
            color: white;
            border-radius: 5px;
            padding: 10px 20px;
            margin-right: 10px;
        }
        .mypage-btn-custom:hover {
            background-color: #f75c5c;
        }
        .nav-pills .nav-link {
            background-color: transparent;
            border: none;
        }
        .nav-pills .nav-link.active {
            background-color: #f86d6d;
            color: white;
            border-radius: 5px;
        }
        .btn-section {
            margin-top: 20px;
            display: flex;
            justify-content: flex-start;
        }
        .btn-section .btn {
            margin-right: 10px;
        }
        .upload-section {
            display: flex;
            align-items: center;
        }
        .upload-section input[type="file"] {
            flex-grow: 1;
            margin-right: 10px;
        }
        .upload-section .btn-custom {
            white-space: nowrap; /* 한 줄로 유지 */
            padding: 10px 15px; /* 버튼 크기 조정 */
        }
    </style>
</head>
<body>

<div class="mypage-container">
    <!-- 네비게이션 탭 -->
    <ul class="nav nav-pills mypage-nav-tabs">
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
    </ul>

    <!-- 회원 정보 섹션 -->
    <div class="mypage-info-section">
        <h3>회원 정보</h3>

        <div class="row mb-3">
            <div class="col-md-3 label">이메일 주소</div>
            <div class="col-md-9 value">${user.userEmail}</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 label">아이디</div>
            <div class="col-md-9 value">${user.userId}</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 label">닉네임</div>
            <div class="col-md-9 value">${user.userNickName}</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 label">핸드폰 번호</div>
            <div class="col-md-9 value">${user.userPhoneNum}</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 label">가입일</div>
            <div class="col-md-9 value">${user.userRegisterDate}</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 label">최근 로그인</div>
            <div class="col-md-9 value">${user.userLastLogin}</div>
        </div>

        <!-- 프로필 사진 업로드 -->
        <div class="row mb-3">
            <div class="col-md-3 label">프로필 사진</div>
            <div class="col-md-9 value">
                <!-- 파일 업로드 섹션 -->
                <form action="/final/user/uploadProfilePicture" method="post" enctype="multipart/form-data" class="upload-section">
                    <input type="file" name="profilePic" class="form-control">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn mypage-btn-custom">업로드</button>
                </form>
            </div>
        </div>
    </div>

    <!-- 버튼 섹션 -->
    <div class="btn-section">
        <form action="/final/user/userUpdate" method="POST">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn mypage-btn-custom">회원정보 변경</button>
        </form>
        
        <form action="/final/user/passwordUpdate" method="POST">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn mypage-btn-custom">비밀번호 변경</button>
        </form>
        
        <form action="/final/user/userDelete" method="POST">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn mypage-btn-custom">탈퇴</button>
        </form>
    </div>

</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
