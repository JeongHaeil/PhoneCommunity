<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style type="text/css">
    #BoardTitleLabel {
      font-family: 'Arial', sans-serif;
      font-size: 48px;
      font-weight: bold;
      color: #f0f8ff; /* 연한 하늘색 글자 */
      background: linear-gradient(45deg, #2c3e50, #34495e, #2f4050); /* 어두운 그라데이션 배경 */
      padding: 20px 40px;
      border-radius: 15px;
      text-align: center;
      display: inline-block;
      box-shadow: 0 12px 24px rgba(0, 0, 0, 0.6); /* 강한 배경 그림자 */
      text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.5), 0px 0px 15px rgba(255, 255, 255, 0.7); /* 입체적인 텍스트 그림자 */
      transition: all 0.3s ease;
    }

    .text-center {
      text-align: center;
    }
    
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
 	@media (max-width: 1200px) {
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
        vertical-align: middle;
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
        border: 1px solid #ddd;
        padding: 4px;     
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
        /* overflow: hidden;  */         
        text-overflow: ellipsis;
    }
    
<!--작성자 클릭시 드랍다운 관련 시작 css--> 
     #WriterdropDiv {
        position: relative;  /* 부모 요소에 position: relative 추가 */
    }
        #WriterdropUl {
        width:60px;
        position: absolute;  /* 드롭다운 메뉴를 다른 요소들 위에 절대적으로 배치 */
        z-index: 1050;       /* 기본 Bootstrap z-index보다 높게 설정 */
    }
    /* 화살표를 숨기기 */
.Wirterbtn::after {
    display: none !important;  /* 중요도를 높여서 강제로 숨깁니다 */
}

/* 다른 방법: 화살표 스타일을 없애기 */
.Wirterbtn {
    padding-right: 0; /* 오른쪽 패딩을 없애서 화살표 공간을 제거 */
}

 .Wirterbtn {
    text-decoration: none !important;  /* 밑줄 제거 */ 
    font-size: 12px !important;
}

.Wirterbtn:hover, .Wirterbtn:focus {
    text-decoration: none !important;  /* 호버 및 포커스 상태에서 밑줄 제거 */
}
<!--작성자 클릭시 드랍다운 관련 끝 css-->
</style>
</head>
<body>
<div class="container mt-5">
	
	<%-- =========타이틀 출력(시작)===== --%>
	<div class="mt-10">
	<c:choose>
		<c:when test="${boardCode==1 }">
			<c:choose>
				<c:when test="${search=='user_nickname' }">
					<h1 class=text-center id="BoardTitleLabel">${keyword}님의 작성글</h1>										
				</c:when>
				<c:otherwise>
					<h1 class=text-center id="BoardTitleLabel">전체글</h1>						
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<h1 class=text-center id="BoardTitleLabel">${boardCodeTitle }</h1>		
		</c:otherwise>
	</c:choose>
    </div>
	<%-- =========타이틀 출력(끝)===== --%>
    
	<input type="hidden" name="freeCode" value="${boardCode }" id="freeCodeValue">
	<%-- <input type="hidden" name="pageNum" value="${pager.pageNum }" id="pageNumValue"> --%>		
    <div class="row">
    	
        <div class="col-md-9" >
    
             
             	<div class="row justify-content-between align-items-center m-1" >
             	<!-- <div>
			        <h3>게시글 목록</h3>
			    </div> -->
			        <div class="d-flex justify-content-end align-items-center">
					    <button type="button" class="btn btn-dark btn-sm" onclick="hideAndShowSearch()">검색</button>&nbsp;
					    <c:choose>
					    	<c:when test="${boardCode >= 10 && boardCode <= 99 }">
					    		<button type="button" class="btn btn-dark btn-sm" onclick="window.location.href='<c:url value="/board/boardwrite/${boardCode }"/>'">글쓰기</button>					    	
					    	</c:when>
					    	<c:otherwise>
					    		<sec:authorize access="isAuthenticated()">
					    			<sec:authorize access="hasRole('ROLE_BOARD_ADMIN')" var="admin"/>
					    			<c:if test="${admin}"><button type="button" class="btn btn-dark btn-sm" onclick="window.location.href='<c:url value="/board/boardwrite/${boardCode }"/>'">글쓰기</button></c:if>
					    		</sec:authorize>
					    	</c:otherwise>
					    </c:choose>					 					 
					</div>
				 </div>
			
			 
			 <%-- 상단 검색창 씨작 --%>
			 <div id="boardSearchDiv" style="display: none;">
			 <div class="row justify-content-end">
				    <div class="col-auto" style="margin: 5px;">  
				        <form id="searchForm" method="get" class="d-flex "> 
				            <input id="code" type="hidden" name="boardCode" value="${boardCode }" disabled="disabled">
				            <select name="search" id="searchSelect" class="">
				                <option value="user_nickname" <c:if test="${search =='user_nickname' }"> selected </c:if>>&nbsp;작성자&nbsp;</option>
				                <option value="board_title" <c:if test="${search=='board_title' }"> selected </c:if>>&nbsp;제목&nbsp;</option>
				                <option value="board_content" <c:if test="${search=='board_content' }"> selected </c:if>>&nbsp;내용&nbsp;</option>
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
		    								<c:choose>
		    									<c:when test="${boards.boardCode==2 }">
		    										<td>&lt;공지&gt;</td>
		    									</c:when>
		    									<c:otherwise>
		    										<td>${boards.boardPostIdx }</td>  										    									
		    									</c:otherwise>
		    								</c:choose>
		    								<td class="tdboardTitle" style="color: #333; cursor: pointer;" 
											    onclick="location.href='<c:url value='/board/boarddetail/${boards.boardCode }/${boards.boardPostIdx }'/>?pageNum=${pager.pageNum}&search=${search }&keyword=${keyword }'">
											    &nbsp;&nbsp;${boards.boardTitle}<c:if test="${boards.cocain !=0}"><span style="color: #A566FF;"> &nbsp;[${boards.cocain }]</span></c:if>
											</td>
		    								 <td class="tdboardWriter">
					                                <!-- 작성자 클릭 시 드롭다운 표시 -->
					                                <div class="dropdown" id='WriterdropDiv'>
					                                    <button class="btn btn-link dropdown-toggle Wirterbtn" style="color: black;" type="button" id="dropdownMenuButton-${boards.boardPostIdx}" data-bs-toggle="dropdown" aria-expanded="false">
					                                        ${boards.userNickname}
					                                    </button>
					                                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton-${boards.boardPostIdx}" id="WriterdropUl">					                                       					                                       
					                                        <li><a class="dropdown-item" href="<c:url value='/board/boardlist/1'/>?&search=user_nickname&keyword=${boards.userNickname }">작성글 전체보기</a></li>
															<%--추가 하려면 위에꺼 복 붙 --%>	
					                                    </ul>
					                                </div>
					                            </td>
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
			
			</div>
			 <%-- <button type="button" class="btn btn-dark" onclick="window.location.href='<c:url value="/board/boardwrite/${freeCode }"/>'">글쓰기</button> --%>
			 </div>
			
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
				<div class="row justify-content-center ">
				    <div class="col-auto" style="margin: 5px;">  
				        <form id="searchForm" method="get" class="d-flex "> 
				            <input id="code" type="hidden" name="boardCode" value="${boardCode }" disabled="disabled">
				            <select name="search" id="searchSelect" class="">
				                <option value="user_nickname" <c:if test="${search =='user_nickname' }"> selected </c:if>>&nbsp;작성자&nbsp;</option>
				                <option value="board_title" <c:if test="${search=='board_title' }"> selected </c:if>>&nbsp;제목&nbsp;</option>
				                <option value="board_content" <c:if test="${search=='board_content' }"> selected </c:if>>&nbsp;내용&nbsp;</option>
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
            <h2><i class="fas fa-fire" style="font-size: 50px; color: orange;"></i>오늘의 인기글</h2>
            <div class="" id="popularSideBoard">
            </div>
        </div>
		
        
    </div>
</div>

 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> --> 
<!--  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script> -->
<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->

<script type="text/javascript">
popularSideBoard();
function hideAndShowSearch() {
    const searchDiv = document.getElementById('boardSearchDiv');
    if (searchDiv.style.display === 'none' ||searchDiv.style.display === "") {
       	searchDiv.style.display = 'block'; // 보이기
    } else {
        searchDiv.style.display = 'none'; // 숨기기
    }
}
//SideBoard 출력
function popularSideBoard() {
 $.ajax({
	type:"get",
	url: "<c:url value='/rest/popular_side_board'/>",
	dataType: "json",
	success : function(result) {
		var html="";
		if(result.popularBoardList.length==0){
		    html += " <li class='list-group-item sideHotboard'>인기글이 없습니다.</li>";
		    return;
		}else{
			$(result.popularBoardList).each(function(index) {
			html +="<li class='list-group-item sideHotboard'>"+(index+1)+". <a class='	' href='<c:url value='/board/boarddetail/"+this.boardCode+"/"+this.boardPostIdx+"'/>'>"+this.boardTitle+"</a> </li>";
			});
		}
		$("#popularSideBoard").html(html);
	},
	error : function(xhr) {
		alert("에러코드(게시글 검색) = " + xhr.status);
	}
});
}
</script>
</body>
</html>