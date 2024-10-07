<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<c:url value='/js/jquery-3.7.1.min.js'/>"></script>
<style type="text/css">
/* 채팅창 전체 */
#chatWindow {
    position: fixed;
    bottom: 120px; /* 시스템 트레이 위에 띄우기 위해 하단에서 40px 위로 */
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

/* 채팅창 상단(헤더) */
#chatHeader {
    background-color: #343a40;
    color: white;
    padding: 10px;
    border-radius: 10px 10px 0 0;
    display: flex;
    justify-content: space-between;
    align-items: center;
    cursor: move;
}

/* 채팅창 닫기 버튼 */
#closeChat {
    background-color: transparent;
    border: none;
    color: white;
    font-size: 16px;
    cursor: pointer;
}

/* 채팅 메시지 표시 영역 */
#chatBox {
    height: 400px;
    padding: 10px;
    overflow-y: auto;
    background-color: #f8f8f8;
}

/* 채팅창 하단(입력 및 전송 버튼) */
#chatFooter {
    padding: 10px;
    border: 1px solid #ccc;
    background-color: #fff;
    display: flex;
    justify-content: space-between;
}

#messageInput {
    width: 80%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 20px;
}

#sendButton {
    width: 15%;
    padding: 10px;
    margin-left: 5px;
    background-color: #343a40;
    color: white;
    border: none;
    border-radius: 20px;
    cursor: pointer;
}

</style>

</head>

<body>
	<!-- <div>
	    <input type="text" id="messageInput" placeholder="Enter your message">
	    <button id="sendButton">Send</button>
	</div>

	<div id="chatBox" style="border: 1px solid black; width: 400px; height: 200px; overflow-y: scroll;"></div> -->


<div id="chatWindow">
    <div id="chatHeader">
        <span>1:1 채팅방</span>
        <button id="closeChat">&times;</button>
    </div>
    <div id="chatBox">
        <!-- 채팅 메시지가 여기에 표시됩니다 -->
    </div>
    <div id="chatFooter">
        <input type="text" id="messageInput" placeholder="메시지를 입력하세요...">
        <button id="sendButton">전송</button>
    </div>
</div>



	
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/atmosphere/2.3.0/atmosphere.min.js"></script>

<script type="text/javascript">

  $(document).ready(function () {
	 
	    var socket = atmosphere;
	    var request = {
	        url: "<c:url value="/chat/websockets"/>",  // WebSocket 연결 경로
	        contentType: "application/json",
	        transport: "websocket",  // WebSocket 사용
	        fallbackTransport: "long-polling",  // WebSocket을 지원하지 않으면 long-polling으로 폴백
	        trackMessageLength: true,
	        reconnectInterval: 5000,
	        beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
	    };

				  /*
			var socket = new WebSocket(socketUrl);  // 일반 WebSocket 사용
			
			// CSRF 토큰을 input[type="hidden"]에서 가져옴
			var csrfToken = $('input[name="_csrf"]').val();
			
			// WebSocket 연결 성공 시
			socket.onopen = function () {
			    console.log("WebSocket 연결 성공");
			};
			
			// WebSocket으로부터 메시지를 수신했을 때
			socket.onmessage = function (event) {
			    var message = event.data;  // 수신한 메시지
			    console.log("Message received: " + message);
			
			    // 채팅 박스에 받은 메시지 추가
			    $('#chatBox').append('<div>' + message + '</div>');
			
			    // 스크롤을 맨 아래로 자동으로 내리기
			    $('#chatBox').scrollTop($('#chatBox')[0].scrollHeight);
			};
			
			// WebSocket 연결이 닫혔을 때
			socket.onclose = function () {
			    console.log("WebSocket 연결 종료");
			};
			
			// WebSocket에서 에러가 발생했을 때
			socket.onerror = function () {
			    console.error("WebSocket 연결 오류 발생");
			};
			
			// Send 버튼 클릭 시 메시지 전송
			$('#sendButton').click(function () {
			    var message = $('#messageInput').val();  // 입력한 메시지 가져오기
			
			    if (message.trim() !== '' && socket.readyState === WebSocket.OPEN) {
			        // 서버로 메시지 전송 (JSON 형식으로 전송)
			        socket.send(JSON.stringify({
			            message: message,
			            csrfToken: csrfToken  // CSRF 토큰도 함께 전송
			        }));
			
			        // 입력창 비우기
			        $('#messageInput').val('');
			    } else {
			        console.error("WebSocket이 아직 연결되지 않았습니다.");
			    }
			});
			*/
			
		    var subSocket;

		    // 구독 함수
		    subSocket = socket.subscribe(request);

		    // 메시지를 받을 때 호출되는 콜백 함수
		    subSocket.onMessage = function (response) {
		        console.log("Message received: " + response.responseBody);
		        if (messageData.sender === 'server') {
		            // 받은 메시지를 chatBox에 추가
		            $('#chatBox').append('<div>' + messageData.message + '</div>');

		            // 채팅 박스를 맨 아래로 스크롤
		            $('#chatBox').scrollTop($('#chatBox')[0].scrollHeight);
		        }
		        
		    };

		    // 연결 성공 시 호출되는 콜백 함수
		    subSocket.onOpen = function (response) {
		        console.log("WebSocket 연결 성공");
		    };

		    // 연결 오류 시 호출되는 콜백 함수
		    subSocket.onError = function (response) {
		        console.error("WebSocket 연결 오류 발생: " + response.reasonPhrase);
		    };

		    // 연결 종료 시 호출되는 콜백 함수
		    subSocket.onClose = function (response) {
		        console.log("WebSocket 연결 종료");
		    };
			
		    $('#sendButton').click(function () {
		        var message = $('#messageInput').val();  // 입력한 메시지 가져오기
		        var csrfToken = $('input[name="_csrf"]').val();  // CSRF 토큰 가져오기

		        if (message.trim() !== '' && subSocket) {
		            // 서버로 메시지 전송 (JSON 형식으로 전송)
		            subSocket.push(JSON.stringify({
		                message: message,
		                csrfToken: csrfToken,
		                sender: 'client'  // 보낸 사람 정보 추가
		            }));

		            // 입력창 비우기
		            $('#messageInput').val('');

		            // 보낸 메시지를 chatBox에 추가 (클라이언트가 보낸 메시지 표시)
		            $('#chatBox').append('<div style="text-align: right;">' + message + '</div>');

		            // 채팅 박스를 맨 아래로 스크롤
		            $('#chatBox').scrollTop($('#chatBox')[0].scrollHeight);
		        } else {
		            console.error("메시지를 전송할 수 없습니다.");
		        }
		    });
		    
		    
	});
		            $(document).ready(function() {
		                $('#chatWindow').show(); // 페이지 로드 시 자동으로 채팅창을 보여줌

		                // X 버튼 클릭 시 채팅창 닫기
		                document.getElementById('closeChat').addEventListener('click', function() {
		                  $('#chatWindow').hide(); // 채팅창 닫기
		                });
		                
		                document.getElementById('messageInput').addEventListener('keydown', function(event) {
		                    if (event.key === 'Enter') {
		                      event.preventDefault(); // 기본 Enter 동작 방지 (새 줄 삽입 방지)
		                      document.getElementById('sendButton').click(); // 전송 버튼 클릭
		                    }
		                  });
		                
		              });

		              // 드래그 앤 드롭 기능 추가
		              dragElement(document.getElementById("chatWindow"));

		              function dragElement(elmnt) {
		                var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
		                if (document.getElementById("chatHeader")) {
		                  // chatHeader 요소에서 드래그가 가능하도록 설정
		                  document.getElementById("chatHeader").onmousedown = dragMouseDown;
		                }

		                function dragMouseDown(e) {
		                  e = e || window.event;
		                  e.preventDefault();
		                  // 마우스 커서 위치를 가져옴
		                  pos3 = e.clientX;
		                  pos4 = e.clientY;
		                  document.onmouseup = closeDragElement;
		                  // 마우스 움직임을 트래킹
		                  document.onmousemove = elementDrag;
		                }

		                function elementDrag(e) {
		                  e = e || window.event;
		                  e.preventDefault();
		                  // 새 마우스 위치를 계산
		                  pos1 = pos3 - e.clientX;
		                  pos2 = pos4 - e.clientY;
		                  pos3 = e.clientX;
		                  pos4 = e.clientY;
		                  // 채팅창의 새 위치 설정
		                  elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
		                  elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
		                }

		                function closeDragElement() {
		                  // 마우스 버튼을 떼면 트래킹 종료
		                  document.onmouseup = null;
		                  document.onmousemove = null;
		                }
		              }
  
  
</script>
		
</body>
</html>