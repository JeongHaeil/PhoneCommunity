<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        .nickname-input-container {
            display: flex;
            align-items: center;
        }
        .nickname-input-container input {
            flex-grow: 1;
            margin-right: 10px;
        }
        .btn-custom {
            height: auto; 
            padding: 5px 10px;
            line-height: normal; 
            background-color: #6c757d; 
            color: white;
            border: none;
            border-radius: 5px;
            white-space: nowrap;
        }
        .btn-custom:hover {
            background-color: #5a6268;
        }
        .error-message {
            color: red;
            font-size: 0.9em;
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
            <div class="col-md-9 info-value">
                <div class="nickname-input-container">
                    <form action="/final/user/updateNickname" method="post" class="d-flex">
                        <!-- CSRF 토큰 추가 -->
                        <sec:csrfInput/>
                        <input type="text" name="nickname" class="form-control" value="${user.userNickname}" />
                        <button type="submit" class="btn btn-custom">변경</button>
                    </form>
                </div>
                <!-- 닉네임 중복 오류 메시지 출력 -->
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">${errorMessage}</div>
                </c:if>
            </div>
        </div>

        <!-- 이름 표시 섹션 추가 -->
        <div class="row mb-3">
            <div class="col-md-3 info-label">이름</div>
            <div class="col-md-9 info-value">${user.userName}</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-3 info-label">핸드폰 번호</div>
            <div class="col-md-9 info-value">
                ${fn:substring(user.userPhoneNum, 0, 3)}-${fn:substring(user.userPhoneNum, 3, 7)}-${fn:substring(user.userPhoneNum, 7, 11)}
            </div>
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
            <div class="col-md-9 info-value">
                ${user.userLevel} 레벨
                <!-- 뱃지 표시 부분 include -->
                <jsp:include page="/WEB-INF/views/user/icon.jsp" />
            </div>
        </div>

        <!-- 경험치 표시 -->
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

    <!-- 하단 버튼 섹션 -->
    <div class="btn-section">
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
<!-- 닉네임 변경 성공 시 팝업창 -->
<script>
    <c:if test="${not empty successMessage}">
        alert("${successMessage}");
    </c:if>
</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</html>
