<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
    .admin-page-bg { background-color: #f8f9fa; }
    .admin-page-container { max-width: 1200px; }
    .admin-page-card { border: none; box-shadow: 0 0 15px rgba(0,0,0,0.0); }
    .admin-page-table { border-collapse: separate; border-spacing: 0; }
    .admin-page-table th, .admin-page-table td { white-space: nowrap; padding: 15px; vertical-align: middle; }
    .admin-page-table thead th { background-color: #343a40; color: white; font-weight: 600; text-transform: uppercase; }
    .admin-hoverable:hover {
	    background-color: #343a40; opacity : 0.8; 
	}
    .admin-page-btn {
        white-space: nowrap;
        border: 1px solid #343a40;
        color: #343a40;
        background-color: transparent;
        transition: all 0.3s ease;
        margin: 2px;
        padding: 5px 10px;
        border-radius: 0.25rem;
    }
    .admin-page-btn:hover { background-color: #343a40; color: white; }
    .admin-page-pagination .page-item.active .page-link { background-color: #343a40; border-color: #343a40; }
    .admin-page-pagination .page-link { color: #343a40; }
    .admin-page-pagination .page-link:hover { background-color: #343a40; color: white; }
    .admin-page-primary-btn { 
		white-space: nowrap;
        border: 1px solid #343a40;
        color: #343a40;
        background-color: transparent;
        transition: all 0.3s ease;
        margin: 2px;
        padding: 5px 10px;
        border-radius: 0.25rem;
	 }
    .admin-page-primary-btn:hover { background-color: #343a40; color: white; }
    .admin-page-form-focus:focus { border-color: #343a40; box-shadow: 0 0 0 0.2rem rgba(52, 58, 64, 0.25); }
    .admin-page-title { color: #343a40; font-weight: bold; }
    
</style>

<script>
$(document).ready(function() {
	// 페이지 로드 시 현재 페이지 번호를 로컬 스토리지에 저장
	localStorage.setItem('currentSpamBoardPage', '${resultMap.pager.pageNum}');
	
	// 게시물 클릭 시 이벤트
	$('tr[onclick]').each(function() {
		var $this = $(this);
		var originalOnclick = $this.attr('onclick');
		$this.removeAttr('onclick');
		$this.on('click', function(e) {
			e.preventDefault();
			var href = originalOnclick.match(/'([^']+)'/)[1];
			location.href = href + '&prevPage=' + localStorage.getItem('currentSpamBoardPage');
		});
	});
});
</script>

	<div class="card admin-page-card">
		<div class="card-body">
			<h2 class="mb-4 admin-page-title">스팸 게시판</h2>
			<div class="admin-page-table-container">
				<table class="table admin-page-table">
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
						        style="cursor: pointer; <c:if test='${article.boardStatus == 4}'>background-color: #D8D8D8; opacity : 0.8;</c:if>'"
						        onclick="location.href='admin/view?boardPostIdx=${article.boardPostIdx}'"
						        class="<c:if test='${article.boardStatus != 4}'>admin-hoverable</c:if>">
						        <td>${article.boardPostIdx}</td>
						        <td>${article.boardTitle}</td>
						        <td>${article.userNickname}</td>
						        <td>${fn:substring(article.boardRegisterDate, 0, 10)}</td>
						    </tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<nav aria-label="Page navigation bar" class="mt-4">
				<ul class="pagination justify-content-center admin-page-pagination">
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
				<select name="search" class="form-select me-2 admin-page-form-focus">
					<option value="boardPostIdx"
						${searchType == 'boardPostIdx' ? 'selected' : ''}>글번호</option>
					<option value="boardTitle"
						${searchType == 'boardTitle' ? 'selected' : ''}>제목</option>
					<option value="userNickname"
						${searchType == 'userNickname' ? 'selected' : ''}>작성자</option>
				</select> <input type="text" name="keyword" placeholder="검색어 입력"
					value="${keyword}" class="form-control me-2 admin-page-form-focus">
				<button type="submit" class=" admin-page-primary-btn">검색</button>
			</form>
		</div>
	</div>
