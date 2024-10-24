<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<meta charset="UTF-8">
<title>게시글 상세보기</title>

<style>
.custom-bg {
	background-color: #f8f9fa;
}

.custom-container {
	max-width: 800px;
	margin: auto;
}

.custom-card {
	border: none;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
	margin-top: 20px;
}

.custom-card-header {
	background-color: #343a40;
	color: white;
	padding: 15px;
}

.custom-card-body {
	padding: 20px;
}

.custom-btn {
	white-space: nowrap;
	border: 1px solid #343a40;
	color: #343a40;
	background-color: transparent;
	transition: all 0.3s ease;
	margin: 5px;
	padding: 5px 10px;
	border-radius: 0.25rem;
}

.custom-btn:hover {
	background-color: #343a40;
	color: white;
}

.custom-title {
	color: #343a40;
	font-weight: bold;
}

.post-content {
	margin-top: 20px;
	border-top: 1px solid #dee2e6;
	padding-top: 20px;
}

.post-info {
	margin-bottom: 10px;
}

.post-info span {
	margin-right: 15px;
}

.no-underline {
	text-decoration: none;
}
</style>

<div class="custom-bg">
	<div class="custom-container">
		<div class="custom-card">
			<div class="custom-card-header">
				<h2 class="custom-title">${post.boardTitle}</h2>
			</div>
			<div class="custom-card-body">
				<div class="post-info">
					<span>작성자: ${post.userNickname}</span> <span>작성일:
						${post.boardRegisterDate}</span> <span>게시물 번호:
						${post.boardPostIdx}</span>
				</div>
				<div class="post-info">
					<span>유저번호: ${post.userNum}</span> <span>이메일:
						${post.userEmail}</span> <span>전화번호: ${post.userPhoneNum}</span>
				</div>
				<div class="post-info">
					<span>가입일: ${post.userRegisterDate}</span>
					<span>게시물상태: <c:choose>
							<c:when test="${post.boardStatus == 0}">
				            삭제
				        </c:when>
							<c:when test="${post.boardStatus == 1}">
				            일반
				        </c:when>
							<c:when test="${post.boardStatus == 3}">
				            제제
				        </c:when>
				        	<c:when test="${post.boardStatus == 4}">
				            관리자 삭제 대기
				        </c:when>
							<c:when test="${post.boardStatus == 5}">
				            관리자 삭제 처리
				        </c:when>
						<c:otherwise>
				            알 수 없음
				        </c:otherwise>
						</c:choose>
					</span>
					<span>유저상태: <c:choose>
							<c:when test="${post.userStatus == 0}">
				            삭제
				        </c:when>
							<c:when test="${post.userStatus == 1}">
				            일반
				        </c:when>
							<c:when test="${post.userStatus == 3}">
				            제제
				        </c:when>
							<c:otherwise>
				            알 수 없음
				        </c:otherwise>
						</c:choose>
					</span>
				</div>
				<div class="post-content">${post.boardContent}</div>
				<div class="text-center mt-4">
					<button class=" custom-btn"
						onclick="changeUserStatus(${post.userNum}, 3, 86400);">사용자
						상태 변경</button>
					<button class=" custom-btn"
						onclick="changeBoardStatus(${post.boardPostIdx}, 4, 259200);">게시물
						상태 변경</button>
					<button class=" custom-btn no-nuderline" onclick="goBack()">목록으로
						돌아가기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
function goBack() {
    var prevPage = '${prevPage}';
    window.location.href = '<c:url value="/super_admin/dashboard"/>#spam?page=' + prevPage;
}

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
            location.reload();
        },
        error: function(xhr) {
            alert("에러코드 = " + xhr.status + ": " + xhr.responseText);
        }
    });
}

function changeBoardStatus(boardPostIdx, boardStatus, duration) {
    $.ajax({
        type: "PUT",
        url: "<c:url value='/super_admin/admin/boardStatus'/>",
        data: JSON.stringify({"boardPostIdx": boardPostIdx, "boardStatus": boardStatus, "duration": duration}),
        contentType: "application/json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(response) {
            alert("게시물 상태가 성공적으로 변경되었습니다.");
            location.reload();
        },
        error: function(xhr) {
            alert("에러코드 = " + xhr.status + ": " + xhr.responseText);
        }
    });
}
</script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>