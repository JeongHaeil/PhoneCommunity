<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 목록</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <!-- 사용자 목록 영역 (col-8) -->
            <div class="col-md-12">
                <h2 class="mb-4">사용자 목록</h2>
                <div class="card">
                    <div class="card-body">

                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">번호</th>
                                    <th scope="col">아이디</th>
                                    <th scope="col">이메일</th>
                                    <th scope="col">닉네임</th>
                                    <th scope="col">이름</th>
                                    <th scope="col">가입일</th>
                                    <th scope="col">유저상태</th>
                                    <th scope="col">상태변경</th> <!-- 새로운 컬럼 추가 -->
                                </tr>
                            </thead>
                            <tbody>
                                <!-- 사용자 출력 부 -->
                                <c:forEach var="user" items="${resultMap.totalUserBoardList}">
                                    <tr>
                                        <!-- 사용자 번호 -->
                                        <td>${user.userNum}</td>
                                        <!-- 아이디 -->
                                        <td>${user.userId}</td>
                                        <!-- 이메일 -->
                                        <td>${user.userEmail}</td>
                                        <!-- 닉네임 -->
                                        <td>${user.userNickname}</td>
                                        <!-- 이름 -->
                                        <td>${user.userName}</td>
                                        <!-- 가입일 -->
                                        <td>${user.userRegisterDate}</td>
                                        <!-- 유저상태 -->
                                        <td>${user.userStatus}</td>
                                        <!-- 상태변경 버튼들 -->
                                        <td>
                                            <!-- 0~3 상태 버튼 추가 -->
                                            <button class="btn btn-sm btn-secondary" onclick="changeUserStatus(${user.userNum}, 0)">삭제상태 0</button>
                                            <button class="btn btn-sm btn-secondary" onclick="changeUserStatus(${user.userNum}, 1)">기본상태 1</button>
                                            <button class="btn btn-sm btn-secondary" onclick="changeUserStatus(${user.userNum}, 2)">대댓글상태 2</button>
                                            <button class="btn btn-sm btn-secondary" onclick="changeUserStatus(${user.userNum}, 3)">제제상태 3</button>
                                        </td> 
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <!-- 페이징 처리 -->
                        <nav aria-label="Page navigation bar">
                            <ul class="pagination justify-content-center">
                                <!-- 이전 페이지 링크 -->
                                <c:if test="${resultMap.pager.prevPage > 0}">
                                    <li class="page-item">
                                        <a class="page-link" href="?pageNum=${resultMap.pager.prevPage}&search=${search}&keyword=${keyword}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:if>

                                <!-- 페이지 번호 링크 -->
                                <c:forEach begin="${resultMap.pager.startPage}" end="${resultMap.pager.endPage}" var="i">
                                    <li class="page-item ${i == resultMap.pager.pageNum ? 'active' : ''}">
                                        <a class="page-link" href="?pageNum=${i}&search=${search}&keyword=${keyword}">${i}</a>
                                    </li>
                                </c:forEach>

                                <!-- 다음 페이지 링크 -->
                                <c:if test="${resultMap.pager.nextPage <= resultMap.pager.totalPage}">
                                    <li class="page-item">
                                        <a class="page-link" href="?pageNum=${resultMap.pager.nextPage}&search=${search}&keyword=${keyword}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>

                        <!-- 검색 폼 -->
                        <form method="get" class="form-inline mb-3">
                            <select name="search" class="form-control mr-2">
                                <option value="userId" ${search == 'userId' ? 'selected' : ''}>아이디</option>
                                <option value="userNum" ${search == 'userNum' ? 'selected' : ''}>유저번호</option>
                                <option value="userNickname" ${search == 'userNickname' ? 'selected' : ''}>닉네임</option>
                            </select>
                            <input type="text" name="keyword" placeholder="검색어 입력" value="${keyword}" class="form-control mr-2">
                            <button type="submit" class="btn btn-primary">검색</button>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    function changeUserStatus(userNum, userStatus) {
    	console.log("userNum:", userNum);
    	console.log("userStatus:", userStatus);
        if (confirm("사용자 상태를 변경하시겠습니까?")) {
            $.ajax({
                type: "PUT",
                url: "<c:url value='/super_admin/admin/userStatus'/>",
                data: JSON.stringify({ "userNum": userNum, "userStatus": userStatus }),
                contentType: "application/json", 
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                dataType: "text",
                success: function(response) {
                    alert(response);
                    location.reload();
                },
                error: function(xhr) {
                    alert("에러코드 = " + xhr.status);
                }
            });
        }
    }
</script>

</body>
</html>