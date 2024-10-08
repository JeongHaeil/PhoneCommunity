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
 

	
 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
		

<script>		
					




				//WebSocket 연결
				var socket = new WebSocket("ws://localhost:8000/final/chat");
				socket.onmessage = function(event) {
				    console.log("Received from WebSocket: " + event.data);
				};
				//WebSocket 메시지 수신
				socket.onmessage = function(event) {
				    console.log("Received from WebSocket: " + event.data);
				};
				socket.onopen = function() {
				    console.log("WebSocket connection established.");
				    document.getElementById("sendButton").disabled = false;  // 연결이 완료되면 전송 버튼 활성화
				};
				
				
				

				// WebSocket 연결 종료 시
				socket.onclose = function() {
				    console.log("WebSocket connection closed. Trying to reconnect...");
				 

				};
				
				// WebSocket 에러 처리
				socket.onerror = function(error) {
				    console.error("WebSocket error: " + error);
				};
				
				function sendMessage() {
				    var message = document.getElementById('messageInput').value;
				    
				    if (socket.readyState === WebSocket.OPEN) {
				        socket.send(message);
				        console.log("Message sent via WebSocket: " + message);
				    } else {
				        console.error("WebSocket is not connected.");
				    }
				}


</script>

		
</body>
</html>