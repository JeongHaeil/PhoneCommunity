<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value='/resources/css/phone.css'/>">
<script type="text/javascript" src="<c:url value='/js/jquery-3.7.1.min.js'/>"></script>

</head>
<body>
<c:if test="${not empty phonePlans}">
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
</c:if>


</body>
</html>