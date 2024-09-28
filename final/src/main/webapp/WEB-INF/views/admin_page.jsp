<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 페이지</title>
    <!-- 부트스트랩 추가 (필요에 따라 스타일링을 추가할 수 있습니다) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1>관리자 페이지</h1>
        <p>이 페이지는 <strong>ROLE_SUPER_ADMIN</strong> 권한이 있는 사용자만 접근할 수 있습니다.</p>

        <!-- 예시로 몇 가지 관리자 기능을 표시합니다 -->
        <div class="mt-4">
            <h3>관리자 기능</h3>
            <ul>
                <li><a href="#">사용자 관리</a></li>
                <li><a href="#">게시판 설정</a></li>
                <li><a href="#">사이트 통계 보기</a></li>
            </ul>
        </div>
    </div>

    <!-- 부트스트랩 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
