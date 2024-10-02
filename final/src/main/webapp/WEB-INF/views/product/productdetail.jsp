<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 기존 스타일 유지 */
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
        /* (생략된 스타일 코드는 기존 그대로 유지) */
    </style>
</head>

<body>

    <div class="container">
        <!-- 제품명 -->
        <div class="product-title">${product.procutSubject}</div>

        <!-- 가격 -->
        <div class="price">
            ${product.productPrice}원
            <span>Pay</span>
        </div>

        <!-- 시간 정보 -->
        <div class="time-info">${product.procutRegisterdate} · 조회 ${product.prodcutCount} · 채팅 1 · 찜 0</div>

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
                            <th>카테고리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>${product.product_model_status}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${product.prodcutMode == 1}">직거래</c:when>
                                    <c:when test="${product.prodcutMode == 2}">안전거래</c:when>
                                    <c:otherwise>택배</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${product.product_delivery}</td>
                            <td>${product.product_category}</td>
                        </tr>
                    </tbody>
                </table>

                <!-- 추가 정보 -->
                <div class="extra-info">
                    <ul>
                        <li><b>내용:</b> ${product.procutContent}</li>
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
                        <li>- 상품명: ${product.procutSubject}</li>
                        <li>- 가격: ${product.productPrice}원</li>
                        <li>- 등록일: ${product.procutRegisterdate}</li>
                        <li>- 상품상태: ${product.product_model_status}</li>
                        <li>- 내용: ${product.procutContent}</li>
                    </ul>
                </div>
            </div>

            <!-- 가게 정보 -->
            <div class="store-info-right">
                <h4 style="font-weight: bold;">프로필 정보</h4>
                <div class="left-wrap" style="border-top: 1px solid #e1e1e1; margin-top: 25px;">
                    <div class="store-name-container" style="margin-top: 30px;">
                        <div class="store-name">${product.productUserid}</div>
                        <img src="https://via.placeholder.com/50" alt="프로필 사진" width="70px;">
                    </div>                  
                    <div class="trust-score" style="margin-top: 30px;">신뢰지수 <span>80</span></div>
                    <div class="trust-bar">
                        <div class="trust-bar-fill" style="width: 80%;"></div>
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
                            ${product.procutSubject}<br>
                            ${product.productPrice}원
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
