<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<!--bootstrap template-->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	
    <link href="${pageContext.request.contextPath}/resources/css/design/sb-admin-2.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/design/all.min.css" rel="stylesheet" type="text/css">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
   <link href="${pageContext.request.contextPath}/resources/css/design/common.css" rel="stylesheet" type="text/css">
	
	
<!-- 채팅메시지 스크립트 -->	
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
				console.log(ptopic_no);
				if(ptopic_no==msg.topic_no && msg.status==2){
				appendMessage(msg);
				}else if(ptopic_no!=msg.topic_no){
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
<!-- 토픽 생성 이름 중복검사 -->
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
<!-- 팀 관련 스크립트 -->
<script>
// 소희 스크립트 공간 

//소희 : 멤버초대 이메일 보내기 
$(function(){
      //이메일 보내기 버튼을 누르면 send주소로 비동기 신호를 전송 
      $('.email-form').submit(function(e){
      	e.preventDefault();
      	
      	$(this).find("input[type=submit]").prop("disabled", true); 
			$(this).find("input[type=submit]").val("인증번호 발송중...");
     
			var url = $(this).attr("action");  //form안의 action으로 url 설정 
			var method = $(this).attr("method"); //form안의 method 방식을 설정 
			var data = $(this).serialize();
			
			$.ajax({
              type : "POST", //전송방식을 지정한다 (POST,GET)
              url : url,  //위에 지정한 url
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
                  	("input[type=submit]").prop("disabled",false).val("");
//       				$('#modal').hide();
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
// 		$('.dropdown-toggle').dropdown('show');
// 		$('.dropdown-toggle').on('shown.bs.dropdown');
	});
	


</script>
<!-- 투표 스크립트 -->
<script>

//오른쪽 메뉴 토글
$(function(){
	$(".gnb-btn:not(.hdd)").click(function(){
		//slide는 현재 버튼과 연결된 창
		//$(".slide")는 모든 창
		var id = $(this).attr("id");
		id = id.replace("toggle", "slide");
		var slide = $("."+id);
		
		if(slide.is(":visible")){
			$(".slide").hide();
		}
		else{
			$(".slide").hide();
			slide.show();
		}
	});	

	$(".slide-close-btn").click(function(){
		$(".slide").hide();
	});

});

//투표
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


</head>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">

	<!-- 오른쪽 메뉴 바 시작 -->
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
	             <li id="search-toggle" class="gnb-btn menu1">
	                <a class="fa fa-search"></a>
	            </li>
<!-- 	            <li class="gnb-btn"> -->
<!-- 	                <a class="fa fa-file"></a> -->
<!-- 	            </li> -->
	            <li id="todolist-toggle" class="gnb-btn">
	                <a class="fa fa-list-ul"></a>
	            </li>
	            <li id="vote-toggle" class="gnb-btn menu4">
	                <a class="fa fa-check-square"></a>
	            </li>
<!-- 	            <li class="gnb-btn"> -->
<!-- 	                <a class="fa fa-plug"></a> -->
<!-- 	            </li> -->
	            <li class="gnb-btn hdd">
	                <a class="fa fa-hdd"></a>
	            </li>
	        </ul>
	    </div>
        <!-- 투표 기능 시작 -->
           <div id="gnb-detail-slide">
            	<div class="slide search-slide">
            		<div class="slide-close">
            			<ul>
            				<li class="slide-close-btn">X</li>
            			</ul>
            		</div>
            			search- slide
            	</div>
            	<div class="slide vote-slide">
            		<div class="slide-close">
            			<ul>
	            			<li class="slide-close-btn">X</li>
            			</ul>
            		</div>   
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
        			<!-- 투표 기능 종료 -->
        			<div class="slide todolist-slide">
	        			<div class="slide-close">
	        				<ul>
		            			<li class="slide-close-btn">X</li>
	        				</ul>
	            		</div>  
	        			todoList- slide
        			</div>
        	</div>
			        
	</div>
	</div>
    <!-- 오른쪽 메뉴 바 끝 -->

    <!-- 왼쪽 바 시작 -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion newline" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <div class="sidebar-brand d-flex align-items-center justify-content-center" >
    <div class="logowrap">
	    <div class="sidebar-brand-icon logo-back">
	            <img style="width:44px" src="${pageContext.request.contextPath}/resources/image/logo.png" alt="logo" />
	    </div>
    </div>
    <div class="sidebar-brand-text mx-3">
    	<!-- 팀 리스트 드롭다운 -->
    	test
    </div>
    </div>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item">
        <a class="nav-link" href="index.html">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>서클 메인</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
<!--       <div class="sidebar-heading"> -->
<!--         토픽 -->
<!--       </div> -->

      <!-- 토픽 목록 시작-->
      <li class="nav-item active">
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
          <i class="fas fa-fw fa-folder"></i>
          <span>토픽</span>
        </a>
        <div id="collapsePages" class="collapse show" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
<!--             <h6 class="collapse-header">Login Screens:</h6> -->
            <c:forEach items="${topicList}" var="topicListDto" varStatus="status" >
		            <a class="collapse-item" href="${pageContext.request.contextPath}/chat/topic_main?team_no=${param.team_no}&topic_no=${topicListDto.topic_no}">
		                    	${topicListDto.topic_name}
		                    	<span class="badge badge-primary badge-pill ${topicListDto.topic_no}">
		                    	<c:if test="${memberChatCount[status.index].count ne 0 && topicListDto.topic_no ne param.topic_no}">
		                    		${memberChatCount[status.index].count}
		                    	</c:if>
		                    	</span>
		            </a>
            </c:forEach>
            <div class="collapse-divider"></div>
          </div>
        </div>
      </li>
      <!-- 토픽 목록 끝 -->
      
      <!-- Heading -->
<!--       <div class="sidebar-heading"> -->
<!--        	채팅 -->
<!--       </div> -->

      <!-- 채팅목록 시작 -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-fw fa-cog"></i>
          <span>채팅</span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <a class="collapse-item" href="#">채팅1</a>
            <a class="collapse-item" href="#">채팅2</a>
          </div>
        </div>
      </li>
	<!-- 채팅목록 끝 -->
    </ul>
    

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top newborder">
			
          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

			<!-- 상단 토픽 정보 시작-->
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
			<!-- 상단 토픽 정보 끝-->
			
          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">

            <!-- Nav Item - Search Dropdown (Visible Only XS) -->
            <li class="nav-item dropdown no-arrow d-sm-none">
              <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-search fa-fw"></i>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in" aria-labelledby="searchDropdown">
                <form class="form-inline mr-auto w-100 navbar-search">
                  <div class="input-group">
                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                      <button class="btn btn-primary" type="button">
                        <i class="fas fa-search fa-sm"></i>
                      </button>
                    </div>
                  </div>
                </form>
              </div>
            </li>

            <!-- 팀, 토픽 기능-->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-user-friends fa-lg"></i>
              </a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
                <h6 class="dropdown-header">
                  Alerts Center
                </h6>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-primary">
                      <i class="fas fa-file-alt text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">December 12, 2019</div>
                    <span class="font-weight-bold">A new monthly report is ready to download!</span>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-success">
                      <i class="fas fa-donate text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">December 7, 2019</div>
                    $290.29 has been deposited into your account!
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-warning">
                      <i class="fas fa-exclamation-triangle text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">December 2, 2019</div>
                    Spending Alert: We've noticed unusually high spending for your account.
                  </div>
                </a>
                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
              </div>
            </li>

            <!-- Nav Item - Messages -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-user-plus fa-lg"></i>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="messagesDropdown">
                <h6 class="dropdown-header">
                  Message Center
                </h6>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/fn_BT9fwg_E/60x60" alt="">
                    <div class="status-indicator bg-success"></div>
                  </div>
                  <div class="font-weight-bold">
                    <div class="text-truncate">Hi there! I am wondering if you can help me with a problem I've been having.</div>
                    <div class="small text-gray-500">Emily Fowler · 58m</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/AU4VPcFN4LE/60x60" alt="">
                    <div class="status-indicator"></div>
                  </div>
                  <div>
                    <div class="text-truncate">I have the photos that you ordered last month, how would you like them sent to you?</div>
                    <div class="small text-gray-500">Jae Chun · 1d</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/CS2uCrpNzJY/60x60" alt="">
                    <div class="status-indicator bg-warning"></div>
                  </div>
                  <div>
                    <div class="text-truncate">Last month's report looks great, I am very happy with the progress so far, keep up the good work!</div>
                    <div class="small text-gray-500">Morgan Alvarez · 2d</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt="">
                    <div class="status-indicator bg-success"></div>
                  </div>
                  <div>
                    <div class="text-truncate">Am I a good boy? The reason I ask is because someone told me that people say this to all dogs, even if they aren't good...</div>
                    <div class="small text-gray-500">Chicken the Dog · 2w</div>
                  </div>
                </a>
                <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
              </div>
            </li>

            <div class="topbar-divider d-none d-sm-block"></div>

            <!-- Nav Item - User Information -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">Valerie Luna</span>
                <img class="img-profile rounded-circle" src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="#">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                  Profile
                </a>
                <a class="dropdown-item" href="#">
                  <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                  Settings
                </a>
                <a class="dropdown-item" href="#">
                  <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                  Activity Log
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Logout
                </a>
              </div>
            </li>

          </ul>

        </nav>
        <!-- End of Topbar -->
		<div class="chat-wrap">
           	<div class="chat-aside">
                   <div class="chat-menu-bar">
        <!-- 채팅 창 -->
        <div class="container-fluid">
		
          	<article class="message-wrap">
<!-- 		          <h5 class="h5 mb-4 text-gray-800"> -->
<%-- 						 ${topicDto.topic_name}    --%>
<!-- 		          </h5> -->
                    
						<!-- 메세지 결과 창 -->          
                        <div class="message" style="text-align: left">
							<div id="chat-content">
								<c:forEach items="${topicChatList}" var="chatVo">
									<div>
										<div class="msg-profile"></div>
											<div class="msg-con">
												<span>${chatVo.member_name} </span>
												<p class="msg">${chatVo.chat_content}</p>
											</div>
									</div>
								</c:forEach>
								
							</div>
						</div>
							
							<!-- 전송 -->
							<div class="chat-send-content">
								<div class="chat-send-text">
									<input class="form-control user-input" type="text" placeholder="메시지를 입력하세요">
								</div>
								<div class="chat-send-button">
									<button type="submit" class="btn btn-lg btn-primary send-btn">전송</button>
								</div>
							</div>
									
			</article>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

      <!-- Footer -->
<!--       <footer class="sticky-footer bg-white"> -->
<!--         <div class="container my-auto"> -->
<!--           <div class="copyright text-center my-auto"> -->
<!--             <span>Copyright &copy; Your Website 2019</span> -->
<!--           </div> -->
<!--         </div> -->
<!--       </footer> -->
      <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.html">Logout</a>
        </div>
      </div>
    </div>
  </div>
</div>
</div>
</div>

  <!-- Bootstrap core JavaScript-->
  <script src="${pageContext.request.contextPath}/resources/js/design/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/design/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="${pageContext.request.contextPath}/resources/js/design/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="${pageContext.request.contextPath}/resources/js/design/sb-admin-2.min.js"></script>

</body>

</html>