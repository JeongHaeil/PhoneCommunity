<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 작성</title>
    <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
    <style type="text/css">
    .cke_button__source { display: none; }
    </style>
</head>
<body>
<input type="hidden" id="regetmessage" value="${regetmessage} ">
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
				<c:when test="${boardCode == 2}">
					<div class="me-2">
						<select name="boardtag" class="form-select">
							<option value="[공지]" <c:if test="${boardtag  == '공지'}"> selected </c:if>>공지</option>
							<option value="[업데이트]" <c:if test="${boardtag  == '업데이트'}"> selected </c:if>>업데이트</option>
							<option value="[이벤트]" <c:if test="${boardtag  == '이벤트'}"> selected </c:if>>이벤트</option>
						</select>
					</div>
				</c:when>
				<c:when test="${boardCode == 3}">
					<div class="me-2">
						<select name="boardtag" class="form-select">
							<option value="[문의]" <c:if test="${boardtag  == '문의'}"> selected </c:if>>문의</option>
							<option value="[신고]" <c:if test="${boardtag  == '신고'}"> selected </c:if>>신고</option>
							<option value="[건의]" <c:if test="${boardtag  == '건의'}"> selected </c:if>>건의</option>
							<option value="[버그]" <c:if test="${boardtag  == '버그'}"> selected </c:if>>버그</option>
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
   			   <input type="text" class="form-control" id="boardTitle" name="boardTitle" value="${board.boardTitle}" required maxlength="50" >
	        </div>	
		</div>
		
        <div class="form-group mt-2">
            <label for="content">내용</label>
            <textarea class="form-control" id="boardContent" name="boardContent" rows="5"  required oninput="checkVarchar2(this, 1300)" ></textarea>
        </div>
		
		 <div>
		<p id="charCount">남은 글자 수: </p>
		</div>
		
        <div class="form-group">
            <label for="image">이미지 업로드:</label>
            <input type="file" class="form-control-file" name=uploaderFileList accept="image/*"  multiple="multiple">
            
        </div>
        <div class="mt-2">
		<button type="button" class="btn btn-dark" onclick="window.location.href='<c:url value='/board/boardlist/${boardCode }'/>'">목록</button>
		<c:choose>
		<c:when test="${empty board }">
			<button type="submit" class="btn btn-dark" >글쓰기</button>		
		</c:when>
		<c:otherwise>
			<button type="submit" class="btn btn-dark" >수정</button>		    					
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
getgetmessage();
CKEDITOR.replace('boardContent', {
    removePlugins: 'sourcearea',
    on: {
        change: function(event) {
            updateCharacterCount();
        }     
    }
});
var getcotent=document.getElementById("getcontent").value
document.getElementById("boardContent").value =getcotent;

function updateCharacterCount() {
    var editorData = CKEDITOR.instances.boardContent.getData() 
    //var charCount = editorData.replace(/<[^>]*>/g, '').length; 
    var charCount = editorData.length; 
    var maxLength = 1000; // 최대 글자 수 설정
    var charCountElement = document.getElementById('charCount');
 
    charCountElement.textContent = "허용 가능한 글자 수를 초과하였습니다.";

    // 글자 수가 최대값을 초과할 경우 경고
    if (charCount > maxLength) {
        //alert("최대 글자 수를 초과 하였습니다");
        charCountElement.style.color = 'red';  // 글자 수 초과 시 빨간색으로 표시
        charCountElement.style.display = 'block';  // 글자 수 초과 시 빨간색으로 표시
        disableSubmitButton();

    } else {
        charCountElement.style.color = '#555';  // 정상 범위일 때 기본 색상
        charCountElement.style.display = 'none';
        enableSubmitButton();
    }

}
function getgetmessage() {
    var getmessages = document.getElementById("regetmessage").value;
    if (getmessages && getmessages.length > 5) {
        alert(getmessages);
    }
}
// 버튼 비활성화
function disableSubmitButton() {
    var submitButton = document.querySelector('button[type="submit"]');
    if (submitButton) {
        submitButton.disabled = true;
    }
}

// 버튼 활성화 함수
function enableSubmitButton() {
    var submitButton = document.querySelector('button[type="submit"]');
    if (submitButton) {
        submitButton.disabled = false;
    }
}
</script>
</body>
</html>