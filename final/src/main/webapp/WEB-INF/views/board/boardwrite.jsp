<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 작성</title>
    <script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>
    <style type="text/css">
    .cke_button__source { display: none; }
    </style>
</head>
<body>

<div class="container mt-5">
	<c:choose>
		<c:when test="${empty board }">
    		<h2>게시판 글 작성</h2>		
		</c:when>
		<c:otherwise>
    		<h2>게시글 수정</h2>
    		<input type="hidden" id="getcontent" value="${board.boardContent }">			
		</c:otherwise>
	</c:choose>
	
	<c:choose>
		<c:when test="${empty board }">
    		<form action="<c:url value="/board/boardwrite/${boardCode }"/>" method="post" enctype="multipart/form-data">
		</c:when>
		<c:otherwise>
    		<form action="<c:url value="/board/boardModify/${boardCode }/${board.boardPostIdx }"/>" method="post" enctype="multipart/form-data">
    		<input type="hidden" name="pageNum" value="${pageNum }">			
    		<input type="hidden" name="pageSize" value="${pageSize }">			
    		<input type="hidden" name="search" value="${ search}">			
    		<input type="hidden" name="keyword" value="${keyword }">			
		</c:otherwise>
	</c:choose>
		<div class="d-flex align-items-center mb-3"> 
			<c:choose>
				<c:when test="${boardCode == 11}">
					<div class="me-2">
						<select name="boardtag" class="form-select">
							<option value="[기타]" <c:if test="${boardtag  == '기타'}"> selected </c:if>>기타</option>
							<option value="[통신사]" <c:if test="${boardtag  == '통신사'}"> selected </c:if>>통신사</option>
							<option value="[구매처]" <c:if test="${boardtag  == '구매처'}"> selected </c:if>>구매처</option>
							<option value="[제품]" <c:if test="${boardtag  == '제품'}"> selected </c:if>>제품</option>
						</select>
					</div>
				</c:when>
				<c:otherwise>
					<div class="me-2">
						<select name="boardtag" class="form-select">
							<option value="[기타]" <c:if test="${boardtag  == '기타'}"> selected </c:if>>기타</option>
							<option value="[잡답]" <c:if test="${boardtag  == '잡답'}"> selected </c:if>>잡답</option>
							<option value="[웃긴글]" <c:if test="${boardtag  == '웃긴글'}"> selected </c:if>>웃긴글</option>
							<option value="[퍼옴]" <c:if test="${boardtag  == '퍼옴'}"> selected </c:if>>퍼옴</option>
						</select>
					</div>
				</c:otherwise>
			</c:choose>
			
			<div>   	
	           <label for="boardTitle" class="me-2">제목:</label>
	        </div>   
	        <div class="flex-grow-1">
   			   <input type="text" class="form-control" id="boardTitle" name="boardTitle" value="${board.boardTitle}" required>
	        </div>	
		</div>
		<hr>
        <div class="form-group mt-2">
            <label for="content">내용</label>
            <textarea class="form-control" id="boardContent" name="boardContent" rows="5"  required></textarea>
        </div>

        <div class="form-group">
            <label for="image">이미지 업로드:</label>
            <input type="file" class="form-control-file" name=uploaderFileList accept="image/*"  multiple="multiple">
        </div>
        <div class="mt-2">
		<button type="button" class="btn btn-dark" onclick="window.location.href='<c:url value='/board/boardlist/${boardCode }'/>'">목록</button>
		<c:choose>
		<c:when test="${empty board }">
			<button type="submit" class="btn btn-dark">글쓰기</button>		
		</c:when>
		<c:otherwise>
			<button type="submit" class="btn btn-dark">수정</button>		    					
		</c:otherwise>
		</c:choose>
		</div>
		<sec:csrfInput/>
    </form>
</div>

<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->

<script type="text/javascript">
CKEDITOR.replace('boardContent', {
    removePlugins: 'sourcearea',  
});
var getcotent=document.getElementById("getcontent").value
document.getElementById("boardContent").value =getcotent;
</script>
</body>
</html>