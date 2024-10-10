<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<c:url value='/js/jquery-3.7.1.min.js'/>"></script>


</head>

<body>
	<h1>하이</h1>

<h2>채팅방 ID: ${roomId}</h2>
  <div id="chatMessages">
    <input type="text" id="messageInput" placeholder="메시지를 입력하세요">
    <button id="sendButton" onclick="sendMessage()">전송</button>
</div>
 

	

 <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script> -->
	
		

<script>		
$(document).ready(function () {
		//WebSocket 연결 변수 설정
		/* var loggedInUserId = "${sessionScope.userId}";
		var buyerId = loggedInUserId;  // 로그인한 사용자의 ID
		var sellerId = "${product.productUserid}";  // JSP에서 상품 판매자의 ID 값 가져오기
		var roomId = "${roomId}";
		 */
		 var loggedInUserId = "${loginUser.userId}";  // 로그인한 사용자 (구매자) ID
		 var sellerId = "${product.productUserid}";  // 판매자 ID (상품의 소유자)
		 var buyerId = loggedInUserId;
		 var roomId = "${roomId}";  // 채팅방 ID (이미 생성된 채팅방의 ID)
		
		 console.log("Room1 ID on chat.jsp: " + roomId);
		 createChatRoom();
		 function createChatRoom () {
				console.log("createChatRoom2  함수가 호출되었습니다.");  
				console.log("Room3 ID on chat.jsp: " + roomId);
				// Ajax 요청으로 채팅방 시작
				$.ajax({
					url: "${pageContext.request.contextPath}/chatroom/start",  // 요청 URL
					type: "POST",  // POST 방식
					contentType: "application/json",
					data: JSON.stringify({
						"roomId": roomId,
						"buyerId": loggedInUserId,
						
						"sellerId": sellerId  // 판매자 ID
					}),
					beforeSend: function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");  // CSRF 토큰 설정
					},
					success: function(response) {
						console.log("Chat room created successfully");
						window.location.href = "<c:url value="/chat/room/"/>" + roomId;  // 서버에서 반환된 roomId로 채팅방 이동
						//window.location.href = "${pageContext.request.contextPath}/chatroom/room/" + roomId;
					},
					error: function(xhr, status, error) {
						console.error("Error creating chat room: " + error);
					}
				});
			}  
		 console.log("Room4 ID on chat.jsp: " + roomId);
		// WebSocket 연결 설정
		var socket = new WebSocket("ws://localhost:8000/final/ws/chat/" + roomId + "?buyerId=" + buyerId + "&sellerId=" + sellerId + "&userId=" + loggedInUserId);
		
		// WebSocket 연결 성공 시
		socket.onopen = function() {
			console.log("WebSocket connection established.");
			document.getElementById("sendButton").disabled = false;  // 연결이 완료되면 전송 버튼 활성화
		};
		
		// WebSocket 메시지 수신 시
		socket.onmessage = function(event) {
			console.log("Received from WebSocket: " + event.data);
		};
		
		// WebSocket 연결 종료 시
		socket.onclose = function() {
			console.log("WebSocket connection closed. Trying to reconnect...");
		};
		
		// WebSocket 에러 처리
		socket.onerror = function(error) {
			console.error("WebSocket error: " + error);
		};
		
		// 메시지 전송 함수
		function sendMessage() {
			var message = document.getElementById('messageInput').value;
			
			if (socket.readyState === WebSocket.OPEN) {
				socket.send(message);
				console.log("Message sent via WebSocket: " + message);
			} else {
				console.error("WebSocket is not connected.");
			}
		}
		 console.log("Room5 ID on chat.jsp: " + roomId);
		
		 
	
});		
				

</script>

		
</body>
</html>