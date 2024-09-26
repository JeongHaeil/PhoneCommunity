<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 작성</title>
    <!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
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
        <div class="form-group">
            <label for="title">제목:</label>
            <input type="text" class="form-control" id="boardTitle" name="boardTitle" value="${board.boardTitle }" required>
        </div>

        <div class="form-group">
            <label for="content">내용:</label>
            <textarea class="form-control" id="boardContent" name="boardContent" rows="5"  required></textarea>
        </div>

        <div class="form-group">
            <label for="image">이미지 업로드:</label>
            <input type="file" class="form-control-file" name=uploaderFileList accept="image/*" value="${board.boardImage }" multiple="multiple">
        </div>
        
		<button type="button" class="btn btn-dark" onclick="window.location.href='<c:url value='/board/boardlist/${freeCode }'/>'">목록</button>
		<c:choose>
		<c:when test="${empty board }">
			<button type="submit" class="btn btn-dark">글쓰기</button>		
		</c:when>
		<c:otherwise>
			<button type="submit" class="btn btn-dark">수정</button>		    					
		</c:otherwise>
	</c:choose>
    </form>
</div>

<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->

<script type="text/javascript">
var getcotent=document.getElementById("getcontent").value
document.getElementById("boardContent").value =getcotent;
</script>
</body>
</html>