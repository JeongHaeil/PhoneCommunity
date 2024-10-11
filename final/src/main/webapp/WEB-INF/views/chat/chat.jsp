<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<c:url value='/js/jquery-3.7.1.min.js'/>"></script>


</head>

<body>
<sec:authentication property="principal" var="loginUser"/>
	

<h2>채팅방 ID: ${roomId}</h2>

<h2>구매자 ID: ${buyerId}</h2>
<h2>판매자 ID: ${sellerId}</h2>
<div id="chatWindow" style="height: 400px; overflow-y: scroll; border: 1px solid #ccc; padding: 10px;">
    <!-- 여기에 메시지들이 추가됩니다 -->
</div>

<!-- 메시지 입력 및 전송 -->
<div style="margin-top: 10px;">
    <input type="text" id="messageInput" placeholder="메시지를 입력하세요" style="width: 80%;">
    <button id="sendButton" onclick="sendMessage()">전송</button>
</div>
	

 <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script> -->
	
		

<script>	
var socket;
$(document).ready(function () {
	
		 var loggedInUserId ="${loginUser.userId}"; //"${loginUser.userId}";  // 로그인한 사용자 (구매자) ID
		 var sellerId = "${sellerId}"	//"${product.productUserid}";  // 판매자 ID (상품의 소유자)
		 var buyerId = loggedInUserId;
		 var roomId = "${roomId}";  // 채팅방 ID (이미 생성된 채팅방의 ID)
		 
		 console.log("Buyer ID: " + buyerId);
		 console.log("Seller ID: " + sellerId);
		 console.log("Room ID: " + roomId);

		// WebSocket 연결 설정  + "&userId=" + loggedInUserId
		socket = new WebSocket("ws://localhost:8000/final/ws/chat/" + roomId + "?roomId=" + roomId +  "&buyerId=" + buyerId + "&sellerId=" + sellerId + "&userId=" + loggedInUserId);
		console.log("WebSocket 연결 시 URL: ws://localhost:8000/final/ws/chat/" + roomId + "?roomId=" + roomId +  "&buyerId=" + buyerId + "&sellerId=" + sellerId + "&userId=" + loggedInUserId);
		// WebSocket 연결 성공 시
		socket.onopen = function() {
			console.log("WebSocket connection established.");
			document.getElementById("sendButton").disabled = false;  // 연결이 완료되면 전송 버튼 활성화
		};
		
		// WebSocket 메시지 수신 시
		socket.onmessage = function(event) {
	    console.log("Received from WebSocket: " + event.data);
	    var chatMessages = document.getElementById("chatMessages");
	    var newMessage = document.createElement("p");
	    newMessage.textContent = event.data;
	    chatMessages.appendChild(newMessage);  // 메시지를 채팅창에 추가
};
		
		// WebSocket 연결 종료 시
		socket.onclose = function() {
			console.log("WebSocket connection closed. Trying to reconnect...");
		};
		
		// WebSocket 에러 처리
		socket.onerror = function(error) {
			console.error("WebSocket error: " + error);
		};
		
		 console.log("Room5 ID on 방번호.jsp: " + roomId); 
		 console.log("Room5 ID on 판매chat.jsp: " + sellerId); 
		 console.log("Room5 ID on 구매chat.jsp: " + buyerId); 
		 console.log("Room5 ID on 유저chat.jsp: " + loggedInUserId); 
});		
		
// 메시지 전송 함수
function sendMessage() {
    var message = document.getElementById("messageInput").value;
    
    if (socket.readyState === WebSocket.OPEN) {
        socket.send(message);
        console.log("Message sent via WebSocket: " + message);
        displayMessage(message, 'self');  // 내가 보낸 메시지를 화면에 표시
        document.getElementById("messageInput").value = "";  // 입력란 초기화
    } else {
        console.error("WebSocket is not connected.");
    }
}
				
//화면에 메시지를 표시하는 함수
function displayMessage(message, sender) {
    var chatWindow = document.getElementById("chatWindow");

    // 새로운 div 태그 생성
    var messageElement = document.createElement("div");
    
    // 메시지 스타일 적용
    if (sender === 'self') {
        messageElement.style.textAlign = 'right';  // 내 메시지는 오른쪽 정렬
        messageElement.style.backgroundColor = '#dcf8c6';
    } else {
        messageElement.style.textAlign = 'left';  // 다른 사람의 메시지는 왼쪽 정렬
        messageElement.style.backgroundColor = '#f1f0f0';
    }

    messageElement.style.margin = '5px';
    messageElement.style.padding = '10px';
    messageElement.style.borderRadius = '10px';
    messageElement.style.display = 'inline-block';
    messageElement.style.maxWidth = '80%';

    messageElement.textContent = message;  // 메시지 내용 설정

    // 메시지를 chatWindow에 추가
    chatWindow.appendChild(messageElement);
    
    // 스크롤을 최신 메시지로 이동
    chatWindow.scrollTop = chatWindow.scrollHeight;
}
</script>

		
</body>
</html>