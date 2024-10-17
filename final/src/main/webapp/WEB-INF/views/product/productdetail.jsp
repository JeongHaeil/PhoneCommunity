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
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

.detail-body {
	font-family: 'Arial', sans-serif;
	background-color: #fff;
	padding: 0;
	margin: 0;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

.detail-container {
	max-width: 1200px;
	margin: 0 auto;
	margin-top: 50px;
}

.detail-content {
	flex: 1;
}

.detail-product-title {
	font-size: 45px;
	font-weight: bold;
	margin-bottom: 10px;
	color: #333;
}

.detail-price {
	font-size: 2.8rem;
	font-weight: bold;
	color: #333;
	margin-bottom: 20px;
}

.detail-price span {
	font-size: 1.2rem;
	background-color: #00c73c;
	color: white;
	padding: 5px 10px;
	border-radius: 5px;
	margin-left: 15px;
}

.detail-product-details {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	margin-bottom: 40px;
	gap: 70px;
}

.detail-swiper {
	width: 100%;
	height: 500px;
}

.detail-wrapwrap {
	width: 65%;
}

.detail-swiper-slide {
	width: 100%;
	height: 500px;
}

.detail-swiper-slide img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 5px;
}

.detail-product-details img {
	width: 100%;
	height: 500px;
	object-fit: cover;
	border-radius: 5px;
}

.detail-info-table {
	width: 123%; /* 기존 100%에서 110%로 변경 */
	border: 1px solid #e1e1e1;
	border-radius: 8px;
	text-align: center;
	margin-bottom: 30px;
	border-collapse: separate;
	border-spacing: 0;
	margin-top: 100px;
}

.detail-info-table th, .detail-info-table td {
	padding: 20px;
	color: #555;
}

.detail-info-table th {
	font-weight: normal;
	font-size: 0.9rem;
	color: #999;
}

.detail-info-table td {
	font-weight: bold;
	font-size: 1.1rem;
	color: #333;
}

.detail-info-table td+td {
	border-left: 1px solid #e1e1e1;
}

.detail-info-table-2 {
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

.detail-info-table-2 th, .detail-info-table-2 td {
	padding: 1px;
	color: #555;
}

.detail-info-table-2 th {
	font-weight: normal;
	font-size: 0.9rem;
	color: #999;
}

.detail-info-table-2 td {
	font-weight: bold;
	font-size: 1.1rem;
	color: #333;
}

.detail-info-table-2 td+td {
	border-left: 1px solid #e1e1e1;
}

.detail-extra-info {
	font-size: 0.9rem;
	color: #333;
	margin-bottom: 30px;
}

.detail-extra-info ul {
	padding-left: 0;
	list-style: none;
}

.detail-extra-info li {
	margin-bottom: 15px;
}

.detail-buttons {
	display: flex;
	justify-content: space-between;
	margin-top: 30px;
}

.detail-btn {
	padding: 15px 0 !important;
	font-size: 1.2rem !important;
	width: 48% !important;
	border-radius: 8px !important;
	text-align: center !important;
	font-weight: bold !important;
	transition: all 0.3s ease !important;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2) !important;
}

.detail-btn-chat {
	width: 100px  !important;
	height: 50px  !important; 
	background-color : #3C3D37 !important; /* 배경색 투명하게 설정 */
	color: white !important;
	border: none !important; /* 테두리 없앰 */
	box-shadow: none !important; /* 그림자 없앰 */
	font-size: 1.0rem !important;
	padding: 10px 10px !important;
	margin-left: 75px;
	background-color: #3C3D37 !important;
}

.detail-btn-chat:hover {
	background-color: #3C3D37 !important;
	box-shadow: 0 8px 11px rgba(0, 0, 0, 0.2) !important;
	color: white !important;
}

.detail-btn-safe {
	background-color: #000 !important;
	color: white !important;
	border: none !important;
}

.detail-btn-safe:hover {
	background-color: #333 !important;
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2) !important;
}

.detail-product-store-info {
	display: flex;
	justify-content: space-between;
	margin-top: 50px;
}

.detail-product-info-left {
	flex: 1.5;
	margin-right: 40px;
}

.detail-store-info-right {
	flex: 1;
	margin-left: 40px;
}

.user-badge {
	margin-right: 300px;
	position:relative;
	bottom:50px;
	left:350px;
	border-radius: 0%;
}

.detail-store-name {
	font-size: 1.4rem;
	font-weight: bold;
	margin-bottom: 15px;
}

.detail-trust-score {
	font-size: 0.9rem;
	margin-bottom: 20px;
	display: flex;
	justify-content: space-between;
}

.detail-trust-bar {
	width: 100%;
	height: 10px;
	background-color: #e1e1e1;
	border-radius: 5px;
	margin-top: 10px;
	position: relative;
}

.detail-trust-bar-fill {
	background-color: #00c73c;
	height: 100%;
	width: 80%;
	border-radius: 5px;
	position: absolute;
	top: 0;
	left: 0;
}

.detail-posted-product {
	display: flex;
	gap: 25px;
	margin-top: 20px;
	align-items: center;
}

.detail-posted-product img {
	width: 70px;
	height: 70px;
	border-radius: 5px;
}

.detail-posted-product-info {
	font-size: 0.9rem;
}

.detail-status-buttons {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 10px;
	margin-left: 200px;
	margin-right: -76px;
}

.detail-status-button {
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

.detail-status-button:hover {
	background-color: #333;
	color: white;
	cursor: pointer;
}

@media ( max-width : 768px) {
	.detail-product-details {
		flex-direction: column;
	}
	.detail-product-store-info {
		flex-direction: column;
	}
	.detail-btn {
		width: 100%;
		margin-bottom: 10px;
	}
	.detail-buttons {
		flex-direction: column;
	}
}

.detail-custom-btn {
	padding: 5px 10px !important;
	font-size: 1rem !important;
	border: none !important;
	box-shadow: none !important;
}

.detail-button-container a {
	white-space: nowrap;
}
</style>
</head>

<body class="detail-body">
	<div class="detail-container">
		<!-- 제품명 -->
		<div class="detail-product-title">
			${product.productSubject} <span
				style="font-size: 1.2rem; font-weight: bold; color:
                <c:choose>
                    <c:when test="${product.productSold == 1}">green;">판매중</c:when>
				<c:when test="${product.productSold == 2}">orange;">예약중</c:when> <c:when
					test="${product.productSold == 3}">red;">판매완료</c:when> <c:otherwise>black;">대기중</c:otherwise>
				</c:choose>
			</span>
		</div>

		<div class="detail-price" style="font-size: 35px;">
			<fmt:formatNumber value="${product.productPrice}" type="number"
				pattern="#,###" />
			원
			<div style="font-size: 17px; font-size: 0.85rem; color: #888;">
				${product.productRegisterdate}·조회 ${product.productCount}</div>
		</div>

		<div class="detail-status-buttons">
			<c:if test="${currentUserId eq product.productUserid}">
				<button class="detail-status-button"
					onclick="updateProductStatus(${product.productIdx}, 1)">판매</button>
				<button class="detail-status-button"
					onclick="updateProductStatus(${product.productIdx}, 2)">예약</button>
				<button class="detail-status-button"
					onclick="updateProductStatus(${product.productIdx}, 3)">판매완료</button>
			</c:if>
		</div>

		<!-- 제품 이미지와 정보 -->
		<div class="detail-product-details">
			<div class="detail-wrapwrap">
				<div class="swiper detail-swiper">
					<div class="swiper-wrapper">
						<c:forEach var="image"
							items="${fn:split(product.productImage, ',')}">
							<div class="swiper-slide detail-swiper-slide">
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
			<div class="detail-product-info">
				<table class="detail-info-table">
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

				<div class="detail-extra-info">
					<ul>
						<li style="color: #f9f9f9;">결제혜택: 페이코 최대 4만원 즉시할인, KB국민카드
							18개월 6% 특별 할부 수수료</li>
						<li style="color: #f9f9f9;">무이자혜택: 1만원 이상 무이자 할부</li>
					</ul>
				</div>

				<div class="detail-buttons"
					style="display: flex; justify-content: center;">
					<button id="openChatRoomBtn" class="detail-btn detail-btn-chat"
						onclick="startChat('${product.productUserid}', '${loginUser.userId}')"
						style="max-width: 130px; max-height: 70px; margin-top: -90px;">채팅하기</button>
					<div id="chatRoomContainer"></div>
				</div>
			</div>
		</div>

		<!-- 상품 정보 및 가게 정보 -->
		<div class="detail-product-store-info">
			<div class="detail-product-info-left">
				<!-- 상품 정보 제목과 수정/삭제 버튼을 동일한 줄에 배치 -->
				<div
					style="display: flex; justify-content: space-between; align-items: center;">
					<h4 class="info-header" style="font-weight: bold;">상품 정보</h4>
					<div class="detail-button-container"
						style="display: flex; justify-content: flex-end; align-items: center;">
						<c:if test="${currentUserId eq product.productUserid}">
							<a
								href="${pageContext.request.contextPath}/product/modify?productIdx=${product.productIdx}"
								class="btn btn-outline-secondary btn-sm detail-custom-btn"
								style="margin-right: 10px;">게시글 수정</a>
							<a
								href="${pageContext.request.contextPath}/product/remove?productIdx=${product.productIdx}&productUserid=${product.productUserid}"
								class="btn btn-outline-danger btn-sm detail-custom-btn"
								style="white-space: nowrap;"
								onclick="return confirm('정말로 이 글을 삭제하시겠습니까?');">게시글 삭제</a>
						</c:if>
					</div>
				</div>

				<div class="detail-left-wrap"
					style="border-top: 1px solid #e1e1e1; margin-top: 25px; padding: 20px; background-color: #f9f9f9; border-radius: 8px;">
					<ul style="margin-top: 25px; list-style: none; padding: 0;">
						<li style="padding: 10px 0;"><strong>내용:</strong>
							<div style="max-height: 200px; overflow-y: auto;">${product.productContent}</div>
						</li>
					</ul>
				</div>
			</div>

			<!-- 가게 정보 -->
			<div class="detail-store-info-right">
				<h4 style="font-weight: bold;">프로필 정보</h4>
				<div class="detail-left-wrap"
					style="border-top: 1px solid #e1e1e1; margin-top: 25px;">
					<div class="detail-store-name-container" style="margin-top: 30px;">
						<div class="detail-store-name">${product.productUsernickname}</div>
						<div style="margin-top: 10px;">
							<c:choose>
								<c:when test="${sellerAuth == 'ROLE_SUPER_ADMIN'}">
									<img
										src="${pageContext.request.contextPath}/resources/images/crown.png"
										alt="Super Admin Badge" class="user-badge" />
								</c:when>
								<c:when test="${sellerAuth == 'ROLE_BOARD_ADMIN'}">
									<img
										src="${pageContext.request.contextPath}/resources/images/rainbow.png"
										alt="Board Admin Badge" class="user-badge" />
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${sellerLevel >= 1 && sellerLevel <= 5}">
											<img
												src="${pageContext.request.contextPath}/resources/images/bronze.png"
												alt="Bronze Badge" class="user-badge" />
										</c:when>
										<c:when test="${sellerLevel >= 6 && sellerLevel <= 10}">
											<img
												src="${pageContext.request.contextPath}/resources/images/silver.png"
												alt="Silver Badge" class="user-badge" />
										</c:when>
										<c:when test="${sellerLevel >= 11 && sellerLevel <= 15}">
											<img
												src="${pageContext.request.contextPath}/resources/images/gold.png"
												alt="Gold Badge" class="user-badge" />
										</c:when>
										<c:when test="${sellerLevel >= 16 && sellerLevel <= 19}">
											<img
												src="${pageContext.request.contextPath}/resources/images/emerald.png"
												alt="Emerald Badge" class="user-badge" />
										</c:when>
										<c:when test="${sellerLevel >= 20}">
											<img
												src="${pageContext.request.contextPath}/resources/images/diamond.png"
												alt="Diamond Badge" class="user-badge" />
										</c:when>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

	<!-- Swiper JS -->
	
   <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	<script>
        var swiper = new Swiper(".detail-swiper", {
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
      				 
      			
      			        
      			        $.ajax({
      			            url: "${pageContext.request.contextPath}/chatroom/createRoom",   // 방 번호를 생성하는 서버 URL
      			            type: "POST",             // 새로운 방 번호 생성은 POST 방식으로 요청
      			            contentType: "application/json",
      			            data: JSON.stringify({
      			            	 buyerId: loggedInUserId,   // 전달된 buyerId
      			                 sellerId: sellerId,        // 전달된 sellerId
      			                
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
      		function startChat(roomId) {
      			var buyerId = loggedInUserId;  // 이미 상단에서 설정된 buyerId 값 사용
      		    var sellerId = "${product.productUserid}";  // 판매자 ID (서버에서 전달된 값 확인)
      		  var roomId= "${product.productIdx}"
      			 if (buyerId === sellerId) {
      		        // 현재 사용자가 판매자라면 buyerId를 임시 구매자 ID로 설정
      		        buyerId = "tempBuyer" + roomId;  // 임시 값 설정 (예시로 방 번호와 연동)
      		    }
      		  
      		  
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
                      //window.location.href = "${pageContext.request.contextPath}/chatroom/room/" + roomId + "?buyerId=" + buyerId + "&sellerId=" + sellerId;
                      window.open("${pageContext.request.contextPath}/chatroom/room/" + roomId + "?buyerId=" + buyerId + "&sellerId=" + sellerId, "_blank", "width=400,height=600");
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
