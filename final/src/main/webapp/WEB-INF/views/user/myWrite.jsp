<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작성 글 보기</title>
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
        a.disabled {
            color: #999;
            pointer-events: none;
        }
        .pagination {
            margin-top: 20px;
            display: flex;
            justify-content: center;
        }
        .page-link, .current-page {
            display: inline-block;
            margin: 0 5px;
            padding: 5px 10px;
            font-size: 16px;
            text-decoration: none;
            border: 1px solid #007bff;
            border-radius: 5px;
            color: #007bff;
        }
        .page-link:hover {
            background-color: #ddd;
            color: #007bff;
        }
        .current-page {
            font-weight: bold;
            background-color: #007bff;
            color: white;
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
                <th>상태</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty postList}">
                    <tr>
                        <td colspan="6" class="no-post-message">작성한 글이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="post" items="${postList}" varStatus="status">
                        <tr class="post-item">
                            <td>${(pager.pageNum - 1) * pager.pageSize + status.index + 1}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${post.boardStatus == 1}">
                                        <a href="${pageContext.request.contextPath}/board/boarddetail/${post.boardCode != 0 ? post.boardCode : 10}/${post.boardPostIdx}?pageNum=${pager.pageNum}&search=board_user_id&keyword=">
                                            ${post.boardTitle}
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="disabled">게시글 삭제 또는 제재로 접근 불가</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${post.boardRegisterDate}</td>
                            <td>${post.boardCount > 0 ? post.boardCount : '없음'}</td>
                            <td>${post.boardStarup > 0 ? post.boardStarup : '없음'}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${post.boardStatus == 1}">정상</c:when>
                                    <c:when test="${post.boardStatus == 0}">삭제됨</c:when>
                                    <c:when test="${post.boardStatus == 3}">제재 상태</c:when>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <!-- 페이징 처리 -->
    <div class="pagination">
        <c:if test="${pager.startPage > 1}">
            <a href="?pageNum=${pager.prevPage}" class="page-link">이전</a>
        </c:if>

        <c:forEach var="i" begin="${pager.startPage}" end="${pager.endPage}">
            <c:choose>
                <c:when test="${i != pager.pageNum}">
                    <a href="?pageNum=${i}" class="page-link">${i}</a>
                </c:when>
                <c:otherwise>
                    <span class="current-page">${i}</span>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${pager.endPage < pager.totalPage}">
            <a href="?pageNum=${pager.nextPage}" class="page-link">다음</a>
        </c:if>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
