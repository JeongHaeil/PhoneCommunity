<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스팸 게시판</title>
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <!-- 스팸 게시판 영역 (col-8) -->
            <div class="col-md-12">
                <h2 class="mb-4">스팸 게시판</h2>
                <div class="card">
                    <div class="card-body">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">제목</th>
                                    <th scope="col">작성자</th>
                                    <th scope="col">작성일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- 게시글 출력 부 -->
                                <c:forEach var="article" items="${resultMap.spamBoardList}">
                                    <tr>
                                        <!-- 게시글 번호 -->
                                        <td>${article.boardPostIdx}</td>
                                        <!-- 제목 -->
                                        <td>${article.boardTitle}</td>
                                        <!-- 작성자 -->
                                        <td>${article.userNickname}</td>
                                        <!-- 작성일 -->
                                        <td>${article.boardRegisterDate}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <!-- 페이징 처리 -->
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <!-- 이전 페이지 링크 -->
                                <c:if test="${resultMap.pager.prevPage > 0}">
                                    <li class="page-item">
                                        <a class="page-link" href="?pageNum=${resultMap.pager.prevPage}&search=${search}&keyword=${keyword}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:if>

                                <!-- 페이지 번호 링크 -->
                                <c:forEach begin="${resultMap.pager.startPage}" end="${resultMap.pager.endPage}" var="i">
                                    <li class="page-item ${i == resultMap.pager.pageNum ? 'active' : ''}">
                                        <a class="page-link" href="?pageNum=${i}&search=${search}&keyword=${keyword}">${i}</a>
                                    </li>
                                </c:forEach>

                                <!-- 다음 페이지 링크 -->
                                <c:if test="${resultMap.pager.nextPage <= resultMap.pager.totalPage}">
                                    <li class="page-item">
                                        <a class="page-link" href="?pageNum=${resultMap.pager.nextPage}&search=${search}&keyword=${keyword}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>

                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>