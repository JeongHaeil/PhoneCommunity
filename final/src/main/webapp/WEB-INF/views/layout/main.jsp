<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.card-header{
    display: flex;
    justify-content:space-between;
    align-items: center;
}
body{
	font-size: 16px;
}
</style>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사이트 UI</title>
    <!-- 부트스트랩 추가 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
</head>
<body>

    <div class="container mt-5 main_container">
       
        <div class="row main_row">
            <div class="col-md-4 main_shopping_info">
                <div class="card main_card">
                    <div class="card-header main_card_header">
                        최신글
                        <a href="#" class="btn btn-link main_more_btn">더보기</a>
                    </div>
                    <div class="card-body main_card_body">
                        <ul class="list-group main_list_group">
                            <li class="list-group-item main_list_item">1. 구뜨꾸뜨</li>
                            <li class="list-group-item main_list_item">2. 아이스아메리카노</li>
                            <li class="list-group-item main_list_item">3. 아이폰</li>
                            <li class="list-group-item main_list_item">4. 전자담배</li>
                            <li class="list-group-item main_list_item">5. 화이팅</li>
                        </ul>
                    </div>
                   
                </div>
            </div>
            <div class="col-md-4 main_community">
                <div class="card main_card">
                    <div class="card-header main_card_header">
                        인기글
                        <a href="#" class="btn btn-link main_more_btn">더보기</a>
                    </div>
                    <div class="card-body main_card_body">
                        <ul class="list-group main_list_group">
                            <li class="list-group-item main_list_item">1. 취업하자</li>
                            <li class="list-group-item main_list_item">2. 2</li>
                            <li class="list-group-item main_list_item">3. 3</li>
                            <li class="list-group-item main_list_item">4. 4</li>
                            <li class="list-group-item main_list_item">5. 5</li>
                        </ul>
                    </div>
                    
                </div>
            </div>
            <div class="col-md-4 main_notice">
                <div class="card main_card">
                    <div class="card-header main_card_header">
                        공지사항
                        <a href="#" class="btn btn-link main_more_btn">더보기</a>
                    </div>
                    <div class="card-body main_card_body">
                        <ul class="list-group main_list_group">
                            <li class="list-group-item main_list_item">1.1</li>
                            <li class="list-group-item main_list_item">2. 2</li>
                            <li class="list-group-item main_list_item">3. 3</li>
                            <li class="list-group-item main_list_item">4. 32</li>
                            <li class="list-group-item main_list_item">5. 123</li>
                        </ul>
                    </div>
                   
                </div>
            </div>
        </div>

        


        <div class="row mt-4 main_new_section">
            <div class="col-md-4 main_popular_posts">
                <div class="card main_card">
                    <div class="card-header main_card_header">
                        자유게시판
                        <a href="#" class="btn btn-link main_more_btn">더보기</a>
                    </div>
                    <div class="card-body main_card_body">
                        <ul class="list-group main_list_group">
                            <li class="list-group-item main_list_item">1. ㅎㅎ</li>
                            <li class="list-group-item main_list_item">2.ㅎㅎ</li>
                            <li class="list-group-item main_list_item">3. ㄴㄴ</li>
                            <li class="list-group-item main_list_item">4. ㅇㅇ</li>
                            <li class="list-group-item main_list_item">5. 222</li>
                        </ul>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>
	
    <!-- 부트스트랩 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery-3.7.1.min.js'/>"></script>
    
</body>