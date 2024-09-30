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
            padding: 15px 0;
            font-size: 1.2rem;
            width: 48%;
            border-radius: 8px;
            text-align: center;
            font-weight: bold;
        }

        .btn-chat {
            background-color: white;
            color: #333;
            border: 1px solid #ddd;
        }

        .btn-chat:hover {
            background-color: #f1f1f1;
        }

        .btn-safe {
            background-color: #000;
            color: white;
            border: none;
        }

        .btn-safe:hover {
            background-color: #333;
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
            width: 27%;
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

        .profile-img {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            object-fit: cover;
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
        <div class="product-title">아이폰 13미니 핑크 128기가</div>

        <!-- 가격 -->
        <div class="price">
            300,000원
            <span>Pay</span>
        </div>

        <!-- 시간 정보 -->
        <div class="time-info">1시간 전 · 조회 13 · 채팅 1 · 찜 0</div>

        <!-- 제품 이미지와 정보 -->
        <div class="product-details">
            <!-- 이미지 -->
            <div class="product-image">
                <img src="https://via.placeholder.com/150" alt="상품 이미지" class="img-fluid">
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
                            <th>카테고리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>중고</td>
                            <td>직거래, 택배</td>
                            <td>별도</td>
                            <td>휴대폰</td> <!-- 여기서 동적으로 카테고리 값 출력 -->
                        </tr>
                    </tbody>
                </table>

                <!-- 추가 정보 -->
                <div class="extra-info">
                    <ul>
                        <li><b>거래희망지역:</b> 고산1동</li>
                        <li><b>결제혜택:</b> 페이코 최대 4만원 즉시할인, KB국민카드 18개월 6% 특별 할부 수수료</li>
                        <li><b>무이자혜택:</b> 1만원 이상 무이자 할부</li>
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
                <h4 style="font-weight: bold;">상품 정보</h4>
                <div class="left-wrap" style="border-top: 1px solid #e1e1e1; margin-top: 25px;">
                    <ul style="margin-top: 25px;">
                        <li>- 상품명: 애플 아이폰 13미니 핑크 128기가</li>
                        <li>- 가격: 300,000원</li>
                        <li>- 구매시기: 2022년 12월</li>
                        <li>- 배터리 성능: 83퍼</li>
                        <li>- 특이사항: 휴대폰 단품이고, 액정과 후면에는 기스, 파손은 없지만 측면에 잔기스와 찍힘 하나 있습니다. 사진 참고해주세요.</li>
                    </ul>
                </div>
            </div>

            <!-- 가게 정보 -->
            <div class="store-info-right">
                <h4 style="font-weight: bold;">프로필 정보</h4>
                <div class="left-wrap" style="border-top: 1px solid #e1e1e1; margin-top: 25px;">
                    <div class="store-name-container" style="margin-top: 30px;">
                        <div class="store-name">woody0226</div>
                        <img src="https://via.placeholder.com/50" alt="프로필 사진" width="70px;">
                    </div>                  
                    <div class="trust-score" style="margin-top: 30px;">신뢰지수 <span>272</span></div>
                    <div class="trust-bar">
                        <div class="trust-bar-fill"></div>
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
                            아이폰 13미니 핑크 128기가<br>
                            300,000원
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>