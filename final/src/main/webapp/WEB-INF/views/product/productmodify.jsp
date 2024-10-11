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
	padding: 20px;
}

.container {
	max-width: 600px;
	margin: 0 auto;
}

/* 이미지 업로드 박스 */
.upload-container {
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

.upload-container img {
	width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 8px;
}

.upload-text {
	color: #888;
	font-size: 0.9rem;
	text-align: center;
	width: 100%;
}

/* 카테고리 선택 박스 */
.category-select {
	width: 100%;
	padding: 10px;
	border: 1px solid #d3d3d3;
	border-radius: 5px;
	margin-bottom: 20px;
	background-color: transparent;
}

/* 상품상태 및 거래방식 버튼 */
.product-status-btn {
	padding: 12px 25px;
	border-radius: 30px;
	border: 2px solid #d3d3d3;
	margin-right: 10px;
	cursor: pointer;
	font-size: 1rem;
	font-weight: bold;
}

.selected {
	background-color: #00c73c;
	color: white;
	border: 2px solid #00c73c;
}

/* 배송비 선택 박스 */
.shipping-select {
	width: 100%;
	padding: 10px;
	border: 1px solid #d3d3d3;
	border-radius: 5px;
	margin-bottom: 20px;
	background-color: transparent;
}

/* 등록 버튼 */
.btn-submit {
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

.btn-submit:hover {
	background-color: #333;
}

/* 반응형 디자인 */
@media ( max-width : 768px) {
	.product-status-btn {
		padding: 10px 20px;
		font-size: 0.9rem;
	}
	.btn-submit {
		padding: 12px;
		font-size: 1rem;
	}
	.upload-container img {
		width: 80px;
		height: 80px;
	}
}
</style>
</head>

<body>

	<div class="container mt-5">
		<c:choose>
			<c:when test="${product != null && product.productIdx != null}">
				<form id="productForm"
					action="${pageContext.request.contextPath}/product/modify"
					method="post" enctype="multipart/form-data">
			</c:when>
			<c:otherwise>
				<form id="productForm"
					action="${pageContext.request.contextPath}/product/register"
					method="post" enctype="multipart/form-data">
			</c:otherwise>
		</c:choose>

		<!-- productIdx 값이 있으면 hidden 필드로 전달 -->
		<input type="hidden" name="productIdx"
			value="${product != null && product.productIdx != null ? product.productIdx : 0}">

		<!-- 이미지 업로드 -->
		<div class="mb-3">
			<div class="upload-container" id="uploadContainer">
				<!-- 기존 이미지 표시 -->
				<c:if test="${product != null && product.productImage != null}">
					<img
						src="${pageContext.request.contextPath}/resources/images/${product.productImage}"
						alt="상품 이미지" width="100">
				</c:if>
				<span class="upload-text">이미지 선택 (최대 10장)</span>
			</div>
			<input type="file" id="fileInput" class="d-none" name="productImage2"
				multiple="multiple">
		</div>

		<!-- 기존 이미지 hidden으로 전달 -->
		<input type="hidden" name="originalProductImage"
			value="${product != null ? product.productImage : ''}">

		<!-- 상품명 입력 -->
		<div class="mb-3">
			<input type="text" class="form-control" name="productSubject"
				placeholder="상품명"
				value="${product != null ? product.productSubject : ''}">
		</div>

		<!-- 카테고리 선택 -->
		<div class="mb-3">
			<select class="form-control category-select" name="productCategory">
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
		<div class="mb-3 price-input-container">
			<input type="text" class="form-control price-input"
				name="productPrice" placeholder="₩ 판매가격"
				value="${product != null ? product.productPrice : ''}">
		</div>

		<!-- 배송비 선택 -->
		<div class="mb-3">
			<select class="form-control shipping-select" name="productDelivery">
				<option value="별도"
					${product != null && product.productDelivery == '별도' ? 'selected' : ''}>별도</option>
				<option value="포함"
					${product != null && product.productDelivery == '포함' ? 'selected' : ''}>포함</option>
			</select>
		</div>

		<!-- 제품상태 선택 -->
		<div class="mb-3 d-flex">
			<div
				class="product-status-btn ${product != null && product.productModelStatus == '중고' ? 'selected' : ''}"
				id="usedBtn" data-value="중고">중고</div>
			<div
				class="product-status-btn ${product != null && product.productModelStatus == '새상품' ? 'selected' : ''}"
				id="newBtn" data-value="새상품">새상품</div>
		</div>
		<input type="hidden" name="productModelStatus" id="productCondition"
			value="${product != null ? product.productModelStatus : '중고'}">

		<!-- 거래방법 -->
		<div class="mb-3 d-flex">
			<div
				class="product-status-btn ${product != null && product.productMode == '택배' ? 'selected' : ''}"
				id="deliveryBtn" data-value="택배">택배</div>
			<div
				class="product-status-btn ${product != null && product.productMode == '안전거래' ? 'selected' : ''}"
				id="safeBtn" data-value="안전거래">안전거래</div>
			<div
				class="product-status-btn ${product != null && product.productMode == '직거래' ? 'selected' : ''}"
				id="directBtn" data-value="직거래">직거래</div>
		</div>
		<input type="hidden" name="productMode" id="dealMethod"
			value="${product != null ? product.productMode : '택배'}">

		<!-- 게시글 내용 추가 -->
		<div class="mb-3">
			<textarea class="form-control" name="productContent" rows="5"
				placeholder="상품 설명을 입력하세요">${product != null ? product.productContent : ''}</textarea>
		</div>

		<button type="submit" class="btn-submit">${product != null && product.productIdx != null ? '수정하기' : '등록하기'}</button>
		<sec:csrfInput />
		</form>

	</div>

	<script>
        const uploadContainer = document.getElementById('uploadContainer');
        const fileInput = document.getElementById('fileInput');

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
                uploadContainer.innerHTML = '<span class="upload-text">이미지 선택 (최대 10장)</span>';
            }
        });

        // 제품상태 버튼 클릭 시 색상 변경 및 선택 값 저장
        const productConditionInput = document.getElementById('productCondition');
        const conditionButtons = document.querySelectorAll('.product-status-btn[data-value="중고"], .product-status-btn[data-value="새상품"]');

        conditionButtons.forEach(button => {
            button.addEventListener('click', () => {
                conditionButtons.forEach(btn => btn.classList.remove('selected'));
                button.classList.add('selected');
                productConditionInput.value = button.getAttribute('data-value');
            });
        });

        // 거래방법 버튼 클릭 시 색상 변경 및 선택 값 저장
        const dealMethodInput = document.getElementById('dealMethod');
        const dealButtons = document.querySelectorAll('.product-status-btn[data-value="택배"], .product-status-btn[data-value="안전거래"], .product-status-btn[data-value="직거래"]');

        dealButtons.forEach(button => {
            button.addEventListener('click', () => {
                dealButtons.forEach(btn => btn.classList.remove('selected'));
                button.classList.add('selected');
                dealMethodInput.value = button.getAttribute('data-value');
            });
        });

    </script>

</body>

</html>
