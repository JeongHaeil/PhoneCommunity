<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>제품 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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

.product-image {
	flex: 1;
	margin-right: 40px;
}

.product-image img {
	width: 100%;
	border-radius: 5px;
}

.product-info {
	flex: 1.2;
	margin-left: 40px;
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

/* 다른 상품 목록 스타일 */
.other-products-section {
    margin-top: 50px;
}

.other-products-section .product-card {
    border: 1px solid #e1e1e1;
    border-radius: 5px;
    padding: 10px;
    background-color: #fff;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.other-products-section .product-card:hover {
    transform: scale(1.05);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
}

.other-products-section .product-title {
    font-size: 1rem;
    font-weight: bold;
    margin-top: 10px;
}

.other-products-section .product-price {
    font-size: 0.9rem;
    color: #555;
    margin-top: 5px;
}

/* 반응형 디자인 */
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
<sec:authentication property="principal" var="loginUser"/>
	<div class="container">
		<!-- 제품명 -->
		<div class="product-title">${product.productSubject}</div>

		<!-- 가격 -->
		<div class="price">
			${product.productPrice}원 <span>Pay</span>
		</div>

		<!-- 시간 정보 -->
		<div class="time-info">${product.productRegisterdate}· 조회
			${product.productCount} · 채팅 1 · 찜 0</div>

		<!-- 제품 이미지와 정보 -->
		<div class="product-details">
			<!-- 이미지 -->
			<div class="product-image">
				<img src="${pageContext.request.contextPath}/upload/${product.productImage}" alt="상품 이미지" class="img-fluid">
			</div>

			<!-- 정보 -->
			<div class="product-info">
				<!-- 첫 번째 테이블 -->
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

				<!-- 추가 정보 -->
				<div class="extra-info">
					<ul>
						<li>결제혜택: 페이코 최대 4만원 즉시할인, KB국민카드 18개월 6% 특별 할부 수수료</li>
                        <li>무이자혜택: 1만원 이상 무이자 할부</li>
					</ul>
				</div>

				<!-- 버튼 -->
				<div class="buttons">
					<button id="openChatRoomBtn"class="btn btn-chat">채팅하기</button>
					<div id="chatRoomContainer"></div> <!-- 채팅방 UI가 로드될 곳 -->
					<button class="btn btn-safe">안전거래</button>
				</div>
			</div>
		</div>

		<!-- 상품 정보 및 가게 정보 -->
		<div class="product-store-info">
			<!-- 상품 정보 -->
			<div class="product-info-left">
				<h4 style="font-weight: bold;">상품 정보</h4>
				<div class="left-wrap" style="border-top: 1px solid #e1e1e1; margin-top: 25px;">
					<ul style="margin-top: 25px;">
						<li>- 상품명: ${product.productSubject}</li>
						<li>- 가격: ${product.productPrice}원</li>
						<li>- 상품상태: ${product.productModelStatus}</li>
						<li>- 내용: ${product.productContent}</li>
					</ul>
				</div>
			</div>

			<!-- 가게 정보 -->
			<div class="store-info-right">
				<h4 style="font-weight: bold;">프로필 정보</h4>
				<div class="left-wrap" style="border-top: 1px solid #e1e1e1; margin-top: 25px;">
					<div class="store-name-container" style="margin-top: 30px;">
						<div class="store-name">${product.productUsernickname}</div>
						<img src="https://via.placeholder.com/50" alt="프로필 사진" width="70px;">
					</div>

					<!-- 두 번째 테이블 -->
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
						<div class="posted-product-info">
							${product.productSubject}<br> ${product.productPrice}원
						</div>
					</div>
				</div>
			</div>
		</div>

        <!-- 다른 상품 목록 추가 -->
        <div class="other-products-section">
          
            <div class="other-products-section">
    <h3>전체 상품 목록 </h3>
    <div class="row product-list">
        <c:forEach var="product" items="${otherProductList}">
            <div class="col-md-3 col-sm-6 mb-4">
                <a href="${pageContext.request.contextPath}/detail?productIdx=${product.productIdx}" class="text-decoration-none">
                    <div class="product-card">
                        <!-- 글 번호 표시 -->
                        <div class="product-meta text-muted" style="font-size: 12px; margin-bottom: 5px;">
                            글 번호: ${product.productIdx}
                        </div>
                        <img src="${pageContext.request.contextPath}/upload/${product.productImage}" alt="상품 이미지" class="img-fluid">
                        <div class="product-meta">
                            <span class="text-muted">판매</span>, <span>${product.productRegisterdate}</span>
                        </div>
                        <p class="product-title">${product.productSubject}</p>
                        <div class="product-details">
                            <p>· 배송 방법:
                                <c:choose>
                                    <c:when test="${product.productMode == '직거래'}">직거래</c:when>
                                    <c:when test="${product.productMode == '안전거래'}">안전거래</c:when>
                                    <c:otherwise>택배</c:otherwise>
                                </c:choose>
                            </p>
                            <p>· 판매 가격: ₩ ${product.productPrice}원</p>
                        </div>
                        <div class="product-footer d-flex align-items-center justify-content-between">
                            <div class="profile-info">
                                <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                                <span>${product.productUserid}</span>
                            </div>
                            <div class="stats">
                                <span>💬 0</span> <span>👁️ ${product.productCount}</span>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
</div>

            <!-- Pagination for other products -->
            <div class="pagination-wrapper">
                <c:choose>
                    <c:when test="${pager.startPage > pager.blockSize}">
                        <a href="${pageContext.request.contextPath}/detail?productIdx=${product.productIdx}&pageNum=${pager.prevPage}&pageSize=${pager.pageSize}">[이전]</a>
                    </c:when>
                    <c:otherwise>
                        [이전]
                    </c:otherwise>
                </c:choose>

                <c:forEach var="i" begin="${pager.startPage}" end="${pager.endPage}">
                    <c:choose>
                        <c:when test="${pager.pageNum != i}">
                            <a href="${pageContext.request.contextPath}/detail?productIdx=${product.productIdx}&pageNum=${i}&pageSize=${pager.pageSize}">[${i}]</a>
                        </c:when>
                        <c:otherwise>
                            [${i}]
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:choose>
                    <c:when test="${pager.endPage != pager.totalPage}">
                        <a href="${pageContext.request.contextPath}/detail?productIdx=${product.productIdx}&pageNum=${pager.nextPage}&pageSize=${pager.pageSize}">[다음]</a>
                    </c:when>
                    <c:otherwise>
                        [다음] 
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
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
				 
				 alert("sellerId before sending request: " + sellerId);
			        // 서버에 새로운 방 번호 요청 (방 번호 생성)
			        console.log("Creating room with buyerId: " + loggedInUserId + ", sellerId: " + sellerId);
			        
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
		    
		    console.log("Starting chat with roomId: " + roomId + ", buyerId: " + buyerId + ", sellerId: " + sellerId);  // 로그 추가
        // AJAX 요청으로 startChat 호출
		alert("sellerId start 시작 sending request: " + sellerId);
		    	
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
            	console.log("Chat room started successfully with roomId: " + roomId);
                console.log("Redirecting to chat room with roomId: " + roomId);
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
	    
	 
	</script>
</body>
</html>
