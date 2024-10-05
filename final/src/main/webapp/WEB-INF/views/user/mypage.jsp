<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 보기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 페이지의 스타일 */
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
        .mypage-info-section {
            margin-top: 20px;
        }
        .mypage-info-section .info-label {
            font-weight: bold;
        }
        .mypage-info-section .info-value {
            margin-left: 10px;
        }
    </style>
</head>
<body>

<div class="mypage-container">
    <!-- 탭 include -->
    <jsp:include page="/WEB-INF/views/user/mypageTabs.jsp">
        <jsp:param name="activeTab" value="profile" />
    </jsp:include>

    <!-- 회원 정보 섹션 -->
    <div class="mypage-info-section">
        <h3 class="mypage-header">회원 정보</h3>

        <div class="row mb-3">
            <div class="col-md-3 info-label">이메일 주소</div>
            <div class="col-md-9 info-value">${user.userEmail}</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 info-label">아이디</div>
            <div class="col-md-9 info-value">${user.userId}</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 info-label">닉네임</div>
            <div class="col-md-9 info-value">${user.userNickName}</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 info-label">핸드폰 번호</div>
            <div class="col-md-9 info-value">${user.userPhoneNum}</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 info-label">가입일</div>
            <div class="col-md-9 info-value">${user.userRegisterDate}</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 info-label">최근 로그인</div>
            <div class="col-md-9 info-value">${user.userLastLogin}</div>
        </div>

        <!-- 레벨 표시 -->
        <div class="row mb-3">
            <div class="col-md-3 info-label">레벨</div>
            <div class="col-md-9 info-value">${user.userLevel} 레벨</div>
        </div>

        <!-- 프로필 사진 업로드 -->
        <div class="row mb-3">
            <div class="col-md-3 info-label">프로필 사진</div>
            <div class="col-md-9 info-value">
                <!-- 파일 업로드 섹션 -->
                <form action="/final/user/uploadProfilePicture" method="post" enctype="multipart/form-data" class="upload-section">
                    <input type="file" name="profilePic" class="form-control">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn btn-custom">업로드</button>
                </form>
            </div>
        </div>
    </div>

    <!-- 하단 버튼 섹션 -->
    <div class="btn-section">
        <form action="/final/user/userUpdate" method="POST">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-custom">회원정보 변경</button>
        </form>

        <form action="/final/user/passwordUpdate" method="GET">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-custom">비밀번호 변경</button>
        </form>

        <form action="/final/user/userDelete" method="GET">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-custom">탈퇴</button>
        </form>
    </div>

</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
