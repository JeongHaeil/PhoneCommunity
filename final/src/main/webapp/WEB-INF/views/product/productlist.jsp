<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- functions 라이브러리 추가 -->
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>쇼핑 정보</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
/* 기존 스타일 유지 */
body {
	background-color: #f8f9fa;
}

.nav-tabs .nav-link.active {
	color: #f85656;
	border-color: #f85656;
	font-weight: bold;
}

.filter-buttons .btn {
	margin-right: 10px;
	border-radius: 2px;
}

.info-list .list-group-item {
	display: flex;
	justify-content: space-between;
	padding: 10px 20px;
	font-size: 14px;
}

.info-list .badge {
	background-color: #f85656;
	margin-right: 10px;
}

.btn-outline-secondary {
	font-size: 14px;
	padding: 5px 10px;
}

.btn-primary {
	background-color: #333;
	border-color: #333;
}

.popular-list ul {
	list-style-type: none;
	padding-left: 0;
}

.popular-list ul li {
	font-size: 14px;
	line-height: 1.8;
	color: #212529;
}

.popular-list ul li span {
	color: #f85656;
}

.popular-list ul li:hover {
	font-weight: bold;
}

.popular-list {
	border: 1px solid #ddd;
	padding: 15px;
	background-color: #fff;
	max-height: 300px;
	overflow-y: auto;
}

.content-wrapper {
	display: flex;
	gap: 20px;
}

.main-content {
	flex: 3;
}

.sidebar {
	flex: 1;
}

/* 상품목록 스타일 */
.product-list {
	margin-top: 20px;
}

.product-card {
	border: 1px solid #e0e0e0;
	border-radius: 5px;
	padding: 10px;
	background-color: #fff;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	height: auto;
	max-width: 220px;
}

.img-fluid {
	width: 100%; /* 가로 크기는 100%로 설정하여 카드의 전체 폭에 맞춤 */
	height: 400px; /* 고정된 세로 크기 설정 */
	object-fit: cover; /* 이미지 비율을 유지하면서 공간에 맞춤 */
}

.product-card:hover {
	transform: scale(1.05);
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
}

.product-title {
	font-size: 14px;
	font-weight: bold;
	margin-bottom: 8px;
	color: #000;
	margin-top: 10px;
}

.product-meta {
	font-size: 12px;
	color: #6c757d;
	margin-top: 10px;
}

.product-details {
	font-size: 13px;
	color: #6c757d;
}

.product-footer {
	margin-top: 10px;
}

.profile-info img {
	margin-right: 5px;
}

.profile-info span {
	font-size: 12px;
}

.stats span {
	margin-left: 10px;
	font-size: 12px;
	color: #6c757d;
}

@media ( max-width : 768px) {
	.product-card {
		margin-bottom: 20px;
	}
}

/* Pagination 스타일 */
.pagination-wrapper {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.pagination {
	list-style: none;
	padding-left: 0;
	display: flex;
	gap: 10px;
}

.pagination li {
	cursor: pointer;
}

.pagination li.active span {
	background-color: #333;
	color: white;
	border-radius: 50%;
	width: 30px;
	height: 30px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.pagination li span {
	padding: 5px;
}

.text-muted span {
	color: blue;
}
</style>

</head>
<body>
	<div class="container my-4">
		<!-- 상단 네비게이션 탭 -->
		<ul class="nav nav-tabs">

		</ul>


		<!-- 필터 및 버튼 -->
		<div
			class="d-flex justify-content-between align-items-center filter-buttons mt-3">
		<div class="dropdown">
    <button class="btn btn-dark btn-sm dropdown-toggle" type="button"
        id="filterDropdown" data-bs-toggle="dropdown" aria-expanded="false">
        분류
    </button>
    <ul class="dropdown-menu" aria-labelledby="filterDropdown" style="font-size: 0.9rem; padding: 5px 0;">
        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/product/list?productSold=1" style="padding: 5px 10px;">판매</a></li>
        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/product/list?productSold=2" style="padding: 5px 10px;">예약</a></li>
        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/product/list?productSold=3" style="padding: 5px 10px;">판매완료</a></li>
    </ul>
</div>


			<div>
				<button class="btn btn-primary btn-sm"
					onclick="location.href='${pageContext.request.contextPath}/product/register'">쓰기</button>
				<button class="btn btn-outline-secondary btn-sm" id="search-btn">검색</button>
				<button class="btn btn-outline-secondary btn-sm"
					onclick="location.href='${pageContext.request.contextPath}/product/list'">목록</button>
			</div>
		</div>




		<!-- 검색 바 -->
		<div class="d-flex justify-content-end mt-3">
			<div class="search-bar" id="search-bar" style="display: none;">
				<form action="${pageContext.request.contextPath}/product/list"
					method="get">
					<div class="input-group">
						<select name="column" class="form-select"
							style="max-width: 150px; border-radius: 8px 0 0 8px;">
							<option value="product_subject">제목</option>
							<option value="product_content">내용</option>
						</select> <input type="text" name="keyword" class="form-control"
							placeholder="검색어를 입력하세요." value="${searchMap.keyword}">
						<button type="submit" class="btn btn-outline-secondary"
							style="border-radius: 0 8px 8px 0;">검색</button>
					</div>
				</form>
			</div>
		</div>

		<div class="content-wrapper mt-4">
			<!-- 메인 콘텐츠 -->
			<div class="main-content">
				<!-- 상품 목록 -->
				<div class="row product-list">
					<c:choose>

						<c:when test="${not empty result.productList}">
							<c:forEach var="product" items="${result.productList}">
    <div class="col-md-3 col-sm-6 mb-4">
        <a href="${pageContext.request.contextPath}/product/details?productIdx=${product.productIdx}" class="text-decoration-none">
            <div class="product-card">
                <!-- 글 번호 표시 -->
                <div class="product-meta text-muted" style="font-size: 12px; margin-bottom: 5px;">
                    글 번호: ${product.productIdx}
                </div>
                <img src="${pageContext.request.contextPath}/resources/images/${fn:split(product.productImage, ',')[0] != null ? fn:split(product.productImage, ',')[0] : '150.png'}" alt="상품 이미지" class="img-fluid">

                <div class="product-meta">
                    <!-- 판매 상태 표시 -->
                    <span class="text-muted" style="font-size: 14px; font-weight: bold; color: 
                        <c:choose>
                            <c:when test="${product.productSold == 1}">
                                blue;">판매중
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
                    </span>,
                    <span>${product.productRegisterdate}</span>
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
                   <p>· 판매 가격: ₩ <fmt:formatNumber value="${product.productPrice}" type="number" pattern="#,###"/>원</p>
                </div>

                <div class="product-footer d-flex align-items-center justify-content-between">
                    <div class="profile-info">
                        <span> 작성자 : ${product.productUsernickname}</span>
                    </div>
                    <div class="stats">
                        <span>👁️ ${product.productCount}</span>
                    </div>
                </div>
            </div>
        </a>
    </div>
</c:forEach>

						</c:when>
						<c:otherwise>
							<div class="col-12 text-center my-4">
								<h5>검색결과가 없습니다.</h5>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<!-- 오른쪽 사이드바 (오늘의 인기글) -->
			<div class="sidebar popular-list">
				<h5>오늘의 인기글</h5>
				<ul>
					<li>1. 인기정보 칵테일새우 1kg 가격 <span>14</span></li>
					<li>2. 뉴발란스 렉스공 7.9만 등 <span>40</span></li>
					<li>3. 국내배송 바라쿠타 5색상 <span>43</span></li>
					<li>4. 나우푸드 더블 스트렝스 아르기닌 <span>16</span></li>
					<li>5. 지오다노 1DAY 타임세일 소가죽 <span>20</span></li>
				</ul>
			</div>
		</div>

		<!-- Pagination -->
		<div class="pagination-wrapper">
			<c:choose>
				<c:when test="${result.pager.startPage > result.pager.blockSize}">
					<a
						href="<c:url value='/product/list'/>?pageNum=${result.pager.prevPage}&pageSize=${result.pager.pageSize}">
						[이전] </a>
				</c:when>
				<c:otherwise>
        [이전]
      </c:otherwise>
			</c:choose>

			<c:forEach var="i" begin="${result.pager.startPage}"
				end="${result.pager.endPage}" step="1">
				<c:choose>
					<c:when test="${result.pager.pageNum != i}">
						<a
							href="<c:url value='/product/list'/>?pageNum=${i}&pageSize=${result.pager.pageSize}">
							[${i}] </a>
					</c:when>
					<c:otherwise>
          [${i}]
        </c:otherwise>
				</c:choose>
			</c:forEach>

			<c:choose>
				<c:when test="${result.pager.endPage != result.pager.totalPage}">
					<a
						href="<c:url value='/product/list'/>?pageNum=${result.pager.nextPage}&pageSize=${result.pager.pageSize}">
						[다음] </a>
				</c:when>
				<c:otherwise>
        [다음]
      </c:otherwise>
			</c:choose>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function() {
			// 검색 버튼 클릭 시 검색창 표시/숨기기
			$('#search-btn').click(function() {
				$('#search-bar').toggle();
			});
		});
		
		
		  function filterByStatus(status) {
		        // 해당 status 값을 가진 게시글만 출력하도록 서버에 요청
		        window.location.href = "${pageContext.request.contextPath}/product/list?status=" + status;
		    }
	</script>
</body>
</html>
