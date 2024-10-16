<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작성 댓글 보기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* comment-container 내부에만 영향을 미치도록 명확히 지정 */
        .comment-container {
            background-color: #f8f9fa;
        }
        .comment-container .container {
            margin-top: 30px;
        }
        .comment-container .header-title {
            font-weight: bold;
            font-size: 1.5rem;
            margin-bottom: 20px;
        }
        .comment-container .comment-table {
            width: 100%;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-collapse: collapse;
            table-layout: fixed; /* 열 너비 고정 */
        }
        .comment-container .comment-table th, 
        .comment-container .comment-table td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #dee2e6;
            word-wrap: break-word; /* 긴 텍스트 줄바꿈 */
            word-break: break-all;  /* 긴 단어 줄바꿈 */
        }
        .comment-container .comment-table th {
            background-color: #f1f1f1;
            font-weight: bold;
        }
        .comment-container .comment-item {
            background-color: #fff;
            margin-bottom: 10px;
        }
        .comment-container .comment-item:hover {
            background-color: #f7f7f7;
        }
        .comment-container .no-comment-message {
            text-align: center;
            padding: 20px;
            font-size: 1rem;
        }
        .comment-container a {
            text-decoration: none;
        }
        .comment-container a.enabled {
            color: #007bff;
        }
        .comment-container a.disabled {
            color: #999;
            pointer-events: none;
        }
        .pagination {
            margin-top: 20px;
            display: flex;
            justify-content: center;
        }
        .pagebtn {
            border-radius: 32px;
            min-width: 36px;
            padding: 0 4px;
            height: 36px;
            line-height: 36px;
            color: #444;
            text-decoration: none !important;
            display: inline-block;
            font-weight: bold;
            font-size: 12px;
            text-align: center;
        }
        .pagebtn:hover {
            background-color: #444; 
            color: #fff;
        }
        .apagebtn {
            border-radius: 32px;
            min-width: 36px;
            padding: 0 4px;
            height: 36px;
            line-height: 36px;
            color: #fff;
            text-decoration: none !important;
            display: inline-block;
            font-weight: bold;
            font-size: 12px;
            background-color: #444;
            text-align: center;
        }
        .apagebtn:hover {
            color: #fff;
        }
    </style>
</head>
<body>

<div class="comment-container">
    <div class="container">
        <!-- 탭 include -->
        <jsp:include page="/WEB-INF/views/user/mypageTabs.jsp">
            <jsp:param name="activeTab" value="myComment" />
        </jsp:include>

        <h3 class="header-title">작성 댓글 보기</h3>
        
        <!-- 작성한 댓글 조회 -->
        <table class="comment-table">
            <thead>
                <tr>
                    <th style="width: 50%;">댓글</th>
                    <th style="width: 20%;">날짜</th>
                    <th style="width: 15%;">추천/비추천</th>
                    <th style="width: 15%;">상태</th>
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
                        <c:forEach var="comment" items="${commentList}">
                            <tr class="comment-item">
                                <td>
                                    <c:choose>
                                        <c:when test="${comment.commentStatus == 1}">
                                            <c:choose>
                                                <c:when test="${comment.boardStatus == 1}">
                                                    <a href="${pageContext.request.contextPath}/board/comment/${comment.commentIdx}" class="enabled">${comment.content}</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="disabled">게시글 삭제로 댓글 확인 불가</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="disabled">${comment.content}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${comment.commentRegDate}</td>
                                <td>${comment.commentStarup}/${comment.commentStardown}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${comment.commentStatus == 1}">정상</c:when>
                                        <c:when test="${comment.commentStatus == 0}">삭제됨</c:when>
                                        <c:when test="${comment.commentStatus == 3}">제재 상태</c:when>
                                         
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
                <a href="?pageNum=${pager.prevPage}" class="pagebtn">◀</a>
            </c:if>

            <c:forEach var="i" begin="${pager.startPage}" end="${pager.endPage}">
                <c:choose>
                    <c:when test="${i != pager.pageNum}">
                        <a href="?pageNum=${i}" class="pagebtn">${i}</a>
                    </c:when>
                    <c:otherwise>
                        <span class="apagebtn">${i}</span>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${pager.endPage < pager.totalPage}">
                <a href="?pageNum=${pager.nextPage}" class="pagebtn">▶</a>
            </c:if>
        </div>

    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
