<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 스타일 정의 -->
<style>
 .user-badge {
    max-width: 30px;    /* 최대 너비를 제한 */
    height: auto;       /* 높이를 자동으로 설정하여 비율 유지 */
    object-fit: contain; /* 이미지 비율 유지 */
    vertical-align: middle; /* 텍스트와 이미지 수평 정렬 */
}

</style>


    <tbody>
        <c:forEach var="board" items="${boardList}">
            <tr>
                <td>${board.boardPostIdx}</td>
                <td>${board.boardTitle}</td>
                <td>
                    <span>${board.userNickname}</span>
                    <!-- 아이콘 출력 로직 -->
                    <c:choose>
                        <c:when test="${board.auth == 'ROLE_SUPER_ADMIN'}">
                            <img src="${pageContext.request.contextPath}/resources/images/crown.png" alt="Super Admin Badge" class="user-badge" />
                        </c:when>
                        <c:when test="${board.auth == 'ROLE_BOARD_ADMIN'}">
                            <img src="${pageContext.request.contextPath}/resources/images/rainbow.png" alt="Board Admin Badge" class="user-badge" />
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${board.userLevel >= 1 && board.userLevel <= 5}">
                                    <img src="${pageContext.request.contextPath}/resources/images/bronze.png" alt="Bronze Badge" class="user-badge" />
                                </c:when>
                                <c:when test="${board.userLevel >= 6 && board.userLevel <= 10}">
                                    <img src="${pageContext.request.contextPath}/resources/images/silver.png" alt="Silver Badge" class="user-badge" />
                                </c:when>
                                <c:when test="${board.userLevel >= 11 && board.userLevel <= 15}">
                                    <img src="${pageContext.request.contextPath}/resources/images/gold.png" alt="Gold Badge" class="user-badge" />
                                </c:when>
                                <c:when test="${board.userLevel >= 16 && board.userLevel <= 19}">
                                    <img src="${pageContext.request.contextPath}/resources/images/emerald.png" alt="Emerald Badge" class="user-badge" />
                                </c:when>
                                <c:when test="${board.userLevel == 20}">
                                    <img src="${pageContext.request.contextPath}/resources/images/diamond.png" alt="Diamond Badge" class="user-badge" />
                                </c:when>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </td>
                
            </tr>
        </c:forEach>
    </tbody>
