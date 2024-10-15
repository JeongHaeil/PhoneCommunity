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
<style>
<style>
/* 채팅창 전체 */
#chatWindow {
    position: fixed;
    bottom: 80px; /* 시스템 트레이보다 더 위로 올리기 위해 하단에서 80px 위로 */
    right: 20px;  /* 오른쪽에서 20px 띄우기 */
    width: 350px;
    height: 500px;
    border: 1px solid #ccc;
    background-color: white;
    z-index: 9999;
    display: none;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
}


  #messageInput {
    width: 80%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
  }

  #sendButton {
    padding: 10px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }

  #sendButton:hover {
    background-color: #0056b3;
  }
</style>
</head>
<body>
<sec:authentication property="principal" var="loginUser"/>
	


<div id="chatWindow" style="height: 400px; overflow-y: scroll; border: 1px solid #ccc; padding: 10px;">
    <!-- 여기에 메시지들이 추가됩니다 -->
</div>

<!-- 메시지 입력 및 전송 버튼 -->
<div style="margin-top: 10px;">
    <input type="text" id="messageInput" placeholder="메시지를 입력하세요" style="width: 80%; padding: 10px; border: 1px solid #ccc; border-radius: 5px;">
    <button id="sendButton" onclick="sendMessage()" style="padding: 10px; background-color: #007bff; color: white; border: none; border-radius: 5px;">전송</button>
</div>
	

 <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script> -->

<script>	

var socket;
$(document).ready(function () {
			

		 var loggedInUserId ="${loginUser.userId}"; //"${loginUser.userId}";  // 로그인한 사용자 (구매자) ID
		 //var sellerId = "${sellerId}"	//"${product.productUserid}";  // 판매자 ID (상품의 소유자)
		 var sellerId = "${sellerId}"	//"${product.productUserid}";  // 판매자 ID (상품의 소유자)
		 var buyerId = loggedInUserId;
		 var roomId = "${roomId}";  // 채팅방 ID (이미 생성된 채팅방의 ID)
		 // var roomId = 100;
		 
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
			 reconnectAttempts = 0; 
		};
		
		// WebSocket 메시지 수신 시
		socket.onmessage = function(event) {
			console.log("Received from WebSocket: " + event.data);
            var chatWindow = document.getElementById("chatWindow");
            var newMessage = document.createElement("p");
            newMessage.textContent = event.data;
            chatWindow.appendChild(newMessage);
            chatWindow.scrollTop = chatWindow.scrollHeight;
};
		
		// WebSocket 연결 종료 시
		socket.onclose = function() {
        console.log("WebSocket 연결이 닫혔습니다.");
       
    };
		
		// WebSocket 에러 처리
		socket.onerror = function(error) {
			console.error("WebSocket error: " + error);
		};
		
		 console.log("Room5 ID on 방번호.jsp: " + roomId); 
		 console.log("Room5 ID on 판매chat.jsp: " + sellerId); 
		 console.log("Room5 ID on 구매chat.jsp: " + buyerId); 
		 console.log("Room5 ID on 유저chat.jsp: " + loggedInUserId); 
		 
		 document.getElementById("messageInput").addEventListener("keydown", function(event) {	
			    if (event.key === "Enter") {
			      event.preventDefault();
			      sendMessage();
			    }
			});		
		 
		 $('#chatWindow').show(); // 페이지 로드 시 자동으로 채팅창을 보여줌

		  // X 버튼 클릭 시 채팅창 닫기
		  document.getElementById('closeChat').addEventListener('click', function() {
		    $('#chatWindow').hide(); // 채팅창 닫기
		  });
		 
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
				
function displayMessage(message, senderId) {
    var chatWindow = document.getElementById("chatWindow");

    // 새로운 div 태그 생성
    var messageElement = document.createElement("div");
    var messageText = document.createElement("span");

    messageText.textContent = message;
    messageText.style.padding = '10px';
    messageText.style.borderRadius = '10px';

    // 메시지 스타일 적용
    if (senderId === "${loginUser.userId}") {
        messageElement.style.textAlign = 'right';  // 내 메시지는 오른쪽 정렬
        messageText.style.backgroundColor = '#dcf8c6';  // 내 메시지 색상
        messageElement.appendChild(messageText);
    } else if (senderId === "${sellerId}") {
        messageElement.style.textAlign = 'left';  // 판매자의 메시지는 왼쪽 정렬
        messageText.style.backgroundColor = '#f1f0f0';  // 상대방 메시지 색상
        messageElement.appendChild(messageText);
    } else {
        messageElement.style.textAlign = 'left';  // 구매자의 메시지는 왼쪽 정렬
        messageText.style.backgroundColor = '#f1f0f0';  // 상대방 메시지 색상
        messageElement.appendChild(messageText);
    }

    // 메시지를 chatWindow에 추가
    chatWindow.appendChild(messageElement);
    
    // 스크롤을 최신 메시지로 이동
    chatWindow.scrollTop = chatWindow.scrollHeight;
}




</script>

		
</body>
</html>