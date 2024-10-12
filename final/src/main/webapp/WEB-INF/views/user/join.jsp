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
        .phone-number-container select, 
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
            color: red;
        }
    </style>
</head>
<body>

<div class="signup-container">
    <h4>회원가입</h4>
    <form id="signupForm" action="${pageContext.request.contextPath}/user/register" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        
        <!-- 아이디 -->
        <div class="mb-3">
            <label for="user_id" class="form-label">아이디</label>
            <input type="text" class="form-control" id="user_id" name="userId" placeholder="아이디를 입력하세요" required>
            <div id="userIdCheck" class="validation-message"></div>
        </div>

        <!-- 비밀번호 -->
        <div class="mb-3">
            <label for="user_password" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="user_password" name="userPassword" placeholder="비밀번호를 입력하세요" required>
            <div id="passwordValidation" class="validation-message"></div>
        </div>

        <!-- 비밀번호 확인 -->
        <div class="mb-3">
            <label for="user_password_confirm" class="form-label">비밀번호 확인</label>
            <input type="password" class="form-control" id="user_password_confirm" placeholder="비밀번호를 다시 입력하세요" required>
            <div id="passwordConfirmValidation" class="validation-message"></div>
        </div>

        <!-- 이름 -->
        <div class="mb-3">
            <label for="user_name" class="form-label">이름</label>
            <input type="text" class="form-control" id="user_name" name="userName" placeholder="이름을 입력하세요" required>
            <div id="nameValidation" class="validation-message"></div>
        </div>

        <!-- 이메일 -->
        <div class="mb-3">
            <label for="user_email" class="form-label">이메일</label>
            <input type="text" class="form-control" id="user_email" name="userEmail" placeholder="이메일 주소를 입력하세요" required>
            <div id="emailCheck" class="validation-message"></div>
        </div>

        <!-- 핸드폰 번호 -->
        <div class="mb-3">
            <label for="user_phone_number" class="form-label">핸드폰 번호</label>
            <div class="phone-number-container">
                <select class="form-control" id="phone_first" name="phone_first" required>
                    <option value="010" selected>010</option>
                    <option value="011">011</option>
                    <option value="016">016</option>
                    <option value="017">017</option>
                    <option value="018">018</option>
                    <option value="019">019</option>
                </select>
                <input type="text" class="form-control" id="phone_middle" name="phone_middle" maxlength="4" placeholder="0000" required>
                <input type="text" class="form-control" id="phone_last" name="phone_last" maxlength="4" placeholder="0000" required>
            </div>
            <input type="hidden" id="user_phone_number" name="userPhoneNumber">
            <div id="phoneValidation" class="validation-message"></div>
        </div>

        <!-- 닉네임 -->
        <div class="mb-3">
            <label for="user_nickname" class="form-label">닉네임</label>
            <input type="text" class="form-control" id="user_nickname" name="userNickname" placeholder="닉네임을 입력하세요" required>
            <div id="nicknameCheck" class="validation-message"></div>
        </div>

        <button type="submit" class="btn btn-signup">가입하기</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // 아이디 중복 체크 및 정규식 검사
    $("#user_id").on("keyup", function() {
        var userId = $(this).val();
        var idReg = /^[a-zA-Z]\w{5,19}$/g;

        if (!idReg.test(userId)) {
            $("#userIdCheck").text("아이디는 영문자로 시작하는 6~20자의 영문자, 숫자, 밑줄(_)만 사용할 수 있습니다.").css("color", "red");
            return;
        } else {
            $("#userIdCheck").text("");
        }

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
            },
            error: function() {
                $("#userIdCheck").text("아이디 확인 중 오류가 발생했습니다.").css("color", "red");
            }
        });
    });

    // 비밀번호 확인 기능
    $("#user_password_confirm").on("keyup", function() {
        var password = $("#user_password").val();
        var passwordConfirm = $(this).val();

        if (password !== passwordConfirm) {
            $("#passwordConfirmValidation").text("비밀번호가 일치하지 않습니다.").css("color", "red");
        } else {
            $("#passwordConfirmValidation").text("비밀번호가 일치합니다.").css("color", "green");
        }
    });

    // 이메일 중복 체크 및 정규식 검사
    $("#user_email").on("keyup", function() {
        var userEmail = $(this).val();
        var emailReg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        if (!emailReg.test(userEmail)) {
            $("#emailCheck").text("유효하지 않은 이메일 형식입니다.").css("color", "red");
            return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/user/checkEmail",
            type: "GET",
            data: { userEmail: userEmail },
            success: function(response) {
                if (response === "AVAILABLE") {
                    $("#emailCheck").text("사용 가능한 이메일입니다.").css("color", "green");
                } else {
                    $("#emailCheck").text("이미 존재하는 이메일입니다.").css("color", "red");
                }
            },
            error: function() {
                $("#emailCheck").text("이메일 확인 중 오류가 발생했습니다.").css("color", "red");
            }
        });
    });

    // 닉네임 중복 체크 및 정규식 검사
    $("#user_nickname").on("keyup", function() {
        var userNickname = $(this).val();
        var nicknameReg = /^[a-zA-Z가-힣0-9!@#$%^&*()_+-=]{2,20}$/;

        if (!nicknameReg.test(userNickname)) {
            $("#nicknameCheck").text("유효하지 않은 닉네임입니다.").css("color", "red");
            return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/user/checkNickname",
            type: "GET",
            data: { userNickname: userNickname },
            success: function(response) {
                if (response === "AVAILABLE") {
                    $("#nicknameCheck").text("사용 가능한 닉네임입니다.").css("color", "green");
                } else {
                    $("#nicknameCheck").text("이미 존재하는 닉네임입니다.").css("color", "red");
                }
            },
            error: function() {
                $("#nicknameCheck").text("닉네임 확인 중 오류가 발생했습니다.").css("color", "red");
            }
        });
    });

    // 전화번호 필드를 합쳐서 hidden 필드에 저장
    $("#signupForm").on("submit", function() {
        var phoneFirst = $("#phone_first").val();
        var phoneMiddle = $("#phone_middle").val();
        var phoneLast = $("#phone_last").val();
        var fullPhoneNumber = phoneFirst + phoneMiddle + phoneLast;
        $("#user_phone_number").val(fullPhoneNumber);
    });
});
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
