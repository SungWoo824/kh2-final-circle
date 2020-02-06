<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">   
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.addons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/layoutstyle.css">
     <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/common.css" />
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

	
<script>
	var enter = 0, exit = 1, message = 2;
	
	$(function(){
		
// 		페이지가 로딩되면 웹소켓 서버에 접속
		connect();

		//페이지를 나가기 전에 웹소켓 서버 접속을 종료
		$(window).on("beforeunload", function(){
			sendMessage(exit);
			window.socket.close();//종료코드
		});
		
		//전송버튼 처리
		$(".send-btn").click(function(){
			var chat_content = $(".user-input").val();//입력값을 불러오고
			if(!chat_content) return;//미입력시 중단
			sendMessage(message, chat_content);
			$(".user-input").val("");//입력창 초기화
		});
		
		//p태그 생성해서 본문에 추가
		function appendMessage(message){
			$("<p>").text(message).appendTo("#chat-content");
		}
		
// 		웹소켓 연결 함수
		function connect(){
			var host = location.host;
			var context = "${pageContext.request.contextPath}";
			var uri = "ws://"+host+context+"/topic";
			console.log(uri);

			window.socket = new WebSocket(uri);
			
// 			연결 시 예약 작업을 설정
			window.socket.onopen = function(){

				sendMessage(enter);
			};
			window.socket.onclose = function(){
				appendMessage("서버와 연결이 종료되었습니다");
			};
			window.socket.onmessage = function(e){
				appendMessage(e.data);
			};
			window.socket.onerror = function(){
				appendMessage("연결 오류가 발생했습니다");
			};
		}
		
// 		메시지 전송 함수
		function sendMessage(status, chat_content){
			var topic_no = ${param.topic_no};
			var message = {
				topic_no:topic_no,
				status:status,
				chat_content:chat_content
			};
			var value = JSON.stringify(message);
			window.socket.send(value);
		}
	});	
    <!--토픽생성-->
    $(function(){
        $('#topic-create').click(function(){
        	
  $('#topic-modal').show();
});
});
    
    $(function(){
		$("#toggle1").click(function(){
			$(".menu1-slide").toggle();
		});
		$("#toggle4").click(function(){
			$(".menu4-slide").toggle();
		});
	});
               
</script>

<style>
	#topic-create > a{
	cursor:pointer;
	}
	
	#topic-modal{
		display:none;
	}
</style>

</head>
<!-- <div class="container-scroller"> -->
<!--     </div>  -->
<div id="topic-modal">

	<div class="topic-modal-view">
		<h1>토픽 생성하기</h1>
		<form action="topic_create" method="post">
			이름 :<input type="text" name="topic_name"><br><br>
			공개여부 :<input type="radio" name="topic_confidential" value="1" checked="checked">비공개
							<input type="radio" name="topic_confidential" value="0" >공개<br><br>
			토픽 설명 :<textarea name="topic_explain" rows="" cols=""></textarea><br><br>
			<input type="submit" value="생성하기">
			<input type="button" value="닫기"> 
		</form>
	
	</div>

</div>

<div class="menu-wrap">
<div class="menu-con bg-base">
    <div class="menu-top">
        <ul class="menu-bar">
            <li class="gnb-btn">
                    <i class="fa fa-bars"></i>
            </li>
        </ul>
    </div>
    <div class="menu-bottom">
        <ul class="menu-bar">
             <li id="toggle1" class="gnb-btn menu1">
                <a class="fa fa-search"></a>
            </li>
            <li class="gnb-btn">
                <a class="fa fa-file"></a>
            </li>
            <li class="gnb-btn">
                <a class="fa fa-list-ul"></a>
            </li>
            <li id="toggle4" class="gnb-btn menu4">
                <a class="fa fa-check-square"></a>
            </li>
            <li class="gnb-btn">
                <a class="fa fa-plug"></a>
            </li>
            <li class="gnb-btn">
                <a class="fa fa-hdd"></a>
            </li>
        </ul>
    </div>
</div>
    </div>
<!-- partial -->

<div class="contents-wrap">
        <aside class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-top">
            <div class="brand-logo-wapper">
                <div class="dropdown">
                    <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">  
                        <div class="brand-topic-list" href="index.html">
                            <div class="navbar-brand">
                                <img src="${pageContext.request.contextPath}/resources/image/logo.png" alt="logo" />
                            </div>
                            <span class="brand-topic-name">test</span>
                            <i class="fa fa-caret-down" aria-hidden="true"></i>
                            </div>
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
                            <h6 class="dropdown-header">팀 리스트</h6>
                            <a class="dropdown-item" href="#">test</a>
                            <a class="dropdown-item" href="#">test2</a>
                            <a class="dropdown-item" href="#">test3</a>
                            <!-- <div class="dropdown-divider"></div> -->
                            <!-- <a class="dropdown-item" href="#">Separated link</a> -->
                        </div> 
                        </div>
                </div>
        </div>
        <!-- partial:partials/_sidebar.html -->
        <nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">
            <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/member/mypage">
                <i class="menu-icon typcn typcn-document-text"></i>
                <span class="menu-title">메인으로</span>
            </a>
            </li>
            <li class="nav-item" id="topic-create">
            	<a>
	                <i class="fa fa-plus"></i>
            	</a>
            </li>
            <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
                <span class="menu-title">토픽</span>
                <i class="menu-arrow fa fa-caret-down" aria-hidden="false"></i>
                <!-- <i class="menu-arrow fa fa-caret-down"></i> -->
            </a>
            
            <div class="collapse" id="ui-basic">
                <ul class="nav flex-column sub-menu">
                	<c:forEach items="${topicList}" var="topicDto">
                		<li class="nav-item">
		                    <a class="nav-link" href="pages/ui-features/buttons.html">topic_name = ${topicDto.topic_name}</a>
		                </li>
                	</c:forEach>
                </ul>
            </div>
            
            </li>
            <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#auth" aria-expanded="false" aria-controls="auth">
                <i class="menu-icon typcn typcn-document-add"></i>
                <span class="menu-title">채팅</span>
                <i class="menu-arrow fa fa-caret-down" aria-hidden="true"></i>
                <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="auth">
                <ul class="nav flex-column sub-menu">
                <li class="nav-item">
                    <a class="nav-link" href="pages/samples/blank-page.html">채팅</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="pages/samples/login.html"> test </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="pages/samples/register.html"> test </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="pages/samples/error-404.html"> test </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="pages/samples/error-500.html"> test </a>
                </li>
                </ul>
            </div>
            </li>
        </ul>
        </nav>

    </aside>
    <!-- partial -->
    
  
            <div class="chat-wrap">
            	<div class="chat-aside">
                    <div class="chat-menu-bar">
                        <div class="chat-img">
                            <div class="chat-img-bg">
                                <div></div>
                                <i class="fa fa-comment"></i>
                            </div>
                        </div>
                        <div class="chat-menu-center">
                            <div class="chat-menu-title">
                                <span>공지사항</span>
                            </div>
                            <div class="chat-menu-sub">
                                <span class="label">기본토픽</span>
                                <span>이 토픽은 모든 정회원이 자동으로 참여되며 나갈 수 없는 기본 토픽입니다. 정회원 모두에게 전달해야하는 내용을 전송할 수 있으며 준회원은 기본 토픽에 참여할 수 없습니다.</span>
                            </div>
                        </div>  
                        <div class="chat-menu-right">
                            <ul>
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                            </ul>
                        </div>
                    </div>
                    <article class="message-wrap">
                        <div class="message" style="text-align: right">
							<h1>웹소켓 클라이언트(with 로그인, ${param.topic_no} 번 방)</h1>
							
									<input type="text" class="user-input">
									<button class="send-btn" type="submit">보내기</button>
							
									<div id="chat-content"></div>
						</div>
					</article>
				</div>
				
					<div id="gnb-detail-slide">
			            <div class ="menu1-slide">d</div>
			            <div class="menu4-slide"><a href="create">+투표 만들기</a></div>
			        </div>
			        
            </div>
            <!-- Page Title Header Ends-->
           
        </div> 
        
        <!-- main-panel ends -->
      <!-- page-body-wrapper ends -->
    <script src="${pageContext.request.contextPath}/resources/js/design/vendor.bundle.base.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/design/vendor.bundle.addons.js"></script>
    

</div>

 </html>

