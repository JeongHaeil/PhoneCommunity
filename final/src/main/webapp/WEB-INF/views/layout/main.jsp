<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>">
</head>
<body>

    <body>


    <div class="main-container">
        <div class="main-row">
            <div class="main-shopping-info">
                <div class="main-card">
                    <div class="main-card-header">
                        최신글
                        <a href="#" class="main-more-btn">더보기</a>
                    </div>
                    <div class="main-card-body">
                        <ul class="main-list-group">
                            <li class="main-list-item">1. 구뜨꾸뜨</li>
                            <li class="main-list-item">2. 아이스아메리카노</li>
                            <li class="main-list-item">3. 아이폰</li>
                            <li class="main-list-item">4. 전자담배</li>
                            <li class="main-list-item">5. 화이팅</li>
                        </ul>
                    </div>
                </div>
            </div>
    
            <div class="main-community">
                <div class="main-card">
                    <div class="main-card-header">
                        인기글
                        <a href="#" class="main-more-btn">더보기</a>
                    </div>
                    <div class="main-card-body">
                        <ul class="main-list-group">
                            <li class="main-list-item">1. 취업하자</li>
                            <li class="main-list-item">2. 2</li>
                            <li class="main-list-item">3. 3</li>
                            <li class="main-list-item">4. 4</li>
                            <li class="main-list-item">5. 5</li>
                        </ul>
                    </div>
                </div>
            </div>
    
            <div class="main-notice">
                <div class="main-card">
                    <div class="main-card-header">
                        공지사항
                        <a href="#" class="main-more-btn">더보기</a>
                    </div>
                    <div class="main-card-body">
                        <ul class="main-list-group">
                            <li class="main-list-item">1.1</li>
                            <li class="main-list-item">2. 2</li>
                            <li class="main-list-item">3. 3</li>
                            <li class="main-list-item">4. 32</li>
                            <li class="main-list-item">5. 123</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    
        <!-- 자유게시판과 새로운 섹션을 같은 행에 배치 -->
        <div class="main-row main-new-section">
            <div class="main-popular-posts">
                <div class="main-card">
                    <div class="main-card-header">
                        중고장터
                        <a href="#" class="main-more-btn">더보기</a>
                    </div>
                    <div class="main-card-body">
                        <div class="main-image-grid">
                            <div class="main-image-item">
                                <img src="image1.jpg" alt="상품1" class="main-image">
                                <p class="main-image-title">상품 1</p>
                            </div>
                            <div class="main-image-item">
                                <img src="image2.jpg" alt="상품2" class="main-image">
                                <p class="main-image-title">상품 2</p>
                            </div>
                            <div class="main-image-item">
                                <img src="image3.jpg" alt="상품3" class="main-image">
                                <p class="main-image-title">상품 3</p>
                            </div>
                            <div class="main-image-item">
                                <img src="image4.jpg" alt="상품4" class="main-image">
                                <p class="main-image-title">상품 4</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    
            <!-- 오른쪽에 추가될 새로운 섹션 -->
            <div class="main-new-board">
                <div class="main-card">
                    <div class="main-card-header">
                        새 게시판
                        <a href="#" class="main-more-btn">더보기</a>
                    </div>
                    <div class="main-card-body">
                        <ul class="main-list-group">
                            <li class="main-list-item">1. 게시글 1</li>
                            <li class="main-list-item">2. 게시글 2</li>
                            <li class="main-list-item">3. 게시글 3</li>
                            <li class="main-list-item">4. 게시글 4</li>
                            <li class="main-list-item">5. 게시글 5</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="<c:url value='/js/jquery-3.7.1.min.js'/>"></script>
    
</body>