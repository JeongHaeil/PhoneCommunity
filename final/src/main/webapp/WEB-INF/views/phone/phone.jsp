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
                                <li style="display: none;">
                                    <span class="plans-product-name" data-manufacturer="${product.manufacturerId}">${product.productName}</span>
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
                                <option >없음</option>
                                <option value="추가지원금 0.15">추가지원금 15%</option>
                                <option value="추가지원금 0.10%">추가지원금 10%</option>
                                <option value="추가지원금 0.20%">추가지원금 20%</option>
                            </select>
                        </div>

                        <!-- 숨겨진 필드들 -->
                       <form id="planForm" method="post">
                       	<input type="hidden" name="carrierId" id="carrierId">
					    <input type="hidden" name="productId" id="productId">
					    <input type="hidden" name="planProductType" id="planProductType">
					    <!-- <input type="hidden" name="planType" id="planType">
					    <input type="hidden" name="planOption" id="planOption">
					    <input type="hidden" name="planMonths" id="planMonths">-->
					    <input type="hidden" name="planAdditional" id="planAdditional"> 
					    <!-- <button type="button"  class="plans-calculate-btn">요금제 조회</button> -->
					    </form>
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
  <%--        
<!-- JSP 혹은 HTML 파일 -->
<input type="hidden" id="sellerId" value="${post.sellerId}">
<input type="hidden" id="productId" value="${post.productId}">
        
 <!-- JSP 페이지에서 현재 로그인한 사용자 정보를 넘겨줌 -->
<input type="hidden" id="buyerId" value="${sessionScope.userNum}">
  --%>
 
 
</div>

<script type="text/javascript" src="<c:url value='/js/jquery-3.7.1.min.js'/>"></script>
<script type="text/javascript">





$(document).ready(function() {
 
    $(document).on("click", ".plans-filter-btn[data-manufacturer]", function(e) {
        e.preventDefault();

        var manufacturerId = $(this).data("manufacturer");  
        filterProducts(manufacturerId);  
    });

   
    $(document).on("click", ".plans-filter-btn[data-division]", function(e) {
        e.preventDefault();

        var division = $(this).data("division");  
        console.log("Selected division: ", division);
        filterPlansByDivision(division); 
    });
    
    function filterProducts(manufacturerId) {
        $('.plans-product-list li').hide(); 

    
        $('.plans-product-list li').each(function() {
            if ($(this).find('.plans-product-name').data('manufacturer') == manufacturerId) {
                $(this).show();  
            }
        });
    }
    
    
    
    
  
    function filterPlansByDivision(division) {
    	 
    	 console.log("실행 확인"); 
    	 
        $.ajax({
            url: "<c:url value="/phone/phonePlansTable"/>",
            type: "POST",
            data: { planProductType: division 
            		
            
            	},   
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(response) {
                try {                  	
                    // JSON 응답을 HTML로 변환
                    var htmlContent = "";
                    
                    if (Array.isArray(response)) { 
                        $.each(response, function(index, plan) {
                            
                        	console.log("plan: ", plan);
                            
                            
                            console.log("plan.planName: ", plan.planName);
                            console.log("plan.planContractType: ", plan.planContractType);
                        	
                        	
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
    }
        
});

                document.getElementById("downloadExcelBtn").addEventListener("click", function() {
                    window.location.href = "<c:url value="/phone/download"/>";
                });

                
               
                
                
                


</script>


</body>
</html>
