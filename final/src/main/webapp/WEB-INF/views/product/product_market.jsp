<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>쇼핑 정보</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
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
      height: 100%; /* 카드의 높이를 동일하게 설정 */
    }

    .img-fluid{
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

    .profile-info span{
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

    .text-muted span{
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
      <button class="btn btn-primary btn-sm">쓰기</button>
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
      <!-- 인기 정보 리스트 -->
      <div class="info-list">
        <ul class="list-group">
          <li class="list-group-item">
            <span><span class="badge">공지</span> 쇼핑정보 게시판 이용 규정</span>
            <span>조회수: 341</span>
          </li>
          <li class="list-group-item">
            <span><span class="badge">공지</span> 세일 정보 문화상품권 이벤트</span>
            <span>조회수: 241</span>
          </li>
          <li class="list-group-item">
            <span><span class="badge">인기</span> 미투시 비첼 블랙 전체 리스트</span>
            <span>조회수: 30</span>
          </li>
        </ul>
      </div>

      <!-- 상품 목록 -->
      <div class="row product-list">
        <!-- 반복되는 상품 카드 -->
        <div class="col-md-3 col-sm-6 mb-4">
          <a href="used_market_detail.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid" >
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.09.22</span>
              </div>
              <p class="product-title">애플 아이폰 13미니 핑크 128기가</p>
              <div class="product-details">
                
                <p>· 제품 상태: 중고</p>
                <p>· 판매 가격: ₩ 300,000원</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>뽀꾸</span>
                </div>
                <div class="stats">
                  <span>💬 0</span>
                  <span>👁️ 42</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <!-- 반복되는 상품 카드 -->
        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="used_market_detail.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">판매</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">폴로 랄프로렌 반집업</p>
              <div class="product-details">
                <p>· 사이즈: S(100)</p>
                <p>· 제품 상태: 새상품</p>
                <p>· 판매 가격: ₩ 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="프로필 이미지" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>아기곰돌이</span>
                </div>
                <div class="stats">
                  <span>💬 1</span>
                  <span>👁️ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <!-- 추가 상품 카드들 계속 추가 -->
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
