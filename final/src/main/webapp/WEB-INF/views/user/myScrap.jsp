<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스크랩 보기</title>
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
        .scrap-table {
            width: 100%;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-collapse: collapse;
        }
        .scrap-table th, .scrap-table td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #dee2e6;
        }
        .scrap-table th {
            background-color: #f1f1f1;
            font-weight: bold;
        }
        .scrap-item {
            background-color: #fff;
            margin-bottom: 10px;
        }
        .scrap-item:hover {
            background-color: #f7f7f7;
        }
        .no-scrap-message {
            text-align: center;
            padding: 20px;
            font-size: 1rem;
        }
    </style>
</head>
<body>

<div class="container">
  <!-- 탭 include -->
    <jsp:include page="/WEB-INF/views/user/mypageTabs.jsp">
        <jsp:param name="activeTab" value="myScrap" />
    </jsp:include>
    <h3 class="header-title">스크랩 보기</h3>
    
    <table class="scrap-table">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>글쓴이</th>
                <th>날짜</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty scrapList}">
                    <tr>
                        <td colspan="5" class="no-scrap-message">스크랩한 글이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="scrap" items="${scrapList}" varStatus="status">
                        <tr class="scrap-item">
                            <td>${status.index + 1}</td>
                            <td><a href="/final/post/${scrap.postId}">${scrap.title}</a></td>
                            <td>${scrap.author}</td>
                            <td>${scrap.date}</td>
                            <td>
                                <form action="/final/scrap/delete" method="post">
                                    <input type="hidden" name="scrapId" value="${scrap.scrapId}">
                                    <button type="submit" class="btn btn-danger btn-sm">삭제</button>
                                </form>
                            </td>
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
