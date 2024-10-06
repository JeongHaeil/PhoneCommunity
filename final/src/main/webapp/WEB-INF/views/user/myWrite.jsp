<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작성 글 보기</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .container {
            margin-top: 30px;
        }
        .header-title {
            font-weight: bold;
            font-size: 1.5rem;
            margin-bottom: 20px;
        }
        .post-table {
            width: 100%;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-collapse: collapse;
        }
        .post-table th, .post-table td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #dee2e6;
        }
        .post-table th {
            background-color: #f1f1f1;
            font-weight: bold;
        }
        .post-item {
            background-color: #fff;
            margin-bottom: 10px;
        }
        .post-item:hover {
            background-color: #f7f7f7;
        }
        .no-post-message {
            text-align: center;
            padding: 20px;
            font-size: 1rem;
            color: #999;
        }
    </style>
</head>
<body>

<div class="container">
    <!-- 탭 include -->
    <jsp:include page="/WEB-INF/views/user/mypageTabs.jsp">
        <jsp:param name="activeTab" value="myWrite" />
    </jsp:include>

    <h3 class="header-title">작성 글 보기</h3>
    
    <table class="post-table">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>날짜</th>
                <th>조회 수</th>
                <th>추천 수</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty postList}">
                    <tr>
                        <td colspan="5" class="no-post-message">작성한 글이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="post" items="${postList}" varStatus="status">
                        <tr class="post-item">
                            <td>${status.index + 1}</td>
                            <td><a href="/post/${post.postId}?${_csrf.parameterName}=${_csrf.token}">${post.title}</a></td>
                            <td>${post.date}</td>
                            <td>${post.viewCount}</td>
                            <td>${post.recommendCount}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <!-- CSRF Token을 포함한 폼 예시 -->
    <form action="/post/new" method="POST">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <!-- 추가할 데이터 입력 -->
        <button type="submit" class="btn btn-primary mt-3">글 작성하기</button>
    </form>

</div>

<!-- CSRF Token을 AJAX 요청에 포함시키기 위한 스크립트 -->
<script type="text/javascript">
    // CSRF 토큰 가져오기
    var csrfParameterName = "${_csrf.parameterName}";
    var csrfToken = "${_csrf.token}";

    // AJAX 설정
    $.ajaxSetup({
        beforeSend: function(xhr, settings) {
            xhr.setRequestHeader(csrfParameterName, csrfToken);
        }
    });

    // AJAX 예시 - 글 삭제 요청
    function deletePost(postId) {
        $.ajax({
            url: '/post/delete/' + postId,
            type: 'POST',
            success: function(result) {
                alert('게시글이 삭제되었습니다.');
                location.reload(); // 페이지를 새로고침하여 게시글 목록을 업데이트
            },
            error: function() {
                alert('게시글 삭제 중 오류가 발생했습니다.');
            }
        });
    }
</script>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
