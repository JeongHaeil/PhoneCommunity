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
/* 채팅 메시지가 표시되는 영역 */
.chatmessage {
  
  max-width: 500px;
  margin: 0 ;
  padding: 10px;
  height: 501px; /* 고정 높이 */
 resize: none;  
  background-color: #cfcbcb;
  overflow-y: auto; /* 메시지가 많아질 경우 스크롤 */
  border-radius: 10px 10px 0 0;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* 입력창과 버튼 영역 */
.chatbtn {
  
  max-width: 500px;
  margin: 0 ;
  display: flex;
  padding: 10px;
 
  border-radius: 0 0 10px 10px;
  background-color: #cfcbcb;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* 채팅 입력창 스타일 */
.chat-input {
  flex: 1;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  margin-right: 10px;
  resize: none; 
  
}

/* 보내기 버튼 스타일 */
.chat-send-btn {
  padding: 10px 20px;
  background-color: #8a929b;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.chat-send-btn:hover {
  background-color: #0056b3;
}

/* 메시지가 채팅창에 표시될 때 스타일 */
.chat-message {
  padding: 8px 12px;
  margin: 5px 0;
  border-radius: 8px;
  background-color: #e2f7d5;
  max-width: 80%;
}

</style>
</head>
<body>
<sec:authentication property="principal" var="loginUser"/>
	

  <div class="chatmessage" id="chatWindow">
    <!-- 채팅 메시지들이 여기에 표시됩니다 -->
  </div>
  <div class="chatbtn">
    <input type="text" id="messageInput" class="chat-input" placeholder="메시지 입력...">
    <button id="sendButton" class="chat-send-btn">보내기</button>
</div>


 <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script> -->

<script>	
var socket;
var reconnectAttempts = 0;
var maxReconnectAttempts = 5;  // 최대 재연결 시도 횟수



$(document).ready(function () {
	
    if (socket && socket.readyState === WebSocket.OPEN) {
        socket.close();
        console.log("기존 WebSocket 연결을 닫습니다.");
    }

    var loggedInUserId = "${loginUser.userId}";
    var sellerId = "${sellerId}";
    var buyerId = loggedInUserId;
    var roomId = "${roomId}";

    console.log("Buyer ID: " + buyerId);
    console.log("Seller ID: " + sellerId);
    console.log("Room ID: " + roomId);

    // WebSocket 연결 설정
    connectWebSocket(roomId, buyerId, sellerId, loggedInUserId);

    // 메시지 입력 시 Enter 키를 눌렀을 때 메시지 전송
    var messageInput = document.getElementById("messageInput");
    if (messageInput) {
        messageInput.addEventListener("keydown", function (event) {
            if (event.key === "Enter") {
                event.preventDefault();
                sendMessage();
            }
        });
    }

    // 전송 버튼 클릭 시 메시지 전송
    var sendButton = document.getElementById("sendButton");
    if (sendButton) {
        sendButton.addEventListener("click", function () {
            sendMessage();
        });
    }

    // X 버튼 클릭 시 채팅창 닫기
    var closeChatButton = document.getElementById("closeChat");
    if (closeChatButton) {
        closeChatButton.addEventListener("click", function () {
            $('#chatWindow').hide(); // 채팅창 닫기
        });
    }
});

// WebSocket 연결 함수
function connectWebSocket(roomId, buyerId, sellerId, loggedInUserId) {
    socket = new WebSocket("ws://localhost:8000/final/ws/chat/" + roomId + "?roomId=" + roomId + "&buyerId=" + buyerId + "&sellerId=" + sellerId + "&userId=" + loggedInUserId);
    
    socket.onopen = function () {
        console.log("WebSocket connection established.");
        document.getElementById("sendButton").disabled = false;
        reconnectAttempts = 0;
    };
    
    socket.onmessage = function (event) {
        var data = JSON.parse(event.data);
        var message = data.message;
        var senderId = data.senderId;

        // 자신이 보낸 메시지를 다시 수신하면 무시
        if (senderId !== "${loginUser.userId}") {
            displayMessage(message, senderId);
        }
    };
    
    socket.onclose = function () {
        console.log("WebSocket 연결이 닫혔습니다.");
        if (reconnectAttempts < maxReconnectAttempts) {
            setTimeout(function () {
                console.log("WebSocket 재연결을 시도합니다.");
                reconnectAttempts++;
                connectWebSocket(roomId, buyerId, sellerId, loggedInUserId);  // 재연결 시도
            }, 1000);
        } else {
            console.log("최대 재연결 시도 횟수를 초과했습니다.");
        }
    };

    socket.onerror = function (error) {
        console.error("WebSocket error: " + error);
    };
}

// 메시지 전송 함수
function sendMessage() {
    var message = document.getElementById("messageInput").value;
    
    if (socket.readyState === WebSocket.OPEN) {
        var payload = {
            message: message,
            senderId: "${loginUser.userId}"
        };
        socket.send(JSON.stringify(payload));  // 메시지를 JSON 형식으로 전송
        console.log("Message sent via WebSocket: " + message);
        displayMessage(message, 'self');  // 내가 보낸 메시지는 화면에 표시
        document.getElementById("messageInput").value = "";  // 입력란 초기화
    } else {
        console.error("WebSocket is not connected. 재연결 시도 중...");
        // 재연결 시도
        reconnectWebSocket();
    }
}

// 메시지를 화면에 표시하는 함수
function displayMessage(message, senderId) {
	
	var loggedInUserId = "${loginUser.userId}";  // 서버에서 전달된 로그인 사용자 ID
    var sellerId = "${sellerId}";  // 서버에서 전달된 판매자 ID
	var buyerId=loggedInUserId;
    var chatWindow = document.getElementById("chatWindow");
    // 새로운 div 태그 생성
    var messageElement = document.createElement("div");
    var messageText = document.createElement("span");

    messageText.textContent = message;
    messageText.style.padding = '10px';
    messageText.style.borderRadius = '10px';

    // 메시지 스타일 적용
   if (senderId === "${sellerId}") {
        // 현재 로그인한 사용자가 메시지를 보낸 경우 (구매자 또는 판매자 본인)
        messageElement.style.textAlign = 'right';  // 내 메시지는 오른쪽 정렬
        messageText.style.backgroundColor = '#dcf8c6';  // 내 메시지 색상
    } else if (senderId === "${sellerId}" && buyerId !== sellerId) {
        // 판매자가 메시지를 보낸 경우
        messageElement.style.textAlign = 'left';  // 판매자의 메시지는 왼쪽 정렬
        messageText.style.backgroundColor = '#f1f0f0';  // 판매자 메시지 색상
    } else if (senderId === buyerId && loggedInUserId !== buyerId) {
        // 구매자가 메시지를 보낸 경우
        messageElement.style.textAlign = 'left';  // 구매자의 메시지는 왼쪽 정렬
        messageText.style.backgroundColor = '#f1f0f0';  // 구매자 메시지 색상
    }
    messageElement.style.margin = '25px 0';

    messageElement.appendChild(messageText);
    
    // 메시지를 chatWindow에 추가
    chatWindow.appendChild(messageElement);
    
    // 스크롤을 최신 메시지로 이동
    chatWindow.scrollTop = chatWindow.scrollHeight;
}


document.getElementById('sendButton').addEventListener('click', function() {
    var messageInput = document.getElementById("messageInput").value;
    if (messageInput.trim() !== '') {
        var chatWindow = document.getElementById("chatWindow");

        // 메시지 엘리먼트 생성
        var messageElement = document.createElement("div");
        messageElement.classList.add('chat-message', 'self'); // 본인 메시지 스타일
        messageElement.textContent = messageInput;

        chatWindow.appendChild(messageElement); // 메시지 추가
        document.getElementById("messageInput").value = ''; // 입력란 초기화
        chatWindow.scrollTop = chatWindow.scrollHeight; // 최신 메시지로 스크롤 이동
    }
});



</script>

		
</body>
</html>