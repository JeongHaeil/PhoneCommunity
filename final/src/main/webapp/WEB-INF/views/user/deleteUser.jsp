<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 탈퇴</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .withdraw-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
            
        }
        .withdraw-header {
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }
        .withdraw-btn-custom {
            background-color: #3C3D37;
            color: white;
            border-radius: 5px;
            padding: 10px 15px;
            width: 100%;
            border: none;
            transition: all 0.3s ease;
            cursor: pointer;
            text-align: center;
        }
        .withdraw-btn-custom:hover {
            background-color: #33342e; /* 조금 더 어두운 색상으로 변경하여 호버 효과 */
        }
    </style>
</head>
<body>


<div class="withdraw-container">
    <h3 class="withdraw-header">회원 탈퇴</h3>
    <!-- 탈퇴 요청을 처리할 form -->
    <form id="withdrawForm" action="${pageContext.request.contextPath}/user/userDelete" method="post" onsubmit="return confirmWithdrawal()">
        <!-- CSRF 토큰 추가 -->
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <!-- 비밀번호 -->
        <div class="mb-3">
            <label for="password" class="form-label" style="text-align: center;">비밀번호</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요" required style="text-align: center;">
        </div>

        <!-- 탈퇴 버튼 -->
        <button type="submit" class="withdraw-btn-custom">탈퇴</button>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- JavaScript로 팝업 구현 -->
<script>
    function confirmWithdrawal() {
        return confirm("정말 탈퇴하겠습니까?");
    }
</script>

</body>
</html>
