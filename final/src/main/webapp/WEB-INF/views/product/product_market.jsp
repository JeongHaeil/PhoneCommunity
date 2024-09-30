<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ì¼í ì ë³´</title>
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

    /* ìíëª©ë¡ ì¤íì¼ */
    .product-list {
      margin-top: 20px;
    }

    .product-card {
      border: 1px solid #e0e0e0;
      border-radius: 5px;
      padding: 10px;
      background-color: #fff;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      height: 100%; /* ì¹´ëì ëì´ë¥¼ ëì¼íê² ì¤ì  */
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

    /* Pagination ì¤íì¼ */
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
  <!-- ìë¨ ë¤ë¹ê²ì´ì í­ -->
  <ul class="nav nav-tabs">
    <li class="nav-item">
      <a class="nav-link active" href="#">ì¸ê¸°ì ë³´</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">í¨ìì ë³´</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">ê¸°íì ë³´</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">ì´ë²¤í¸ì ë³´</a>
    </li>
  </ul>

  <!-- íí° ë° ë²í¼ -->
  <div class="d-flex justify-content-between align-items-center filter-buttons mt-3">
    <div>
      <button class="btn btn-dark btn-sm">ë¶ë¥</button>
      <button class="btn btn-dark btn-sm">ì ë ¬</button>
    </div>
    <div>
      <button class="btn btn-primary btn-sm">ì°ê¸°</button>
      <button class="btn btn-outline-secondary btn-sm" id="search-btn">ê²ì</button>
      <button class="btn btn-outline-secondary btn-sm">ëª©ë¡</button>
    </div>
  </div>

  <!-- ê²ì ë° -->
  <div class="d-flex justify-content-end mt-3">
    <div class="search-bar" id="search-bar" style="display:none;">
      <div class="d-flex">
        <span style="margin-top: 6px;">ì ëª©+ë´ì© â¼</span>
        <input type="text" class="form-control ms-2" placeholder="ê²ìì´ë¥¼ ìë ¥íì¸ì." style="width: 200px;">
      </div>
    </div>
  </div>

  <div class="content-wrapper mt-4">
    <!-- ë©ì¸ ì½íì¸  -->
    <div class="main-content">
      <!-- ì¸ê¸° ì ë³´ ë¦¬ì¤í¸ -->
      <div class="info-list">
        <ul class="list-group">
          <li class="list-group-item">
            <span><span class="badge">ê³µì§</span> ì¼íì ë³´ ê²ìí ì´ì© ê·ì </span>
            <span>ì¡°íì: 341</span>
          </li>
          <li class="list-group-item">
            <span><span class="badge">ê³µì§</span> ì¸ì¼ ì ë³´ ë¬¸íìíê¶ ì´ë²¤í¸</span>
            <span>ì¡°íì: 241</span>
          </li>
          <li class="list-group-item">
            <span><span class="badge">ì¸ê¸°</span> ë¯¸í¬ì ë¹ì²¼ ë¸ë ì ì²´ ë¦¬ì¤í¸</span>
            <span>ì¡°íì: 30</span>
          </li>
        </ul>
      </div>

      <!-- ìí ëª©ë¡ -->
      <div class="row product-list">
        <!-- ë°ë³µëë ìí ì¹´ë -->
        <div class="col-md-3 col-sm-6 mb-4">
          <a href="used_market_detail.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid" >
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.09.22</span>
              </div>
              <p class="product-title">ì í ìì´í° 13ë¯¸ë íí¬ 128ê¸°ê°</p>
              <div class="product-details">
                
                <p>Â· ì í ìí: ì¤ê³ </p>
                <p>Â· íë§¤ ê°ê²©: â© 300,000ì</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ë½ê¾¸</span>
                </div>
                <div class="stats">
                  <span>ð¬ 0</span>
                  <span>ðï¸ 42</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <!-- ë°ë³µëë ìí ì¹´ë -->
        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="used_market_detail.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="product2.html" class="text-decoration-none">
            <div class="product-card">
              <img src="https://via.placeholder.com/150" alt="ìí ì´ë¯¸ì§" class="img-fluid">
              <div class="product-meta">
                <span class="text-muted">íë§¤</span>, <span>24.07.14</span>
              </div>
              <p class="product-title">í´ë¡ ëíë¡ë  ë°ì§ì</p>
              <div class="product-details">
                <p>Â· ì¬ì´ì¦: S(100)</p>
                <p>Â· ì í ìí: ììí</p>
                <p>Â· íë§¤ ê°ê²©: â© 70,000</p>
              </div>
              <div class="product-footer d-flex align-items-center justify-content-between">
                <div class="profile-info">
                  <img src="https://via.placeholder.com/24" alt="íë¡í ì´ë¯¸ì§" class="rounded-circle" style="width: 24px; height: 24px;">
                  <span>ìê¸°ê³°ëì´</span>
                </div>
                <div class="stats">
                  <span>ð¬ 1</span>
                  <span>ðï¸ 349</span>
                </div>
              </div>
            </div>
          </a>
        </div>

        <!-- ì¶ê° ìí ì¹´ëë¤ ê³ì ì¶ê° -->
      </div>
    </div>

    <!-- ì¤ë¥¸ìª½ ì¬ì´ëë° (ì¤ëì ì¸ê¸°ê¸) -->
    <div class="sidebar popular-list">
      <h5>ì¤ëì ì¸ê¸°ê¸</h5>
      <ul>
        <li>1. ì¸ê¸°ì ë³´ ì¹µíì¼ìì° 1kg ê°ê²© <span>14</span></li>
        <li>2. ë´ë°ëì¤ ë ì¤ê³µ 7.9ë§ ë± <span>40</span></li>
        <li>3. êµ­ë´ë°°ì¡ ë°ë¼ì¿ í 5ìì <span>43</span></li>
        <li>4. ëì°í¸ë ëë¸ ì¤í¸ë ì¤ ìë¥´ê¸°ë <span>16</span></li>
        <li>5. ì§ì¤ë¤ë¸ 1DAY íìì¸ì¼ ìê°ì£½ <span>20</span></li>
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
      <li><span>âº</span></li>
    </ul>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function() {
    // íì´ì§ ë²í¸ í´ë¦­ ì ì´ë²¤í¸ ì²ë¦¬
    $('.pagination li').click(function() {
      $('.pagination li').removeClass('active');
      $(this).addClass('active');

      var pageNumber = $(this).text().trim();
      if (pageNumber === 'âº') {
        pageNumber = 'ë¤ì íì´ì§';
      }

      $('#content').html('<p>íì´ì§ ' + pageNumber + 'ì ë´ì©ìëë¤.</p>');
    });
  });

  $(document).ready(function() {
    // ê²ì ë²í¼ í´ë¦­ ì ê²ìì°½ íì/ì¨ê¸°ê¸°
    $('#search-btn').click(function() {
      $('#search-bar').toggle();
    });
  });
</script>
</body>
</html>
