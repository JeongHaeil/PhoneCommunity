<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
    .user-list-bg { background-color: #f8f9fa; }
    .user-list-container { max-width: 1200px; }
    .user-list-card { border: none; box-shadow: 0 0 15px rgba(0,0,0,0.0); }
    .user-list-table { border-collapse: separate; border-spacing: 0; }
    .user-list-table th, .user-list-table td { white-space: nowrap; padding: 15px; vertical-align: middle; }
    .user-list-table thead th { background-color: #f05d5e; color: white; font-weight: 600; text-transform: uppercase; }
    .user-list-table tbody tr:nth-child(even) { background-color: #f8f9fa; }
    .user-list-btn {
        white-space: nowrap;
        border: 1px solid #f05d5e;
        color: #f05d5e;
        background-color: transparent;
        transition: all 0.3s ease;
        margin: 2px;
        padding: 5px 10px;
    }
    .user-list-btn:hover { background-color: #f05d5e; color: white; }
    .user-list-pagination .page-item.active .page-link { background-color: #f05d5e; border-color: #f05d5e; }
    .user-list-pagination .page-link { color: #f05d5e; }
    .user-list-pagination .page-link:hover { background-color: #f05d5e; color: white; }
    .user-list-primary-btn { background-color: #f05d5e; border-color: #f05d5e; }
    .user-list-primary-btn:hover { background-color: #d04d4e; border-color: #d04d4e; }
    .user-list-form-focus:focus { border-color: #f05d5e; box-shadow: 0 0 0 0.2rem rgba(240, 93, 94, 0.25); }
    .user-list-title { color: #f05d5e; font-weight: bold; }
    .user-list-ellipsis {
        max-width: 100px; 
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    
    .user-list-btn-container {
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .user-list-btn-row {
        display: flex;
        justify-content: center;
        margin-bottom: 5px;
    }
</style>
<div class="card user-list-card">
    <div class="card-body">
        <h2 class="mb-4 user-list-title">유저 목록</h2>
        <div class="user-list-table-container">
            <table class="table user-list-table">
                <thead>
                    <tr>
                        <th class="text-center">번호</th>
                        <th class="text-center">아이디</th>
                        <th class="text-center">이메일</th>
                        <th class="text-center">닉네임</th>
                        <th class="text-center">이름</th>
                        <th class="text-center">가입일</th>
                        <th class="text-center">유저상태</th>
                        <th class="text-center" style="width: 300px;">정지종료일</th>
                        <th class="text-center">상태변경</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${resultMap.totalUserBoardList}">
                        <tr>
                            <td class="text-center">${user.userNum}</td>
                            <td class="text-center user-list-ellipsis">${user.userId}</td>
                            <td class="text-center">${user.userEmail}</td>
                            <td class="text-center">${user.userNickname}</td>
                            <td class="text-center">${user.userName}</td>
                            <td class="text-center">${fn:substring(user.userRegisterDate, 0, 10)}</td>
                            <td class="text-center">
							    <c:choose>
							        <c:when test="${user.userStatus == 0}">
							            삭제
							        </c:when>
							        <c:when test="${user.userStatus == 1}">
							            일반
							        </c:when>
							        <c:when test="${user.userStatus == 3}">
							            제제
							        </c:when>
							        <c:otherwise>
							            알 수 없음
							        </c:otherwise>
							    </c:choose>
							</td>
                            <td class="text-center">${user.expiryDate}</td>
                            <td class="text-center">
                                <div class="user-list-btn-container">
                                    <div class="user-list-btn-row ">
                                        <button class=" user-list-btn" onclick="changeUserStatus(${user.userNum}, 1, 0)">제제 해제</button>
                                        <button class=" user-list-btn" onclick="changeUserStatus(${user.userNum}, 3, 60)">1분 벤</button>
                                        <button class=" user-list-btn" onclick="changeUserStatus(${user.userNum}, 3, 86400)">1일 벤</button>
                                    </div>
                                    <div class="user-list-btn-row">
                                        <button class=" user-list-btn" onclick="changeUserStatus(${user.userNum}, 3, 259200)">3일 벤</button>
                                        <button class="user-list-btn" onclick="changeUserStatus(${user.userNum}, 3, 432000)">5일 벤</button>
                                        <button class="user-list-btn" onclick="changeUserStatus(${user.userNum}, 3, 604800)">7일 벤</button>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <nav aria-label="Page navigation bar" class="mt-4">
        <ul class="pagination justify-content-center user-list-pagination">
            <c:if test="${resultMap.pager.prevPage > 0}">
                <li class="page-item">
                    <a class="page-link" href="#" data-page="${resultMap.pager.prevPage}" aria-label="Previous">&laquo;</a>
                </li>
            </c:if>
            <c:forEach begin="${resultMap.pager.startPage}" end="${resultMap.pager.endPage}" var="i">
                <li class="page-item ${i == resultMap.pager.pageNum ? 'active' : ''}">
                    <a class="page-link" href="#" data-page="${i}">${i}</a>
                </li>
            </c:forEach>
            <c:if test="${resultMap.pager.nextPage <= resultMap.pager.totalPage}">
                <li class="page-item">
                    <a class="page-link" href="#" data-page="${resultMap.pager.nextPage}" aria-label="Next">&raquo;</a>
                </li>
            </c:if>
        </ul>
    </nav>

    <form id="searchForm" class="d-flex mt-4">
        <select name="search" class="form-select me-2 user-list-form-focus">
            <option value="userId" ${search == 'userId' ? 'selected' : ''}>아이디</option>
            <option value="userNum" ${search == 'userNum' ? 'selected' : ''}>유저번호</option>
            <option value="userNickname" ${search == 'userNickname' ? 'selected' : ''}>닉네임</option>
        </select>
        <input type="text" name="keyword" placeholder="검색어 입력" value="${keyword}" class="form-control me-2 user-list-form-focus">
        <button type="submit" class="btn user-list-primary-btn">검색</button>
    </form>
</div>

<script>
$(document).ready(function() {
    $('#searchForm').on('submit', function(e) {
        e.preventDefault();
        loadUserList(1);
    });
});

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
            loadUserList(1);
        },
        error: function(xhr) {
            alert("에러코드 = " + xhr.status + ": " + xhr.responseText);
        }
    });
}
</script>
