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

<div>
    <input type="text" id="message" placeholder="Enter your message" />
    <button onclick="sendMessage()">Send</button>
</div>



	
<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
		

<script>
//WebSocket 연결
var socket = new WebSocket("ws://localhost:8000/final/chat");
socket.onmessage = function(event) {
    console.log("Received from WebSocket: " + event.data);
};

// 메시지 전송
function sendMessage() {
    var message = document.getElementById('message').value;
    socket.send(message);
    console.log("Sent via WebSocket: " + message);
}


</script>

		
</body>
</html>