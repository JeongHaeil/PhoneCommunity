<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 보기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body.custom-body {
            background-color: #f8f9fa;
             
            
            
        }
       .mypage-container.custom-container {
    max-width: 900px;
    margin: 50px auto; /* 가로 방향 중앙 정렬 (위아래 50px, 양쪽 자동) */
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 10px;
    font-size: 20px; /* 전체 기본 글씨 크기 */
    display: block; /* 블록 요소로 설정 */
}
        .mypage-header.custom-header {
            font-weight: bold;
            margin-bottom: 15px;
        }
        .nickname-input-container.custom-nickname {
            display: flex;
            align-items: center;
        }
        .nickname-input-container.custom-nickname input {
            flex-grow: 1;
            margin-right: 10px;
        }
        .btn-custom.custom-button {
            height: auto; 
            padding: 10px 20px;
            background-color: #3C3D37 !important; /* 버튼 색상 */
            color: white;
            border: none;
            border-radius: 10px; /* 끝이 둥근 모양 */
            white-space: nowrap;
        }
        .btn-custom.custom-button:hover {
            background-color: #2e2f28 !important; /* 호버시 색상 */
        }
        .error-message.custom-error {
            color: red;
            font-size: 0.9em;
        }
        .badge-section.custom-badge {
            display: flex;
            align-items: flex-start; /* 뱃지와 텍스트 수직 정렬 */
            margin-bottom: 20px;
        }
        .badge-icon.custom-badge-icon {
            width: 100px !important;  /* 뱃지 크기 */
            height: 125px !important;  /* 뱃지 크기 */
            border-radius: 50%;
        }
        .user-info.custom-info {
            margin-left: 150px; /* 뱃지와 정보 사이의 간격 */
        }
       .header-with-tabs {
    display: flex; /* 회원 정보와 탭을 가로로 배치 */
    align-items: center; /* 세로 중앙 정렬 */
    justify-content: flex-start; /* 좌측 정렬로 변경 */
    margin-bottom: 20px;
}

.mypage-header.custom-header {
    margin-right: 10px; /* 회원 정보와 탭 사이의 간격을 더 좁게 설정 */
}

.tabs-wrapper {
    display: flex;
    gap: 5px; /* 탭 사이의 간격을 더 좁게 설정 */
}
    </style>
</head>
<body class="custom-body">



<div class="mypage-container custom-container">
    <!-- 회원 정보 제목과 탭을 가로로 배치하기 위한 컨테이너 -->
    <div class="header-with-tabs">
        <h2 class="mypage-header custom-header">회원 정보</h2>
        <div class="tabs-wrapper">
				<hr>
            <jsp:include page="/WEB-INF/views/user/mypageTabs.jsp">
                <jsp:param name="activeTab" value="profile" />
            </jsp:include>
        </div>
    </div>
    

    <!-- 뱃지와 회원 정보 표시 섹션 -->
    <div class="badge-section custom-badge">
        <!-- 뱃지 include -->
        <div class="badge-icon custom-badge-icon">
            <jsp:include page="/WEB-INF/views/user/myicon.jsp" />
        </div>
        
        <div class="user-info custom-info">
            <!-- 이름 표시 섹션 -->
            <div class="row mb-3">
                <div class="col-md-3 info-label">이름</div>
                <div class="col-md-9 info-value">${user.userName}</div>
            </div>

            <!-- 닉네임 표시 및 변경 섹션 -->
            <div class="row mb-3">
                <div class="col-md-3 info-label">닉네임</div>
                <div class="col-md-9 info-value">
                    <div class="nickname-input-container custom-nickname">
                        <form action="/final/user/updateNickname" method="post" class="d-flex">
                            <!-- CSRF 토큰 추가 -->
                            <sec:csrfInput/>
                            <input type="text" name="nickname" class="form-control" value="${user.userNickname}" />
                            <button type="submit" class="btn-custom custom-button">변경</button>
                        </form>
                    </div>
                    <!-- 닉네임 중복 오류 메시지 출력 -->
                    <c:if test="${not empty errorMessage}">
                        <div class="error-message custom-error">${errorMessage}</div>
                    </c:if>
                </div>
            </div>

            <!-- 레벨 표시 섹션 -->
            <div class="row mb-3">
                <div class="col-md-3 info-label">레벨</div>
                <div class="col-md-9 info-value">${user.userLevel} 레벨</div>
            </div>

            <!-- 경험치 표시 섹션 -->
            <div class="row mb-3">
                <div class="col-md-3 info-label">경험치</div>
                <div class="col-md-9 info-value">
                    ${currentExperience}/${experienceForNextLevel} P (${progressPercentage}%)
                    <div class="progress">
                        <div class="progress-bar" role="progressbar" style="width: ${progressPercentage}%;"
                             aria-valuenow="${progressPercentage}" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 이메일 표시 섹션 -->
    <div class="row mb-3">
        <div class="col-md-3 info-label">이메일 주소</div>
        <div class="col-md-9 info-value">${user.userEmail}</div>
    </div>

    <!-- 핸드폰 번호 표시 섹션 -->
    <div class="row mb-3">
        <div class="col-md-3 info-label">핸드폰 번호</div>
        <div class="col-md-9 info-value">
            ${fn:substring(user.userPhoneNum, 0, 3)}-${fn:substring(user.userPhoneNum, 3, 7)}-${fn:substring(user.userPhoneNum, 7, 11)}
        </div>
    </div>

    <!-- 가입일 표시 섹션 -->
    <div class="row mb-3">
        <div class="col-md-3 info-label">가입일</div>
        <div class="col-md-9 info-value">${user.userRegisterDate}</div>
    </div>

    <!-- 최근 로그인 표시 섹션 -->
    <div class="row mb-3">
        <div class="col-md-3 info-label">최근 로그인</div>
        <div class="col-md-9 info-value">${user.userLastLogin}</div>
    </div>

    <!-- 하단 버튼 섹션 -->
    <div class="btn-section">
        <form action="/final/user/passwordUpdate" method="GET" class="d-inline">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn-custom custom-button">비밀번호 변경</button>
        </form>

        <form action="/final/user/userDelete" method="GET" class="d-inline">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn-custom custom-button">탈퇴</button>
        </form>
    </div>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- 닉네임 변경 성공 시 팝업창 -->
<script>
    <c:if test="${not empty successMessage}">
        alert("${successMessage}");
    </c:if>
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
