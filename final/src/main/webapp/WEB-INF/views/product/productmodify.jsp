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
<title>상품 수정 페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
	
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #fff;
	
}

.modify-container {
	max-width: 600px;
	margin: 0 auto;
}

/* 이미지 업로드 박스 */
.modify-upload-container {
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

.modify-upload-container img {
	width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 8px;
}

.modify-upload-text {
	color: #888;
	font-size: 0.9rem;
	text-align: center;
	width: 100%;
}

/* 카테고리 선택 박스 */
.modify-category-select {
	width: 100%;
	padding: 10px;
	border: 1px solid #d3d3d3;
	border-radius: 5px;
	margin-bottom: 20px;
	background-color: transparent;
}

/* 상품상태 및 거래방식 버튼 */
.modify-product-status-btn {
	padding: 12px 25px;
	border-radius: 30px;
	border: 2px solid #d3d3d3;
	margin-right: 10px;
	cursor: pointer;
	font-size: 1rem;
	font-weight: bold;
}

.modify-selected {
	background-color: #00c73c;
	color: white;
	border: 2px solid #00c73c;
}

/* 배송비 선택 박스 */
.modify-shipping-select {
	width: 100%;
	padding: 10px;
	border: 1px solid #d3d3d3;
	border-radius: 5px;
	margin-bottom: 20px;
	background-color: transparent;
}

/* 등록 버튼 */
.modify-btn-submit {
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

.modify-btn-submit:hover {
	background-color: #333;
}

/* 반응형 디자인 */
@media ( max-width : 768px) {
	.modify-product-status-btn {
		padding: 10px 20px;
		font-size: 0.9rem;
	}
	.modify-btn-submit {
		padding: 12px;
		font-size: 1rem;
	}
	.modify-upload-container img {
		width: 80px;
		height: 80px;
	}
}
</style>
</head>

<body>

	<div class="modify-container mt-5">
		<c:choose>
			<c:when test="${product != null && product.productIdx != null}">
				<form id="modify-productForm"
					action="${pageContext.request.contextPath}/product/modify"
					method="post" enctype="multipart/form-data">
			</c:when>
			<c:otherwise>
				<form id="modify-productForm"
					action="${pageContext.request.contextPath}/product/register"
					method="post" enctype="multipart/form-data">
			</c:otherwise>
		</c:choose>

		<!-- productIdx 값이 있으면 hidden 필드로 전달 -->
		<input type="hidden" name="productIdx"
			value="${product != null && product.productIdx != null ? product.productIdx : 0}">

		<!-- 이미지 업로드 -->
		<div class="mb-3">
			<div class="modify-upload-container" id="modify-uploadContainer">
				<!-- 기존 이미지 표시 -->
				<c:if test="${product != null && product.productImage != null}">
					<img
						src="${pageContext.request.contextPath}/resources/images/${product.productImage}"
						alt="상품 이미지" width="100">
				</c:if>
				<span class="modify-upload-text">이미지 선택 (최대 10장)</span>
			</div>
			<input type="file" id="modify-fileInput" class="d-none" name="productImage2"
				multiple="multiple">
		</div>

		<!-- 기존 이미지 hidden으로 전달 -->
		<input type="hidden" name="originalProductImage"
			value="${product != null ? product.productImage : ''}">

		<!-- 상품명 입력 -->
		<div class="mb-3">
			<input type="text" class="form-control" name="productSubject"
				placeholder="상품명" maxlength="20"
				value="${product != null ? product.productSubject : ''}">
		</div>

		<!-- 카테고리 선택 -->
		<div class="mb-3">
			<select class="form-control modify-category-select" name="productCategory">
				<option value="휴대폰"
					${product != null && product.productCategory == '휴대폰' ? 'selected' : ''}>휴대폰</option>
				<option value="태블릿"
					${product != null && product.productCategory == '태블릿' ? 'selected' : ''}>태블릿</option>
				<option value="노트북"
					${product != null && product.productCategory == '노트북' ? 'selected' : ''}>노트북</option>
				<option value="PC"
					${product != null && product.productCategory == 'PC' ? 'selected' : ''}>PC</option>
			</select>
		</div>

		<!-- 판매가격 입력 -->
		<div class="mb-3 modify-price-input-container">
			<input type="text" class="form-control modify-price-input"
				name="productPrice" placeholder="₩ 판매가격"
				value="${product != null ? product.productPrice : ''}" maxlength="10" pattern="\d*">
		</div>

		<!-- 배송비 선택 -->
		<div class="mb-3">
			<select class="form-control modify-shipping-select" name="productDelivery">
				<option value="별도"
					${product != null && product.productDelivery == '별도' ? 'selected' : ''}>별도</option>
				<option value="포함"
					${product != null && product.productDelivery == '포함' ? 'selected' : ''}>포함</option>
			</select>
		</div>

		<!-- 제품상태 선택 -->
		<div class="mb-3 d-flex">
			<div
				class="modify-product-status-btn ${product != null && product.productModelStatus == '중고' ? 'modify-selected' : ''}"
				id="modify-usedBtn" data-value="중고" style="background-color:#3C3D37; color:white;">중고</div>
			<div
				class="modify-product-status-btn ${product != null && product.productModelStatus == '새상품' ? 'modify-selected' : ''}"
				id="modify-newBtn" data-value="새상품" style="background-color:#3C3D37; color:white;">새상품</div>
		</div>
		<input type="hidden" name="productModelStatus" id="modify-productCondition"
			value="${product != null ? product.productModelStatus : '중고'}">

		<!-- 거래방법 -->
		<div class="mb-3 d-flex">
			<div
				class="modify-product-status-btn ${product != null && product.productMode == '택배' ? 'modify-selected' : ''}"
				id="modify-deliveryBtn" data-value="택배" style="background-color:#3C3D37; color:white;">택배</div>
			<div
				class="modify-product-status-btn ${product != null && product.productMode == '직거래' ? 'modify-selected' : ''}"
				id="modify-directBtn" data-value="직거래" style="background-color:#3C3D37; color:white;">직거래</div>
		</div>
		<input type="hidden" name="productMode" id="modify-dealMethod"
			value="${product != null ? product.productMode : '택배'}">

		<!-- 게시글 내용 추가 -->
		<div class="mb-3">
			<textarea class="form-control" name="productContent" rows="5"
				placeholder="상품 설명을 입력하세요" maxlength="200">${product != null ? product.productContent : ''}</textarea>
		</div>

		<button type="submit" class="modify-btn-submit">${product != null && product.productIdx != null ? '수정하기' : '등록하기'}</button>
		<sec:csrfInput />
		</form>

	</div>

	<script>
        const uploadContainer = document.getElementById('modify-uploadContainer');
        const fileInput = document.getElementById('modify-fileInput');

        uploadContainer.addEventListener('click', () => {
            fileInput.click();
        }); 

        fileInput.addEventListener('change', function () {
            uploadContainer.innerHTML = ''; // Clear previous images
            const files = Array.from(this.files);
            if (files.length > 10) {
                alert('이미지는 최대 10장까지 선택할 수 있습니다.');
                return;
            }

            files.forEach(file => {
                const reader = new FileReader();
                reader.onload = function (e) {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    uploadContainer.appendChild(img);
                };
                reader.readAsDataURL(file);
            });

            if (files.length === 0) {
                uploadContainer.innerHTML = '<span class="modify-upload-text">이미지 선택 (최대 10장)</span>';
            }
        });

        // 제품상태 버튼 클릭 시 색상 변경 및 선택 값 저장
        const productConditionInput = document.getElementById('modify-productCondition');
        const conditionButtons = document.querySelectorAll('.modify-product-status-btn[data-value="중고"], .modify-product-status-btn[data-value="새상품"]');

        conditionButtons.forEach(button => {
            button.addEventListener('click', () => {
                conditionButtons.forEach(btn => btn.classList.remove('modify-selected'));
                button.classList.add('modify-selected');
                productConditionInput.value = button.getAttribute('data-value');
            });
        });

        // 거래방법 버튼 클릭 시 색상 변경 및 선택 값 저장
        const dealMethodInput = document.getElementById('modify-dealMethod');
        const dealButtons = document.querySelectorAll('.modify-product-status-btn[data-value="택배"], .modify-product-status-btn[data-value="직거래"]');

        dealButtons.forEach(button => {
            button.addEventListener('click', () => {
                dealButtons.forEach(btn => btn.classList.remove('modify-selected'));
                button.classList.add('modify-selected');
                dealMethodInput.value = button.getAttribute('data-value');
            });
        });

        // 가격 입력 필드 숫자만 허용 및 10억 제한
        const priceInput = document.querySelector('.modify-price-input');
        priceInput.addEventListener('input', (e) => {
            let value = e.target.value.replace(/[^0-9]/g, ''); // 숫자만 허용
            if (parseInt(value, 10) > 1000000000) { // 최대 10억
                value = '1000000000';
            }
            e.target.value = value;
        });
    </script>

</body>

</html>
