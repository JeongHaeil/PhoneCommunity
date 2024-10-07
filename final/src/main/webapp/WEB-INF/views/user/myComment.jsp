<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  <!-- JSTL 코어 태그 선언 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작성 댓글 보기</title>
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
        .comment-table {
            width: 100%;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-collapse: collapse;
        }
        .comment-table th, .comment-table td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #dee2e6;
        }
        .comment-table th {
            background-color: #f1f1f1;
            font-weight: bold;
        }
        .comment-item {
            background-color: #fff;
            margin-bottom: 10px;
        }
        .comment-item:hover {
            background-color: #f7f7f7;
        }
        .no-comment-message {
            text-align: center;
            padding: 20px;
            font-size: 1rem;
        }
    </style>
</head>
<body>
    <!-- 탭 include -->
    <jsp:include page="/WEB-INF/views/user/mypageTabs.jsp">
        <jsp:param name="activeTab" value="myComment" />
    </jsp:include>

<div class="container">
    <h3 class="header-title">작성 댓글 보기</h3>
    
    <table class="comment-table">
        <thead>
            <tr>
                <th>댓글</th>
                <th>삭제</th>
                <th>날짜</th>
                <th>추천/비추천</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty commentList}">
                    <tr>
                        <td colspan="4" class="no-comment-message">작성한 댓글이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="comment" items="${commentList}" varStatus="status">
                        <tr class="comment-item">
                            <td>${comment.content}</td>
                            <td>
                                <form action="/final/comment/delete" method="post">
                                    <input type="hidden" name="commentIdx" value="${comment.commentIdx}">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> <!-- CSRF 토큰 추가 -->
                                    <button type="submit" class="btn btn-danger btn-sm">삭제</button>
                                </form>
                            </td>
                            <td>${comment.commentRegDate}</td>
                            <td>${comment.commentStarup}/${comment.commentStardown}</td> <!-- 수정된 부분 -->
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
