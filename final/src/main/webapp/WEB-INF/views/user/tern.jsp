<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 약관 동의</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h5 {
            font-weight: bold;
            margin-bottom: 20px;
        }
        .scroll-box {
            height: 150px;
            overflow-y: auto;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 10px;
            background-color: #f9f9f9;
        }
        .btn-agree {
            background-color: #f86d6d;
            color: white;
            border-radius: 20px;
            width: 100%;
            padding: 10px;
        }
        .btn-agree:hover {
            background-color: #f75c5c;
        }
    </style>
</head>
<body>

<div class="container">
    <h5>회원가입 이용약관</h5>
    <div class="scroll-box">
        <p>이용약관 안내 제 1 장 총 칙</p>
        <p>제 1조 ( 목적 ) 본 약관은 어미새가 제공하는 동호회 서비스의 이용과 관련하여 현행 법령에 위반하지 않는 범위 내에서 회원과 당사와의 중요 사항을 정하는 것을 목적으로 한다.</p>
        <p>제 2조 ( 약관의 효력과 변경)</p>
        <p>(1) 약관의 효력 이 약관은 사이트 게시판을 통하여 이용자에게 공시함으로써 효력을 발생합니다.</p>
        <p>(2) 어미새는 회원을 위하여 새로운 서비스를 추가하거나 어미새 정책상 중요 사유가 있을 경우 회원에 대한 사전 고지없이 약관을 변경할 수 있으며 이 경우 회원은 약관 변경을 이유로 가입을 취소할 수 있으나 공시된 약관의 변경에도 불구하고 2회 이상 접속 시 동의한 것으로 간주하겠습니다.</p>
        <p>제 3조 (약관 규정외 사항에 관한 준칙) 현 약관에 규정되지 않은 사항에 대해서는 전기통신 사업법 등 관계 법령에 규정을 따르게 됩니다.</p>
        <p>제 4조 (용어의 정의)</p>
        <p>(1) 회원: 어미새와 서비스 이용계약을 체결한 자</p>
        <p>(2) ID: 회원식별과 서비스 이용을 위하여 회원이 선정한 문자와 숫자의 조합</p>
        <p>(3) 비밀번호: 회원의 정보보호와 회원만의 이용을 위한 문자와 숫자로 이루어진 조합</p>
        <p>(4) 관리자: 서비스의 전반적인 관리와 운영을 담당하는 자</p>
        <p>제 5조 (이용계약의 성립)</p>
        <p>회원은 어미새가 제시하는 양식에 자기 정보를 입력하고 이용신청을 하고 어미새는 이에 대하여 승낙함으로써 당사의 서비스를 제공 받으실 수 있습니다.</p>
        <p>제 6조 (이용신청시 기재사항)</p>
        <p>(1) 이름, (2) E-mail 주소, (3) 비밀번호, (4) 닉네임</p>
        <p>제 7조 (이용신청의 승낙 등)</p>
        <p>어미새는 상기 각 항목을 성실히 기재하고 본 약관에 동의할 때 본 서비스의 이용을 승낙합니다. 단, 특정 상황에 따라 승낙을 거부할 수 있습니다.</p>
        <p>제 8조 (기재사항의 변경) 회원은 본 서비스의 이용을 위해 자신의 정보를 성실히 관리해야 하며 변동사항이 있을 경우 이를 변경해야 합니다.</p>
        <p>제 9조 (어미새의 의무) 어미새는 회원의 개인정보 보호를 위하여 최선을 다합니다.</p>
        <p>제 10조 (회원의 비밀번호 등 관리의무) 회원의 잘못으로 발생한 피해는 회원 책임입니다.</p>
        <p>제 11조 (서비스 전반에 관한 회원의 의무) 회원은 서비스 이용 시 법령 및 공공질서를 준수해야 합니다.</p>
        <p>제 12조 (동호회 서비스 이용 관련) 회원은 동호회 규칙을 준수해야 합니다.</p>
        <p>제 13조 (정보의 제공 등) 어미새는 다양한 정보 제공을 위해 전자우편을 발송할 수 있습니다.</p>
        <p>제 14조 (회원의 게시물 등) 회원의 게시물에 대한 책임은 본인에게 있으며, 부적절한 게시물은 관리자가 삭제할 수 있습니다.</p>
        <p>제 15조 (게시물의 저작권) 게시물의 저작권은 게시자에게 있으며, 서비스 이용 중 발생한 문제에 대한 책임도 회원 본인에게 있습니다.</p>
        <p>admin@mail.eomisae.co.kr</p>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="checkbox" id="agreeTerms">
        <label class="form-check-label" for="agreeTerms">이용약관에 동의 합니다.</label>
    </div>

    <h5 class="mt-4">개인정보처리방침 이용 동의</h5>
    <div class="scroll-box">
        <p>개인정보 수집 이용 동의</p>
        <p>어미새 커뮤니티 (eomiase.co.kr)는 개인정보보호법에 따라 이용자의 개인정보 보호 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 다음과 같은 처리방침을 두고 있습니다. 회사는 개인정보처리방침을 개정하는 경우 웹사이트 공지사항(또는 개별공지)을 통하여 공지할 것입니다. 본 방침은 2016년 4월 16일부터 시행됩니다.</p>
        <p>[개인정보의 수집 및 이용 목적]</p>
        <p>회사는 개인정보를 다음의 목적으로 처리합니다. 회원 관리, 불량회원의 부정이용 방지, 가입의사 확인 및 회원의 식별 등을 목적으로 합니다.</p>
        <p>[개인정보 수집 항목]</p>
        <p>회원 가입 시 필수 항목으로 아이디, 비밀번호, 이메일, 연락처, 닉네임 등을 수집합니다.</p>
        <p>[개인정보의 보유 및 이용기간]</p>
        <p>회사는 개인정보의 이용목적이 달성된 후에는 지체 없이 해당 개인정보를 파기합니다.</p>
        <p>[개인정보의 열람 및 정정]</p>
        <p>회원은 언제든지 자신의 개인정보를 열람하거나 정정할 수 있습니다.</p>
        <p>[개인정보 파기 절차 및 방법]</p>
        <p>회사는 수집한 개인정보의 목적 달성 후 즉시 파기하며, 전자적 파일 형태는 복구 불가능하게 기술적 방법으로 삭제합니다.</p>
        <p>개인정보관리책임자 성명 : 송영희</p>
        <p>이메일 : admin@mail.eomisae.co.kr</p>
        <p>기타 개인정보침해에 대한 신고나 상담은 개인정보침해신고센터 (국번 없이 118) 등을 통해 가능합니다.</p>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="checkbox" id="agreePrivacy">
        <label class="form-check-label" for="agreePrivacy">개인정보 수집방침에 동의 합니다.</label>
    </div>

    <button type="submit" class="btn btn-agree mt-4">가입하기</button>
</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
