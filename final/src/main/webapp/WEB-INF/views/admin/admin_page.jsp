<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container mt-5">
    <div class="row">
        <!-- 게시판 영역 (col-8) / -->
        <div class="col-md-8">
            <h2 class="mb-4">게시판</h2>
            <div class="card">
                <div class="card-body">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">제목</th>
                                <th scope="col">작성자</th>
                                <th scope="col">작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- 게시글 출력 부 (임시 값)-->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- 유저 정보 영역 (col-4) -->
        <div class="col-md-4">
            <h2 class="mb-4">유저 정보</h2>
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">사용자 이름</h5>
                    <p class="card-text">이메일: </p>
                    <p class="card-text">가입일: 2023-01-01</p>
                    <p class="card-text">작성 게시글 수: 10</p>
                    <p class="card-text">제제 일자(시간? 일수?>)</p>
                    <p class="card-text">작업자(관리자 이름 따와서)</p>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>