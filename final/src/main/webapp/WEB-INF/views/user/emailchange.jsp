<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이메일 주소 변경</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .modal-header {
            background-color: #f8f9fa;
        }
        .btn-custom {
            background-color: #f86d6d;
            color: white;
            border-radius: 5px;
            padding: 10px 15px;
            margin-right: 5px;
        }
        .btn-custom:hover {
            background-color: #f75c5c;
        }
        .text-danger {
            color: red;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <!-- 이메일 주소 변경 버튼 -->
    <button type="button" class="btn btn-custom" data-bs-toggle="modal" data-bs-target="#passwordConfirmModal">이메일 주소 변경</button>
</div>

<!-- 비밀번호 재확인 Modal -->
<div class="modal fade" id="passwordConfirmModal" tabindex="-1" aria-labelledby="passwordConfirmLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="passwordConfirmLabel">비밀번호 재확인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form id="passwordForm" action="/verify-password" method="post">
        <div class="modal-body">
          <p>회원의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한 번 확인 합니다.</p>
          <div class="mb-3">
            <label for="currentEmail" class="form-label">이메일 주소</label>
            <input type="email" class="form-control" id="currentEmail" name="currentEmail" value="tosmreo@naver.com" readonly>
          </div>
          <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" required>
          </div>
          <p class="text-danger">이메일 주소는 "naver.com"만 허용됩니다.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
          <button type="submit" class="btn btn-custom">확인</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- 이메일 변경 Modal (비밀번호 확인 후) -->
<div class="modal fade" id="emailChangeModal" tabindex="-1" aria-labelledby="emailChangeLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="emailChangeLabel">이메일 주소 변경</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="/update-email" method="post">
        <div class="modal-body">
          <p>사용하는 이메일 주소를 변경할 수 있습니다.</p>
          <div class="mb-3">
            <label for="newEmail" class="form-label">이메일 주소</label>
            <input type="email" class="form-control" id="newEmail" name="newEmail" placeholder="이메일을 입력하세요" required>
          </div>
          <p class="text-danger">이메일 주소는 "naver.com"만 허용됩니다.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
          <button type="submit" class="btn btn-custom">신규 메일 주소로 인증 메일 발송</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- 자바스크립트 비밀번호 확인 후 이메일 변경 모달 호출 -->
<script>
document.getElementById('passwordForm').addEventListener('submit', function(event) {
    event.preventDefault();
    
    // 비밀번호 확인 후 성공적으로 통과한 경우 (백엔드에서 확인 후 처리 가능)
    const password = document.getElementById('password').value;
    if (password === "password123") { // 임시로 하드코딩된 예시, 실제 구현은 서버 검증 필요
        // 비밀번호 확인이 성공하면 비밀번호 재확인 모달 닫고 이메일 변경 모달 열기
        const passwordModal = new bootstrap.Modal(document.getElementById('passwordConfirmModal'));
        passwordModal.hide();

        const emailChangeModal = new bootstrap.Modal(document.getElementById('emailChangeModal'));
        emailChangeModal.show();
    } else {
        alert("비밀번호가 올바르지 않습니다.");
    }
});
</script>

</body>
</html>
