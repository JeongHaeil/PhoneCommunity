<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="card custom-card">
	<div class="card-body">
		<h2 class="mb-4 custom-title">유저 목록</h2>
		<div class="table-responsive">
			<table class="table custom-table">
				<!-- 테이블 내용 -->
				<thead>
					<tr>
						<th>번호</th>
						<th>아이디</th>
						<th>이메일</th>
						<th>닉네임</th>
						<th>이름</th>
						<th>가입일</th>
						<th>유저상태</th>
						<th>정지종료일</th>
						<th>상태변경</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="user" items="${resultMap.totalUserBoardList}">
						<tr>
							<td>${user.userNum}</td>
							<td class="ellipsis">${user.userId}</td>
							<td>${user.userEmail}</td>
							<td>${user.userNickname}</td>
							<td>${user.userName}</td>
							<td>${user.userRegisterDate}</td>
							<td>${user.userStatus}</td>
							<td>${user.expiryDate}</td>
							<td>
								<div class="d-flex flex-wrap justify-content-center">
									<button class="custom-btn btn btn-sm "
										onclick="changeUserStatus(${user.userNum}, 1, 0)">제제
										해제</button>
									<button class="btn btn-sm custom-btn"
										onclick="changeUserStatus(${user.userNum}, 3, 60)">1분
										벤</button>
									<button class="btn btn-sm custom-btn"
										onclick="changeUserStatus(${user.userNum}, 3, 86400)">1일
										벤</button>
									<button class="btn btn-sm custom-btn"
										onclick="changeUserStatus(${user.userNum}, 3, 259200)">3일
										벤</button>
									<button class="btn btn-sm custom-btn"
										onclick="changeUserStatus(${user.userNum}, 3, 432000)">5일
										벤</button>
									<button class="btn btn-sm custom-btn"
										onclick="changeUserStatus(${user.userNum}, 3, 604800)">7일
										벤</button>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
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
			<c:if test="${resultMap.pager.nextPage <= resultMap.pager.totalPage}">
				<li class="page-item"><a class="page-link" href="#"
					data-page="${resultMap.pager.nextPage}" aria-label="Next">&raquo;</a>
				</li>
			</c:if>
		</ul>
	</nav>

	<form id="searchForm" class="d-flex mt-4">
		<select name="search" class="form-select me-2 custom-form-focus">
			<option value="userId" ${search == 'userId' ? 'selected' : ''}>아이디</option>
			<option value="userNum" ${search == 'userNum' ? 'selected' : ''}>유저번호</option>
			<option value="userNickname"
				${search == 'userNickname' ? 'selected' : ''}>닉네임</option>
		</select> <input type="text" name="keyword" placeholder="검색어 입력"
			value="${keyword}" class="form-control me-2 custom-form-focus">
		<button type="submit" class="btn custom-primary-btn">검색</button>
	</form>
</div>

<script>
$(document).ready(function() {
    $('#searchForm').on('submit', function(e) {
        e.preventDefault();
        loadUserList(1);
    });
});

function changeUserStatus(userNum, userStatus, duration) {
    $.ajax({
        type: "PUT",
        url: "<c:url value='/super_admin/admin/userStatus'/>",
        data: JSON.stringify({"userNum": userNum, "userStatus": userStatus, "duration": duration}),
        contentType: "application/json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(response) {
            alert("유저 상태가 성공적으로 변경되었습니다.");
            loadUserList(1);
        },
        error: function(xhr) {
            alert("에러코드 = " + xhr.status + ": " + xhr.responseText);
        }
    });
}
</script>