<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>제품 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Swiper CSS -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
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
	font-size: 2.2rem;
	font-weight: bold;
	margin-bottom: 20px;
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

.time-info {
	font-size: 0.85rem;
	color: #888;
	margin-bottom: 30px;
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

/* 가게 정보 스타일 수정 */
.store-info-right .store-name-container {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 15px;
}

.store-info-right .store-name-container img {
	margin-right: 10px;
	border-radius: 50%;
}

.store-info-right .store-name {
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

/* 하단 정보 */
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
	font-size: 1rem;
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

/* 버튼 크기 조절 */
.status-button {
	min-width: 100px;
	text-align: center;
}

/* 반응형 디자인 */
@media ( max-width : 768px) {
	.status-buttons {
		justify-content: center;
	}
}

@media ( max-width : 768px) {
	.product-details {
		flex-direction: column;
	}
	.product-store-info {
		flex-direction: column;
	}
	.product-image, .product-info {
		margin-right: 0;
		margin-left: 0;
	}
	.btn {
		width: 100%;
		margin-bottom: 10px;
	}
	.buttons {
		flex-direction: column;
	}
}
</style>
</head>

<body>
	<div class="container">
		<!-- 제품명 -->
		<div class="product-title">
			${product.productSubject}
			<span style="font-size: 1.2rem; font-weight: bold; color:
			    <c:choose>
				    <c:when test="${product.productSold == 1}">
				        green;">판매중
				    </c:when>
				    <c:when test="${product.productSold == 2}">
				        orange;">예약중
				    </c:when>
				    <c:when test="${product.productSold == 3}">
				        red;">판매완료
				    </c:when>
				    <c:otherwise>
				        black;">대기중
				    </c:otherwise>
			    </c:choose>
			</span>
		</div>

		<div class="price">${product.productPrice}원</div>

		<div class="status-buttons">
			<button class="status-button" onclick="updateProductStatus(${product.productIdx}, 1)">판매</button>
			<button class="status-button" onclick="updateProductStatus(${product.productIdx}, 2)">예약</button>
			<button class="status-button" onclick="updateProductStatus(${product.productIdx}, 3)">판매완료</button>
		</div>

		<!-- 시간 정보 -->
		<div class="time-info" style="font-size: 15px;">${product.productRegisterdate}·조회 ${product.productCount}</div>

		<!-- 제품 이미지와 정보 -->
		<div class="product-details">
			<div class="wrapwrap">
				<div class="swiper mySwiper">
					<div class="swiper-wrapper">
						<c:forEach var="image" items="${productImages}">
							<div class="swiper-slide">
								<img src="${pageContext.request.contextPath}/resources/images/${product.productImage != null ? fn:split(product.productImage, ',')[0] : '150.png'}" alt="상품 이미지" class="img-fluid">
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
							<th>카테고리</th>
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
						<li>결제혜택: 페이코 최대 4만원 즉시할인, KB국민카드 18개월 6% 특별 할부 수수료</li>
						<li>무이자혜택: 1만원 이상 무이자 할부</li>
					</ul>
				</div>
				<div class="buttons" style="display: flex; justify-content: center;">
					<button id="openChatRoomBtn" class="btn btn-chat" onclick="startChat('${product.productUserid}', '${loginUser.userId}')">채팅하기</button>
					<div id="chatRoomContainer"></div>
				</div>
			</div>
		</div>

		<!-- 상품 정보 및 가게 정보 -->
		<div class="product-store-info">
			<div class="product-info-left">
				<h4 class="info-header" style="font-weight: bold;">상품 정보</h4>
				<div class="left-wrap" style="border-top: 1px solid #e1e1e1; margin-top: 25px; padding: 20px; background-color: #f9f9f9; border-radius: 8px;">
					<ul style="margin-top: 25px; list-style: none; padding: 0;">
						<li style="padding: 10px 0;"><strong>내용:</strong>
							<div style="max-height: 200px; overflow-y: auto;">${product.productContent}</div>
						</li>
					</ul>
				</div>

				<!-- 수정 및 삭제 버튼 배치 -->
				<c:if test="${currentUserId eq product.productUserid}">
					<a href="${pageContext.request.contextPath}/product/modify?productIdx=${product.productIdx}" class="btn btn-outline-secondary btn-sm" style="display: inline-block; margin-top: 20px; padding: 10px 20px; font-size: 1rem;">게시글 수정 </a>
					<a href="${pageContext.request.contextPath}/product/remove?productIdx=${product.productIdx}&productUserid=${product.productUserid}" class="btn btn-outline-danger btn-sm" style="display: inline-block; margin-top: 20px; margin-left: 10px; padding: 10px 20px; font-size: 1rem;" onclick="return confirm('정말로 이 글을 삭제하시겠습니까?');">게시글 삭제</a>
				</c:if>
			</div>

			<!-- 가게 정보 -->
			<div class="store-info-right">
				<h4 style="font-weight: bold;">프로필 정보</h4>
				<div class="left-wrap" style="border-top: 1px solid #e1e1e1; margin-top: 25px;">
					<div class="store-name-container" style="margin-top: 30px;">
						<div class="store-name">${product.productUsernickname}</div>
						<img src="https://via.placeholder.com/50" alt="프로필 사진" width="70px;">
					</div>

					<table class="info-table-2">
						<thead>
							<tr>
								<th>안전거래</th>
								<th>거래후기</th>
								<th>단골</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1</td>
								<td>0</td>
								<td>2</td>
							</tr>
						</tbody>
					</table>
					<div class="posted-product">
						<img src="https://via.placeholder.com/60" alt="아이폰 13미니">
						<div class="posted-product-info">${product.productSubject}<br>
							${product.productPrice}원
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
   		 var loggedInUserId = "${loginUser.userId}";   //"${loginUser.userId}";  // 로그인한 사용자 (구매자) ID
   		 var sellerId = "${product.productUserid}";  // 판매자 ID (상품의 소유자)
   		 var roomId = "${roomId}";  // 채팅방 ID (이미 생성된 채팅방의 ID)
   		 var buyerId = loggedInUserId;
   		 var newRoomId;
   		 
   		    console.log("buyerId: " + loggedInUserId);
   		    console.log("sellerId: " + sellerId);
   		    console.log("roomId: " + roomId);	
   		    console.log("loggedInUserId: " + loggedInUserId);	
   		 
   	
   			 $("#openChatRoomBtn").click(function () {
   				 
   				 //alert("sellerId before sending request: " + sellerId);  // sellerId 값 확인
   				   // alert("buyerId before sending request: " + loggedInUserId);  // buyerId 값 확인
   				    console.log("Creating room with buyerId: " + loggedInUserId + ", sellerId: " + sellerId);  // 로그로 값 확인

   			        $.ajax({
   			            url: "${pageContext.request.contextPath}/chatroom/createRoom",   // 방 번호를 생성하는 서버 URL
   			            type: "POST",             // 새로운 방 번호 생성은 POST 방식으로 요청
   			            contentType: "application/json",
   			            data: JSON.stringify({
   			               
   			                buyerId: loggedInUserId,
   			                sellerId: sellerId,
   			              
   			            }),
   			            
   			            beforeSend: function(xhr) {
   			                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");  // CSRF 토큰 설정
   			            },
   			            success: function (newRoomId) {
   			                // 새로운 방 번호를 받아온 후, 채팅방으로 이동
   			                console.log("Created roomId: " + newRoomId);  // 방 번호 확인
   			                startChat(newRoomId);  // startChat 호출
   			            },
   			            error: function (xhr, status, error) {
   			                console.error('Error creating chat room:', error);
   			            }
   			        });
   			    });

   				// startChat() 함수로 채팅 시작 요청
   		//function startChat(roomId) {
   		function startChat(roomId) {
   			var roomId= "${product.productIdx}"
   			var buyerId = loggedInUserId;  // 이미 상단에서 설정된 buyerId 값 사용
   		    var sellerId = "${product.productUserid}";  // 판매자 ID (서버에서 전달된 값 확인)
   		    //var sellerId = "${sellerId}";  // 판매자 ID (서버에서 전달된 값 확인)
   		    console.log("Start Chat with Seller IDddddddddddddd: " + sellerId + " and Buyer ID: " + buyerId);
   		    console.log("Starting chat with roomIdddddddddddddd: " + roomId + ", buyerId: " + buyerId + ", sellerId: " + sellerId);  // 로그 추가
   		    
           $.ajax({
               url: "${pageContext.request.contextPath}/chatroom/start",  // 채팅 시작 URL
               type: "POST",
               contentType: "application/json",
               data: JSON.stringify({
                 	roomId: roomId,
                   buyerId: loggedInUserId,
                   sellerId: sellerId,
                 
               }), 
               success: function (response) {
               	
                   // 생성된 채팅방으로 이동
                   window.location.href = "${pageContext.request.contextPath}/chatroom/room/" + roomId + "?buyerId=" + buyerId + "&sellerId=" + sellerId;
               },
               beforeSend: function(xhr) {
                   xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");  // CSRF 토큰 설정
               },
               error: function (xhr, status, error) {
                   console.error("Error starting chat:", error);
               }
           });
       }
       
      
   			 
   	        // 방 번호를 받아 해당 방의 채팅방 UI를 로드하는 함수
   	        function loadChatRoom(newRoomId) {
   	        	console.log("Loaded roomId: " + newRoomId); // roomId 값 출력
   	            $.ajax({
   	                url: "${pageContext.request.contextPath}/chatroom/room/" + newRoomId,  // 생성된 방 번호로 채팅방 UI를 요청
   	                type: "GET",
   	                success: function (data) {
   	                    $("#chatRoomContainer").html(data);  // 성공 시 채팅방 UI 로드
   	                },
   	                error: function (xhr, status, error) {
   	                    console.error("Error loading chat room:", error);
   	                }
   	            });
   	        } 
   	        
   	    }); 

        
        var csrfHeaderName = "${_csrf.headerName}";
        var csrfToken = "${_csrf.token}";


        function updateProductStatus(productIdx, status) {
            $.ajax({
                url: '${pageContext.request.contextPath}/product/updateStatus',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ productIdx: productIdx, productSold: status }),
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfToken);  // CSRF 토큰을 헤더에 포함
                },
                success: function(response) {
                    location.reload();  // 성공 시 페이지를 새로고침
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);  // 콘솔에 오류 출력
                    alert('상태 변경에 실패했습니다.');
                }
            });
        }

    </script>
</body>
</html>
