<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
            /* 이미지 크기를 300px로 줄임 */
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

        .info-table th,
        .info-table td {
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

        .info-table-2 th,
        .info-table-2 td {
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
        @media (max-width: 768px) {
            .product-details {
                flex-direction: column;
            }

            .product-store-info {
                flex-direction: column;
            }

            .product-image,
            .product-info {
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
        <div class="product-title">${product.productSubject}</div>

        <!-- 가격 -->
        <div class="price">
            ${product.productPrice}원 <span>Pay</span>
        </div>

        <!-- 시간 정보 -->
        <div class="time-info">${product.productRegisterdate}·조회 ${product.productCount} · 채팅 1 · 찜 0</div>

        <!-- 제품 이미지와 정보 -->
        <div class="product-details">
            <div class="wrapwrap">
                <!-- Swiper 이미지 슬라이드 -->
                <div class="swiper mySwiper">
                    <div class="swiper-wrapper">
                        <c:forEach var="image" items="${productImages}">
                            <div class="swiper-slide">
                                <img src="${pageContext.request.contextPath}/resources/images/${image}" alt="상품 이미지">
                            </div>
                        </c:forEach>
                    </div>

                    <!-- 이전/다음 버튼 -->
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                    <!-- 페이지네이션 -->
                    <div class="swiper-pagination"></div>
                </div>
            </div>
            <!-- 상품 정보 -->
            <div class="product-info">
                <!-- 첫 번째 테이블 -->
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

                <!-- 추가 정보 -->
                <div class="extra-info">
                    <ul>
                        <li>결제혜택: 페이코 최대 4만원 즉시할인, KB국민카드 18개월 6% 특별 할부 수수료</li>
                        <li>무이자혜택: 1만원 이상 무이자 할부</li>
                    </ul>
                </div>

                <!-- 버튼 -->
                <div class="buttons">
                    <button class="btn btn-chat">채팅하기</button>
                    <button class="btn btn-safe">안전거래</button>
                </div>

            </div>
        </div>

        <!-- 상품 정보 및 가게 정보 -->
        <div class="product-store-info">
            <!-- 상품 정보 -->
            <div class="product-info-left">
                <h4 class="info-header" style="font-weight: bold;">상품 정보</h4>
                <div class="left-wrap" style="border-top: 1px solid #e1e1e1; margin-top: 25px; padding: 20px; background-color: #f9f9f9; border-radius: 8px;">
                    <ul style="margin-top: 25px; list-style: none; padding: 0;">
                        <li style="padding: 10px 0; border-bottom: 1px solid #ddd;">
                            <strong>상품명:</strong> ${product.productSubject}
                        </li>
                        <li style="padding: 10px 0; border-bottom: 1px solid #ddd;">
                            <strong>가격:</strong> ${product.productPrice}원
                        </li>
                        <li style="padding: 10px 0; border-bottom: 1px solid #ddd;">
                            <strong>상품상태:</strong> ${product.productModelStatus}
                        </li>
                        <li style="padding: 10px 0;"><strong>내용:</strong> ${product.productContent}</li>
                    </ul>
                </div>
                <!-- 수정 및 삭제 버튼 배치 -->
                <c:if test="${currentUserId eq product.productUserid}">
                    <a href="${pageContext.request.contextPath}/product/modify?productIdx=${product.productIdx}" class="btn btn-outline-secondary btn-sm" style="display: inline-block; margin-top: 20px; padding: 10px 20px; font-size: 1rem;">게시글 수정</a>
                    <!-- 삭제 버튼 추가 -->
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
    </script>
</body>

</html>
