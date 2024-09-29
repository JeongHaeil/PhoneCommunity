<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>요금 계산기</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/phone.css'/>">
    <script type="text/javascript" src="<c:url value='/js/jquery-3.7.1.min.js'/>"></script>
</head>
<body>

    <header class="plans-header">
        <h1>요금 계산기</h1>
    </header>

    <!-- 필터 테이블 -->
    <form action="<c:url value='/phone/phone'/>" method="post">
    <section class="plans-filter">
        <table class="plans-table">
            <thead>
                <tr>
                    <th>통신사</th>
                    <th>제조사</th>
                    <th>제품
                        <input type="text" id="product-search" placeholder="제품 검색" class="plans-search">
                    </th>
                    <th>구분</th>
                    <th>기타</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <ul class="plans-list">
                            <c:forEach var="carrier" items="${carriersList}">
                                <li><button type="button" class="plans-filter-btn" data-carrier="${carrier.carrierId}">
                                    ${carrier.carrierName}</button></li>
                            </c:forEach>
                        </ul>
                    </td>
                    <td>
                        <ul class="plans-list">
                            <c:forEach var="manufacturer" items="${manufacturersList}">
                                <li><button type="button" class="plans-filter-btn" data-manufacturer="${manufacturer.manufacturerId}">
                                    ${manufacturer.manufacturerName}</button></li>
                            </c:forEach>
                        </ul>
                    </td>
                    <td>
                        <ul class="plans-product-list">
                            <c:forEach var="product" items="${productsList}">
                                <li style="display: none;">
                                    <span class="plans-product-name" data-manufacturer="${product.manufacturerId}">${product.productName}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </td>
                    <td>
                        <ul class="plans-list">
                            <li><button class="plans-filter-btn" data-division="5g">5G</button></li>
                            <li><button class="plans-filter-btn" data-division="lte">LTE</button></li>
                        </ul>
                    </td>
                    <td>
                        <!-- 가입 구분, 할부 개월 및 추가 지원금 -->
                        <div class="plans-option-group">
                            <h3>가입 구분</h3>
                            <div class="plans-btn-group">
                                <button class="plans-btn active">신규</button>
                                <button class="plans-btn">기변</button>
                            </div>
                        </div>
                        <div class="plans-option-group">
                            <h3>할부 개월</h3>
                            <div class="plans-btn-group">
                                <button class="plans-btn active">자급제</button>
                                <button class="plans-btn" id="installmentBtn">할부</button>
                            </div>
                            <div class="dropdown">
                                <button class="dropdown-toggle" onclick="toggleDropdown()">개월 선택</button>
                                <div id="dropdown-menu" class="dropdown-menu" style="display: none;">
                                    <button class="dropdown-item" onclick="selectMonth(12)">12개월</button>
                                    <button class="dropdown-item" onclick="selectMonth(24)">24개월</button>
                                </div>
                            </div>
                        </div>
                        <div class="plans-option-group">
                            <h3>추가 지원금</h3>
                            <select id="extra-support" class="plans-select">
                                <option value="추가지원금 15%">추가지원금 15%</option>
                                <option value="추가지원금 10%">추가지원금 10%</option>
                                <option value="추가지원금 20%">추가지원금 20%</option>
                            </select>
                        </div>

                        <!-- 숨겨진 필드들 -->
                        <input type="hidden" name="carrierId" id="carrierId" value="0">
                        <input type="hidden" name="productId" id="productId" value="0">
                        <input type="hidden" name="planProductType" id="planProductType">
                        <input type="hidden" name="planType" id="planType">
                        <input type="hidden" name="planMonths" id="planMonths">
                        <input type="hidden" name="planOption" id="planOption">
                        <input type="hidden" name="planAdditional" id="planAdditional">
                        <button type="submit" class="plans-calculate-btn">요금제 조회</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </section>
    </form>

    <!-- 요금제 구분 테이블 -->
    <section class="plans-summary">
        <c:if test="${not empty planDetails}">
            <table class="plans-summary-table">
                <tr>
                    <th>요금제 이름</th>
                    <td>${planDetails.planName}</td>
                </tr>
                <tr>
                    <th>약정 구분</th>
                    <td>${planDetails.planContractType}</td>
                </tr>
                <tr>
                    <th>데이터 용량</th>
                    <td>${planDetails.planData}</td>
                </tr>
                <tr>
                    <th>추가 지원금</th>
                    <td>${planDetails.additionalSupport}원</td>
                </tr>
                <tr>
                    <th>월 할부금</th>
                    <td>${planDetails.monthlyInstallmentFee}원</td>
                </tr>
                <tr>
                    <th>할부 이자</th>
                    <td>${planDetails.installmentInterest}원</td>
                </tr>
                <tr>
                    <th>총 월 요금</th>
                    <td>${planDetails.totalMonthlyFee}원</td>
                </tr>
            </table>
        </c:if>
    </section>

<script type="text/javascript">
// 자바스크립트 부분
document.addEventListener('DOMContentLoaded', function () {
    const carrierButtons = document.querySelectorAll('[data-carrier]');
    const manufacturerButtons = document.querySelectorAll('[data-manufacturer]');
    const productListItems = document.querySelectorAll('.plans-product-list li');
    const filterButtons = document.querySelectorAll('.plans-filter-btn');
    const planButtons = document.querySelectorAll('.plans-btn');
    const extraSupportSelect = document.getElementById('extra-support');
    const planMonthsHidden = document.getElementById('planMonths');
    const form = document.querySelector('form');
    let isInstallment = false;

    // 폼 제출 시 처리
    form.addEventListener('submit', function(event) {
        const carrierId = document.getElementById('carrierId').value || "0";
        const productId = document.getElementById('productId').value || "0";
        const planOption = document.getElementById('planOption').value;

        // 자급제일 경우 planMonths를 초기화
        if (planOption === '자급제') {
            planMonthsHidden.value = '';  
        }

        // 할부 선택 시 개월 수가 없으면 경고
        if (planOption === '할부' && !planMonthsHidden.value) {
            alert("할부 개월 수를 선택하세요.");
            event.preventDefault();
        }
    });

    // 통신사 버튼 클릭 시 처리
    carrierButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const carrierId = this.getAttribute('data-carrier');
            document.getElementById('carrierId').value = carrierId;
        });
    });

    // 제조사 버튼 클릭 시 처리
    manufacturerButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const manufacturerId = this.getAttribute('data-manufacturer');
            document.getElementById('productId').value = manufacturerId;
            
            // 해당 제조사에 맞는 제품 목록만 표시
            productListItems.forEach(item => {
                const productManufacturerId = item.querySelector('.plans-product-name').getAttribute('data-manufacturer');
                item.style.display = productManufacturerId === manufacturerId ? 'block' : 'none';
            });
        });
    });

    // 구분(5G, LTE) 버튼 클릭 시 처리
    filterButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const planProductType = this.getAttribute('data-division');
            document.getElementById('planProductType').value = planProductType;
        });
    });

    // 가입 구분 처리(신규, 기변, 자급제, 할부)
    planButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const planOption = this.textContent.trim();
            document.getElementById('planOption').value = planOption;
            if (planOption === '할부') {
                isInstallment = true; 
            } else {
                planMonthsHidden.value = ''; // 자급제일 경우 할부 개월 비움
            }
        });
    });

    // 추가 지원금 선택 처리
    extraSupportSelect.addEventListener('change', function() {
        const additionalSupport = this.value.replace('추가지원금 ', '').replace('%', '');
        document.getElementById('planAdditional').value = additionalSupport;
    });

    // 할부 개월 선택 처리
    const dropdown = document.getElementById("dropdown-menu");
    document.getElementById("installmentBtn").addEventListener('click', function(e) {
        e.preventDefault();
        dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
    });

    document.querySelectorAll('.dropdown-item').forEach(button => {
        button.addEventListener('click', function() {
            const months = this.textContent.replace("개월", "").trim();
            planMonthsHidden.value = months;
            document.getElementById("installmentBtn").textContent = months + "개월 할부";
            dropdown.style.display = "none"; 
        });
    });
});
</script>
</html>
