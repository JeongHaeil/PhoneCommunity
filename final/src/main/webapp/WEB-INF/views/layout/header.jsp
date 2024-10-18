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
        .eomisae-navbar nav.navbar {
            background-color: #343a40;
            padding: 10px 20px;
        }

        .eomisae-navbar .navbar-brand,
        .eomisae-navbar .nav-link {
            color: #fff !important;
        }

        .eomisae-navbar .btn-login,
        .eomisae-navbar .btn-logout {
            background-color: #f05d5e !important;
            color: #fff !important;
        }

        .eomisae-navbar .btn-login:hover,
        .eomisae-navbar .btn-logout:hover {
            background-color: #f75c5c !important;
        }

        .eomisae-navbar .dropdown-menu {
            width: 300px;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            border: 1px solid #ddd;
            z-index: 1050;
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
                <a class="navbar-brand" href="/final">
				    <img src="<c:url value='/resources/images/logo.png'/>" alt="EOMISAE Logo" style="height: 40px;">
				 <span>니폰내폰</span>
				</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item"><a class="nav-link" href="<c:url value='/board/boardlist/10'/>">자유게시판</a></li>
                        <li class="nav-item"><a class="nav-link" href="<c:url value='/board/boardlist/11'/>">질문답변</a></li>
                        <li class="nav-item"><a class="nav-link" href="<c:url value='/phone/phone'/>">요금제비교</a></li>
                        <li class="nav-item"><a class="nav-link" href="<c:url value='/product/list'/>">중고장터</a></li>
                        <li class="nav-item"><a class="nav-link" href="<c:url value='/board/boardlist/3'/>">1:1문의</a></li>
                        <li class="nav-item"><a class="nav-link" href="<c:url value='/board/boardlist/2'/>">공지사항</a></li>
                       
                    </ul>

                    <div class="dropdown">
                        <c:choose>
                            <c:when test="${not empty pageContext.request.userPrincipal}">
                                <!-- 드롭다운 버튼 -->
                                <a class="btn btn-secondary dropdown-toggle text-white" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
									    <sec:authentication property="principal.nickname"/> 님
									    <jsp:include page="/WEB-INF/views/user/icon.jsp" />
									</a>
 
                                <!-- 최고관리자일 경우 -->
                                <sec:authorize access="hasRole('ROLE_SUPER_ADMIN')">
                                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuLink">
                                        <li class="user-info text-center">
                                            <h4><sec:authentication property="principal.nickname"/></h4>
                                        </li>
                                        <li>
                                           <!-- <div class="level-bar text-center mt-2">
                                                <p id="userLevel">Loading...</p>
                                                <div class="progress">
                                                    <div class="progress-bar" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
                                                <p class="level-text mt-2" id="experienceText">Loading...</p>
                                            </div> -->
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li class="menu-list">
                                            <a class="dropdown-item" href="<c:url value='/super_admin/'/>"><i class="bi bi-speedometer"></i> 관리자 대시보드</a>
                                            <a class="dropdown-item" href="<c:url value='/super_admin/userList'/>"><i class="bi bi-people"></i> 회원 관리</a>
                                            <a class="dropdown-item" href="<c:url value='/super_admin/admin'/>"><i class="bi bi-gear"></i>블라인드 게시글</a>
                                            <a class="dropdown-item" href="<c:url value='/board/boardlist/3'/>"><i class="bi bi-gear"></i>건의 게시글</a>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li class="logout-section">
                                            <form action="<c:url value='/logout'/>" method="post" style="display:inline;">
                                                <sec:csrfInput/>
                                                <button type="submit" class="btn btn-logout">로그아웃</button>
                                            </form>
                                        </li>
                                    </ul>
                                </sec:authorize>

                                <!-- 일반 회원일 경우 -->
                                <sec:authorize access="!hasRole('ROLE_SUPER_ADMIN')">
                                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuLink">
                                        <li class="user-info text-center">
                                            <h4><sec:authentication property="principal.nickname"/></h4>
                                        </li>
                                        <li>
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
                                            <a class="dropdown-item" href="<c:url value='/user/myProducts'/>"><i class="bi bi-box-seam"></i> 중고장터 글</a>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li class="logout-section">
                                            <form action="<c:url value='/logout'/>" method="post" style="display:inline;">
                                                <sec:csrfInput/>
                                                <button type="submit" class="btn btn-logout">로그아웃</button>
                                            </form>
                                        </li>
                                    </ul>
                                </sec:authorize>
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
                url: '/final/user/getUserInfo',  
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
