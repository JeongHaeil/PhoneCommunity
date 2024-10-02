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
                                <button class="dropdown-toggle"  onclick="toggleDropdown()">개월 선택</button>
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
                       <input type="hidden" name="carrierId" id="carrierId">
					    <input type="hidden" name="productId" id="productId">
					    <input type="hidden" name="planProductType" id="planProductType">
					    <input type="hidden" name="planType" id="planType">
					    <input type="hidden" name="planOption" id="planOption">
					    <input type="hidden" name="planMonths" id="planMonths">
					    <input type="hidden" name="planAdditional" id="planAdditional">
					    <button type="submit" onclick="fetchPlanDetails()" class="plans-calculate-btn">요금제 조회</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </section>
    </form>

    <!-- 요금제 구분 테이블 -->
    <section class="plans-summary">
      	<%-- <c:if test="${not empty phonePlans}"> --%>
    <table class="plans-summary-table">
        <tr>
            <th>요금제 이름</th>
            <td>${phonePlans[0].planName}</td>
        </tr>
        <tr>
            <th>약정 구분</th>
            <td>${phonePlans[0].planContractType}</td>
        </tr>
        <tr>
            <th>데이터 용량</th>
            <td>${phonePlans[0].planData}</td>
        </tr>
        <tr>
            <th>추가 지원금</th>
            <td>${phonePlans[0].additionalSupport}원</td>
        </tr>
        <tr>
            <th>월 할부금</th>
            <td>${phonePlans[0].monthlyInstallmentFee}원</td>
        </tr>
        <tr>
            <th>할부 이자</th>
            <td>${phonePlans[0].installmentInterest}원</td>
        </tr>
        <tr>
            <th>총 월 요금</th>
            <td>${phonePlans[0].totalMonthlyFee}원</td>
        </tr>
    </table>
<%-- </c:if> --%>
            
    </section>
</body>
<script type="text/javascript">
		
function fetchPlanDetails() {
    // 폼 데이터를 직렬화합니다.
    var formData = $('form').serialize(); 

    // Ajax 요청을 통해 서버로 데이터 전송 및 응답 받기
    $.ajax({
        url: '/final/phone/phonePlansTable',  // 서버에 요청을 보낼 URL
        type: 'POST',
        data: formData,  // 직렬화된 폼 데이터
        success: function(response) {
            // 성공적으로 응답을 받았을 때
            $('#plans-summary').html(response);  // 응답을 받아 결과를 해당 영역에 삽입
        },
        error: function(xhr, status, error) {
            // 오류 발생 시 처리
            console.error('오류 발생:', error);
        }
    });
}
		
	





document.addEventListener('DOMContentLoaded', function () {
    const carrierButtons = document.querySelectorAll('[data-carrier]');
    const manufacturerButtons = document.querySelectorAll('[data-manufacturer]');
    const productListItems = document.querySelectorAll('.plans-product-list li');
    const planTypeButtons = document.querySelectorAll('.plans-btn'); // planType 처리용 버튼
    const extraSupportSelect = document.getElementById('extra-support');
    const planMonthsHidden = document.getElementById('planMonths');
    const planOptionHidden = document.getElementById('planOption');  // planOption 숨김 필드
    const planTypeHidden = document.getElementById('planType');  // planType 숨김 필드

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

    // 구분(신규, 기변 및 자급제, 할부) 버튼 클릭 시 처리
    planTypeButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const buttonText = this.textContent.trim();

            if (buttonText === '신규' || buttonText === '기변') {
                planTypeHidden.value = buttonText;  // planType 설정
                console.log("Selected Plan Type: " + buttonText);
            } else if (buttonText === '자급제' || buttonText === '할부') {
                planOptionHidden.value = buttonText;  // planOption 설정
                console.log("Selected Plan Option: " + buttonText);
            }
            console.log("Plan Type Hidden Value:", planTypeHidden.value);
            console.log("Plan Option Hidden Value:", planOptionHidden.value);
        });
    });

    // 추가 지원금 선택 처리
    extraSupportSelect.addEventListener('change', function() {
        const additionalSupport = this.value.replace('추가지원금 ', '').replace('%', '');
        document.getElementById('planAdditional').value = additionalSupport;
    });

    // 드롭다운 버튼 클릭 시 처리
    document.getElementById("installmentBtn").addEventListener('click', function(e) {
        e.preventDefault();
        toggleDropdown();  // 드롭다운 토글
    });

    // 할부 개월 선택 처리 (드롭다운 내 아이템 클릭 시 처리)
    document.querySelectorAll('.dropdown-item').forEach(button => {
        button.addEventListener('click', function() {
            const months = this.textContent.replace("개월", "").trim();
            selectMonth(months);  // 선택된 개월 수를 함수에 전달하여 처리
        });
    });
});

// 할부 개월 선택 함수 정의
function selectMonth(months) {
    // 선택된 개월 수를 숨겨진 필드에 설정
    document.getElementById('planMonths').value = months;

    // 할부 버튼에 선택된 개월 수를 표시
    document.getElementById('installmentBtn').textContent = months + "개월 할부";

    // 드롭다운 메뉴 숨기기
    document.getElementById('dropdown-menu').style.display = "none";
}

// 드롭다운 열고 닫기 함수 정의
function toggleDropdown() {
    var dropdownMenu = document.getElementById('dropdown-menu');
    dropdownMenu.style.display = (dropdownMenu.style.display === "block") ? "none" : "block";
}

// 모든 jQuery 관련 기능을 하나로 통합
$(document).ready(function() {
    // 5G/LTE 선택 시
    $('.plans-filter-btn').on('click', function(e) {
        e.preventDefault(); // 기본 동작 방지

        var division = $(this).attr('data-division'); // 5G 또는 LTE
        $('#planProductType').val(division); // 숨겨진 필드에 5G 또는 LTE 값 설정

        var formData = $('form').serialize(); // 직렬화된 폼 데이터 전송

        // 구분(5G/LTE)에 따라 요금제를 Ajax로 조회
        $.ajax({
            url: '/final/phone/phonePlansTable',  // POST 요청할 URL
            type: 'POST',
            data: formData, // 직렬화된 폼 데이터 전송
            success: function(response) {
                $('#plans-summary').html(response);  // 요금제 테이블 갱신
            },
            error: function(xhr, status, error) {
                console.error('오류 발생:', error);  // 오류 처리
            }
        });
    });

    // 할부 개월 선택 시 (AJAX로 요금제 갱신 처리)
    $('.dropdown-item').on('click', function(e) {
        e.preventDefault();

        var formData = $('form').serialize(); // 직렬화된 폼 데이터 전송

        // 할부 개월 선택 시 Ajax로 요금제 조회
        $.ajax({
            url: '/final/phone/phonePlansTable',  // POST 요청할 URL
            type: 'POST',
            data: formData, // 직렬화된 폼 데이터 전송
            success: function(response) {
                $('#plans-summary').html(response);  // 요금제 테이블 갱신
            },
            error: function(xhr, status, error) {
                console.error('오류 발생:', error);  // 오류 처리
            }
        });
    });
});


</script>
</html>
