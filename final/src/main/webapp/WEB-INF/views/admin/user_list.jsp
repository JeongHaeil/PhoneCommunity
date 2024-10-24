<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 목록</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .custom-bg { background-color: #f8f9fa; }
        .custom-container { max-width: 1200px; }
        .custom-card { border: none; box-shadow: 0 0 15px rgba(0,0,0,0.0); }
        .custom-table { border-collapse: separate; border-spacing: 0; }
        .custom-table th, .custom-table td { white-space: nowrap; padding: 15px; vertical-align: middle; }
        .custom-table thead th { background-color: #f05d5e; color: white; font-weight: 600; text-transform: uppercase; }
        .custom-table tbody tr:nth-child(even) { background-color: #f8f9fa; }
        body .custom-btn {
            white-space: nowrap;
            border: 1px solid #f05d5e;
            color: #f05d5e;
            background-color: transparent;
            transition: all 0.3s ease;
            margin: 2px;
            padding: 5px 10px;
        }
        .custom-btn:hover { background-color: #f05d5e; color: white; }
        .custom-pagination .page-item.active .page-link { background-color: #f05d5e; border-color: #f05d5e; }
        .custom-pagination .page-link { color: #f05d5e; }
        .custom-pagination .page-link:hover { background-color: #f05d5e; color: white; }
        .custom-primary-btn { background-color: #f05d5e; border-color: #f05d5e; }
        .custom-primary-btn:hover { background-color: #d04d4e; border-color: #d04d4e; }
        .custom-form-focus:focus { border-color: #f05d5e; box-shadow: 0 0 0 0.2rem rgba(240, 93, 94, 0.25); }
        .custom-title { color: #f05d5e; font-weight: bold; }
        .ellipsis {
            max-width: 100px; 
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
</head>
<body class="custom-bg">
    <div class="container custom-container mt-5">
        <!-- <h2 class="mb-4 text-center custom-title">사용자 목록</h2> -->
        <div class="card custom-card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table custom-table">
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>아이디</th>
                                <th>이메일</th>
                                <th>닉네임</th>
                                <th>이름</th>
                                <th>가입일</th>
                                <th>유저상태</th>
                                <th>정지종료일</th>
                                <th>상태변경</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${resultMap.totalUserBoardList}">
                                <tr>
                                    <td>${user.userNum}</td>
                                    <td class="ellipsis">${user.userId}</td>
                                    <td>${user.userEmail}</td>
                                    <td>${user.userNickname}</td>
                                    <td>${user.userName}</td>
                                    <td>${user.userRegisterDate}</td>
                                    <td>${user.userStatus}</td>
                                    <td>${user.expiryDate}</td>
                                    <td>
                                        <div class="d-flex flex-wrap justify-content-center">
                                            <button class="custom-btn btn btn-sm " onclick="changeUserStatus(${user.userNum}, 1, 0)">제제 해제</button>
                                            <button class="btn btn-sm custom-btn" onclick="changeUserStatus(${user.userNum}, 3, 60)">1분 벤</button>
                                            <button class="btn btn-sm custom-btn" onclick="changeUserStatus(${user.userNum}, 3, 86400)">1일 벤</button>
                                            <button class="btn btn-sm custom-btn" onclick="changeUserStatus(${user.userNum}, 3, 259200)">3일 벤</button>
                                            <button class="btn btn-sm custom-btn" onclick="changeUserStatus(${user.userNum}, 3, 432000)">5일 벤</button>
                                            <button class="btn btn-sm custom-btn" onclick="changeUserStatus(${user.userNum}, 3, 604800)">7일 벤</button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <nav aria-label="Page navigation bar" class="mt-4">
                    <ul class="pagination justify-content-center custom-pagination">
                        <c:if test="${resultMap.pager.prevPage > 0}">
                            <li class="page-item">
                                <a class="page-link" href="?pageNum=${resultMap.pager.prevPage}&search=${search}&keyword=${keyword}" aria-label="Previous">&laquo;</a>
                            </li>
                        </c:if>
                        <c:forEach begin="${resultMap.pager.startPage}" end="${resultMap.pager.endPage}" var="i">
                            <li class="page-item ${i == resultMap.pager.pageNum ? 'active' : ''}">
                                <a class="page-link" href="?pageNum=${i}&search=${search}&keyword=${keyword}">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${resultMap.pager.nextPage <= resultMap.pager.totalPage}">
                            <li class="page-item">
                                <a class="page-link" href="?pageNum=${resultMap.pager.nextPage}&search=${search}&keyword=${keyword}" aria-label="Next">&raquo;</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>

                <form method="get" class="d-flex mt-4">
                    <select name="search" class="form-select me-2 custom-form-focus">
                        <option value="userId" ${search == 'userId' ? 'selected' : ''}>아이디</option>
                        <option value="userNum" ${search == 'userNum' ? 'selected' : ''}>유저번호</option>
                        <option value="userNickname" ${search == 'userNickname' ? 'selected' : ''}>닉네임</option>
                    </select>
                    <input type="text" name="keyword" placeholder="검색어 입력" value="${keyword}" class="form-control me-2 custom-form-focus">
                    <button type="submit" class="btn custom-primary-btn">검색</button>
                </form>
            </div>
        </div>
    </div>

    <script type="text/javascript">
    function changeUserStatus(userNum, userStatus, duration) {
        $.ajax({
            type: "PUT",
            url: "<c:url value='/super_admin/admin/userStatus'/>",
            data: JSON.stringify({"userNum": userNum, "userStatus": userStatus, "duration": duration}),
            contentType: "application/json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(response) {
                alert("유저 상태가 성공적으로 변경되었습니다.");
                location.reload();
            },
            error: function(xhr) {
                alert("에러코드 = " + xhr.status + ": " + xhr.responseText);
            }
        });
    }
    </script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>