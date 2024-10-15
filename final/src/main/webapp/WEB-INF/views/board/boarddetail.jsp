<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<!-- <link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
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


    .boardDiv{
		padding: 0;
		margin: 0 auto;
		font-weight: normal;
		overflow-x: hidden;
		font-size: 12px;
		letter-spacing: -0.03em;
    }
    .boardsListTable{
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
	
   .boardsListTable th:not(.boardTitle,.boardWriter,.boardDate) {
  		text-align: center;
 		 width: 55px;
 		 padding: 0 0px;
	}
	.boardsListTable th:not(.boardNum,.boardTitle,.boardDate,.boardViewCount){
		width: 125px;
 		padding: 0 0px;
	}
	th.boardDate{
		width: 65px;
 		padding: 0 0px;
	}
	
	.boardTitle{
		text-align: center;
	}
	.boardsListTable thead th{
 		padding: 0 8px;
  		text-align: center;
  		
	}
	.boardsListTable thead{
    	line-height: 2.5;		
	}
	.boardsListTable tbody td:not(.tdboardTitle){
        text-align: center;
        padding: 3.5px 2px;
        line-height: 1.5;
        vertical-align: middle;
    }
    .pagebtn{
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
    .pagebtn:hover{
    	background-color : #444; 
   	  	color: #fff;
    }
    .apagebtn{
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
    	background-color : #444;
    	text-align: center;
    }
     .apagebtn:hover{
     	color: #fff;
    } 
	/*  .row{
		margin-left: 0px;
		margin-right: 0px;										
	} */
	
	.commentRowDiv{
		border-top: 1px solid #e5e5e5;
	}
	.reCommentDiv{
		background-color: #fcfcfc;
	}
	.aCursorActive{
	 cursor: pointer;
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
	.sideHotboard{
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
        /* overflow: hidden;   */        
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

.user-badge {
    margin-left: 10px;
    width: 20px;
    height: 20px;
}
<!--작성자 클릭시 드랍다운 관련 끝 css-->

    </style>

</head>
<body>
	<div class="container mt-5">
		<h1 class=text-center id="BoardTitleLabel">${boardTitle }</h1>
		<input type="hidden" value="${boardCode }" name="boardCode"
			id="freeCodeValue"> <input type="hidden"
			value="${board.boardPostIdx }" name="boardPostIdx"
			id="freePostIdxValue">
		<div class="row no-gutters">
			<div class="col-md-9">
				<div class="card mb-3">
					<div class="card-body">
						<h5 class="card-title" style="color:#f05d5e;">${board.boardTitle }</h5>
						<%-- 삭제 수정은 로그인 유저와 작성자가 같을때만 출력 --%>
						
						<p class="card-text d-flex justify-content-between aCursorActive">
						<small class="text-muted">작성자: ${board.userNickname} | 작성일:${board.boardRegisterDate }</small>
							<sec:authorize access="isAuthenticated()">
								<sec:authorize access="hasRole('ROLE_BOARD_ADMIN')" var="admin"/>
								<sec:authentication property="principal" var="userinfo"/>	
								<c:if test="${admin || userinfo.userId eq board.boardUserId }"><small class="text-muted"><a onclick="deleteFreeboard();" style="color: red;">삭제</a> | <a onclick="modifyFreeboard();">수정</a></small></c:if>					
							</sec:authorize>
						</p>
						 <c:choose>
							<c:when test="${imageArray != null && !empty imageArray}">
								<c:forEach var="boardgetimage" items="${imageArray }" varStatus="status">
									<img  src="<c:url value="/resources/images/uploadFile/board/${fn:trim(boardgetimage) }"/>" width="200" >					
								</c:forEach>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
						<p class="card-text">${board.boardContent }</p>
					</div>

					<div class="container text-center mt-5">
						<button class="btn btn-outline-dark" onclick="boardstarup(${board.boardPostIdx});">
							 추천&nbsp;<i class="fas fa-thumbs-up" style="color: #5CD1E5;"></i>
						</button>
						<button class="btn btn-outline-dark" onclick="boardstardown(${board.boardPostIdx});">
							<i class="fas fa-thumbs-down" style="color: #FFB2F5;"></i> 비추천
						</button>
					</div>

					<div class="container mt-4">
						<div class="d-flex justify-content-between">
							<p>
								<c:choose>
									<c:when test="${pageNum}!=null">
										<a href="<c:url value="/board/boardlist/${boardCode }"/>?search=${search }&keyword=${keyword }&pageNum=${pageNum}" style="color: #333;">목록</a>
									</c:when>
									<c:otherwise>
										<a href="<c:url value="/board/boardlist/${boardCode }"/>?search=${search }&keyword=${keyword }&pageNum=1" style="color: #333;">목록</a>									
									</c:otherwise>
								</c:choose>											
							</p>
							<p>
								<a style="color: #333; cursor: pointer;" onclick="boardspam(${board.boardPostIdx});"> <i class="fas fa-flag"></i>신고하기</a>
							</p>
						</div>
					</div>
				</div>
				
				<%--============================ 편의성 버튼 시작 (위치 미정) ================= --%>
				<div class="container mt-2">
					<div class="row">
						<div class="col-md-6">
							<!-- <button class="btn btn-secondary">목록</button> -->
							<button type="button" class="btn btn-secondary btn-sm" onclick="nextboard(${boardCode },${downboard})">다음글▲</button>
							<button type="button" class="btn btn-secondary btn-sm" onclick="beforeboard(${boardCode },${upboard})">이전글▼</button>
						</div>
						<div
							class="col-md-6 d-flex justify-content-end align-items-center">
							<div class="m-3">
								<a href="#" class="link-height text-dark">맨위로</a>
							</div>
							<button type="button" class="btn btn-dark btn-sm" onclick="window.location.href='<c:url value="/board/boardwrite/${boardCode }"/>'">글쓰기</button>
						</div>
					</div>
				</div>
				<%--============================ 편의성 버튼 끝 (위치 미정) ================= --%>
				
				
				<div class="card mt-3">
					<%--================ 댓글 출력 태그 시작============ --%>
					<div class="m-2" id="commentsListDiv"></div>
					<%--================ 댓글 출력 태그 끝============ --%>
				</div>
					<%--=================댓글 페이지 처리 시작 =========   --%>
					<div id='cocopageNumDiv' class='row justify-content-center mt-2'></div>
					<%--=================댓글 페이지 처리 끝 =========   --%>

				<%-- =============================게시글 전둉 댓글 작성창 시작===================== --%>			
				<div class="card mt-4" id="commentsNumber_0">
					<form id="commentsList_0">
						<div class="form-group">
							<sec:authorize access="isAuthenticated()">
							<input type="hidden" id="commentwriter" value="<sec:authentication property="principal.userId"/>">
							</sec:authorize>
							<label for="commentText">게시글에 댓글 작성</label>
							<textarea class="form-control" id="commentText_0"
								name="content" rows="3"  onclick="checkLogin()" required></textarea>
						</div>
						<div class="d-flex justify-content-between">
							<div>
								<input type="file" class="form-control-file" id="commentImage_0"
									name="commentImage">
							</div>
							<div>
								<button type="button" class="btn btn-dark float-right btn-sm" onclick="insertComment(0);">등록</button>
							</div>
						</div>
					</form>
				</div>
				<%-- =============================게시글 전둉 댓글 작성창 끝===================== --%>			

				


				<hr>
				<%-- ========================하단 게시글 목록 및 검색창 시작 ========================== --%>
				<%-- 1.게시글 목록 출력 , 2, 게시글 페이징, 3. 게시글 검색창      --%>		
				<div class="mt-4">
					<%-- 1.게시글 목록 출력 (시작) --%>
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
												    &nbsp;&nbsp;${boards.boardTitle}<c:if test="${boards.cocain !=0}"><span style="color: #A566FF;"> &nbsp;[${boards.cocain }]</span></c:if>
												</td>
			    								<td class="tdboardWriter">
					                                <!-- 작성자 클릭 시 드롭다운 표시 -->
					                                <div class="dropdown" id='WriterdropDiv'>
					                                    <button class="btn btn-link dropdown-toggle Wirterbtn" style="color: black;" type="button" id="dropdownMenuButton-${boards.boardPostIdx}" data-bs-toggle="dropdown" aria-expanded="false">
					                                        ${boards.userNickname}
					                                    </button>
					                                    <!-- 작성자 아이콘 표시 -->
                                                        <c:choose>
                                                            <c:when test="${boards.auth == 'ROLE_SUPER_ADMIN'}">
                                                                <img src="${pageContext.request.contextPath}/resources/images/crown.png" alt="Super Admin Badge" class="user-badge" />
                                                            </c:when>
                                                            <c:when test="${boards.auth == 'ROLE_BOARD_ADMIN'}">
                                                                <img src="${pageContext.request.contextPath}/resources/images/rainbow.png" alt="Board Admin Badge" class="user-badge" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:choose>
                                                                    <c:when test="${boards.userLevel >= 1 && boards.userLevel <= 5}">
                                                                        <img src="${pageContext.request.contextPath}/resources/images/bronze.png" alt="Bronze Badge" class="user-badge" />
                                                                    </c:when>
                                                                    <c:when test="${boards.userLevel >= 6 && boards.userLevel <= 10}">
                                                                        <img src="${pageContext.request.contextPath}/resources/images/silver.png" alt="Silver Badge" class="user-badge" />
                                                                    </c:when>
                                                                    <c:when test="${boards.userLevel >= 11 && boards.userLevel <= 15}">
                                                                        <img src="${pageContext.request.contextPath}/resources/images/gold.png" alt="Gold Badge" class="user-badge" />
                                                                    </c:when>
                                                                    <c:when test="${boards.userLevel >= 16 && boards.userLevel <= 19}">
                                                                        <img src="${pageContext.request.contextPath}/resources/images/emerald.png" alt="Emerald Badge" class="user-badge" />
                                                                    </c:when>
                                                                    <c:when test="${boards.userLevel >= 20}">
                                                                        <img src="${pageContext.request.contextPath}/resources/images/diamond.png" alt="Diamond Badge" class="user-badge" />
                                                                    </c:when>
                                                                </c:choose>
                                                            </c:otherwise>
                                                        </c:choose>
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
					<%-- 1.게시글 목록 출력 (끝) --%>
					
					<%-- 2, 게시글 페이징 (시작) --%>
					 <div id="pageNumDiv" class="row justify-content-center">
					 	 <div class="col-auto " style="margin: 5px;">           
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
					<%-- 2, 게시글 페이징 (끝) --%>

					<%-- 3. 게시글 검색창 (시작) --%>
					<%-- <div class="row  justify-content-center">
						<form id="searchForm" method="get" action="<c:url value="/board/boardlist/${freeCode }"/>"> 
							<input id="code" type="hidden" name="freeCode" value="${freeCode }" disabled="disabled">
							<select name="search" id="searchSelect" class="form-select">					
								<!-- userinfo 이기 때문에 name 으로 임시 작성 -->
								<option value="free_user_id" <c:if test="${search }=='free_user_id'"> selected </c:if>>&nbsp;작성자&nbsp;</option>
								<option value="free_title" <c:if test="${search }=='free_title'"> selected </c:if>>&nbsp;제목&nbsp;</option>
								<option value="free_content" <c:if test="${search }=='free_content'"> selected </c:if>>&nbsp;내용&nbsp;</option>
							</select>
							<input type="text" name="keyword" value="${keyword }" id="keywordInput" placeholder="검색..">
							<!-- <button type="button" onclick="getForm()">검색</button> -->
							<button type="submit">검색</button>
						</form>
					</div> --%>
				</div>
					<%-- 3. 게시글 검색창 (끝) --%>
			</div>

				<%-- ========================하단 게시글 목록 및 검색창 끝 ========================== --%>		

	




			<!-- 사이드 광고 및 인기글  -->
			<div class="col-md-3 sideHotboardList">
		            <h2><i class="fas fa-fire" style="font-size: 50px; color: orange;"></i>오늘의 인기글</h2>
		            <div class="" id="popularSideBoard">
	            </div>
	        </div>
		</div>
	</div>

	<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
		var Codetag = document.getElementById("freeCodeValue");
		var PostIdxtag = document.getElementById("freePostIdxValue");
		var boardCode = Codetag.value;
		var boardPostIdx = PostIdxtag.value;
	
		var cocopageNum =1;	
		commentsListDisplay(boardCode, boardPostIdx,1);
		popularSideBoard();
		
		function commentsListDisplay(boardCode, boardPostIdx, cocopageNum) {
		    $.ajax({
		        type: "get",
		        url: "<c:url value='/rest/commentsList'/>/" + boardCode + "/" + boardPostIdx,
		        data: {
		            "boardCode": boardCode,
		            "boardPostIdx": boardPostIdx,
		            "pageNum": cocopageNum
		        },
		        dataType: "json",
		        success: function(result) {
		            if (result.commentList.length == 0) {
		                var html = "<p>검색된 댓글이 없습니다.</p>";
		                $("#commentsListDiv").html(html);
		                return;
		            }

		            var contextPath = "<%=request.getContextPath()%>";
		            var html = "<p>댓글 (" + result.commentCount + ")</p>";

		            $(result.commentList).each(function() {
		                if (this.commentLevel != 0) {
		                    html += "<div class='commentRowDiv reCommentDiv mt-1' style='margin-left:" + this.commentLevel * 20 + "px;'>";
		                } else {
		                    html += "<div class='commentRowDiv mt-1' style='margin-left:" + this.commentLevel * 20 + "px;'>";
		                }

		                html += "<div class='list-group'>";
		                html += "<div>";
		                html += "<div class='d-flex justify-content-between'>";
		                html += "<div>";

		                if (this.commentStatus > 1) {
		                    // 상태 처리
		                } else {
		                    if (this.commentLevel != 0) {
		                        html += "<strong>┖" + this.userNickname;
		                    } else {
		                        html += "<strong>" + this.userNickname;
		                    }

		                    // 뱃지 추가
		                    if (this.auth === 'ROLE_SUPER_ADMIN') {
		                        html += "<img src='" + contextPath + "/resources/images/crown.png' alt='Super Admin Badge' class='user-badge' style='margin-left: 5px;'/>";
		                    } else if (this.auth === 'ROLE_BOARD_ADMIN') {
		                        html += "<img src='" + contextPath + "/resources/images/rainbow.png' alt='Board Admin Badge' class='user-badge' style='margin-left: 5px;'/>";
		                    } else {
		                        if (this.userLevel >= 1 && this.userLevel <= 5) {
		                            html += "<img src='" + contextPath + "/resources/images/bronze.png' alt='Bronze Badge' class='user-badge' style='margin-left: 5px;'/>";
		                        } else if (this.userLevel >= 6 && this.userLevel <= 10) {
		                            html += "<img src='" + contextPath + "/resources/images/silver.png' alt='Silver Badge' class='user-badge' style='margin-left: 5px;'/>";
		                        } else if (this.userLevel >= 11 && this.userLevel <= 15) {
		                            html += "<img src='" + contextPath + "/resources/images/gold.png' alt='Gold Badge' class='user-badge' style='margin-left: 5px;'/>";
		                        } else if (this.userLevel >= 16 && this.userLevel <= 19) {
		                            html += "<img src='" + contextPath + "/resources/images/emerald.png' alt='Emerald Badge' class='user-badge' style='margin-left: 5px;'/>";
		                        } else if (this.userLevel >= 20) {
		                            html += "<img src='" + contextPath + "/resources/images/diamond.png' alt='Diamond Badge' class='user-badge' style='margin-left: 5px;'/>";
		                        }
		                    }

		                    html += "</strong> <small class='text-muted'>" + this.commentRegDate + "</small>";

		                    // 작성자 표시
		                    if (this.commentUserId == result.board.boardUserId) {
		                        html += "<span style='display: inline-block; width: 52px; height: 21px; margin-right: 2px; margin-left: 4px; border-style: solid; border-width: 1px; border-radius: 4px;font-size: 10px; font-weight: normal; letter-spacing: -1px; line-height: 22px; text-align: center;text-indent: -1px; color: #CC3D3D;'>작성자</span>";
		                    }

		                    // 삭제 버튼
		                    if (this.commentUserId == result.userId || result.boardAdmin != null) {
		                        html += "<a class='aCursorActive' onclick='deleteComment(" + this.commentIdx + ");'><span style='display: inline-block; width: 52px; height: 21px; margin-right: 2px; border-style: solid; border-width: 1px; border-radius: 4px;font-size: 10px; font-weight: normal; letter-spacing: -1px; line-height: 22px; text-align: center;text-indent: -1px; color: #0D6EFD;'>삭제</span></a>";
		                    }
		                }

		                html += "</div>";
		                html += "<div class='btn-group btn-group-sm aCursorActive' role='group' aria-label='Small button group'>";
		                if (this.commentStatus > 1) {
		                    // 상태에 따른 처리
		                } else {
		                    html += "<p><small class='text-muted'><a onclick='voteUp(" + this.commentIdx + ");' style='color: #F29661;'><i class='fa-solid fa-hand-holding-heart'></i>추천</a> | <a onclick='commentspam(" + this.commentIdx + ");' style='color: dark;'><i class='fa-solid fa-user-large-slash'></i>신고</a></small></p>";
		                }
		                html += "</div>";
		                html += "</div>";

		                if (this.commentStatus == 2) {
		                    html += "<p><span style='color: pink;'>삭제된 댓글입니다.</span></p>";
		                } else if (this.commentStatus == 3) {
		                    html += "<p><span style='color: blue;'>신고 누적으로 블라인드 처리된 댓글 입니다.</span></p>";
		                } else {
		                    if (this.commentRestep != 0) {
		                        html += "<p><span style='color: blue;'>@" + this.commentReuser + "&nbsp;&nbsp;&nbsp;</span>" + this.content + "</p>";
		                    } else {
		                        html += "<p>" + this.content + "</p>";
		                    }

		                    if (this.commentImage && this.commentImage.length != 0) {
		                        html += "<img src='" + contextPath + "/resources/images/uploadFile/comment/" + this.commentImage + "' width='80'>";
		                    }
		                }

		                html += "</div>";
		                html += "<div class='d-flex justify-content-between'>";
		                html += "<div></div>";
		                if (this.commentStatus > 1) {
		                    // 상태에 따른 처리
		                } else {
		                    html += "<div class='text-drak'><a style='font-size:15px;' onclick='writeComment(" + this.commentIdx + ");'>답글</a></div>";
		                }
		                html += "</div>";
		                html += "<div id='rrDiv'></div>";
		                html += "</div>";
		                html += "</div>";
		                
		                // 대댓글 입력란 추가
		                html += "<div class='card mt-4 cocoment' id='commentsNumber_" + this.commentIdx + "' style='display:none;'>"; // 답글 폼 숨김
		                html += "<form id='commentsList_" + this.commentIdx + "'>";
		                html += "<div class='form-group'>";
		                html += "<label for='commentText_" + this.commentIdx + "'>&nbsp;<span style='color: blue;'>@" + this.userNickname + "</span> 답글</label>";
		                html += "<textarea class='form-control' id='commentText_" + this.commentIdx + "' name='content' rows='3' required></textarea>";
		                html += "</div>";
		                html += "<div class='d-flex justify-content-between'>";
		                html += "<div>";
		                html += "<input type='file' class='form-control-file' id='commentImage_" + this.commentIdx + "' name='commentImage'>";
		                html += "</div>";
		                html += "<div>";
		                html += "<button type='button' class='btn btn-dark float-right btn-sm' onclick='insertComment(" + this.commentIdx + ");'>등록</button>";
		                html += "</div>";
		                html += "</div>";
		                html += "</form>";
		                html += "</div>"; // cocoment 끝
		                html += "</div>"; // commentRowDiv 끝
		         
		            });

		            html += "<input type='hidden' value='" + result.pager.pageNum + "' id='pageNumValue'>";

		            $("#commentsListDiv").html(html);
		            pageNumberDisplay(result.boardCode, result.boardPostIdx, result.pager);
		            $(".cocoment").css({ display: 'none' });
		        },
		        error: function(xhr) {
		            alert("에러코드(게시글 목록 검색) = " + xhr.status);
		        }
		    });
		}



		//=========댓글 삭제버튼
		function deleteComment(commentIdx) {
			checkLogin();
			var confirmCommentdelet = confirm("정말로 댓글을 삭제 하시겠습니까?");
			if(confirmCommentdelet){				 
				$.ajax({
					type : "put",
					url : "<c:url value='/rest/comment_delete'/>/" + commentIdx,
					beforeSend: function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					contentType : "application/json",
					success : function(result) {
						commentsListDisplay(boardCode, boardPostIdx);
					},
					error : function(xhr) {
						alert("에러코드(게시글 검색) = " + xhr.status);
					}
				});
			}
		}

		
		//게시글 삭제버튼
		function deleteFreeboard(){
			checkLogin();
			var confirmdelet = confirm("정말로 게시글을 삭제 하시겠습니까?");
			if(confirmdelet){
				 window.location.href = '<c:url value="/board/boardDeleteBoard"/>/'+boardCode+"/"+boardPostIdx;
			}
		}
		//게시글 수정버튼
		function modifyFreeboard(){
			 checkLogin();
			var confirmdelet = confirm("게시글을 수정 하시겠습니까?");
			if(confirmdelet){
				 window.location.href = '<c:url value="/board/boardModify"/>/'+boardCode+"/"+boardPostIdx;
			}
		}
		
		//=========댓글 추가
		function insertComment(commentIdx) {
			var formData = new FormData(); // FormData 객체 생성

		    // 텍스트 필드 추가
		    var commentText = document.getElementById('commentText_'+commentIdx).value;
		    formData.append('content', commentText);

		    // 파일 추가
		    var commentImage = document.getElementById('commentImage_'+commentIdx).files[0];
		    if (commentImage) {
		        formData.append('commentImage', commentImage);
		    }
		    
			$.ajax({
				type : "POST",
				url : "<c:url value='/rest/comment_insert'/>/" +boardPostIdx +"/"+commentIdx,
				data: formData,
				beforeSend: function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				processData: false, // jQuery가 데이터를 처리하지 않도록 설정
		        contentType: false, // jQuery가 Content-Type을 설정하지 않도록 설정
				success : function(result) {
					document.getElementById('commentText_'+commentIdx).value = "";
					commentsListDisplay(boardCode, boardPostIdx);
				},
				error : function(xhr) {
					alert("에러코드(게시글 검색) = " + xhr.status);
				}
			});
		}
		
		//대댓글 답글 버튼
		function writeComment(commentIdx){
			 checkLogin();
			 $(".cocoment").css({ display: 'none' });
			 $("#commentsNumber_" + commentIdx).css({ display: 'block' });
		}
		
		//댓글 페이징
		function pageNumberDisplay(boardCode,boardPostIdx,pager) {
			var html="";		
			 html+="<div class='col-auto'>";		
			if(pager.startPage > pager.blockSize) {
				  html+= "<a class='pagebtn' href='javascript:commentsListDisplay("+boardCode+","+boardPostIdx+","+pager.prevPage+");'>◀</a>";
			} else {
				
			}		
			for(i = pager.startPage ; i <= pager.endPage ; i++) {
				if(pager.pageNum != i) {
					html+= "<a class='pagebtn' href='javascript:commentsListDisplay("+boardCode+","+boardPostIdx+","+i+");'>"+i+"</a>";
				} else {
					/* html+="["+i+"]"; */	
					html+="<a class='apagebtn disabled' tabindex='-1'>"+i+"</a>";	
					
				}
			}	
			if(pager.endPage != pager.totalPage) {
				 html+= "<a class='pagebtn' href='javascript:commentsListDisplay("+boardCode+","+boardPostIdx+","+pager.nextPage+");'>▶</a>";
			} else {
				
			}
			html+="</div>";	
			$("#cocopageNumDiv").html(html);
		}
		
		//댓글 중 추천 버튼 클릭
		function voteUp(commentIdx){
			checkLogin();
			var confirmcommentvoteUp = confirm("추천 하시겠습니까?");
			if(confirmcommentvoteUp){ 
				$.ajax({
					type : "post",
					url : "<c:url value='/rest/comment_starup'/>/" + commentIdx,
					beforeSend: function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					contentType : "application/json",
					success : function(result) {
						if(result =="success"){										
							alert("댓글 추천 완료!");					
						}else if(result =="pass"){
							alert("이미 추천에 참여하셨습니다.");						
						}
						commentsListDisplay(boardCode, boardPostIdx);
					},
					error : function(xhr) {
						alert("에러코드(게시글 검색) = " + xhr.status);
					}
				});
			}	
		}
		//댓글 신고 버튼 클릭
		function commentspam(commentIdx){
			 checkLogin();
			var confirmcommentspam = confirm("댓글을 신고 하시겠습니까?");
			if(confirmcommentspam){
				$.ajax({
					type : "post",
					url : "<c:url value='/rest/comment_commentspam'/>/" + commentIdx,
					beforeSend: function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					contentType : "application/json",
					success : function(result) {
						if(result =="success"){										
							alert("댓글 신고 완료!");					
						}else if(result =="pass"){
							alert("이미 신고한 댓글 입니다.");						
						}
						commentsListDisplay(boardCode, boardPostIdx);
					},
					error : function(xhr) {
						alert("에러코드(게시글 검색) = " + xhr.status);
					}
				});
			}	
		}
		
		//게시글 추천 버튼 클릭
		function boardstarup(boardPostIdx){
			checkLogin();
			var confirmboardstarup = confirm("이 게시글을 추천 하시겠습니까?");
			if(confirmboardstarup){
				$.ajax({
					type : "post",
					url : "<c:url value='/rest/board_starup'/>/" + boardPostIdx,
					beforeSend: function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					contentType : "application/json",
					success : function(result) {
						if(result =="success"){
						alert("게시글 추천 완료!");					
						}else if(result =="pass"){
						alert("이미 추천에 참여하셨습니다.");					
						}
						commentsListDisplay(boardCode, boardPostIdx);	
					},
					error : function(xhr) {
						alert("에러코드(게시글 검색) = " + xhr.status);
					}
				});
			}	
		}
		
		//게시글 비추천 버튼 클릭
		function boardstardown(boardPostIdx){
			 checkLogin();
			 checkLogin();
			var confirmboardsdown = confirm("이 게시글을 비추천 하시겠습니까?");
			if(confirmboardsdown){
				$.ajax({
					type : "post",
					url : "<c:url value='/rest/board_stardown'/>/" + boardPostIdx,
					beforeSend: function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					contentType : "application/json",
					success : function(result) {
						if(result =="success"){
							alert("게시글 비추천 완료!");										
						}else if(result =="pass"){
							alert("이미 추천에 참여하셨습니다.");						
						}
						commentsListDisplay(boardCode, boardPostIdx);
					},
					error : function(xhr) {
						alert("에러코드(게시글 검색) = " + xhr.status);
					}
				});
			}
		}
		
		//게시글 신고 버튼 클릭
		function boardspam(boardPostIdx){
			checkLogin();
			var confirmboardspam = confirm("이 게시글을 신고 하시겠습니까?");
			if(confirmboardspam){
				$.ajax({
					type : "post",
					url : "<c:url value='/rest/board_spam'/>/" + boardPostIdx,
					beforeSend: function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					contentType : "application/json",
					success : function(result) {
						if(result =="success"){
							alert("게시글 신고 완료!");															
						}else if(result =="pass"){
							alert("이미 신고한 게시글 입니다..");						
						}
						commentsListDisplay(boardCode, boardPostIdx);
					},
					error : function(xhr) {
						alert("에러코드(게시글 검색) = " + xhr.status);
					}
				});
			}	
		}
		
	//로그인 상태 확인
	function checkLogin() {
        var isAuthenticated = $("#commentwriter").val() ? true : false;
        if (!isAuthenticated) {
            window.location.href = "<c:url value='/user/login'/>"; 
        }
    }
	//다음글로 이동 버튼
	function nextboard(boardCode,boardPostIdx){
		if(boardPostIdx==0){
			alert("가장 최신글 입니다.");
		}else{
		window.location.href = "<c:url value='/board/boarddetail/"+boardCode+"/"+boardPostIdx+"'/>"; 					
		}
	}
	//이전글로 이동 버튼
	function beforeboard(boardCode,boardPostIdx){
		if(boardPostIdx==0){
			alert("마지막글 입니다.");
		}else{
		window.location.href = "<c:url value='/board/boarddetail/"+boardCode+"/"+boardPostIdx+"'/>"; 					
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
				html +="<li class='list-group-item sideHotboard'>"+(index+1)+". <a href='<c:url value='/board/boarddetail/"+this.boardCode+"/"+this.boardPostIdx+"'/>'>"+this.boardTitle+"</a> </li>";
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