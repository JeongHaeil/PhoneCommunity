<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>쇼핑 정보</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
      height: 100%;
    }

    .img-fluid {
      width: 190px;
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

    @media (max-width: 768px) {
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
    <li class="nav-item">
      <a class="nav-link active" href="#">인기정보</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">패션정보</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">기타정보</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">이벤트정보</a>
    </li>
  </ul>

  <!-- 필터 및 버튼 -->
  <div class="d-flex justify-content-between align-items-center filter-buttons mt-3">
    <div>
      <button class="btn btn-dark btn-sm">분류</button>
      <button class="btn btn-dark btn-sm">정렬</button>
    </div>
    <div>
     <button class="btn btn-primary btn-sm" onclick="location.href='${pageContext.request.contextPath}/product/productregister'">쓰기</button>
      <button class="btn btn-outline-secondary btn-sm" id="search-btn">검색</button>
      <button class="btn btn-outline-secondary btn-sm">목록</button>
    </div>
  </div>

  <!-- 검색 바 -->
  <div class="d-flex justify-content-end mt-3">
    <div class="search-bar" id="search-bar" style="display:none;">
      <div class="d-flex">
        <span style="margin-top: 6px;">제목+내용 ▼</span>
        <input type="text" class="form-control ms-2" placeholder="검색어를 입력하세요." style="width: 200px;">
      </div>
    </div>
  </div>

  <div class="content-wrapper mt-4">
    <!-- 메인 콘텐츠 -->
    <div class="main-content">
      <!-- 상품 목록 -->
      <div class="row product-list">
        <c:forEach var="product" items="${productList}">
          <div class="col-md-3 col-sm-6 mb-4">
            <a href="productDetail.jsp?productIdx=${product.productIdx}" class="text-decoration-none">
              <div class="product-card">
                <img src="${pageContext.request.contextPath}/upload/${product.productImage}" alt="상품 이미지" class="img-fluid">
                <div class="product-meta">
                  <span class="text-muted">판매</span>, <span>${product.procutRegisterdate}</span>
                </div>
                <p class="product-title">${product.procutSubject}</p>
                <div class="product-details">
                  <p>· 배송 방법: ${product.productMode}</p>
                  <p>· 판매 가격: ₩ ${product.productPrice}원</p>
                </div>
                <div class="product-footer d-flex align-items-center justify-content-between">
                  <div class="profile-info">
                    <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                    <span>${product.productUserid}</span>
                  </div>
                  <div class="stats">
                    <span>💬 0</span>
                    <span>👁️ ${product.prodcutCount}</span>
                  </div>
                </div>
              </div>
            </a>
          </div>
        </c:forEach>
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
    <ul class="pagination">
      <li class="active"><span>1</span></li>
      <li><span>2</span></li>
      <li><span>3</span></li>
      <li><span>4</span></li>
      <li><span>5</span></li>
      <li><span>6</span></li>
      <li><span>7</span></li>
      <li><span>8</span></li>
      <li><span>9</span></li>
      <li><span>10</span></li>
      <li><span>›</span></li>
    </ul>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function() {
    // 페이지 번호 클릭 시 이벤트 처리
    $('.pagination li').click(function() {
      $('.pagination li').removeClass('active');
      $(this).addClass('active');

      var pageNumber = $(this).text().trim();
      if (pageNumber === '›') {
        pageNumber = '다음 페이지';
      }

      $('#content').html('<p>페이지 ' + pageNumber + '의 내용입니다.</p>');
    });
  });

  $(document).ready(function() {
    // 검색 버튼 클릭 시 검색창 표시/숨기기
    $('#search-btn').click(function() {
      $('#search-bar').toggle();
    });
  });
</script>
</body>
</html>
