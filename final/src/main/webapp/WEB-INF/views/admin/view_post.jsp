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
    <button class="btn btn-outline-dark" onclick="changeUserStatus(${post.userNum}, 1);">사용자 상태 변경</button>
    <button class="btn btn-outline-dark" onclick="changeBoardStatus(${post.boardPostIdx}, 1);">게시물 상태 변경</button>
</div>

<div class="col-8"></div>
<h2>${post.boardTitle}</h2>
<h2>${post.boardPostIdx }</h2>
<p>작성자: ${post.userNickname}</p>
<p>유저번호: ${post.userNum}</p>
<p>이메일: ${post.userEmail}</p>
<p>전화번호: ${post.userPhoneNum}</p>
<p>가입일: ${post.userRegisterDate}</p>
<p>작성일: ${post.boardRegisterDate}</p>

<div>${post.boardContent}</div>


<a href="<c:url value='/super_admin/admin'/>">목록으로 돌아가기</a>


<script type="text/javascript">

function changeUserStatus(userId, status) {
	console.log("userId:", userId);
	
    if (confirm("사용자 상태를 변경하시겠습니까?")) {
        $.ajax({
            type: "get",
            url: "<c:url value='/super_admin/admin/userStatus'/>",
            data: { "userId": userId, "status": status },
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            dataType: "text",
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
/*
function changeBoardStatus(boardPostIdx, status) {
	 
	console.log("boardPostIdx:", boardPostIdx);
    if (confirm("게시물 상태를 변경하시겠습니까?")) {
        $.ajax({
            type: "get",
            url: "<c:url value='/super_admin/admin/boardStatus'/>",
            data: { "boardPostIdx": boardPostIdx, "status": status },
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            dataType: "text",
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
*/
function changeBoardStatus(boardPostIdx, status) {
    // 콘솔에 boardPostIdx 값을 출력하여 디버깅에 도움을 줍니다.
    console.log("boardPostIdx:", boardPostIdx);

    // 사용자에게 게시물 상태를 변경할 것인지 확인하는 대화 상자를 표시합니다.
    if (confirm("게시물 상태를 변경하시겠습니까?")) {
        // AJAX 요청을 통해 서버와 비동기적으로 통신합니다.
        $.ajax({
            type: "PUT",  // HTTP 메서드를 PUT으로 설정하여 리소스를 업데이트하도록 지정합니다.
            url: "<c:url value='/super_admin/admin/boardStatus'/>",  // 서버 측 엔드포인트 URL입니다. JSP에서 URL을 생성합니다.
            data: JSON.stringify({ "boardPostIdx": boardPostIdx, "status": status }),  // 요청 본문에 JSON 형식으로 데이터를 포함시킵니다.
            contentType: "application/json",  // 서버에 전송하는 데이터의 형식을 JSON으로 지정합니다.
            beforeSend: function(xhr) {
                // 요청을 보내기 전에 CSRF 토큰을 헤더에 설정하여 보안을 강화합니다.
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");  // CSRF 토큰이 JSP에서 올바르게 설정되었는지 확인합니다.
            },
            dataType: "text",  // 서버로부터 받을 데이터의 형식을 텍스트로 지정합니다.
            success: function(response) {
                // 요청이 성공적으로 완료되면 서버의 응답을 알림으로 표시하고 페이지를 새로고침합니다.
                alert(response);
                location.reload();
            },
            error: function(xhr) {
                // 요청이 실패하면 오류 코드를 포함한 상세한 오류 메시지를 알림으로 표시합니다.
                alert("에러코드 = " + xhr.status + ": " + xhr.responseText);  // 더 자세한 오류 피드백을 제공하여 문제 해결에 도움을 줍니다.
            }
        });
    }
}

</script>

</body>
</html>