<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
 
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">   
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.addons.css">

	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/layoutstyle.css">
    <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/common.css" />
    
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

	
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
		
		
		$('.user-input').keydown(function(e) {
		    if (e.keyCode == 13) {
		    	var chat_content = $(".user-input").val();//입력값을 불러오고
				if(!chat_content) return;//미입력시 중단
				sendMessage(message, chat_content);
				$(".user-input").val("");//입력창 초기화
		    }
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
			$("<p>").text(message.chat_content).appendTo("#chat-content");
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
				//db에 대화내용들 저장
				sendMessage(enter);
			};
			window.socket.onclose = function(){
				//db에 대화 내용들 저장
				appendMessage("서버와 연결이 종료되었습니다");
			};
			window.socket.onmessage = function(e){
				var msg = JSON.parse(e.data);
				console.log(msg);
				var ptopic_no = ${param.topic_no};
				if(ptopic_no==msg.topic_no && msg.status==2){
				appendMessage(msg);
				}
				if(ptopic_no!=msg.topic_no){
					var topic_no = msg.topic_no;
					var count = $('.'+topic_no).text();
					count *=1;
					count++;
					$('.'+topic_no).text(count);
				}
			};
			
			window.socket.onerror = function(){
				appendMessage("연결 오류가 발생했습니다");
			};
		};
		
// 		메시지 전송 함수
		function sendMessage(status, chat_content){
			var team_no = ${param.team_no};
			var topic_no = ${param.topic_no};
			var message = {
				team_no:team_no,
				topic_no:topic_no,
				member_no:'',
				member_name:'',
				status:status,
				chat_content:chat_content
			};
			var value = JSON.stringify(message);
			window.socket.send(value);
		}
	});	

</script>

<script>
$(function(){
	
	//입력을 마치면(blur) 비동기통신으로 아이디 유무를 검사
	$("#check-btn").attr("disabled",true);
	
	$("input[name=topic_name]").blur(function(){
		
		
		var topic_name = $(this).val();
		var team_no = $("input[name=team_no]").val();
		
		$.ajax({
			url : "${pageContext.request.contextPath}/chat/topic_namecheck",
			type:"get",
			data:{
				topic_name :topic_name,
				team_no: team_no
			},
			dataType:"text",
			success: function(resp){
				if(resp === "Y"){
					$("input[name=topic_name]").next("span").text("동일한 이름이 있습니다.");
					$("#check-btn").prop("disabled",true); 
				}
				else if(resp === "N"){
					$("input[name=topic_name]").next("span").text("토픽생성가능");
					$("#check-btn").prop("disabled",false); 
				}
			}
		});			
	});
});

</script>

<script>
// 소희 스크립트 공간 

//소희 : 멤버초대 이메일 보내기 
$(function(){
      //이메일 보내기 버튼을 누르면 send주소로 비동기 신호를 전송 
      $('.email-form').submit(function(e){
      	e.preventDefault();
      	
      	$(this).find("input[type=submit]").prop("disabled", true);
			$(this).find("input[type=submit]").val("인증번호 발송중...");
     
			var url = $(this).attr("action"); 
			var method = $(this).attr("method");
			var data = $(this).serialize();
			
			$.ajax({
              type : "POST", //전송방식을 지정한다 (POST,GET)
              url : url,
              data : data,
              error : function(){
            	  alert("통신실패!!!!");
            	  $('#modal').hide();
              },
              success : function(resp){
                  //console.log(resp);
      				alert("발송완료되었습니다");
      			//입력창 초기화
                    $(".form-control").val("");
                    
      				$('#modal').hide();
                  	("input[type=submit]").prop("disabled",false)
                    .val("이메일 전송");
                  	//추후에 전송 완료되었습니다라는 메시지와 이메일을 확인해달라는 모달팝업창 띄우기
              }
   
          });

      });
 });
 

  	//멤버 초대 모달 화면
	$(function(){
	    //팝업 Show 기능(팀 멤버로 초대 버튼 누르면 모달 화면 열림)

	      //팝업 Close 기능(닫기 버튼 누르면 닫아짐)
	      $('#invite_close').click(function(){
	           $('#modal').hide();
	      });
	      $('#invite_btn').click(function(){
	              $('#modal').show();
	      		});
	});
  	
  	
  	
	//멤버 리스트 모달 화면
	$(function(){
	    //팝업 Show 기능(팀 멤버로 초대 버튼 누르면 모달 화면 열림)

	      //팝업 Close 기능(닫기 버튼 누르면 닫아짐)
	      $('#memberlist_close').click(function(){
	           $('#modal2').hide();
	      });
	      $('#memberlist_btn').click(function(){
	              $('#modal2').show();
	      });

	});
	
	//멤버 리스트 드롭다운
	$(function () {
		$('.dropdown-toggle').dropdown('show');
// 		$('.dropdown-toggle').on('shown.bs.dropdown');
	});
	
// 	$('#myDropdown').on('show.bs.dropdown', function () {
// 		  // do something...
// 		});

</script>
<script>
$(function(){
	$("#toggle1").click(function(){
		$(".menu1-slide").toggle();
	});
	
	$("#toggle4").click(function(){
		$(".menu4-slide").toggle();
	});
});

function MovePage(no){
	var team_no = ${param.team_no};
	var topic_no = ${param.topic_no};
	var  ajaxOption = {
			url : "./vote_detail?vote_create_no="+no,
			type : "GET",
			dataType : "html",
			data : {team_no:team_no, topic_no:topic_no},
			cache : false
	};
	$.ajax(ajaxOption).done(function(data){
		$('#bodyContents').html(data);
	});
}

// function MoveList(){
// 	var ajaxOption = {
// 			url: "./vote_golist",
// 			type: "GET",
// 			dataType: "html",
// 			cache: false
// 	};
// 	$.ajax(ajaxOption).done(function(data){
// 		$('#bodyContents').html(data);
// 	});
// }
</script>
<style>
#invite-create,
#topic-create{
 cursor: pointer;
border-top:1px solid #eee;
border-bottom: 1px solid #eee;
background-color:#f8f8f8;
 height:40px;
}
#invite-create a,
#topic-create a{
		position:absolute;
      	display:inline-block;
      	line-height:40px;
      	left:55px;
      	
}

	/* 소희 : 멤버초대 모달 화면 디자인 */
   .modal{
            position: fixed;
            top:0;
            left:0;
            right:0;
            bottom:0;
            background-color:rgba(139, 133, 133, 0.5);
            
            display: none;
        }
        
        .modal > .modal-view{
            position: fixed;
            width:300px;
            height:400px;
            background-color: white;
            border:1px solid; padding:10px;
            /* 가운데 배치 */
            top:50%;
            left:50%;
            margin-left: -150px;
            margin-top: -200px;
                       
        }
        
        /* 소희 : 멤버초대 모달 화면 디자인 */
       .modal2{
            position: fixed;
            top:0;
            left:0;
            right:0;
            bottom:0;
            background-color:rgba(139, 133, 133, 0.5);
            
            display: none;
        }
        
         .modal2 > .modal-view2{
            position: fixed;
            width:300px;
            height:400px;
            background-color: white;
            border:1px solid; padding:10px;
            /* 가운데 배치 */
            top:50%;
            left:50%;
            margin-left: -150px;
            margin-top: -200px;
                       
        }
        
        
        #membertList{
        position: absolute;
   		 right: 0;
        }

    </style> 

</head>

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
            	<a data-toggle="modal" data-target="#newTopicCreate">
					새 토픽 생성
            	</a>	<i class="fa fa-plus"></i>
            </li>
            <!-- 등급이 소유자 또는 정회원만 초대 가능하게 if문 걸어야 한다 -->
            <li class="nav-item" id="invite-create">
            	<a id="invite_btn" data-toggle="modal"> 멤버 초대하기
				</a>	<i class="fa fa-plus"></i>
            </li>
            <li class="nav-item">
	            <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
	                <span class="menu-title">토픽</span>
	                <i class="menu-arrow fa fa-caret-down" aria-hidden="false"></i>
	                <!-- <i class="menu-arrow fa fa-caret-down"></i> -->
	            </a>
            
            <div class="collapse" id="ui-basic">
                <ul class="nav flex-column sub-menu">

                	<c:forEach items="${topicList}" var="topicListDto" varStatus="status" >
                		<li class="nav-item">
		                    <a class="nav-link" href="${pageContext.request.contextPath}/chat/topic_main?team_no=${param.team_no}&topic_no=${topicListDto.topic_no}">
		                    	${topicListDto.topic_name}
			                    	<span class="badge badge-primary badge-pill ${topicListDto.topic_no}">
			                    	<c:if test="${memberChatCount[status.index].count ne 0 && topicListDto.topic_no ne param.topic_no}">
			                    		${memberChatCount[status.index].count}
			                    	</c:if>
			                    	</span>
		                    </a>
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
                    
                      <!-- 팀멤버 보기 드롭다운 시작-->
                      <div class="btn-group" id="membertList">
 						 <button  type="button" id="myDropdown" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    						팀멤버 보기 </button>
  							<div class="dropdown-menu">
  							<p>멤버 검색 </p>
  								<input type="search" value="멤버 찾기">
  							<div class="dropdown-divider"></div>	
  							<br>
   								 	<p>멤버 보기  </p>
									  <c:forEach items="${memberList}" var="memberListVO">	
   								 <div class="dropdown-item"> 
									<c:out value="${memberListVO.member_name}">${memberListVO.member_name}</c:out>
									<c:out value="${memberListVO.member_position}">${memberListVO.member_position}</c:out> 
									<br>
   								 </div>
								    </c:forEach>
    						<div class="dropdown-divider"></div>
  								  <a class="dropdown-item" href="#">Separated link</a>
 							 </div>
						</div>
						<!-- 팀멤버 보기 드롭다운 끝-->
						
                        <div class="chat-img">
                            <div class="chat-img-bg">
                                <div></div>
                                <i class="fa fa-comment"></i>
                            </div>
                        </div>
                        <div class="chat-menu-center">
                            <div class="chat-menu-title">
                                <span>${topicDto.topic_name}</span>
                            </div>
                            <div class="chat-menu-sub">
                                <span class="label">기본토픽</span>
                                <span>${topicDto.topic_explain}</span>
                            </div>
                        </div> 
                        
                      </div>
            <!-- partial -->                 

                    
                    
                 <div>  

                  

		
				<!-- 토픽 더보기 -->
				<div>
					<ul class="nav nav-pills">
						<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#"
							role="button" aria-haspopup="true" aria-expanded="false">더 보기</a>
							<div class="dropdown-menu" style="">
<%-- 									<c:choose> --%>
<%-- 										<c:when test="${param.topic_member_position eq '토픽소유자'}"> --%>
											<a class="dropdown-item" data-toggle="modal" data-target="#inTopic">토픽 참여 목록보기</a> 
											<a class="dropdown-item" data-toggle="modal" data-target="#inviteTopic">토픽 초대하기</a> 
											<a class="dropdown-item" data-toggle="modal" data-target="#editTopic">토픽 정보변경</a>
											<a class="dropdown-item" href="deletetopic?topic_no=${param.topic_no }">토픽 삭제하기</a> 
											<a class="dropdown-item" data-toggle="modal" data-target="#topicMasterChange">토픽 나가기(소유자)</a>
<%-- 										</c:when> --%>
<%-- 										<c:otherwise> --%>
<!-- 											<a class="dropdown-item" data-toggle="modal" data-target="#inTopic">토픽 참여 목록보기</a>  -->
<!-- 											<a class="dropdown-item" data-toggle="modal" data-target="#inviteTopic">토픽 초대하기</a>  -->
											<a class="dropdown-item" href="outtopic?topic_no=${param.topic_no }&member_no=${sessionScope.member_no}">토픽 나가기</a>
<%-- 										</c:otherwise> --%>
<%-- 									</c:choose> --%>
							</div>
						</li>
					</ul>
				</div>
				<!-- 토픽 더보기 end -->
				
			</div>
			<!-- partial -->



			     <article class="message-wrap">
                    
                        <div class="message" style="text-align: right">

							<h1>${topicDto.topic_name}</h1>
							<div id="chat-content">
								<c:forEach items="${topicChatList}" var="chatVo">
									<p>[${chatVo.member_name}] ${chatVo.chat_content}
								</c:forEach>
							</div>
							<div class="chat-send-content">
								<div class="chat-send-text">

									<input type="text" class="user-input">
								</div>
								<div class="chat-send-button">
									<button class="send-btn" type="submit">보내기</button>
								</div>
							</div>
									
						</div>
					</article>
					
				</div>
					
					        	 
 		 <!-- partical : Team_Member_List-->	 			
         <!-- 팀멤버 목록보기 버튼 -->
         

		
        <!-- partical end : Team_Member_List -->

					<div id="gnb-detail-slide">
			            <div class ="menu1-slide">d</div>
			            <!-- 주소 변경했음 -->
	        			<div id="bodyContents" class="menu4-slide">   
	<!-- 			       		<button id="movelist" onclick="MoveList()">목록으로..</button> -->
							<a href="./topic_main?team_no=${param.team_no }&topic_no=${param.topic_no }"><button id="golist" >목록으로</button></a>
	        				<!-- 목록으로 버튼 if처리해야함 -->
				            <a href="./vote_create?team_no=${param.team_no }&topic_no=${param.topic_no }">+투표 만들기</a><br><br>
				            <h3>진행중인 투표 목록</h3>
	
	        <!-- 화면 동적 전환(투표 상세 페이지) -->
				            		<ul>
				            	<c:forEach var="voteList" items="${voteList }" >
				            		<fmt:formatNumber type="number" var="no">${voteList.vote_create_team_no}</fmt:formatNumber>
				            		<li>
	        					<c:if test="${param.team_no eq no}">
				            		<c:out value="${voteList.vote_create_no}"/>번 투표
				            		<input type="button" name="${voteList.vote_create_no }" value="${voteList.vote_create_title}" onclick="MovePage(${voteList.vote_create_no })">     		
				            	</c:if>
				            		</li>
				            		<br>
				            	</c:forEach>   	
				            		</ul>
				            </div>
			        </div>
            </div>

            <!-- Page Title Header Ends-->      

			
		<!-- 멤버초대 하기 모달-->
		<!-- 모달 띄우기 -->
		<div id="modal" class="modal">
			<!--모달창 디자인-->
			<div class="modal-view"></div>
			<div
				style="position: absolute; top: 50%; left: 50%; width: 300px; height: 400px; margin-left: -150px; margin-top: -200px;">
				<div style="height: 30px;"></div>
				<p>멤버를 초대하세요!</p>
				<br>
				<hr>
				<!-- 이메일 전송 폼 -->
				<form class="email-form" action="topic_main" method="post">
					<input class="form-control" id="exampleInputEmail1"
						aria-describedby="emailHelp" name="cert_email" type="email"
						placeholder="Enter email"> <br> <input type="hidden"
						value="${param.team_no}" name="team_no"> <input
						type="hidden" value="${param.topic_no}" name="topic_no"> <br>
					<input type="submit" value="이메일전송" id="invite-send"
						class="invite-send" data-dismiss="modal"> <span></span>

					<button type="button" id="invite_close">닫기</button>
				</form>
			</div>
		</div>
	</div>
</div>


<!-- 토픽 기능 모달-->
		<!-- 토픽생성 모달 -->
		<form action="topic_create" method="post">
			<div class="modal fade" id="newTopicCreate" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalCenterTitle"
				aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalCenterTitle">새 토픽 생성</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<input type="hidden" name="team_no" value="${param.team_no}">
							이름 :<input type="text" name="topic_name"><span></span><br>
							<br> 공개여부 :<input type="radio" name="topic_confidential"
								value="1" checked="checked">비공개 <input type="radio"
								name="topic_confidential" value="0">공개<br>
							<br> 토픽 설명 :
							<textarea name="topic_explain" rows="" cols=""></textarea>
							<br>
							<br>

						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">닫기</button>
							<button type="submit" id="check-btn" class="btn btn-primary">생성하기</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	<!-- 새토픽 생성 end -->
<!-- 토픽 참여자리스트 -->
<div class="modal fade" id="inTopic" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">
				토픽 참여 멤버 보기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<c:forEach var="tmList" items="${topicMemberList}">
					<input type="hidden" name="team_no" value="${tmList.team_no }">
						   ${tmList.member_name}-${tmList.member_email}(${tmList.topic_member_position })
							   <c:if test="${tmList.member_no ne sessionScope.member_no }">
							   		<a style="color:red" 
							   		href="outtopic?topic_no=${param.topic_no }&member_no=${tmList.member_no}&team_no=${tmList.team_no}">
							   		내보내기
							   		</a>
							   </c:if>
						       <br>
				</c:forEach>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 토픽 참여자end -->
<!-- 토픽 정보변경 -->
<form action="edittopic" method="post">
	<div class="modal fade" id="editTopic" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalCenterTitle">토픽 정보 변경</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<input type="hidden" name="team_no" value="${param.team_no}">
					<input type="hidden" name="topic_no" value="${param.topic_no}">
					이름 :<input type="text" name="topic_name"><span></span><br>
					<br> 토픽 설명 :
					<textarea name="topic_explain" rows="" cols=""></textarea>
					<br>
					<br>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
					<button type="submit" id="check-btn" class="btn btn-primary">수정하기</button>
				</div>
			</div>
		</div>
	</div>
</form>
<!-- 토픽 정보변경end -->
<!-- 토픽 나가기(소유자) -->
<form action="topic_masterchange" method="post">
<div class="modal fade" id="topicMasterChange" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle"> 토픽 관리자 변경</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">
			<span>다음 토픽 관리자를 선택해주세요</span><br><hr>
					        	<input type="hidden" name="topic_no" value="${param.topic_no }">
					        	<input type="hidden" name="team_no" value="${param.team_no }">
		    		<c:forEach var="tmList" items="${topicMemberList}">
	    				<c:choose>
		    				<c:when test="${tmList.member_no eq sessionScope.member_no}">
				        		<input type="checkbox" disabled>
		    				</c:when>
				        	<c:otherwise>
					        	<input type="checkbox" name="member_no" value="${tmList.member_no }">	
				        	</c:otherwise>
			    		</c:choose>
					        	<span>
					        		${tmList.member_no}/${tmList.member_name}-${tmList.member_email}(${tmList.topic_member_position })
					        	</span>
			        			<br>
			        </c:forEach>
		 </div>
		 <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="submit"  class="btn btn-primary" >토픽 나가기</button>
		</div>
      </div>
    </div>
  </div>
</form>
<!-- 토픽 나가기(소유자) end -->
<!-- 토픽 초대 -->
<form action="invitetopic" method="post">
<div class="modal fade" id="inviteTopic" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle"> 토픽 멤버 초대하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        	<input type="hidden" name="team_no" value="${param.team_no }">
        	<input type="hidden" name="topic_no" value="${param.topic_no }">
	        <c:forEach var="tmlist" items="${inviteTopicList}">
	        	<c:choose>
	   				<c:when test="${tmlist.member_no eq sessionScope.member_no}">
	   					<!--  자기자신은 체크할 일이 없으므로 모양만 보여준다 -->
		        		<input type="checkbox"  disabled>
	   				</c:when>
		        	<c:otherwise>
			        	<input type="checkbox" name="member_no" value="${tmlist.member_no }">	
		        	</c:otherwise>
			 	</c:choose>
		 	        	<span>${tmlist.member_no}/${tmlist.member_name}/${tmlist.member_email}</span>
	 	        	<br>
	        </c:forEach>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary">초대하기</button>
      </div>
    </div>
  </div>
  </div>
</form>
<!-- 토픽 초대 end -->



<!-- main-panel ends -->
<!-- page-body-wrapper ends -->
<script
	src="${pageContext.request.contextPath}/resources/js/design/vendor.bundle.base.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/design/vendor.bundle.addons.js"></script>



 </html>
