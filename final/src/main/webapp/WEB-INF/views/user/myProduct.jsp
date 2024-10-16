<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내가 쓴 중고장터 글</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .container {
            margin-top: 0px; /* 상단 마진 완전 제거 */
        }
        .header-title {
            font-weight: bold;
            font-size: 1.5rem;
            margin-bottom: 5px; /* 제목과 탭 사이 간격 최소화 */
        }
        .tabs-wrapper {
            margin-bottom: 5px; /* 탭과 테이블 사이 간격 최소화 */
        }
        .product-table {
            width: 100%;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-collapse: collapse;
            table-layout: fixed; /* 테이블 열 너비 고정 */
        }
        .product-table th, .product-table td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #dee2e6;
            word-wrap: break-word; /* 긴 텍스트 줄바꿈 */
            word-break: break-all;  /* 긴 단어 줄바꿈 */
        }
        .product-table th {
            background-color: #f1f1f1;
            font-weight: bold;
        }
        .product-item {
            background-color: #fff;
            margin-bottom: 10px;
        }
        .product-item:hover {
            background-color: #f7f7f7;
        }
        .no-product-message {
            text-align: center;
            padding: 20px;
            font-size: 1rem;
            color: #999;
        }

        /* 페이지네이션 스타일 추가 */
        .pagination {
            margin-top: 20px;
            justify-content: center;
        }
        .pagebtn {
            border-radius: 32px;
            min-width: 36px;
            padding: 0 4px;
            height: 36px;
            line-height: 36px;
            color: #444;
            text-decoration: none !important;
            display: inline-block;
            font-weight: bold;
            font-size: 12px;
            text-align: center;
        }
        .pagebtn:hover {
            background-color: #444; 
            color: #fff;
        }
        .apagebtn {
            border-radius: 32px;
            min-width: 36px;
            padding: 0 4px;
            height: 36px;
            line-height: 36px;
            color: #fff;
            text-decoration: none !important;
            display: inline-block;
            font-weight: bold;
            font-size: 12px;
            background-color: #444;
            text-align: center;
        }
        .apagebtn:hover {
            color: #fff;
        }
    </style>
</head>
<body>

<div class="container">
    <!-- 탭 include -->
    <jsp:include page="/WEB-INF/views/user/mypageTabs.jsp">
        <jsp:param name="activeTab" value="myProduct" />
    </jsp:include>

    <h3 class="header-title">내가 쓴 중고장터 글</h3>
    
    <table class="product-table">
        <thead>
            <tr>
                <th style="width: 10%;">번호</th>
                <th style="width: 40%;">제목</th>
                <th style="width: 15%;">날짜</th>
                <th style="width: 15%;">가격</th>
                <th style="width: 20%;">상태</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty productList}">
                    <tr>
                        <td colspan="5" class="no-product-message">작성한 중고장터 글이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="product" items="${productList}" varStatus="status">
                        <tr class="product-item">
                            <td>${status.index + 1}</td>
                            <td><a href="/final/product/details?productIdx=${product.productIdx}">${product.productSubject}</a></td>
                            <td>${product.productRegisterdate}</td>
                            <td>${product.productPrice} 원</td>
                            <td>${product.productModelStatus}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <!-- 페이지 네비게이션 -->
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <c:if test="${pager.startPage > 1}">
                <li class="pagebtn">
                    <a href="?pageNum=${pager.prevPage}" class="pagebtn">◀</a>
                </li>
            </c:if>

            <c:forEach var="i" begin="${pager.startPage}" end="${pager.endPage}">
                <li class="page-item ${pager.pageNum == i ? 'active' : ''}">
                    <c:choose>
                        <c:when test="${i != pager.pageNum}">
                            <a href="?pageNum=${i}&pageSize=${pager.pageSize}" class="pagebtn">${i}</a>
                        </c:when>
                        <c:otherwise>
                            <span class="apagebtn">${i}</span>
                        </c:otherwise>
                    </c:choose>
                </li>
            </c:forEach>

            <c:if test="${pager.endPage < pager.totalPage}">
                <li class="pagebtn">
                    <a href="?pageNum=${pager.nextPage}" class="pagebtn">▶</a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>

<!-- 부트스트랩 JS -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
