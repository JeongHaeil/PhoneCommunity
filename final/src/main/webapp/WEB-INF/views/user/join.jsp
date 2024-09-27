<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .signup-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h4 {
            margin-bottom: 30px;
            font-weight: bold;
            color: #333;
            text-align: center;
        }
        .form-control {
            border-radius: 10px;
            padding: 10px;
        }
        .phone-number-container {
            display: flex;
            justify-content: space-between;
        }
        .phone-number-container input {
            width: 32%;
        }
        .btn-signup {
            background-color: #f86d6d;
            color: white;
            border-radius: 20px;
            width: 100%;
            padding: 10px;
            margin-top: 20px;
        }
        .btn-signup:hover {
            background-color: #f75c5c;
        }
        .alert-info {
            margin-top: 20px;
            padding: 15px;
            background-color: #e9ecef;
            border-radius: 10px;
        }
        .validation-message {
            margin-top: 5px;
            font-size: 0.9em;
        }
    </style>
</head>
<body>

<div class="signup-container">
    <h4>회원가입</h4>
    <form id="signupForm" action="${pageContext.request.contextPath}/user/register" method="post">
        <div class="mb-3">
            <label for="user_id" class="form-label">아이디</label>
            <input type="text" class="form-control" id="user_id" name="userId" placeholder="아이디를 입력하세요" required>
            <div id="userIdCheck" class="validation-message"></div>
        </div>
        <div class="mb-3">
            <label for="user_password" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="user_password" name="userPassword" placeholder="비밀번호를 입력하세요" required>
        </div>
        <div class="mb-3">
            <label for="user_password_confirm" class="form-label">비밀번호 확인</label>
            <input type="password" class="form-control" id="user_password_confirm" placeholder="비밀번호를 다시 입력하세요" required>
        </div>
        <div class="mb-3">
            <label for="user_email" class="form-label">이메일</label>
            <input type="email" class="form-control" id="user_email" name="userEmail" placeholder="이메일 주소를 입력하세요" required>
        </div>
        <div class="mb-3">
            <label for="user_phone_number" class="form-label">핸드폰 번호</label>
            <div class="phone-number-container">
                <input type="text" class="form-control" id="phone_first" maxlength="3" placeholder="010" required>
                <input type="text" class="form-control" id="phone_middle" maxlength="4" placeholder="0000" required>
                <input type="text" class="form-control" id="phone_last" maxlength="4" placeholder="0000" required>
            </div>
            <input type="hidden" id="user_phone_number" name="userPhoneNumber">
        </div>
        <div class="mb-3">
            <label for="user_name" class="form-label">이름</label>
            <input type="text" class="form-control" id="user_name" name="userName" placeholder="이름을 입력하세요" required>
        </div>
        <div class="mb-3">
            <label for="nickname" class="form-label">닉네임</label>
            <input type="text" class="form-control" id="nickname" name="userNickName" placeholder="닉네임을 입력하세요" required>
            <div id="nicknameCheck" class="validation-message"></div>
        </div>
        <button type="submit" class="btn btn-signup">가입하기</button>
    </form>

    <div class="alert alert-info" role="alert" style="display: none;" id="email-verification-message">
        회원가입이 완료되었습니다. 계정을 활성화하려면 이메일을 확인하고 인증 링크를 클릭하세요.
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    document.getElementById('signupForm').addEventListener('submit', function(e) {
        var phoneFirst = document.getElementById('phone_first').value;
        var phoneMiddle = document.getElementById('phone_middle').value;
        var phoneLast = document.getElementById('phone_last').value;
        document.getElementById('user_phone_number').value = phoneFirst + '-' + phoneMiddle + '-' + phoneLast;
    });

    document.getElementById('signupForm').addEventListener('submit', function(e) {
        var password = document.getElementById('user_password').value;
        var confirmPassword = document.getElementById('user_password_confirm').value;
        if (password !== confirmPassword) {
            alert("비밀번호가 일치하지 않습니다.");
            e.preventDefault();
        }
    });

    $(document).ready(function() {
        $("#user_id").on("keyup", function() {
            var userId = $(this).val();
            $.ajax({
                url: "${pageContext.request.contextPath}/user/checkUserId",
                type: "GET",
                data: { userId: userId },
                success: function(response) {
                    if (response === "AVAILABLE") {
                        $("#userIdCheck").text("사용 가능한 아이디입니다.").css("color", "green");
                    } else {
                        $("#userIdCheck").text("이미 존재하는 아이디입니다.").css("color", "red");
                    }
                }
            });
        });

        $("#nickname").on("keyup", function() {
            var userNickName = $(this).val();
            $.ajax({
                url: "${pageContext.request.contextPath}/user/checkNickname",
                type: "GET",
                data: { userNickName: userNickName },
                success: function(response) {
                    if (response === "AVAILABLE") {
                        $("#nicknameCheck").text("사용 가능한 닉네임입니다.").css("color", "green");
                    } else {
                        $("#nicknameCheck").text("이미 존재하는 닉네임입니다.").css("color", "red");
                    }
                }
            });
        });
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
