<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>스팸 게시판</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .custom-bg { background-color: #f8f9fa; }
        .custom-container { max-width: 1200px; }
        .custom-card { border: none; box-shadow: 0 0 15px rgba(0,0,0,0.0); }
        .custom-table { border-collapse: separate; border-spacing: 0; }
        .custom-table th, .custom-table td { white-space: nowrap; padding: 15px; vertical-align: middle; }
        .custom-table thead th { background-color: #343a40; color: white; font-weight: 600; text-transform: uppercase; }
        .custom-table tbody tr:nth-child(even) { background-color: #f8f9fa; }
        .custom-btn {
            white-space: nowrap;
            border: 1px solid #343a40;
            color: #343a40;
            background-color: transparent;
            transition: all 0.3s ease;
            margin: 2px;
            padding: 5px 10px;
        }
        .custom-btn:hover { background-color: #343a40; color: white; }
        .custom-pagination .page-item.active .page-link { background-color: #343a40; border-color: #343a40; }
        .custom-pagination .page-link { color: #343a40; }
        .custom-pagination .page-link:hover { background-color: #343a40; color: white; }
        .custom-primary-btn { background-color: #343a40; border-color: #343a40; color: white; }
        .custom-primary-btn:hover { background-color: #23272b; border-color: #23272b; }
        .custom-form-focus:focus { border-color: #343a40; box-shadow: 0 0 0 0.2rem rgba(52, 58, 64, 0.25); }
        .custom-title { color: #343a40; font-weight: bold; }
    </style>
</head>
<body class="custom-bg">
    <div class="container custom-container mt-5">
        <div class="card custom-card">
            <div class="card-body">
                <h2 class="mb-4 custom-title">스팸 게시판</h2>
                <div class="table-responsive">
                    <table class="table custom-table">
                        <thead>
                            <tr>
                                <th>글번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>작성일</th>
                            </tr>
                        </thead>
                        <!-- 
                        <tbody>
                            <c:forEach var="article" items="${resultMap.spamBoardList}">
                                <tr style="cursor: pointer;" onclick="location.href='admin/view?boardPostIdx=${article.boardPostIdx}'">
                                    <td>${article.boardPostIdx}</td>
                                    <td>${article.boardTitle}</td>
                                    <td>${article.userNickname}</td>
                                    <td>${article.boardRegisterDate}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        -->
                        <tbody>
    <c:forEach var="article" items="${resultMap.spamBoardList}">
        <tr style="cursor: pointer; <c:if test='${article.boardStatus == 4}'>background-color: #333333;</c:if>'" 
            onclick="location.href='admin/view?boardPostIdx=${article.boardPostIdx}'">
            <td>${article.boardPostIdx}</td>
            <td>${article.boardTitle}</td>
            <td>${article.userNickname}</td>
            <td>${article.boardRegisterDate}</td>
        </tr>
    </c:forEach>
</tbody>
                    </table>
                </div>

                <nav aria-label="Page navigation bar" class="mt-4">
                    <ul class="pagination justify-content-center custom-pagination">
                        <c:if test="${resultMap.pager.prevPage > 0}">
                            <li class="page-item">
                                <a class="page-link" href="?pageNum=${resultMap.pager.prevPage}&search=${search}&keyword=${keyword}" aria-label="Previous">&laquo;</a>
                            </li>
                        </c:if>
                        <c:forEach begin="${resultMap.pager.startPage}" end="${resultMap.pager.endPage}" var="i">
                            <li class="page-item ${i == resultMap.pager.pageNum ? 'active' : ''}">
                                <a class="page-link" href="?pageNum=${i}&search=${search}&keyword=${keyword}">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${resultMap.pager.nextPage <= resultMap.pager.totalPage}">
                            <li class="page-item">
                                <a class="page-link" href="?pageNum=${resultMap.pager.nextPage}&search=${search}&keyword=${keyword}" aria-label="Next">&raquo;</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>

                <form method="get" class="d-flex mt-4">
                    <select name="search" class="form-select me-2 custom-form-focus">
                        <option value="boardPostIdx" ${searchType == 'boardPostIdx' ? 'selected' : ''}>글번호</option>
                        <option value="boardTitle" ${searchType == 'boardTitle' ? 'selected' : ''}>제목</option>
                        <option value="userNickname" ${searchType == 'userNickname' ? 'selected' : ''}>작성자</option>
                    </select>
                    <input type="text" name="keyword" placeholder="검색어 입력" value="${keyword}" class="form-control me-2 custom-form-focus">
                    <button type="submit" class="btn custom-primary-btn">검색</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
