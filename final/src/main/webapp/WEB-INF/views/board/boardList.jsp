<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <style type="text/css">
    .boardDiv {
        padding: 0;
        margin: 0 auto;
        font-weight: normal;
        overflow-x: hidden;
        font-size: 12px;
        letter-spacing: -0.03em;
    }
    .boardsListTable {
        width: 100%;
    }
    @media (min-width: 1400px) {
  		.container {
   	 		max-width: 1320px;
 		}
 	}
 	@media (max-width: 900px) {
	    .sideHotboardList {
	        display: none; 
   		 }
	}
    
    .boardsListTable th:not(.boardTitle, .boardWriter, .boardDate) {
        text-align: center;
        width: 55px;
        padding: 0;
    }
    .boardsListTable th:not(.boardNum, .boardTitle, .boardDate, .boardViewCount) {
        width: 125px;
        padding: 0;
    }
    th.boardDate {
        width: 65px;
        padding: 0;
    }
    
    .boardTitle {
        text-align: center;
    }
    .boardsListTable thead th {
        padding: 0 8px;
        text-align: center;
    }
    .boardsListTable thead {
        line-height: 2.5;		
    }
    .boardsListTable tbody td:not(.tdboardTitle){
        text-align: center;
        padding: 3.5px 2px;
        line-height: 1.5;
    }
    .pagebtn {
        border-radius: 32px;
        min-width: 36px;
        padding: 0 4px;
        height: 36px;
        line-height: 36px;
        color: #444;
        text-decoration: none !important;
        display: inline-block;
        font-weight: bold;
        font-size: 12px;
        text-align: center;
    }
    .pagebtn:hover {
        background-color: #444; 
        color: #fff;
    }
    .apagebtn {
        border-radius: 32px;
        min-width: 36px;
        padding: 0 4px;
        height: 36px;
        line-height: 36px;
        color: #fff;
        text-decoration: none !important;
        display: inline-block;
        font-weight: bold;
        font-size: 12px;
        background-color: #444;
        text-align: center;
    }
    .apagebtn:hover {
        color: #fff;
    }
    .sideHotboardList {
        position: fixed;
        top: 190px; 
        right: 40px; 
        z-index: 1000;
        box-sizing: border-box;
    }
    .sideHotboard {
        white-space: nowrap;       
        overflow: hidden;          
        text-overflow: ellipsis;
    }
    .tdboardTitle {
        white-space: nowrap;       
        overflow: hidden;          
        text-overflow: ellipsis;
    }
    .tdboardWriter {
        white-space: nowrap;       
        overflow: hidden;          
        text-overflow: ellipsis;
    }
</style>
</head>
<body>
<div class="container mt-5">
	
	<%-- =========타이틀 출력(시작)===== --%>
	<div class="mt-10">
    <h1 class="text-center">${boardCodeTitle }</h1>
    </div>
	<%-- =========타이틀 출력(끝)===== --%>
    
	<input type="hidden" name="freeCode" value="${boardCode }" id="freeCodeValue">
	<%-- <input type="hidden" name="pageNum" value="${pager.pageNum }" id="pageNumValue"> --%>		
    <div class="row">
    	
        <div class="col-md-9" >
    
             <c:if test="${boardCode >= 10 && boardCode <= 99 }">
             	<div class="row justify-content-between align-items-center m-1" >
             	<div>
			        <h3>게시글 목록</h3>
			    </div>
			        <div class="d-flex justify-content-end align-items-center">
					    <button type="button" class="btn btn-dark btn-sm" onclick="hideAndShowSearch()">검색</button>&nbsp;					 					 
					    <button type="button" class="btn btn-dark btn-sm" onclick="window.location.href='<c:url value="/board/boardwrite/${boardCode }"/>'">글쓰기</button>
					</div>
				 </div>
			 </c:if>
			 <%-- 상단 검색창 씨작 --%>
			 <div id="boardSearchDiv" style="display: none;">
			 <div class="row justify-content-end">
				    <div class="col-auto">  
				        <form id="searchForm" method="get" class="d-flex "> 
				            <input id="code" type="hidden" name="boardCode" value="${boardCode }" disabled="disabled">
				            <select name="search" id="searchSelect" class="">
				                <option value="user_nickname" <c:if test="${search }=='user_nickname'"> selected </c:if>>&nbsp;작성자&nbsp;</option>
				                <option value="board_title" <c:if test="${search }=='board_title'"> selected </c:if>>&nbsp;제목&nbsp;</option>
				                <option value="board_content" <c:if test="${search }=='board_content'"> selected </c:if>>&nbsp;내용&nbsp;</option>
				            </select>
				            <input type="text" name="keyword" value="${keyword }" id="keywordInput" placeholder="검색..">
				            <button id="boardSearchBtn" class="btn btn-dark btn-sm"  type="submit">검색</button>
				        </form>
				    </div>
				</div>
			 </div>
			 <%-- 상단 검색창 끝 --%>
			 
             <div class="boardDiv card">
		            <table class="table table-hover boardsListTable">
		                <thead class="thead-dark">
		                    <tr>
		                        <th class="boardNum">번호</th>
		                        <th class="boardTitle">제목</th>
		                        <th class="boardWriter">작성자</th>
		                        <th class="boardDate">날짜</th>
		                        <th class="boardViewCount">조회수</th>
		                    </tr>
		                </thead>
		                <tbody>
		                	<c:choose>
		    					 <c:when test="${empty boardList}">
		    						게시글이 없습니다
		    					</c:when>
		    						<c:otherwise>
		    						<c:forEach var="boards" items="${boardList}">
		    							<tr>
		    								<td>${boards.boardPostIdx }</td>  								
		    								<td class="tdboardTitle" style="color: #333; cursor: pointer;" 
											    onclick="location.href='<c:url value='/board/boarddetail/${boards.boardCode }/${boards.boardPostIdx }'/>?pageNum=${pager.pageNum}&search=${search }&keyword=${keyword }'">
											    &nbsp;&nbsp;${boards.boardTitle}
											</td>
		    								<td class="tdboardWriter">${boards.userNickname }</td>
		    								<td>${boards.boardRegisterDate }</td>
		    								<td>${boards.boardCount }</td>
		    							</tr>
		    						</c:forEach>   						
		    						</c:otherwise>
		    				</c:choose>
		                </tbody>
		            </table>
	            </div>
            
			 <div class="d-flex justify-content-end align-items-center">
			 <div>
				<a href="#" class="link-height text-dark">맨위로</a>
			<c:if test="${boardCode >= 10 && boardCode <= 99 }">
			</div>
			 <%-- <button type="button" class="btn btn-dark" onclick="window.location.href='<c:url value="/board/boardwrite/${freeCode }"/>'">글쓰기</button> --%>
			 </div>
			 </c:if>
			            <%-- 페이지 번호 출력 --%>
			 <div id="pageNumDiv" class="row justify-content-center">
			 	 <div class="col-auto">           
				 <c:choose>
					<c:when test="${pager.startPage > pager.blockSize }">
						<a class="pagebtn" href="<c:url value="/board/boardlist/${boardCode }"/>?search=${search }&keyword=${keyword }&pageNum=${pager.prevPage}">◀</a>
					</c:when>
					<c:otherwise>
						
					</c:otherwise>		
				</c:choose>
				
				<c:forEach var="i" begin="${pager.startPage }" end="${pager.endPage }" step="1">
					<c:choose>
						<c:when test="${pager.pageNum !=i }">
							<a  class="pagebtn" href="<c:url value="/board/boardlist/${boardCode }"/>?search=${search }&keyword=${keyword }&pageNum=${i}">${i }</a>			
						</c:when>
						<c:otherwise>
							<a class="apagebtn disabled" tabindex="-1" >${i }</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<c:choose>
					<c:when test="${pager.endPage != pager.totalPage }">
						<a class="pagebtn" href="<c:url value="/board/boardlist/${boardCode }"/>?search=${search }&keyword=${keyword }&pageNum=${pager.nextPage}">▶</a>
					</c:when>
					<c:otherwise>
						
					</c:otherwise>		
				</c:choose>
			</div>	
				<!-- 검색   -->
				<div class="row justify-content-center">
				    <div class="col-auto">  
				        <form id="searchForm" method="get" class="d-flex "> 
				            <input id="code" type="hidden" name="boardCode" value="${boardCode }" disabled="disabled">
				            <select name="search" id="searchSelect" class="">
				                <option value="user_nickname" <c:if test="${search }=='user_nickname'"> selected </c:if>>&nbsp;작성자&nbsp;</option>
				                <option value="board_title" <c:if test="${search }=='board_title'"> selected </c:if>>&nbsp;제목&nbsp;</option>
				                <option value="board_content" <c:if test="${search }=='board_content'"> selected </c:if>>&nbsp;내용&nbsp;</option>
				            </select>
				            <input type="text" name="keyword" value="${keyword }" id="keywordInput" placeholder="검색..">
				            <button id="boardSearchBtn" class="btn btn-dark btn-sm"  type="submit">검색</button>
				        </form>
				    </div>
				</div>
			</div> 		
        </div>
        <%-- 사이드  --%>
        <div class="col-md-3 sideHotboardList">
            <h2>오늘의 인기글</h2>
            <ul class="list-group">
                <li class="list-group-item sideHotboard"><a href="#">1. 일반 bcaa 2종 1980원 무배</a> <span class="badge badge-primary">13</span></li>
                <li class="list-group-item sideHotboard"><a href="#">2. 블렌드 유산균 반값</a> <span class="badge badge-primary">8</span></li>
                <li class="list-group-item sideHotboard"><a href="#">3. 미사 스포츠 음료 300P</a> <span class="badge badge-primary">1500</span></li>
                <li class="list-group-item sideHotboard"><a href="#">4. 가스펠 포드 ADV 신제품</a> <span class="badge badge-primary">16</span></li>
                <li class="list-group-item sideHotboard"><a href="#">5. 이너 마이핏 ADV 신제품</a> <span class="badge badge-primary">14</span></li>
            </ul>
        </div>
		
        
    </div>
</div>

<!--  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
<!--  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script> -->
<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->

<script type="text/javascript">
function hideAndShowSearch() {
    const searchDiv = document.getElementById('boardSearchDiv');
    if (searchDiv.style.display === 'none' ||searchDiv.style.display === "") {
       	searchDiv.style.display = 'block'; // 보이기
    } else {
        searchDiv.style.display = 'none'; // 숨기기
    }
}
</script>
</body>
</html>