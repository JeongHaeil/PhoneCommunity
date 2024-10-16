<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작성 글 보기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* body 스타일 설정 */
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }

        /* container 스타일 설정 */
        .write-post-container {
            margin-top: 30px;
        }

        /* header-title 스타일 설정 */
        .write-post-header-title {
            font-weight: bold;
            font-size: 1.5rem;
            margin-bottom: 20px;
        }

        /* post-table 스타일 설정 */
        .write-post-table {
            width: 100%;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-collapse: collapse;
            table-layout: fixed; /* 열 너비 고정 */
        }

        /* post-table th, td 스타일 설정 */
        .write-post-table th, .write-post-table td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #dee2e6;
            word-wrap: break-word; /* 긴 텍스트 줄바꿈 */
            word-break: break-all;  /* 긴 단어 줄바꿈 */
        }

        /* post-table th 스타일 */
        .write-post-table th {
            background-color: #f1f1f1;
            font-weight: bold;
        }

        /* post-item hover 효과 */
        .write-post-item:hover {
            background-color: #f7f7f7;
        }

        /* 작성한 글이 없을 경우 */
        .write-no-post-message {
            text-align: center;
            padding: 20px;
            font-size: 1rem;
            color: #999;
        }

        /* 페이지네이션 버튼 스타일 */
        .write-pagination {
            margin-top: 20px;
            display: flex;
            justify-content: center;
        }

        .write-pagebtn {
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

        .write-pagebtn:hover {
            background-color: #444; 
            color: #fff;
        }

        .write-apagebtn {
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

        .write-apagebtn:hover {
            color: #fff;
        }
    </style>
</head>
<body>

<div class="write-post-container container">
    <!-- 탭 include -->
    <jsp:include page="/WEB-INF/views/user/mypageTabs.jsp">
        <jsp:param name="activeTab" value="myWrite" />
    </jsp:include>

    <h3 class="write-post-header-title">작성 글 보기</h3>
    
    <table class="write-post-table">
        <thead>
            <tr>
                <th style="width: 10%;">번호</th>
                <th style="width: 40%;">제목</th>
                <th style="width: 15%;">날짜</th>
                <th style="width: 10%;">조회 수</th>
                <th style="width: 10%;">추천 수</th>
                <th style="width: 15%;">상태</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty postList}">
                    <tr>
                        <td colspan="6" class="write-no-post-message">작성한 글이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="post" items="${postList}" varStatus="status">
                        <tr class="write-post-item">
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
    <div class="write-pagination">
        <c:if test="${pager.startPage > 1}">
            <a href="?pageNum=${pager.prevPage}" class="write-pagebtn">◀</a>
        </c:if>

        <c:forEach var="i" begin="${pager.startPage}" end="${pager.endPage}">
            <c:choose>
                <c:when test="${i != pager.pageNum}">
                    <a href="?pageNum=${i}" class="write-pagebtn">${i}</a>
                </c:when>
                <c:otherwise>
                    <span class="write-apagebtn">${i}</span>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${pager.endPage < pager.totalPage}">
            <a href="?pageNum=${pager.nextPage}" class="write-pagebtn">▶</a>
        </c:if>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
