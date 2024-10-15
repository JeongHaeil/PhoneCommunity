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
    
</head>
<body>

    <section class="plans-filter">
        <table class="plans-table">
            <thead>
                <tr>
                    <th>통신사</th>
                    <th>제조사</th>
                    <th>제품</th>
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
                                <li style="display: none;" >
                                    <span  class="plans-product-name"  data-manufacturer="${product.manufacturerId}">
                                    ${product.productName}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </td>
                    <td>
                        <ul class="plans-list">
                            <li><button class="plans-filter-btn" data-division="5G">5G</button></li>
                            <li><button class="plans-filter-btn" data-division="LTE">LTE</button></li>
                        </ul>
                    </td>
                    <td>
                        <!-- 가입 구분 추가 지원금 -->
                        <div class="plans-option-group">
                            <h3>가입 구분</h3>
                            <div class="plans-btn-group">
                                <button class="plans-btn active" data-type="신규">신규</button>
                                <button class="plans-btn" data-type="기변">기변</button>
                            </div>
                        </div>
                        
                      <div class="plans-option-group">
                            <h3>할부 개월</h3>
                            <div class="plans-btn-group">
                                <button class="plans-btn active" data-type="자급제">자급제</button>       
                            </div>
                          
                        </div> 
                        
                        <div class="plans-option-group">
                            <h3>추가 지원금</h3>
                            <select id="extra-support" class="plans-select">
                                <option >없음</option>
                                <option value="추가지원금 0.15">추가지원금 15%</option>
                                <option value="추가지원금 0.10%">추가지원금 10%</option>
                                <option value="추가지원금 0.20%">추가지원금 20%</option>
                            </select>
                        </div>

                        <!-- 숨겨진 필드들 -->
                      
                       	<input type="hidden" name="carrierId" id="carrierId"value=""	>
					    <input type="hidden" name="productId" id="productId"value="">
					    <input type="hidden" name="planProductType" id="planProductType"value="">
					    <input type="hidden" name="planType" id="planType" value="">
					    <input type="hidden" name="planOption" id="planOption" value="">
					    <input type="hidden" name="planAdditional" id="planAdditional" value=""> 
					    <input type="hidden" id="manufacturerId" name="manufacturerId" value="">
					    
					     <button id="calculateBtn" class="plans-calculate-btn">요금제 조회</button>

                    </td>
                </tr>
            </tbody>
        </table>
    </section>
    
    <button id="downloadExcelBtn">엑셀 다운로드</button>
    
    
    
    
    <!-- 요금제 구분 테이블 -->
    <div class="plans-summary">
        <table class="plans-summary-table">
        <tr>
        	<th>요금제 이름</th>
        	<th>약정 구분</th>
        	<th>데이터 용량</th>
        	<th>추가 지원금</th>
        	<th>월 할부금</th>
        	<th>할부 이자</th>
        	<th>총 월 요금</th>
        </tr>	
        </table>
        <table class="plans-summary-table plans-summary-body " id="plans-summary-body">
        
       
        </table>

 
</div>

<script type="text/javascript" src="<c:url value='/js/jquery-3.7.1.min.js'/>"></script>
<script type="text/javascript">





$(document).ready(function() {
    // 통신사 선택 시 처리
    $(document).on("click", ".plans-filter-btn[data-carrier]", function(e) {
        e.preventDefault();
        var carrierId = $(this).data("carrier");
        $('#carrierId').val(carrierId);  // 숨겨진 필드에 통신사 값 저장
        console.log("Selected carrierId: ", carrierId);
    });
	//제조사
  $(document).on("click", ".plans-filter-btn[data-manufacturer]", function(e) {
    e.preventDefault();

    var manufacturerId = $(this).data("manufacturer");  // 선택된 제조사 ID 가져오기
    $('#manufacturerId').val(manufacturerId);  // 숨겨진 필드에 저장
    console.log("Selected manufacturerId: ", manufacturerId);  // 로그로 확인

    // 제품 필터링 함수 호출
    filterProducts(manufacturerId);
});	

		// 제품 필터링 함수
		function filterProducts(manufacturerId) {
		    console.log("Filtering products for manufacturerId: ", manufacturerId);
		    
		    // 모든 제품을 숨김
		    $('.plans-product-list li').hide();
		    
		    // 선택된 제조사에 해당하는 제품만 표시
		    $('.plans-product-list li').each(function() {
		        var productManufacturerId = $(this).find('.plans-product-name').data('manufacturer');
		        if (productManufacturerId == manufacturerId) {
		            $(this).show();  // 해당 제품 표시
		        }
		    });
		}

    // 5G/LTE 선택 시 처리
    $(document).on("click", ".plans-filter-btn[data-division]", function(e) {
        e.preventDefault();
        var division = $(this).data("division");
        $('#planProductType').val(division);  // 숨겨진 필드에 5G/LTE 값 저장
        console.log("Selected planProductType: ", division);
    });

    // 신규/기변 선택 시 처리
    $(document).on("click", ".plans-btn[data-type]", function(e) {
        e.preventDefault();
        var planType = $(this).data("type");
        $('#planType').val(planType);  // 숨겨진 필드에 신규/기변 값 저장
        console.log("Selected planType: ", planType);
    });

    // 추가 지원금 선택 시 처리
    $('#extra-support').on('change', function() {
        var planAdditional = $(this).val();
        $('#planAdditional').val(planAdditional);  // 숨겨진 필드에 추가 지원금 값 저장
        console.log("Selected planAdditional: ", planAdditional);
    });
    $(document).on("click", ".plans-filter-btn[data-manufacturer]", function(e) {
        e.preventDefault();
        var manufacturerId = $(this).data("manufacturer");
        
        // 제조사 변경 시 기존 선택된 제품 및 기타 값 초기화
        $('#manufacturerId').val(manufacturerId); 
        $('#productId').val(''); // 제품 선택을 초기화
        $('#planProductType').val(''); // 5G/LTE 초기화
        $('#planType').val(''); // 신규/기변 초기화
        $('#planAdditional').val(''); // 추가지원금 초기화

        console.log("Selected manufacturerId: ", manufacturerId);
    });

    
    
    
    // 요금제 조회 버튼 클릭 시 처리
    $('#calculateBtn').on('click', function(e) {
        e.preventDefault();

        /* var carrierId = $('#carrierId').val(); // KT, SKT
        var manufacturerId = $('#manufacturerId').val(); // 삼성, 애플
        var planProductType = $('#planProductType').val(); // 5G, LTE
        var planType = $('#planType').val(); // 신규, 기변
        var planOption = $('#planOption').val(); // 자급제
        var planAdditional = $('#planAdditional').val(); // 추가 지원금 */
		
        var carrierId = $('#carrierId').val() || 0;  // 통신사 선택되지 않았을 때 기본값 0
        var manufacturerId = $('#manufacturerId').val() || 0;  // 제조사 선택되지 않았을 때 기본값 0
        var planProductType = $('#planProductType').val() || '';  // 5G/LTE 선택되지 않았을 때 기본값 ''
        var planType = $('#planType').val() || '';  // 신규/기변 선택되지 않았을 때 기본값 ''
        var planOption = $('#planOption').val() || '';  // 자급제 선택되지 않았을 때 기본값 ''
        var planAdditional = $('#planAdditional').val() || 0;  // 추가 지원금 선택되지 않았을 때 기본값 0
        
        
        console.log("carrierId: ", carrierId, "manufacturerId: ", manufacturerId, "planProductType: ", planProductType, "planType: ", planType, "planAdditional: ", planAdditional);

        // Ajax 요청으로 서버에 값 전달
        $.ajax({
        	 url: "<c:url value="/phone/phonePlansTable"/>",

            type: "POST",
            data: { 
                /* carrierId: carrierId,
                manufacturerId: manufacturerId,
                planProductType: planProductType,
                planType: planType,
                planAdditional: planAdditional  */
            	 carrierId: carrierId || 0,
                 manufacturerId: manufacturerId || 0,
                 planProductType: planProductType || '',
                 planType: planType || '',
                 planOption: planOption || '',
                 planAdditional: planAdditional || 0
            },   
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(response) {
                try {
                    var htmlContent = "";
                    if (Array.isArray(response)) { 
                        $.each(response, function(index, plan) {
                            htmlContent += "<tr>";
                            htmlContent += "<td>" + plan.planName + "</td>";
                            htmlContent += "<td>" + plan.planContractType + "</td>";
                            htmlContent += "<td>" + plan.planData + "</td>";
                            htmlContent += "<td>" + plan.additionalSupport + "원</td>";
                            htmlContent += "<td>" + plan.monthlyInstallmentFee + "원</td>";
                            htmlContent += "<td>" + plan.installmentInterest + "원</td>";
                            htmlContent += "<td>" + plan.totalMonthlyFee + "원</td>";
                            htmlContent += "</tr>";
                        });
                        $("#plans-summary-body").html(htmlContent);  // 변환된 HTML을 테이블에 추가
                    } else {
                        console.error("Unexpected response format:", response);
                    }
                } catch (error) {
                    console.error("Error parsing response:", error);
                }
            },
            error: function(xhr, status, error) {
                console.error("Error occurred: ", error);
            }
        });
    });

                
});



                document.getElementById("downloadExcelBtn").addEventListener("click", function() {
                    window.location.href = "<c:url value="/phone/download"/>";
                });

                
               
                
                
                


</script>


</body>
</html>
