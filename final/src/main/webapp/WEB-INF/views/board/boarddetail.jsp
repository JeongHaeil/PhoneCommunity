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
<title>부트스트랩 예제</title>

<!-- <link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
    <style type="text/css">
    .boardDiv{
		padding: 0;
		margin: 0 auto;
		font-weight: normal;
		overflow-x: hidden;
		font-size: 14px;
		letter-spacing: -0.03em;
    }
    .boardsListTable{
 		 width: 100%;
 		 /* border: 1px solid #ededed; */
    }
    @media (min-width: 1400px) {
  		.container {
   	 		max-width: 1320px;
 		}
 	}
	
   .boardsListTable th:not(.boardTitle,.boardWriter,.boardDate) {
  		text-align: center;
 		 width: 55px;
 		 padding: 0 0px;
	}
	.boardsListTable th:not(.boardNum,.boardTitle,.boardDate,.boardViewCount){
		width: 70px;
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
		/* border-top: 1px solid #e5e5e5; */
 		padding: 0 8px;
  		/* border-bottom: 1px solid #e5e5e5; */
  		background: #fff;
  		text-align: center;
  		
	}
	.boardsListTable thead{
		background-color: #343a40;
    	color: #fff;
    	line-height: 2.5;		
	}
	.boardsListTable tbody td{
 		 text-align: left;
 		 padding: 3.5 2px;
 		 line-height: 1.5;
 		 
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
	.row{
		margin-left: 0px;
		margin-right: 0px;										
	}
	
	.commentRowDiv{
		border-top: 1px solid #e5e5e5;
	}
	.reCommentDiv{
		background-color: #fcfcfc;
	}
	.aCursorActive{
	 cursor: pointer;
	}
    </style>

<!-- 추천에 하트모양 오류 출력불가-->
<!-- <script src="https://kit.fontawesome.com/a076d05399.js"
	crossorigin="anonymous"></script> -->
</head>
<body>
	<div class="container mt-5">
		<h1 class=text-center>${boardTitle }</h1>
		<input type="hidden" value="${boardCode }" name="boardCode"
			id="freeCodeValue"> <input type="hidden"
			value="${board.boardPostIdx }" name="boardPostIdx"
			id="freePostIdxValue">
		<div class="row">
			<div class="col-md-9">
				<div class="card mb-3">
					<div class="card-body">
						<h5 class="card-title" style="color:#f05d5e;">${board.boardTitle }</h5>
						<%-- 삭제 수정은 로그인 유저와 작성자가 같을때만 출력 --%>
						<p class="card-text d-flex justify-content-between aCursorActive">
						<small class="text-muted">작성자: ${board.userNickname} | 작성일:${board.boardResigsterDate }</small>
							<sec:authorize access="isAuthenticated()">
								<sec:authorize access="hasRole('ROLE_SUPER_ADMIN')" var="admin"/>
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
							<i class="fas fa-heart"></i> 추천
						</button>
						<button class="btn btn-outline-dark" onclick="boardstardown(${board.boardPostIdx});">
							<i class="fas fa-heart" ></i> 비추천
						</button>
					</div>

					<div class="container mt-4">
						<div class="row">
							<div class="col-md-6">
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
								
							</div>
							<div class="col-md-6 text-right">
								<p>
									<a class="" style="color: #333;" onclick="boardspam(${board.boardPostIdx});">신고하기</a>
								</p>
							</div>
						</div>
					</div>
				</div>
				
				<%--============================ 편의성 버튼 시작 (위치 미정) ================= --%>
				<div class="container mt-2">
					<div class="row">
						<div class="col-md-6">
							<!-- <button class="btn btn-secondary">목록</button> -->
							<button class="btn btn-secondary btn-sm">다음글▲</button>
							<button class="btn btn-secondary btn-sm">이전글▼</button>
						</div>
						<div
							class="col-md-6 d-flex justify-content-end align-items-center">
							<div class="mr-3">
								<a href="#" class="link-height text-dark">맨위로</a>
							</div>
							<button type="button" class="btn btn-dark btn-sm" onclick="window.location.href='<c:url value="/board/boardwrite/${boardCode }"/>'">글쓰기</button>
						</div>
					</div>
				</div>
				<%--============================ 편의성 버튼 끝 (위치 미정) ================= --%>
				
				
				<div class="card mt-3">
					<%--================ 댓글 출력 태그 시작============ --%>
					<div id="commentsListDiv"></div>
					<%--================ 댓글 출력 태그 끝============ --%>
				</div>



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
			    								<td>&nbsp;&nbsp;<a href="<c:url value='/board/boarddetail/${boards.boardCode }/${boards.boardPostIdx }'/>?pageNum=${pager.pageNum}&search=${search }&keyword=${keyword }" style="color: #333;">${boards.boardTitle }</a></td>
			    								<td>${boards.userNickname }</td>
			    								<td>${fn:substring(boards.boardResigsterDate,5,10) }</td>
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
			<div class="col-md-3">
				<h2>오늘의 인기글</h2>
				<ul class="list-group">
					<li class="list-group-item"><a href="#">1. 일반 bcaa 2종
							1980원 무배</a> <span class="badge badge-primary">13</span></li>
					<li class="list-group-item"><a href="#">2. 블렌드 유산균 반값</a> <span
						class="badge badge-primary">8</span></li>
					<li class="list-group-item"><a href="#">3. 미사 스포츠 음료 300P</a>
						<span class="badge badge-primary">1500</span></li>
					<li class="list-group-item"><a href="#">4. 가스펠 포드 ADV 신제품</a>
						<span class="badge badge-primary">16</span></li>
					<li class="list-group-item"><a href="#">5. 이너 마이핏 ADV 신제품</a>
						<span class="badge badge-primary">14</span></li>
				</ul>
			</div>
		</div>
	</div>

	<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->

	<script type="text/javascript">
		var Codetag = document.getElementById("freeCodeValue");
		var PostIdxtag = document.getElementById("freePostIdxValue");
		var boardCode = Codetag.value;
		var boardPostIdx = PostIdxtag.value;
	
		var cocopageNum =1;	
		commentsListDisplay(boardCode, boardPostIdx,1);
		function commentsListDisplay(boardCode, boardPostIdx,cocopageNum) {
			$.ajax({
				type : "get",
				url : "<c:url value='/rest/commentsList'/>/" + boardCode+ "/" + boardPostIdx,
				data : {
					"boardCode" : boardCode,
					"boardPostIdx" : boardPostIdx,
					"pageNum": cocopageNum
				},
				dataType : "json",
				success : function(result) {
							if (result.commentList.length == 0) {
								var html = "<p>검색된 댓글이 없습니다.</p>";
								$("#commentsListDiv").html(html);
								return;
							}
							var html = "<h4>댓글 (" + result.commentCount
									+ ")</h4>";
							$(result.commentList)
									.each(
											function() {
												if(this.commentLevel!=0){
												html += "<div class='row commentRowDiv reCommentDiv mt-1' style='margin-left:"+this.commentLevel*20+"px;'>"; 
												}else{
												html += "<div class='row commentRowDiv mt-1' style='margin-left:"+this.commentLevel*20+"px;'>"; 				
												}
												html += "<div class='list-group w-100'>";
												html += "<div>";
												html += "<div class='d-flex justify-content-between'>";
												
												html += "<div>";
												if(this.commentLevel!=0){													
												html += "<strong>┖"+ this.userNickname+ "</strong> <small class='text-muted'>"+ this.commentRegDate+ "</small>";													
												}else{
												html += "<strong>"+ this.userNickname+ "</strong> <small class='text-muted'>"+ this.commentRegDate+ "</small>";
												}
												
												if (this.commentUserId == result.board.boardUserId) {//세션에서 값 가져와서 로그인 유저와 비교 <---잘못된 작성
													html += "<span style='display: inline-block; width: 52px; height: 21px; margin-right: 2px; border-style: solid; border-width: 1px; border-radius: 4px;font-size: 10px; font-weight: normal; letter-spacing: -1px; line-height: 22px; text-align: center;text-indent: -1px; color: blue;'>작성자</span>";										
												}
												if(this.commentUserId == result.board.boardUserId || result.boardAdmin !=null){
													html += "<a class='aCursorActive' onclick='deleteComment("+ this.commentIdx+ ");'><span style='display: inline-block; width: 52px; height: 21px; margin-right: 2px; border-style: solid; border-width: 1px; border-radius: 4px;font-size: 10px; font-weight: normal; letter-spacing: -1px; line-height: 22px; text-align: center;text-indent: -1px; color: red;'>삭제</span></a>";													
												}
												
												html += "</div>";												
												html += "<div class='btn-group btn-group-sm aCursorActive' role='group' aria-label='Small button group'>";
												if(this.commentStatus>1){
													
												}else{												
													html += "<p><small class='text-muted'><a onclick='voteUp("+this.commentIdx+");' style='color: red;'>추천▲</a> | <a onclick='commentspam("+this.commentIdx+");' style='color: dark;'>신고</a></small></p>";
												}	
												html += "</div>";
												html += "</div>";
												if(this.commentStatus>1){
													html +="<p><span style='color: pink;'>삭제된 댓글입니다.</span></p>"
												}else{
													if(this.commentRestep!=0){
													html += "<p><span style='color: blue;'>@"+this.commentReuser+"&nbsp;&nbsp;&nbsp;   </span>" + this.content+ "</p>";																										
													}else{
													html += "<p>" + this.content+ "</p>";													
													}													
													if (this.commentImage
															&& this.commentImage.length != 0) {
														html += "<img  src='<c:url value='/resources/images/uploadFile/comment/"+this.commentImage+"'/>' width='80' >";						
													}
												}
												html += "</div>";
												html += "<div class='d-flex justify-content-between'>";
												html += "<div></div>";
												if(this.commentStatus>1){
													
												}else{
													html += "<div class='text-drak'><a  style='font-size:15px;' onclick='writeComment("+ this.commentIdx+ ");'>답글</a></div>";													
												}	
												html += "</div>";
												html += "<div id='rrDiv'></div>";
												html += "</div>";
												html += "</div>";
												
												
												html += "<div class='card mt-4 cocoment' id='commentsNumber_"+this.commentIdx+"'>";
												html += "<form id='commentsList_"+this.commentIdx+"'>";
												html += "<div class='form-group'>";
												html += "<label class='aCursorActive' for='commentText'>&nbsp;<span style='color: blue;'>@"+this.userNickname+"</span> 답글</label>";
												html += "<textarea class='form-control' id='commentText_"+this.commentIdx+"' name='content' rows='3' required></textarea>";
												html += "</div>";
												html += "<div class='d-flex justify-content-between'>";
												html += "<div>";
												html += "<input type='file' class='form-control-file' id='commentImage_"+this.commentIdx+"' name='commentImage'>";
												html += "</div>";
												html += "<div>";
												html += "<button type='button' class='btn btn-dark float-right btn-sm' onclick='insertComment("+this.commentIdx+");'>등록</button>";
												html += "</div>";
												html += "</div>";
												html += "</form>";
												html += "</div>";
												<%-- <input type="hidden" name="pageNum" value="${pager.pageNum }" id="pageNumValue">; --%>	
											
											});
							html += "<input type='hidden' value='${pager.pageNum }' id='pageNumValue'>"; 
							html += "<div id='cocopageNumDiv' class='row justify-content-center'></div>"; 
							
							$("#commentsListDiv").html(html);
							pageNumberDisplay(result.boardCode,result.boardPostIdx,result.pager);
							$(".cocoment").css({ display: 'none' });
						},
						error : function(xhr) {
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
	</script>
</body>
</html>