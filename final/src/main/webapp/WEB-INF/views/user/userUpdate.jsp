<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 조회/수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .info-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .info-header {
            font-weight: bold;
            margin-bottom: 20px;
        }
        .info-label {
            font-weight: bold;
        }
        .info-btn-custom {
            background-color: #f86d6d;
            color: white;
            border-radius: 5px;
            padding: 10px 20px;
        }
        .info-btn-custom:hover {
            background-color: #f75c5c;
        }
        .info-form-group {
            margin-bottom: 15px;
        }
        .info-form-control:disabled {
            background-color: #e9ecef;
        }
        .info-form-check-input {
            margin-right: 10px;
        }
    </style>
</head>
<body>

<div class="info-container">
    <h3 class="info-header">회원정보 조회/수정</h3>
    <form action="/user/update" method="post">
        <!-- CSRF 토큰 추가 -->
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        
        <div class="info-form-group row">
            <label for="email" class="col-sm-3 col-form-label info-label">이메일 주소 <span class="text-danger">*</span></label>
            <div class="col-sm-9">
                <input type="email" class="form-control info-form-control" id="email" value="tosmreo@naver.com" disabled>
            </div>
        </div>
        <div class="info-form-group row">
            <label for="userId" class="col-sm-3 col-form-label info-label">아이디</label>
            <div class="col-sm-9">
                <input type="text" class="form-control info-form-control" id="userId" value="tosmreo">
            </div>
        </div>
        <div class="info-form-group row">
            <label for="nickname" class="col-sm-3 col-form-label info-label">닉네임 <span class="text-danger">*</span></label>
            <div class="col-sm-9">
                <input type="text" class="form-control info-form-control" id="nickname" value="김혜련">
            </div>
        </div>
        <div class="info-form-group row">
            <label for="profilePic" class="col-sm-3 col-form-label info-label">프로필 사진</label>
            <div class="col-sm-9">
                <input type="file" class="form-control info-form-control" id="profilePic">
                <small class="form-text text-muted">가로 제한 길이: 100px, 세로 제한 길이: 100px</small>
            </div>
        </div>
        <div class="info-form-group row">
            <label class="col-sm-3 col-form-label info-label">메일링 가입</label>
            <div class="col-sm-9">
                <div class="form-check">
                    <input class="form-check-input info-form-check-input" type="radio" name="mailing" id="mailingYes" value="yes" checked>
                    <label class="form-check-label" for="mailingYes">예</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input info-form-check-input" type="radio" name="mailing" id="mailingNo" value="no">
                    <label class="form-check-label" for="mailingNo">아니오</label>
                </div>
            </div>
        </div>
        <div class="info-form-group row">
            <label class="col-sm-3 col-form-label info-label">쪽지 수신 허용</label>
            <div class="col-sm-9">
                <div class="form-check">
                    <input class="form-check-input info-form-check-input" type="radio" name="message" id="messageAll" value="all" checked>
                    <label class="form-check-label" for="messageAll">전체 수신</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input info-form-check-input" type="radio" name="message" id="messageFriend" value="friend">
                    <label class="form-check-label" for="messageFriend">친구만 허용</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input info-form-check-input" type="radio" name="message" id="messageNone" value="none">
                    <label class="form-check-label" for="messageNone">거부</label>
                </div>
            </div>
        </div>
        <div class="info-form-group row">
            <div class="col-sm-12 text-end">
                <button type="button" class="btn btn-secondary">취소</button>
                <button type="submit" class="btn info-btn-custom">등록</button>
            </div>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
