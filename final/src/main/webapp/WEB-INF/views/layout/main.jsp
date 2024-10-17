<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>">
</head>
<body>



    <div class="main-container">
        <div class="main-row">
            <div class="main-shopping-info">
                <div class="main-card">
                    <div class="main-card-header" id="MainViewDisplay">
                        최신글
                        <a href="#" class="main-more-btn">더보기</a>
                    </div>
                    <div class="main-card-body">
                        <ul class="main-list-group" id="MainNewboardDisplay">
                            <li class="main-list-item">1. </li>
                            <li class="main-list-item">2. </li>
                            <li class="main-list-item">3. </li>
                            <li class="main-list-item">4. </li>
                            <li class="main-list-item">5. </li>
                        </ul>
                    </div>
                </div>
            </div>
    
            <div class="main-community">
                <div class="main-card">
                    <div class="main-card-header">
                        인기글
                        <a href="#" class="main-more-btn">더보기</a>
                    </div>
                    <div class="main-card-body">
                        <ul class="main-list-group" id="MainPopularDisplay">
                            <li class="main-list-item">1. </li>
                            <li class="main-list-item">2. </li>
                            <li class="main-list-item">3. </li>
                            <li class="main-list-item">4. </li>
                            <li class="main-list-item">5. </li>
                        </ul>
                    </div>
                </div>
            </div>
    
            <div class="main-notice">
                <div class="main-card">
                    <div class="main-card-header">
                        공지사항
                        <a href="#" class="main-more-btn">더보기</a>
                    </div>
                    <div class="main-card-body">
                        <ul class="main-list-group" id="MainNoticeDisplay">
                            <li class="main-list-item">1. </li>
                            <li class="main-list-item">2. </li>
                            <li class="main-list-item">3. </li>
                            <li class="main-list-item">4. </li>
                            <li class="main-list-item">5. </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    
        <!-- 자유게시판과 새로운 섹션을 같은 행에 배치 -->
        <div class="main-row main-new-section">
            <div class="main-popular-posts">
                <div class="main-card">
                    <div class="main-card-header">
                        중고장터
                        <a href="#" class="main-more-btn">더보기</a>
                    </div>
                    <div class="main-card-body">
                        <div class="main-image-grid">
                            <div class="main-image-item">
                                <img src="<c:url value="resources/images/crown.png"/>"  class="main-image">
                                <p class="main-image-title">상품 1</p>
                            </div>
                            <div class="main-image-item">
                                <img src="<c:url value="resources/images/gold.png"/>"  class="main-image">
                                <p class="main-image-title">상품 2</p>
                            </div>
                            <div class="main-image-item">
                                <img src="<c:url value="resources/images/rainbow.png"/>"  class="main-image">
                                <p class="main-image-title">상품 3</p>
                            </div>
                            <div class="main-image-item">
                                <img src="<c:url value="resources/images/silver.png"/>" class="main-image">
                                <p class="main-image-title">상품 4</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    
            <!-- 오른쪽에 추가될 새로운 섹션 -->
            <div class="main-new-board">
                <div class="main-card">
                    <div class="main-card-header">
                        새 게시판
                        <a href="#" class="main-more-btn">더보기</a>
                    </div>
                    <div class="main-card-body">
                        <ul class="main-list-group">
                            <li class="main-list-item">1. </li>
                            <li class="main-list-item">2. </li>
                            <li class="main-list-item">3. </li>
                            <li class="main-list-item">4. </li>
                            <li class="main-list-item">5. </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery-3.7.1.min.js'/>"></script>
	<script type="text/javascript">
    $(document).ready(function() {
        popularBoardList();
        NoticeBoardList();
        NewBoardList();
    });
    function popularBoardList() {	
    	 $.ajax({
    		type:"get",
    		url: "<c:url value='/rest/popular_side_board'/>",
    		dataType: "json",
    		success : function(result) {
    			var html="";
    			if(result.popularBoardList.length==0){
    			    html += " <li class='main-list-item '>인기글이 없습니다.</li>";
    			    return;
    			}else{
    				$(result.popularBoardList).each(function(index) {
    				html +="<li class='main-list-item '>"+(index+1)+". <a class='	' href='<c:url value='/board/boarddetail/"+this.boardCode+"/"+this.boardPostIdx+"'/>'>"+this.boardTitle+"</a> </li>";
    				});
    			}
    			$("#MainPopularDisplay").html(html);
    		},
    		error : function(xhr) {
    			alert("에러코드(게시글 검색) = " + xhr.status);
    		}
    	});
    	}
    
    function NewBoardList() {	
    	 $.ajax({
    		type:"get",
    		url: "<c:url value='/rest/main_board_view'/>",
    		dataType: "json",
    		success : function(result) {
    			var html="";
    			if(result.NewBoardList.length==0){
    			    html += " <li class='main-list-item '>글이 없습니다.</li>";
    			    return;
    			}else{
    				$(result.NewBoardList).each(function(index) {
    				html +="<li class='main-list-item '>"+(index+1)+". <a class='	' href='<c:url value='/board/boarddetail/"+this.boardCode+"/"+this.boardPostIdx+"'/>'>"+this.boardTitle+"</a> </li>";
    				});
    			}
    			$("#MainNewboardDisplay").html(html);
    		},
    		error : function(xhr) {
    			alert("에러코드(게시글 검색) = " + xhr.status);
    		}
    	});
    	}
    
    function NoticeBoardList() {  	
    	 $.ajax({
    		type:"get",
    		url: "<c:url value='/rest/main_board_notice'/>",
    		dataType: "json",
    		success : function(result) {
    			var html="";
    			if(result.NoticeBoardList.length==0){
    			    html += " <li class='main-list-item '>글이 없습니다.</li>";
    			    return;
    			}else{
    				$(result.NoticeBoardList).each(function(index) {
    				html +="<li class='main-list-item '>"+(index+1)+". <a class='	' href='<c:url value='/board/boarddetail/"+this.boardCode+"/"+this.boardPostIdx+"'/>'>"+this.boardTitle+"</a> </li>";
    				});
    			}
    			$("#MainNoticeDisplay").html(html);
    		},
    		error : function(xhr) {
    			alert("에러코드(게시글 검색) = " + xhr.status);
    		}
    	});
    	}
    </script>  
    
</body>