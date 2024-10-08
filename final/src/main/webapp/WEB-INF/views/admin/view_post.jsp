<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>게시글 상세보기</title>
</head>
<body>
<h2>게시글 상태 변경 / 유저 상태 변경</h2>

<h2>${post.boardTitle}</h2>
<p>작성자: ${post.userNickname}</p>
<p>작성일: ${post.boardRegisterDate}</p>

<div>${post.boardContent}</div>

<a href="/super_admin/admin">목록으로 돌아가기</a>

</body>
</html>