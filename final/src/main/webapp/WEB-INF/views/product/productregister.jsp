<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 등록 페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
	
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #fff;
	
}

.register-container {
	max-width: 600px;
	margin: 0 auto;
}

/* 이미지 업로드 박스 */
.register-upload-container {
	display: flex;
	align-items: center;
	justify-content: center;
	border: 1px dashed #d3d3d3;
	width: 100%;
	min-height: 120px;
	border-radius: 8px;
	cursor: pointer;
	margin-bottom: 20px;
	position: relative;
	background-color: #f9f9f9;
	flex-wrap: wrap;
	gap: 10px;
	padding: 10px;
}

.register-upload-container img {
	width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 8px;
}

.register-upload-text {
	color: #888;
	font-size: 0.9rem;
	text-align: center;
	width: 100%;
}

/* 카테고리 선택 박스 */
.register-category-select {
	width: 100%;
	padding: 10px;
	border: 1px solid #d3d3d3;
	border-radius: 5px;
	margin-bottom: 20px;
	background-color: transparent;
}

/* 상품상태 및 거래방식 버튼 */
.register-product-status-btn {
	padding: 12px 25px;
	border-radius: 30px;
	border: 2px solid #d3d3d3;
	margin-right: 10px;
	cursor: pointer;
	font-size: 1rem;
	font-weight: bold;
}

.register-selected {
	background-color: #00c73c;
	color: white;
	border: 2px solid #00c73c;
}

/* 배송비 선택 박스 */
.register-shipping-select {
	width: 100%;
	padding: 10px;
	border: 1px solid #d3d3d3;
	border-radius: 5px;
	margin-bottom: 20px;
	background-color: transparent;
}

/* 등록 버튼 */
.register-btn-submit {
	background-color: #000;
	color: white;
	padding: 15px;
	border-radius: 30px;
	margin-top: 30px;
	width: 100%;
	font-size: 1.1rem;
	font-weight: bold;
	border: none;
	cursor: pointer;
}

.register-btn-submit:hover {
	background-color: #333;
}

/* 반응형 디자인 */
@media ( max-width : 768px) {
	.register-product-status-btn {
		padding: 10px 20px;
		font-size: 0.9rem;
	}
	.register-btn-submit {
		padding: 12px;
		font-size: 1rem;
	}
	.register-upload-container img {
		width: 80px;
		height: 80px;
	}
}
</style>
</head>

<body>

	<div class="register-container mt-5">
		<form id="register-productForm"
			action="${pageContext.request.contextPath}/product/register"
			method="post" enctype="multipart/form-data">
			<!-- 이미지 업로드 -->
			<div class="mb-3">
				<div class="register-upload-container" id="register-uploadContainer">
					<span class="register-upload-text" accep>이미지 선택 (최대 10장 jpg, png만 가능)</span>
				</div>
				<input type="file" id="register-fileInput" class="d-none"
					name="productImage2" multiple="multiple">
			</div>

			<!-- 상품명 입력 -->
			<div class="mb-3">
				<input type="text" class="form-control" name="productSubject"
					placeholder="상품명" maxlength="20" required>
			</div>

			<!-- 카테고리 선택 -->
			<div class="mb-3">
				<select class="form-control register-category-select" name="productCategory">
					<option value="" disabled selected>카테고리 선택</option>
					<option value="휴대폰">휴대폰</option>
					<option value="태블릿">태블릿</option>
					<option value="노트북">노트북</option>
					<option value="PC">PC</option>
				</select>
			</div>

			<!-- 판매가격 입력 -->
			<div class="mb-3 price-input-container">
				<input type="text" class="form-control price-input"
					name="productPrice" placeholder="₩ 판매가격" pattern="\d*" required
					maxlength="10">
			</div>

			<!-- 배송비 선택 -->
			<div class="mb-3">
				<select class="form-control register-shipping-select"
					name="productDelivery">
					<option value="" disabled selected>배송비 선택</option>
					<option value="별도">별도</option>
					<option value="포함">포함</option>
				</select>
			</div>

			<!-- 제품상태 선택 -->
			<div class="mb-3 d-flex">
				<div class="register-product-status-btn register-selected"
					id="register-usedBtn" data-value="중고"
					style="background-color:#3C3D37; color:white;">중고</div>
				<div class="register-product-status-btn"
					id="register-newBtn" data-value="새상품"
					style="background-color:#3C3D37; color:white;">새상품</div>
			</div>
			<input type="hidden" name="productModelStatus"
				id="register-productCondition" value="중고">

			<!-- 유의사항 텍스트박스 -->
			<div class="mb-3">
				<textarea class="form-control notice-box" name="productContent"
					id="register-noticeBox" rows="4" maxlength="200"
					onclick="registerclearPlaceholder(this)">
- 상품명(브랜드)
- 구매 시기
- 사용 기간
- 하자 여부
* 실제 촬영한 사진과 함께 상세 정보를 입력해주세요.
                </textarea>
				<div class="text-end mt-2"><span id="register-charCount">0</span> / 200</div>
			</div>

			<div class="mb-3 d-flex">
				<div class="register-product-status-btn register-selected"
					id="register-deliveryBtn" data-value="택배"
					style="background-color:#3C3D37; color:white; ">택배</div>
				<div class="register-product-status-btn"
					id="register-directBtn" data-value="직거래"
					style="background-color:#3C3D37; color:white;">직거래</div>
			</div>
			<input type="hidden" name="productMode" id="register-dealMethod"
				value="택배">

			<button type="submit" class="register-btn-submit">등록</button>
			<sec:csrfInput />
		</form>

	</div>

	<script>
// DOM이 완전히 로드된 후에 실행되도록 설정
document.addEventListener('DOMContentLoaded', function () {
    const uploadContainer = document.getElementById('register-uploadContainer');
    const fileInput = document.getElementById('register-fileInput');

    // 이미지 업로드 컨테이너 클릭 시 파일 선택 창 열기
    uploadContainer.addEventListener('click', function () {
        fileInput.click();
    });

    // 파일이 변경되었을 때 이미지 미리보기 표시
    fileInput.addEventListener('change', function () {
        uploadContainer.innerHTML = ''; // 기존 이미지 제거
        const files = Array.from(this.files);
        
        if (files.length > 10) {
            alert('이미지는 최대 10장까지 선택할 수 있습니다.');
            return;
        }

        // 파일 확장자 확인 및 jpg/png 외의 파일 경고 및 제외
        const validExtensions = ['jpg', 'jpeg', 'png'];
        let validFiles = [];

        files.forEach(function (file) {
            const fileExtension = file.name.split('.').pop().toLowerCase();
            if (validExtensions.includes(fileExtension)) {
                validFiles.push(file); // 유효한 파일만 추가
            } else {
                alert(`${file.name}은(는) 지원하지 않는 파일 형식입니다. (jpg, png만 가능)`);
            }
        });

        validFiles.forEach(function (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.alt = '미리보기 이미지';
                uploadContainer.appendChild(img);
            };
            reader.readAsDataURL(file);
        });

        // 선택된 파일이 없을 때 기본 텍스트 표시
        if (validFiles.length === 0) {
            uploadContainer.innerHTML = '<span class="register-upload-text">이미지 선택 (최대 10장)</span>';
        }
    });

    // 유의사항 박스 클릭 시 placeholder처럼 동작
    function registerclearPlaceholder(element) {
        if (element.value.startsWith('- 상품명')) {
            element.value = '';
        }
    }

    // 제품상태 버튼 클릭 시 색상 변경 및 선택 값 저장
    const productConditionInput = document.getElementById('register-productCondition');
    const conditionButtons = document.querySelectorAll('.register-product-status-btn[data-value="중고"], .register-product-status-btn[data-value="새상품"]');

    conditionButtons.forEach(button => {
        button.addEventListener('click', () => {
            conditionButtons.forEach(btn => btn.classList.remove('register-selected'));
            button.classList.add('register-selected');
            productConditionInput.value = button.getAttribute('data-value');
        });
    });

    // 거래방법 버튼 클릭 시 색상 변경 및 선택 값 저장
    const dealMethodInput = document.getElementById('register-dealMethod');
    const dealButtons = document.querySelectorAll('.register-product-status-btn[data-value="택배"], .register-product-status-btn[data-value="직거래"]');

    dealButtons.forEach(button => {
        button.addEventListener('click', () => {
            dealButtons.forEach(btn => btn.classList.remove('register-selected'));
            button.classList.add('register-selected');
            dealMethodInput.value = button.getAttribute('data-value');
        });
    });

    // 문자수 카운터
    const textarea = document.getElementById('register-noticeBox');
    const charCount = document.getElementById('register-charCount');

    textarea.addEventListener('input', () => {
        charCount.textContent = textarea.value.length;
    });

    // 가격 입력 필드 숫자만 허용 및 10억 제한
    const priceInput = document.querySelector('.price-input');
    priceInput.addEventListener('input', (e) => {
        let value = e.target.value.replace(/[^0-9]/g, ''); // 숫자만 허용
        if (parseInt(value, 10) > 1000000000) { // 최대 10억
            value = '1000000000';
        }
        e.target.value = value;
    });
});
</script>


</body>

</html>
