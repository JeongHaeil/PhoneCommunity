<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>삭제된 게시글</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">삭제된 게시글입니다</h1>
        <p class="text-center">해당 게시글은 삭제되었거나 존재하지 않는 게시글입니다.</p>
        <div class="text-center">
            <a href="${pageContext.request.contextPath}/board/boardlist" class="btn btn-primary">게시판으로 돌아가기</a>
        </div>
    </div>
</body>
</html>
