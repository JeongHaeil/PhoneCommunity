<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 부트스트랩 5.3 CSS 링크 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>EOMISAE</title>

    <style>
        /* 네비게이션 바 스타일 */
        .eomisae-navbar nav.navbar {
            background-color: #343a40;
            padding: 0 20px;
        }

        .eomisae-navbar .navbar-brand,
        .eomisae-navbar .nav-link {
            color: #fff !important;
        }

        /* 충돌 방지: 버튼 스타일의 고유한 클래스명 사용 */
        .eomisae-navbar .btn-login,
        .eomisae-navbar .btn-logout {
            background-color: #f05d5e !important;
            color: #fff !important;
        }

        .eomisae-navbar .btn-login:hover,
        .eomisae-navbar .btn-logout:hover {
            background-color: #f75c5c !important;
        }

        /* 드롭다운 메뉴 스타일 */
        .eomisae-navbar .dropdown-menu {
            width: 300px;
            padding: 20px;
            background-color: #ffffff;  /* 드롭다운 배경을 흰색으로 설정 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);  /* 드롭다운 그림자 추가 */
            border: 1px solid #ddd;  /* 테두리 추가 */
            z-index: 1050;  /* 다른 요소 위에 표시 */
        }

        .eomisae-navbar .dropdown-menu .user-info h4 {
            font-weight: bold;
        }

        .eomisae-navbar .dropdown-menu .progress-bar {
            background-color: #f86d6d;
        }

        .eomisae-navbar .dropdown-menu .menu-list a {
            display: flex;
            align-items: center;
            padding: 10px;
            text-decoration: none;
            color: #333;
        }

        .eomisae-navbar .dropdown-menu .menu-list a:hover {
            background-color: #f1f1f1;
        }

        .eomisae-navbar .dropdown-menu .logout-section {
            text-align: center;
            margin-top: 10px;
        }

        /* 부트스트랩 기본 스타일과 충돌 방지 */
        .eomisae-navbar .navbar-toggler {
            border-color: rgba(255, 255, 255, 0.1);
        }

        .eomisae-navbar .dropdown-menu-end {
            right: 0 !important;
            left: auto !important;
        }
    </style>
</head>
<body>

    <div class="eomisae-navbar">
        <nav class="navbar navbar-expand-lg navbar-dark">
            <div class="container">
                <a class="navbar-brand" href="/final">EOMISAE</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item"><a class="nav-link" href="<c:url value='/board/boardlist/10'/>">자유게시판</a></li>
                        <li class="nav-item"><a class="nav-link" href="<c:url value='/board/boardlist/11'/>">질문답변</a></li>
                        <li class="nav-item"><a class="nav-link" href="<c:url value='/phone/phone'/>">요금제비교</a></li>
                        <li class="nav-item"><a class="nav-link" href="<c:url value='/product/list'/>">중고장터</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">플리마켓</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">서비스</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">운영관리</a></li>
                    </ul>

                    <div class="dropdown">
                        <c:choose>
                            <c:when test="${not empty pageContext.request.userPrincipal}">
                                <!-- 드롭다운 버튼 -->
                                <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                                    <sec:authentication property="principal.nickname"/> 님
                                    <!-- 아이콘 표시 -->
                                    <jsp:include page="/WEB-INF/views/user/icon.jsp" />
                                </a>
                                <!-- 드롭다운 메뉴 -->
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuLink">
                                    <li class="user-info text-center">
                                        <!-- 로그인한 회원의 닉네임 -->
                                        <h4><sec:authentication property="principal.nickname"/></h4>
                                    </li>
                                    <li>
                                        <!-- 로그인한 회원의 레벨 표시 및 경험치 바 -->
                                        <div class="level-bar text-center mt-2">
                                            <p id="userLevel">Loading...</p>
                                            <div class="progress">
                                                <div class="progress-bar" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                            <p class="level-text mt-2" id="experienceText">Loading...</p>
                                        </div>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li class="menu-list">
                                        <a class="dropdown-item" href="<c:url value='/user/profile'/>"><i class="bi bi-person"></i> 마이페이지</a>
                                        <a class="dropdown-item" href="<c:url value='/user/myWrite'/>"><i class="bi bi-pencil-square"></i> 작성글</a>
                                        <a class="dropdown-item" href="<c:url value='/user/myComment'/>"><i class="bi bi-chat-dots"></i> 작성 댓글</a>
                                        <a class="dropdown-item" href="<c:url value='/final/user/myProducts'/>"><i class="bi bi-box-seam"></i> 중고장터 글</a>
                                        <a class="dropdown-item" href="#"><i class="bi bi-moon"></i> 다크모드</a>
                                    </li>

                                    <li><hr class="dropdown-divider"></li>
                                    <li class="logout-section">
                                        <form action="<c:url value='/logout'/>" method="post" style="display:inline;">
                                            <sec:csrfInput/>
                                            <button type="submit" class="btn btn-logout">로그아웃</button>
                                        </form>
                                    </li>
                                </ul>
                            </c:when>
                            <c:otherwise>
                                <a class="btn btn-login" id="loginButton" href ="<c:url value='/user/login'/>">로그인</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>
    </div>

    <script>
        $(document).ready(function() {
            $.ajax({
                url: '/final/user/getUserInfo',  // 서버에 데이터를 요청할 URL
                method: 'GET',
                success: function(data) {
                    if (data.userLevel) {
                        $('#userLevel').text('레벨: ' + data.userLevel);
                        $('.progress-bar').css('width', data.progressPercentage + '%');
                        $('#experienceText').text(data.currentExperience + '/' + data.experienceForNextLevel + ' P (' + data.progressPercentage + '%)');
                    } else {
                        $('#userLevel').text('레벨 정보가 없습니다.');
                    }
                },
                error: function() {
                    $('#userLevel').text('데이터를 불러오는 데 실패했습니다.');
                }
            });
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>