<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>제품 페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Swiper CSS -->
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<style>
* {
	list-style: none;
}

body {
	font-family: 'Arial', sans-serif;
	background-color: #fff;
	padding: 20px;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
	margin-top: 50px;
}

.product-title {
	font-size: 45px;
	font-weight: bold;
	margin-bottom: 10px;
	color: #333;
}

.price {
	font-size: 2.8rem;
	font-weight: bold;
	color: #333;
	margin-bottom: 20px;
}

.price span {
	font-size: 1.2rem;
	background-color: #00c73c;
	color: white;
	padding: 5px 10px;
	border-radius: 5px;
	margin-left: 15px;
}

.product-details {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	margin-bottom: 40px;
}

/* Swiper 이미지 슬라이드 스타일 */
.swiper {
	width: 100%;
	height: 300px;
}

.wrapwrap {
	width: 700px;
}

.swiper-slide {
	width: 50%;
	height: 300px;
}

.swiper-slide img {
	width: 100%;
	height: 100%;
	object-fit: contain;
	border-radius: 5px;
}

/* 테이블 스타일 */
.info-table {
	width: 100%;
	border: 1px solid #e1e1e1;
	border-radius: 8px;
	text-align: center;
	margin-bottom: 30px;
	border-collapse: separate;
	border-spacing: 0;
}

.info-table th, .info-table td {
	padding: 20px;
	color: #555;
}

.info-table th {
	font-weight: normal;
	font-size: 0.9rem;
	color: #999;
}

.info-table td {
	font-weight: bold;
	font-size: 1.1rem;
	color: #333;
}

.info-table td+td {
	border-left: 1px solid #e1e1e1;
}

/* 두 번째 테이블 */
.info-table-2 {
	width: 100%;
	border: 1px solid #e1e1e1;
	border-radius: 8px;
	text-align: center;
	margin-bottom: 30px;
	border-collapse: separate;
	border-spacing: 0;
	margin-top: 30px;
	table-layout: fixed;
}

.info-table-2 th, .info-table-2 td {
	padding: 1px;
	color: #555;
}

.info-table-2 th {
	font-weight: normal;
	font-size: 0.9rem;
	color: #999;
}

.info-table-2 td {
	font-weight: bold;
	font-size: 1.1rem;
	color: #333;
}

.info-table-2 td+td {
	border-left: 1px solid #e1e1e1;
}

/* 추가 정보 */
.extra-info {
	font-size: 0.9rem;
	color: #333;
	margin-bottom: 30px;
}

.extra-info ul {
	padding-left: 0;
	list-style: none;
}

.extra-info li {
	margin-bottom: 15px;
}

.buttons {
	display: flex;
	justify-content: space-between;
	margin-top: 30px;
}

.btn {
	padding: 15px 0 !important;
	font-size: 1.2rem !important;
	width: 48% !important;
	border-radius: 8px !important;
	text-align: center !important;
	font-weight: bold !important;
	transition: all 0.3s ease !important;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2) !important;
}

.btn-chat {
	background-color: white !important;
	color: #333 !important;
	border: 1px solid #ddd !important;
}

.btn-chat:hover {
	background-color: #f1f1f1 !important;
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2) !important;
}

.btn-safe {
	background-color: #000 !important;
	color: white !important;
	border: none !important;
}

.btn-safe:hover {
	background-color: #333 !important;
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2) !important;
}

/* 상품 정보 및 가게 정보 */
.product-store-info {
	display: flex;
	justify-content: space-between;
	margin-top: 50px;
}

.product-info-left {
	flex: 1.5;
	margin-right: 40px;
}

.store-info-right {
	flex: 1;
	margin-left: 40px;
}

.store-name-container img {
	margin-right: 10px;
	border-radius: 50%;
}

.store-name {
	font-size: 1.4rem;
	font-weight: bold;
	margin-bottom: 15px;
}

.trust-score {
	font-size: 0.9rem;
	margin-bottom: 20px;
	display: flex;
	justify-content: space-between;
}

.trust-bar {
	width: 100%;
	height: 10px;
	background-color: #e1e1e1;
	border-radius: 5px;
	margin-top: 10px;
	position: relative;
}

.trust-bar-fill {
	background-color: #00c73c;
	height: 100%;
	width: 80%;
	border-radius: 5px;
	position: absolute;
	top: 0;
	left: 0;
}

.posted-product {
	display: flex;
	gap: 15px;
	margin-top: 20px;
	align-items: center;
}

.posted-product img {
	width: 70px;
	height: 70px;
	border-radius: 5px;
}

.posted-product-info {
	font-size: 0.9rem;
}

/* 상태 변경 버튼 스타일 */
.status-buttons {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 10px;
}

.status-button {
	padding: 10px 20px;
	margin-left: 10px;
	font-size: 0.9rem;
	font-weight: bold;
	border: 1px solid #333;
	border-radius: 5px;
	background-color: white;
	color: #333;
	transition: background-color 0.3s, color 0.3s;
}

.status-button:hover {
	background-color: #333;
	color: white;
	cursor: pointer;
}

@media ( max-width : 768px) {
	.product-details {
		flex-direction: column;
	}
	.product-store-info {
		flex-direction: column;
	}
	.btn {
		width: 100%;
		margin-bottom: 10px;
	}
	.buttons {
		flex-direction: column;
	}
}

.custom-btn {
    padding: 5px 10px !important; /* 버튼 크기 줄임 */
    font-size: 1rem !important; /* 폰트 크기 조정 */
    border: none !important; /* 테두리 제거 */
    box-shadow: none !important; /* 버튼의 그림자 제거 */
}

.button-container a {
    white-space: nowrap; /* 텍스트가 한 줄로 유지되게 함 */
}
</style>
</head>

<body>
	<div class="container">
		<!-- 제품명 -->
		<div class="product-title">
			${product.productSubject} <span
				style="font-size: 1.2rem; font-weight: bold; color:
			    <c:choose>
				    <c:when test="${product.productSold == 1}">
				        green;">판매중
				</c:when> <c:when test="${product.productSold == 2}">
				        orange;">예약중
				    </c:when> <c:when test="${product.productSold == 3}">
				        red;">판매완료
				    </c:when> <c:otherwise>
				        black;">대기중
				    </c:otherwise> </c:choose>
			</span>
		</div>

		<div class="price" style="font-size: 35px;">
			<fmt:formatNumber value="${product.productPrice}" type="number"
				pattern="#,###" />
			원
			<div style="font-size: 17px; font-size: 0.85rem; color: #888;">
				${product.productRegisterdate}·조회 ${product.productCount}</div>
		</div>

		<div class="status-buttons">
			<c:if test="${currentUserId eq product.productUserid}">
				<button class="status-button"
					onclick="updateProductStatus(${product.productIdx}, 1)">판매</button>
				<button class="status-button"
					onclick="updateProductStatus(${product.productIdx}, 2)">예약</button>
				<button class="status-button"
					onclick="updateProductStatus(${product.productIdx}, 3)">판매완료</button>
			</c:if>
		</div>

		<!-- 제품 이미지와 정보 -->
		<div class="product-details">
			<div class="wrapwrap">
				<div class="swiper mySwiper">
					<div class="swiper-wrapper">
						<!-- 모든 이미지 표시 -->
						<c:forEach var="image"
							items="${fn:split(product.productImage, ',')}">
							<div class="swiper-slide">
								<img
									src="${pageContext.request.contextPath}/resources/images/${image}"
									alt="상품 이미지" class="img-fluid">
							</div>
						</c:forEach>
					</div>
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>
					<div class="swiper-pagination"></div>
				</div>
			</div>

			<!-- 상품 정보 -->
			<div class="product-info">
				<table class="info-table">
					<thead>
						<tr>
							<th>제품상태</th>
							<th>거래방식</th>
							<th>배송비</th>
							<th>${session.roomId}카테고리</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${product.productModelStatus}</td>
							<td><c:choose>
									<c:when test="${product.productMode == '직거래'}">직거래</c:when>
									<c:when test="${product.productMode == '안전거래'}">안전거래</c:when>
									<c:otherwise>택배</c:otherwise>
								</c:choose></td>
							<td>${product.productDelivery}</td>
							<td>${product.productCategory}</td>
						</tr>
					</tbody>
				</table>

				<div class="extra-info">
					<ul>
						<li style="color: #f9f9f9;">결제혜택: 페이코 최대 4만원 즉시할인, KB국민카드
							18개월 6% 특별 할부 수수료</li>
						<li style="color: #f9f9f9;">무이자혜택: 1만원 이상 무이자 할부</li>
					</ul>
				</div>

				<div class="buttons" style="display: flex; justify-content: center;">
					<button id="openChatRoomBtn" class="btn btn-chat"
						onclick="startChat('${product.productUserid}', '${loginUser.userId}')"
						style="max-width: 130px; max-height: 70px; margin-top: -90px;">채팅하기</button>
					<div id="chatRoomContainer"></div>
				</div>
			</div>
		</div>

		<!-- 상품 정보 및 가게 정보 -->
		<div class="product-store-info">
			<div class="product-info-left">
				<!-- 상품 정보 제목과 수정/삭제 버튼을 동일한 줄에 배치 -->
				<div
					style="display: flex; justify-content: space-between; align-items: center;">
					<h4 class="info-header" style="font-weight: bold;">상품 정보</h4>
					<!-- 수정 및 삭제 버튼 -->
					<div class="button-container"
						style="display: flex; justify-content: flex-end; align-items: center;">
						<c:if test="${currentUserId eq product.productUserid}">
							<a
								href="${pageContext.request.contextPath}/product/modify?productIdx=${product.productIdx}"
								class="btn btn-outline-secondary btn-sm custom-btn"
								style="margin-right: 10px;">게시글 수정</a>
							<a
								href="${pageContext.request.contextPath}/product/remove?productIdx=${product.productIdx}&productUserid=${product.productUserid}"
								class="btn btn-outline-danger btn-sm custom-btn"
								style="white-space: nowrap;"
								onclick="return confirm('정말로 이 글을 삭제하시겠습니까?');">게시글 삭제</a>
						</c:if>
					</div>
				</div>


				<div class="left-wrap"
					style="border-top: 1px solid #e1e1e1; margin-top: 25px; padding: 20px; background-color: #f9f9f9; border-radius: 8px;">
					<ul style="margin-top: 25px; list-style: none; padding: 0;">
						<li style="padding: 10px 0;"><strong>내용:</strong>
							<div style="max-height: 200px; overflow-y: auto;">${product.productContent}</div>
						</li>
					</ul>
				</div>
			</div>

			<!-- 가게 정보 -->
			<div class="store-info-right">
				<h4 style="font-weight: bold;">프로필 정보</h4>
				<div class="left-wrap"
					style="border-top: 1px solid #e1e1e1; margin-top: 25px;">
					<div class="store-name-container" style="margin-top: 30px;">
						<div class="store-name">${product.productUsernickname}</div>
						<div class="level-bar text-center mt-2">
							<p id="userLevel">Loading...</p>
							<div class="progress">
								<div class="progress-bar" role="progressbar" style="width: 0%;"
									aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
							<p class="level-text mt-2" id="experienceText">Loading...</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Swiper JS -->
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	<script>
        var swiper = new Swiper(".mySwiper", {
            spaceBetween: 30,
            centeredSlides: true,
            navigation: {
                nextEl: ".swiper-button-next",
                prevEl: ".swiper-button-prev",
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
        });

        $(document).ready(function () {
            var loggedInUserId = "${loginUser.userId}";
            var sellerId = "${product.productUserid}";
            var roomId = "${roomId}";
            var buyerId = loggedInUserId;
            var newRoomId;

            $("#openChatRoomBtn").click(function () {
                $.ajax({
                    url: "${pageContext.request.contextPath}/chatroom/createRoom",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({
                        buyerId: loggedInUserId,
                        sellerId: sellerId,
                    }),
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    success: function (newRoomId) {
                        startChat(newRoomId);
                    },
                    error: function (xhr, status, error) {
                        console.error('Error creating chat room:', error);
                    }
                });
            });

            function startChat(roomId) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/chatroom/start",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({
                        roomId: roomId,
                        buyerId: loggedInUserId,
                        sellerId: sellerId,
                    }),
                    success: function () {
                        window.open("${pageContext.request.contextPath}/chatroom/room/" + roomId + "?buyerId=" + loggedInUserId + "&sellerId=" + sellerId, "_blank", "width=400,height=600");
                    },
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    error: function (xhr, status, error) {
                        console.error("Error starting chat:", error);
                    }
                });
            }
        });

        function updateProductStatus(productIdx, status) {
            $.ajax({
                url: '${pageContext.request.contextPath}/product/updateStatus',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ productIdx: productIdx, productSold: status }),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function () {
                    location.reload();
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                    alert('상태 변경에 실패했습니다.');
                }
            });
        }
    </script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
