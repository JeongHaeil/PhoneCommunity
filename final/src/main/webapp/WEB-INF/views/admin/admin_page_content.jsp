<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
					<tbody>
						<c:forEach var="article" items="${resultMap.spamBoardList}">
							<tr
								style="cursor: pointer; <c:if test='${article.boardStatus == 4}'>background-color: #333333;</c:if>'"
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
						<li class="page-item"><a class="page-link" href="#"
							data-page="${resultMap.pager.prevPage}" aria-label="Previous">&laquo;</a>
						</li>
					</c:if>
					<c:forEach begin="${resultMap.pager.startPage}"
						end="${resultMap.pager.endPage}" var="i">
						<li
							class="page-item ${i == resultMap.pager.pageNum ? 'active' : ''}">
							<a class="page-link" href="#" data-page="${i}">${i}</a>
						</li>
					</c:forEach>
					<c:if
						test="${resultMap.pager.nextPage <= resultMap.pager.totalPage}">
						<li class="page-item"><a class="page-link" href="#"
							data-page="${resultMap.pager.nextPage}" aria-label="Next">&raquo;</a>
						</li>
					</c:if>
				</ul>
			</nav>

			<form id="searchForm" class="d-flex mt-4">
				<select name="search" class="form-select me-2 custom-form-focus">
					<option value="boardPostIdx"
						${searchType == 'boardPostIdx' ? 'selected' : ''}>글번호</option>
					<option value="boardTitle"
						${searchType == 'boardTitle' ? 'selected' : ''}>제목</option>
					<option value="userNickname"
						${searchType == 'userNickname' ? 'selected' : ''}>작성자</option>
				</select> <input type="text" name="keyword" placeholder="검색어 입력"
					value="${keyword}" class="form-control me-2 custom-form-focus">
				<button type="submit" class="btn custom-primary-btn">검색</button>
			</form>
		</div>
	</div>

