<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>게시글 상세보기</title>
</head>
<body>
<h2>게시글 상태 변경 / 유저 상태 변경</h2>

<div class="container text-center mt-5">
    <button class="btn btn-outline-dark" onclick="changeUserStatus(${post.boardUserId}, 1);">사용자 상태 변경</button>
    <button class="btn btn-outline-dark" onclick="changeBoardStatus(${post.boardPostIdx}, 1);">게시물 상태 변경</button>
    <button class="btn btn-outline-dark" onclick="changeBoardStatus(72, 1);">게시물 상태 변경</button>
</div>

<div class="col-8"></div>
<h2>${post.boardTitle}</h2>
<h2>${post.boardPostIdx }</h2>
<p>작성자: ${post.userNickname}</p>
<p>이메일: ${post.userEmail}</p>
<p>전화번호: ${post.userPhoneNum}</p>
<p>가입일: ${post.userRegisterDate}</p>
<p>작성일: ${post.boardRegisterDate}</p>

<div>${post.boardContent}</div>


<a href="/final/super_admin/admin">목록으로 돌아가기</a>
<a href="<c:url value='/super_admin/admin'/>">목록으로 돌아가기</a>

<!--  -->

<script type="text/javascript">
function changeUserStatus(userId, status) {
    if (confirm("사용자 상태를 변경하시겠습니까?")) {
        $.ajax({
            type: "PUT",
            url: "<c:url value='/super_admin/admin/userStatus'/>",
            data: { userId: userId, status: status },
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(response) {
                alert(response);
                location.reload();
            },
            error: function(xhr) {
                alert("에러코드 = " + xhr.status);
            }
        });
    }
}

function changeBoardStatus(boardPostIdx, status) {
	console.log("boardPostIdx:", boardPostIdx);
    if (confirm("게시물 상태를 변경하시겠습니까?")) {
        $.ajax({
            type: "PUT",
            url: "<c:url value='/super_admin/admin/boardStatus'/>",
            //url: "<c:url value='/admin/board/status'/>",
            data: { boardPostIdx: boardPostIdx, status: status },
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(response) {
                alert(response);
                location.reload();
            },
            error: function(xhr) {
                alert("에러코드 = " + xhr.status);
            }
        });
    }
}
</script>

</body>
</html>