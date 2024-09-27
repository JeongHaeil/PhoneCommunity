<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>요금 계산기</title>
    <link rel="stylesheet" href="<c:url value="/resources/css/phone.css"/>">
    <link rel="js" href="<c:url value="/resources/js/phone.js"/>">
    
    <script type="text/javascript" src="<c:url value="/js/jquery-3.7.1.min.js"/>"></script>
</head>
<body>

    <header class="plans-header">
        <h1>요금 계산기</h1>
    </header>

    <!-- 필터 테이블 -->
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
                    <th>분류</th>
                    <th>기타</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <ul class="plans-list">
                      
                            <li><button class="plans-filter-btn active" data-carrier="skt">SKT</button></li>
                            <li><button class="plans-filter-btn" data-carrier="kt">KT</button></li>
                            <li><button class="plans-filter-btn" data-carrier="lg">LG</button></li>
                            
                        </ul>
                    </td>
                    <td>
                        <ul class="plans-list">
                        
                            <li><button class="plans-filter-btn" data-manufacturer="samsung">삼성</button></li>
                            <li><button class="plans-filter-btn" data-manufacturer="apple">애플</button></li>
                            
                        </ul>
                    </td>
                    <td>
                        <div class="plans-product-wrapper">
                            <ul class="plans-product-list">
                              <c:forEach var="plan" items="${plansList}">
                                <li style="display: none;">
                                    <span class="plans-product-name" data-manufacturer="samsung">${plan.plansname}</span>
                                    <span class="plans-product-price" data-manufacturer="samsung">1,200,000원</span>
                                </li>
                                </c:forEach>
                                 <c:forEach var="plan" items="${plansList}">
                                <li style="display: none;">
                                    <span class="plans-product-name" data-manufacturer="apple">${plan.plansname}</span>
                                    <span class="plans-product-price" data-manufacturer="apple">1,500,000원</span>
                                </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </td>
                    <td>
                        <ul class="plans-list">
                            <li><button class="plans-filter-btn" data-division="5g">5G</button></li>
                            <li><button class="plans-filter-btn" data-division="lte">LTE</button></li>
                        </ul>
                    </td>
                    <td>
                        <ul class="plans-list">
                            <li><button class="plans-filter-btn" data-category="direct-youth">청년 다이렉트</button></li>
                            <li><button class="plans-filter-btn" data-category="direct-5g">다이렉트5G</button></li>
                            <li><button class="plans-filter-btn" data-category="5gx-plan">5GX 플랜</button></li>
                        </ul>
                    </td>
                    <td>
                        <div class="plans-option-group">
                            <h3>가입 구분</h3>
                            <div class="plans-btn-group">
                                <button class="plans-btn active">번호이동</button>
                                <button class="plans-btn">신규/기변</button>
                            </div>
                        </div>
                        
                        <div class="plans-option-group">
                            <h3>할부 개월</h3>
                            <div class="plans-btn-group">
                                <button class="plans-btn active">자급제</button>
                                <button class="plans-btn">할부</button>
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

                            <div class="plans-option-group">
                                <h3>출고가</h3>
                                <input type="text" id="final-price" class="plans-input" placeholder="출고가 입력" />
                            </div>

                            <button class="plans-calculate-btn">요금 계산</button>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </section>

    <!-- 요금제 구분 테이블 -->
    <section class="plans-summary">
        <table class="plans-summary-table">
            <thead>
                <tr>
                    <th>요금제</th>
                    <th>약정 구분</th>
                    <th>공시지원금</th>
                    <th>추가지원금</th>
                    <th>월할부금</th>
                    <th>할부이자</th>
                    <th>총 월요금</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>5GX 레귤러</td>
                    <td>선택약정</td>
                    <td>0원</td>
                    <td>0원</td>
                    <td>69,000원</td>
                    <td>0원</td>
                    <td>69,000원</td>
                </tr>
                <tr>
                    <td>5GX 프라임</td>
                    <td>선택약정</td>
                    <td>0원</td>
                    <td>0원</td>
                    <td>89,000원</td>
                    <td>0원</td>
                    <td>89,000원</td>
                </tr>
            </tbody>
        </table>
    </section>
</body>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function () {
    const manufacturerLinks = document.querySelectorAll('[data-manufacturer]');
    const carrierLinks = document.querySelectorAll('[data-carrier]');
    const divisionLinks = document.querySelectorAll('[data-division]');
    const categoryLinks = document.querySelectorAll('[data-category]');
    const productListItems = document.querySelectorAll('.plans-product-list li');
    const productSearchInput = document.getElementById('product-search');

    // 처음에는 모든 제품 숨김
    productListItems.forEach(product => product.style.display = 'none');

    // 공통된 필터 처리 함수
    function applyFilter(linkGroup, activeClass = 'active') {
        linkGroup.forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                // 같은 그룹 내의 다른 항목에서 active 클래스 제거
                linkGroup.forEach(link => link.classList.remove(activeClass));
                // 선택된 항목에 active 클래스 추가
                this.classList.add(activeClass);
            });
        });
    }

    // 각 필터 그룹에 독립적인 이벤트 리스너 적용
    applyFilter(manufacturerLinks);
    applyFilter(carrierLinks);
    applyFilter(divisionLinks);
    applyFilter(categoryLinks);

    // 제조사 클릭 시 해당 제품만 표시
    manufacturerLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const selectedManufacturer = this.dataset.manufacturer;
            productListItems.forEach(product => {
                product.style.display = 'none'; // 모든 제품 숨김
                if (product.querySelector('.plans-product-name').getAttribute('data-manufacturer') === selectedManufacturer) {
                    product.style.display = 'flex'; // 선택된 제조사의 제품만 표시
                }
            });
        });
    });

    // 제품 클릭 시 제품 이름을 검색창에 입력
    document.querySelector('.plans-product-list').addEventListener('click', function(e) {
        if (e.target.classList.contains('plans-product-name')) {
            productSearchInput.value = e.target.innerText;
        }
    });
});

</script>
</html>
