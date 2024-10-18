<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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

.btn {
	background-color: #3C3D37 !important; /* 버튼 배경색을 강제로 #3C3D37로 설정 */
	color: white !important; /* 글씨 색을 하얀색으로 강제 설정 */
	border-color: #3C3D37 !important; /* 버튼 테두리도 같은 색상으로 강제 설정 */
}

.btn:hover {
	transform: scale(1.05);
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
}

.popular-list ul {
	list-style-type: none; /* 리스트 점 제거 */
	padding-left: 0;
}

.popular-list ul li {
	font-size: 14px;
	line-height: 1.8;
	color: #212529;
	white-space: nowrap; /* 긴 제목이 줄바꿈 되지 않도록 설정 */
	overflow: hidden; /* 넘치는 텍스트를 숨김 */
	text-overflow: ellipsis; /* 긴 제목은 ...로 표시 */
}

.popular-list ul li a {
	text-decoration: none; /* 밑줄 제거 */
	color: #333; /* 텍스트 색상 변경 */
}

.popular-list ul li a:hover {
	font-weight: bold; /* 마우스를 올리면 글자 두껍게 */
	color: #f85656; /* 마우스를 올리면 색상 변경 */
}

.popular-list ul li span {
	color: #f85656; /* 조회수 컬러 */
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
}

.img-fluid {
	width: 100%; /* 가로 크기는 100%로 설정하여 카드의 전체 폭에 맞춤 */
	height: 300px; /* 고정된 세로 크기 설정 */
	object-fit: cover; /* 이미지 비율을 유지하면서 공간에 맞춤 */
	margin: 0; /* 여백 제거 */
	padding: 0; /* 패딩 제거 */
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
	gap: 8px;
}

.pagination li {
	cursor: pointer;
}

.pagination li a, .pagination li span {
	color: #333;
	text-decoration: none;
	padding: 6px 12px;
	border: 1px solid #ddd;
	transition: background-color 0.3s ease, color 0.3s ease;
}

.pagination li.active span {
	background-color: #333;
	color: white;
}

.pagination li a:hover {
	background-color: #f0f0f0;
	color: #333;
}

.text-muted span {
	color: blue !important;
}

/* 리스트 페이지에서 이미지 크기 고정 */
.product-list img {
	width: 300px; /* 원하는 고정 너비 */
	height: 200px; /* 원하는 고정 높이 */
	object-fit: cover; /* 이미지가 고정된 크기에 맞게 자르기 */
	border-radius: 5px; /* 모서리를 둥글게 */
}

.wow {
	font-weight: bold;
}
</style>

</head>
<body>
	<div class="container my-4">
		<!-- 필터 및 버튼 -->
		<div
			class="d-flex justify-content-between align-items-center filter-buttons mt-3">
			<div class="dropdown">
				<button class="btn btn-dark btn-sm dropdown-toggle" type="button"
					id="filterDropdown" data-bs-toggle="dropdown" aria-expanded="false">
					분류</button>
				<ul class="dropdown-menu" aria-labelledby="filterDropdown"
					style="font-size: 0.9rem; padding: 5px 0;">
					<li><a class="dropdown-item"
						href="${pageContext.request.contextPath}/product/list?productSold=1"
						style="padding: 5px 10px;">판매</a></li>
					<li><a class="dropdown-item"
						href="${pageContext.request.contextPath}/product/list?productSold=2"
						style="padding: 5px 10px;">예약</a></li>
					<li><a class="dropdown-item"
						href="${pageContext.request.contextPath}/product/list?productSold=3"
						style="padding: 5px 10px;">판매완료</a></li>
				</ul>
			</div>

			<div>
				<!-- user_level이 9999가 아닌 경우에만 글쓰기 버튼을 표시 (최고관리자는 글을 쓸 수 없게 막아둠) -->
				<c:if test="${sessionScope.userLevel != 9999}">
				    <button class="btn btn-primary btn-sm"
				        onclick="location.href='${pageContext.request.contextPath}/product/register'">쓰기</button>
				</c:if>
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

		<c:if test="${not empty errorMessage}">
			<div class="alert alert-warning mb-3">${errorMessage}</div>
		</c:if>

		<div class="content-wrapper mt-4 sidebar-fixed">
			<!-- 메인 콘텐츠 -->
			<div class="main-content">
				<!-- 상품 목록 -->
				<div class="row product-list">
					<c:choose>
						<c:when test="${not empty result.productList}">
							<c:forEach var="product" items="${result.productList}">
								<div class="col-md-3 col-sm-6 mb-4">
									<a
										href="${pageContext.request.contextPath}/product/details?productIdx=${product.productIdx}"
										class="text-decoration-none">
										<div class="product-card">
											<!-- 글 번호 표시 -->
											<div class="product-meta text-muted"
												style="font-size: 12px; margin-bottom: 5px;">글 번호:
												${product.productIdx}</div>
											<img
												src="${pageContext.request.contextPath}/resources/images/${fn:split(product.productImage, ',')[0] != null ? fn:split(product.productImage, ',')[0] : '150.png'}"
												alt="상품 이미지" class="img-fluid">

											<div class="product-meta">
												<span class="text-muted"
													style="font-size: 14px; font-weight: bold; color: blue !important;">
													<c:choose>
														<c:when test="${product.productSold == 1}">
                판매중
            </c:when>
														<c:when test="${product.productSold == 2}">
                예약중
            </c:when>
														<c:when test="${product.productSold == 3}">
                판매완료
            </c:when>
														<c:otherwise>
                대기중
            </c:otherwise>
													</c:choose>
												</span>, <span>${product.productRegisterdate}</span>
											</div>



											<p class="product-title">${product.productSubject}</p>

											<div class="product-details">
												<p>
													· 배송 방법:
													<c:choose>
														<c:when test="${product.productMode == '직거래'}">직거래</c:when>
														<c:when test="${product.productMode == '안전거래'}">안전거래</c:when>
														<c:otherwise>택배</c:otherwise>
													</c:choose>
												</p>
												<p class="wow">
													· 판매 가격: ₩
													<fmt:formatNumber value="${product.productPrice}"
														type="number" pattern="#,###" />
													원
												</p>
											</div>

											<div
												class="product-footer d-flex align-items-center justify-content-between">
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
				<!-- row product-list 종료 -->
			</div>
			<!-- main-content 종료 -->
		</div>
		<!-- content-wrapper 종료 -->

		<!-- Pagination -->
		<div class="pagination-wrapper">
			<ul class="pagination">
				<c:choose>
					<c:when test="${result.pager.startPage > result.pager.blockSize}">
						<li><a
							href="<c:url value='/product/list'/>?pageNum=${result.pager.prevPage}&pageSize=${result.pager.pageSize}">이전</a></li>
					</c:when>
					<c:otherwise>
						<li class="disabled"><span>이전</span></li>
					</c:otherwise>
				</c:choose>

				<c:forEach var="i" begin="${result.pager.startPage}"
					end="${result.pager.endPage}" step="1">
					<c:choose>
						<c:when test="${result.pager.pageNum != i}">
							<li><a
								href="<c:url value='/product/list'/>?pageNum=${i}&pageSize=${result.pager.pageSize}">${i}</a></li>
						</c:when>
						<c:otherwise>
							<li class="active"><span>${i}</span></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:choose>
					<c:when test="${result.pager.endPage != result.pager.totalPage}">
						<li><a
							href="<c:url value='/product/list'/>?pageNum=${result.pager.nextPage}&pageSize=${result.pager.pageSize}">다음</a></li>
					</c:when>
					<c:otherwise>
						<li class="disabled"><span>다음</span></li>
					</c:otherwise>
				</c:choose>
			</ul>
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

	        // 경고 메시지를 1초 후에 서서히 사라지게 설정
	        setTimeout(function() {
	            $(".alert").fadeOut("slow");
	        }, 1000);
	    });
		
		
	</script>
</body>
</html>
