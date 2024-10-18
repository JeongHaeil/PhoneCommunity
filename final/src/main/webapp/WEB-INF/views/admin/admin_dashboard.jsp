<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .custom-bg { background-color: #f8f9fa; }
        .custom-container { max-width: 1200px; }
        .custom-card { border: none; box-shadow: 0 0 15px rgba(0,0,0,0.1); }
        .custom-table { border-collapse: separate; border-spacing: 0; }
        .custom-table th, .custom-table td { white-space: nowrap; padding: 15px; vertical-align: middle; }
        .custom-table thead th { background-color: #343a40; color: white; font-weight: 600; text-transform: uppercase; }
        .custom-table tbody tr:nth-child(even) { background-color: #f8f9fa; }
        .custom-btn {
            white-space: nowrap;
            border: 1px solid #343a40;
            color: #343a40;
            background-color: transparent;
            transition: all 0.3s ease;
            margin: 2px;
            padding: 5px 10px;
        }
        .custom-btn:hover { background-color: #343a40; color: white; }
        .custom-pagination .page-item.active .page-link { background-color: #343a40; border-color: #343a40; }
        .custom-pagination .page-link { color: #343a40; }
        .custom-pagination .page-link:hover { background-color: #343a40; color: white; }
        .custom-primary-btn { background-color: #343a40; border-color: #343a40; color: white; }
        .custom-primary-btn:hover { background-color: #23272b; border-color: #23272b; }
        .custom-form-focus:focus { border-color: #343a40; box-shadow: 0 0 0 0.2rem rgba(52, 58, 64, 0.25); }
        .custom-title { color: #343a40; font-weight: bold; }
        .ellipsis {
            max-width: 100px; 
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .nav-tabs .nav-link { color: #343a40; }
        .nav-tabs .nav-link.active { color: #343a40; font-weight: bold; }
        
        /* 새로 추가된 스타일 */
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        .dashboard-container {
            display: flex;
            flex-direction: column;
            height: 100vh;
            overflow: hidden;
        }
        .dashboard-header {
            flex: 0 0 auto;
            padding: 20px 0;
        }
        .dashboard-content {
            flex: 1 1 auto;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        .tab-content {
            flex: 1;
            overflow: hidden;
        }
        .tab-pane {
            height: 100%;
            overflow-y: auto;
        }
    </style>
</head>
<body class="custom-bg">
    <div class="dashboard-container">
        <div class="dashboard-header">
            <h1 class="mb-4 custom-title text-center">관리자 대시보드</h1>
            
            <ul class="nav nav-tabs mb-4" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="spam-tab" data-bs-toggle="tab" data-bs-target="#spam" type="button" role="tab" aria-controls="spam" aria-selected="true">스팸 게시판</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="users-tab" data-bs-toggle="tab" data-bs-target="#users" type="button" role="tab" aria-controls="users" aria-selected="false">사용자 목록</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="suggestions-tab" data-bs-toggle="tab" data-bs-target="#suggestions" type="button" role="tab" aria-controls="suggestions" aria-selected="false">건의 게시글</button>
                </li>
            </ul>
        </div>
        
        <div class="dashboard-content">
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="spam" role="tabpanel" aria-labelledby="spam-tab">
                    <!-- 스팸 게시판 내용 -->
                </div>
                <div class="tab-pane fade" id="users" role="tabpanel" aria-labelledby="users-tab">
                    <!-- 사용자 목록 내용 -->
                </div>
                <div class="tab-pane fade" id="suggestions" role="tabpanel" aria-labelledby="suggestions-tab">
                    <!-- 건의 게시글 내용 -->
                    <p>새로운 탭을 확인해 주세요</p>
                    <p>만약 탭이 생기지 않는다면 팝업 차단을 해제하세요</p>
                </div>
            </div>
        </div>
    </div>

    <script>
	    function openSuggestBoardList() {
	        // '/board/boardlist/3' 경로로 이동
	        window.open('<c:url value="/board/boardlist/3"/>', '_blank');
	    }
	    
        function loadContent(url, targetId, page, search, keyword) {
            $.ajax({
                url: url,
                type: 'GET',
                data: { 
                    pageNum: page,
                    search: search,
                    keyword: keyword
                },
                success: function(response) {
                    $('#' + targetId).html(response);
                },
                error: function(xhr, status, error) {
                    console.error("Error loading content:", error);
                }
            });
        }

        function loadSpamBoard(page, search, keyword) {
            loadContent('<c:url value="/super_admin/admin/ajax"/>', 'spam', page, search, keyword);
            // 현재 페이지 번호를 로컬 스토리지에 저장
            localStorage.setItem('currentSpamBoardPage', page);
        }

        function loadUserList(page, search, keyword) {
            loadContent('<c:url value="/super_admin/userList/ajax"/>', 'users', page, search, keyword);
        }

        // URL 해시가 변경될 때 실행되는 함수
        $(window).on('hashchange', function() {
            var hash = window.location.hash;
            if (hash.startsWith('#spam')) {
                $('#spam-tab').tab('show');
                var params = new URLSearchParams(hash.split('?')[1]);
                var prevPage = params.get('page') || localStorage.getItem('currentSpamBoardPage') || 1;
                loadSpamBoard(prevPage, '', '');
            }
        });

        // 페이지 로드 시 실행
        $(document).ready(function() {
            loadSpamBoard(1, '', '');
            
            // 탭 클릭 이벤트
            $('#myTab button').on('click', function (e) {
                e.preventDefault();
                $(this).tab('show');
                var target = $(this).data('bs-target');
                if (target === '#spam') {
                    loadSpamBoard(1, '', '');
                } else if (target === '#users') {
                    loadUserList(1, '', '');
                } else if (target === '#suggestions') {
                	openSuggestBoardList();
                }
            });
            
        	// URL에 #spam이 있으면 스팸 탭을 보여주고 이전 페이지를 로드
            if (window.location.hash.startsWith('#spam')) {
                $('#spam-tab').tab('show');
                var params = new URLSearchParams(window.location.hash.split('?')[1]);
                var prevPage = params.get('page') || localStorage.getItem('currentSpamBoardPage') || 1;
                loadSpamBoard(prevPage, '', '');
            }
        });

        // 페이징 처리를 위한 이벤트 위임
        $(document).on('click', '.pagination a', function(e) {
            e.preventDefault();
            var page = $(this).data('page');
            var tabId = $(this).closest('.tab-pane').attr('id');
            var search = $(this).closest('.card').find('select[name="search"]').val();
            var keyword = $(this).closest('.card').find('input[name="keyword"]').val();
            if (tabId === 'spam') {
                loadSpamBoard(page, search, keyword);
            } else if (tabId === 'users') {
                loadUserList(page, search, keyword);
            }
        });

        // 검색 폼 제출 이벤트
        $(document).on('submit', '#searchForm', function(e) {
            e.preventDefault();
            var tabId = $(this).closest('.tab-pane').attr('id');
            var search = $(this).find('select[name="search"]').val();
            var keyword = $(this).find('input[name="keyword"]').val();
            if (tabId === 'spam') {
                loadSpamBoard(1, search, keyword);
            } else if (tabId === 'users') {
                loadUserList(1, search, keyword);
            }
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
