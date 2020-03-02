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
			$("<div>").text(message.chat_content).appendTo("#chat-content");
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
<!-- 토픽 생성 이름 중복검사 -->
<script>

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
// });

</script>
<!-- 팀 관련 스크립트 -->
<script>
// 소희 스크립트 공간 

//소희 : 멤버초대 이메일 보내기 
$(function(){
      //이메일 보내기 버튼을 누르면 send주소로 비동기 신호를 전송 
      $('.email-form').submit(function(e){
      	e.preventDefault();
      	

      	$(this).find('#invite-send').prop("disabled", true);
			$(this).find('#invite-send').val("인증번호 발송중...");

     
			var url = $(this).attr("action");  //form안의 action으로 url 설정 
			var method = $(this).attr("method"); //form안의 method 방식을 설정 
			var data = $(this).serialize();
			
			$.ajax({
              type : "GET", //전송방식을 지정한다 (POST,GET)
              url : url,  //위에 지정한 url
              data : data,            
              error : function(){
            	  alert("통신실패!!!!");

            	  $('#inviteTeam').hide();

              },
              success : function(resp){
                  //console.log(resp);
      				alert("발송완료되었습니다");
      			//입력창 초기화
                    $(".form-control").val("");
          
      				$('#inviteTeam').hide();
                  	('#invite-send').prop("disabled",false)
                    .val("초대하기");

                  	//추후에 전송 완료되었습니다라는 메시지와 이메일을 확인해달라는 모달팝업창 띄우기
              }
          });
      });
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

<!-- 투두 리스트 관련 스크립트 -->
<script>

//할일 완료 버튼 누르기 
function TodoDone(no){
	
	var team_no = ${param.team_no};
	var topic_no = ${param.topic_no}
	var member_no = ${member_no};
	var todo_list_no = $("#todo_list_no_done").val();
	
	var  ajaxOption = {
			url : "./todo_done",
			type : "post",
			dataType : "html",
			data : {team_no:team_no,topic_no:topic_no, member_no:member_no, todo_list_no:todo_list_no},
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){
				$('#count-todo').hide();
				
				$('#list-content').hide();
				$('#list-done').html(data);
			});
	
}


//투두 리스트 검색 결과 비동기
function TodoSearch(){

	var team_no = ${param.team_no};
	var member_no = ${member_no};
	var todo_list_content = $("#todo_list_content").val();  //인풋에 있는 벨류를 가져올게 

		var  ajaxOption = {
			url : "./todo_list_search_result",
			type : "post",
			dataType : "html",
			data : {team_no:team_no, member_no:member_no, todo_list_content:todo_list_content},
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){
// 				$('#todo-list-search').html(data);
// 				$('#list-content').hide();
				$('#list-content').html(data);
				$('#todo_list_btn_all').hide();
			});
		
}

//할일 완료 목록 불러오
function todoDoneList(){
	var member_no = ${member_no};
	var todo_list_no = $("#todo_list_no").val();  //인풋에 있는 벨류를 가져올게 
	var team_no = ${param.team_no};
	var topic_no = ${param.topic_no};
	var todo_list_content = $("#todo_list_content").val();


		var  ajaxOption = {
			url : "./todo_done_result",
			type : "GET",
			dataType : "html",
			data : {team_no:team_no, member_no:member_no,topic_no:topic_no, todo_list_no:todo_list_no,todo_list_content:todo_list_content},
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){

			
// 			if($("input[name=todo_done_list]").prop('checked', true)) {
// 				$('#list-done-result').html(data);


				$('#list-done-result').html(data);
				$('#list-content').hide();
				$('#todo-list-search').hide();
			});
}


//클릭 하면 열고 닫기 : 할일 목록 상세보기 (Detail, Edit , Delete 있는 거 )
$(function(){
	$(".modify-fix-div").hide();
	$(".modify-origin-div").show();
	
	$(".modify-origin-div").click(function() {
        $(this).parent().children(".modify-fix-div").show('3000');
        $(this).hide('fast');
	    $(".modify-origin-div").hide();
    });
	
	//취소 버튼 
	$(".modify-cancel").click(function(){
		$(this).parent().parent().children(".modify-origin-div").show('3000');
        $(this).parent().parent().children(".modify-fix-div").hide('fast');
        $(".modify-origin-div").show();
	})
});


</script>
<script>
// 할일 추가 
function TodoCreate(){
	var member_no = ${member_no};
	var todo_list_no = $("#todo_list_no_create").val();  //인풋에 있는 벨류를 가져올게 
	var team_no = ${param.team_no};
	var topic_no = ${param.topic_no};
	var todo_list_content = $("#todo_list_content_create").val();


		var  ajaxOption = {
			url : "./todo_list_create",
			type : "POST",
			dataType : "html",
			data : {team_no:team_no, member_no:member_no,topic_no:topic_no, todo_list_no:todo_list_no,todo_list_content:todo_list_content},
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){


				$('#list-content').html(data);
				$('#todo_list_content_create').val("");
// 				$('#list-content').hide();
// 				$('#todo-list-search').hide();

		
			});
}

//할일 삭제하기 
function TodoDelete(){
	var member_no = ${member_no};
	var todo_list_no = $("#todo_list_no_delete").val();  //인풋에 있는 벨류를 가져올게 
	var team_no = ${param.team_no};
	var topic_no = ${param.topic_no};


		var  ajaxOption = {
			url : "./todo_list_delete",
			type : "POST",
			dataType : "html",
			data : {team_no:team_no,topic_no:topic_no, todo_list_no:todo_list_no,member_no:member_no},
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){

				$('#todo-delete').html(data);
				$('#list-content').hide();
// 				$('#list-done-result').html(data);
// 				$('#todo-list-search').hide();
			});
}


//할일 수정하기
function EditTodo(team_no,todo_list_no,topic_no){
	console.log("11111team_no"+team_no);
	console.log("t22222odo_list_content"+todo_list_content);
	console.log("t333333topic_no"+topic_no);
// 	var todo_list_no = $("#todo_list_no_edit").val();  //인풋에 있는 벨류를 가져올게 
// 	var team_no = ${param.team_no};
// 	var topic_no = ${param.topic_no};
	var todo_list_content = $("#todo_list_content_edit"+todo_list_no).val(); 
	


		var  ajaxOption = {
			url : "./todo_list_edit?team_no="+team_no+"&todo_list_no="+todo_list_no+"&topic_no="+topic_no,
			type : "get",
			dataType : "html",
			data : {todo_list_content:todo_list_content},
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){

				$('#todo-edit').html(data);
// 				$('#list-content').hide();
				$(".todo-title").hide();

			});
}


</script>

</head>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">

<!-- <form action="todo_list_main" method="get"> -->
				
<%-- 					<input type="hidden" name="team_no" value="${param.team_no}"> --%>
<%-- 					<input type="hidden" name="topic_no" value="${param.topic_no}"> --%>
<!-- 					<button type="submit">투두리스트 가기 임시버튼</button> -->
<!-- 					</form> -->
	<!-- 오른쪽 메뉴 바 시작 -->
	<div class="menu-wrap">
	<div class="menu-con bg-base">
	    <div class="menu-top">
	        <ul class="menu-bar">
	            <li class="gnb-btn nav-item dropdown no-arrow mx-1">
	                    <a class="fa fa-bars nav-link dropdown-toggle"  id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
                <a class="dropdown-item d-flex align-items-center"  href="${pageContext.request.contextPath}/member/mypage">
	                <div>
	                    <span>팀 전환 하기</span>
	                 </div>
                </a>
		        <a class="dropdown-item d-flex align-items-center"  href="${pageContext.request.contextPath}/team_admin/team_manager_team" >
	               <c:set var="team" value="${memberList.get(0)}"></c:set>
	               <c:choose>
						<c:when test="${team.member_position eq '소유자' }">
			                  <div>
			                 	<span>관리자 메뉴</span>
			                  </div>
		                </c:when>
	                </c:choose>
		      	</a>
              </div>
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
	                <a class="fa fa-hdd" href="#"></a>
	            </li>
	        </ul>
	    </div>
        <!-- 투표 기능 시작 -->
           <div id="gnb-detail-slide">
            	<div class="slide search-slide">
            		<div class="slide-close">
            			<ul>
            				<li class="slide-close-btn"><a class="fa fa-times" alt="닫기"></a></li>
            			</ul>
            		</div>
            			search- slide
            	</div>
            	<div class="slide vote-slide">
            		<div class="slide-close">
            			<ul>
	            			<li class="slide-close-btn"><a class="fa fa-times" alt="닫기"></a></li>
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
			        					<c:if test="${param.team_no == no}">
						            		<c:out value="${voteList.vote_create_no}"/>번 투표
						            		<input type="button" name="${voteList.vote_create_no }" value="${voteList.vote_create_title}" onclick="MovePage(${voteList.vote_create_no })">     		
						            	</c:if>
					            		</li>
					            		<br>
					            	</c:forEach>   	
				            	</ul>
				    </div>
        			<!-- 투표 기능 종료 -->
        			
   <!--투두리스트 시작 -->
   <div class="slide todolist-slide">
	   <div class="slide-close">
	       <ul>
		       <li class="slide-close-btn"><a class="fa fa-times" alt="닫기"></a></li>
	       </ul>
	   </div>  
	        <a href="./topic_main?team_no=${param.team_no }&topic_no=${param.topic_no }"><button id="golist" >목록으로</button></a>
	        	todoList- slide
	        	<h3>투두 리스트</h3>
				    <br>


	<div id="todo_list_all">
			<div id="todo_list_btn_all"> 
			<p>토픽 메인 페이지에 있음 </p> <br>     
				      
				<!-- 할일 검색하기 비동기 -->
				<input type="text" id="todo_list_content" name="todo_list_content" placeholder="비동기 검색">
				<input type="submit" id="submit-search" onclick="TodoSearch()" value="검색">
					<br><br>
							
					<!-- 할일 추가하기 버튼 -->
					 <input type="hidden" id="todo_list_no_create" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
					 <input type="hidden" name="team_no" value="${param.team_no}">
					 <input type="hidden" name="topic_no" value="${param.topic_no}">
					 <input type="text" id="todo_list_content_create" name="todo_list_content" placeholder="할일을 추가하세요" required>
					 <input type="submit" onclick="TodoCreate()" value="추가">
					 <br>
				
				<!-- 완료된 할일 보기  -->
				완료된 할일 보기 <span></span>
				<input type="hidden" id="team_no" name="team_no" value="${todoListJoinVO.team_no}">
				<input type="hidden" id="topic_no" name="topic_no" value="${todoListJoinVO.topic_no}">
				<input type="hidden" id="todo_list_no" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
				<input type="hidden" id="todo_list_content" name="todo_list_content" value="${todoListJoinVO.todo_list_content}">
				<input type="checkbox" name="todo_done_list" onclick="todoDoneList()" value="완료된 할일 보기">		
								
				돌아가기  <span></span>
				<input type="checkbox" id="back_list" name="back_list" onclick="backList()" value="돌아가">			

				<!-- 개수 나오는 곳 출력 -->
	        	<div id="count_todo">
				<p>${countTodo} 개의 할일</p>
	        	</div>
			</div>		
				
			   <!-- 할일 상세보기 -->
		  	   <div id="todo-list-detail"></div>
	        	
			   <!-- 완료 버튼 누르면 목록에서 사라지기  -->
			   <div id="list-done"></div>	
			   
	        	
			   	<br><br>
				<!-- 할일 전체 목록 -->
				<div id="list-content">
					
					<p>할일 전체 목록보기	</p> 

					<c:forEach items="${todoPerAll}" var="todoListJoinVO">
						
						<!-- 진행중인 목록만 뽑는다 / 완료버튼 누르면 목록에서 사라짐-->
						<c:choose>
							<c:when test="${todoListJoinVO.todo_list_done=='진행'}">
								<hr> 

						<!--할일 목록 누르면 할일상세페이지(<div id="show_detail">)로 이동 -->
						<div class="all-div">
								<div class="modify-origin-div">
								
									<div class="todo-title">
											<span> ${todoListJoinVO.todo_list_content} ${todoListJoinVO.topic_name} / ${todoListJoinVO.todo_list_done}"</span>
										
			
											<!-- 할일 완료 시키기 -->	
												<input type="hidden" name="team_no" value="${todoListJoinVO.team_no}">
												<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}">
												<input type="hidden" id="todo_list_no_done" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
												<input type="submit" onclick="TodoDone()" value="완료">
												<span></span>
											
											<!--할일 진행중으로 돌리기 -->			
											<form action="todo_back_done" method="post">
												<input type="hidden" name="team_no" value="${todoListJoinVO.team_no}">
												<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}">
												<input type="hidden" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
												<input type="submit" id="submit-back-done" onclick="TodoBackDone()" value="진행으로 돌리">
											</form>
									</div>
								
							</div>
	


							<!-- todo_list_detail 부분 -->
							<div class="modify-fix-div">

								<!-- 할일 수정  -->
								<p>할일 수정하기</p>
<%-- 										<input type="hidden" name="team_no"	value="${todoListJoinVO.team_no}"> --%>
<%-- 										<input type="hidden" id="todo_list_no_edit" name="todo_list_no" value="${todoListJoinVO.todo_list_no}"> --%>
<%-- 										<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}"> --%>
										<textarea type="text" id="todo_list_content_edit${todoListJoinVO.todo_list_no}" name="todo_list_content">${todoListJoinVO.todo_list_content}</textarea>
										<input type="button" onclick="EditTodo(${todoListJoinVO.team_no},${todoListJoinVO.todo_list_no},${todoListJoinVO.topic_no})" value="수정">
								
								<!-- 할일 삭제하기 -->
								<br>
									<input type="hidden" name="team_no"	value="${todoListJoinVO.team_no}">
									<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}">
									<input type="hidden" id="todo_list_no_delete" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
									<input type="submit" onclick="TodoDelete()" value="삭제">
									<button class="modify-cancel">닫기 </button>
							</div>
					</div>
						   <!-- 할일 수정 결과 -->
			   				<div id="todo-edit"></div>


									
									<span></span>
											


							</c:when>
						</c:choose>
					</c:forEach>
							<hr>
		  	   </div>
		  	   
		  	   

		  	   

			   <!--비동기 검색 결과   -->
			   <div id="todo-list-search"></div>
			 	
										
			   <!-- 할일 추가 된 것 결과 -->									
			   <div id="todo-create"></div>				
			   
			   <!--할일 삭제 결과 -->					
			   <div id="todo-delete"></div>			
			   
			   <!-- 완료 목록보기   -->		
			   <div id="list-done-result"></div>
			   
		
			   
     </div>
</div>   
     <!-- 투두리스트 종료 -->
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
    <div class="sidebar-brand-text">
    </div>
    </div>
    </div>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}">
          <i class="fas fa-fw fa-home"></i>
          <span>서클 메인</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
		    <a class="nav-link" data-toggle="modal" data-target="#newTopicCreate">
			     <i style="color:#2196f3" class="fa fa-fw fa-plus"></i> 
			     <span style="color:#666">토픽 생성하기</span>
		     </a>
      </div>

	<hr class="sidebar-divider">

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
      
      <hr class="sidebar-divider">
      <!-- Heading -->
 	<div class="sidebar-heading">
		    <a class="nav-link" href="#">
			     <i style="color:#2196f3" class="fa fa-fw fa-plus"></i> 
			     <span style="color:#666">채팅 시작하기</span>
		     </a>
      </div>
 	<hr class="sidebar-divider">
      <!-- 채팅목록 시작 -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-fw fa-comments"></i>
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
        <nav class="navbar navbar-expand navbar-light bg-white topbar static-top newborder">
			
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
                       <span class="label">토픽정보</span>
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

            <!-- 팀, 토픽 기능 시작-->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-user-friends fa-lg"></i>
              </a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
                <a class="dropdown-item d-flex align-items-center" data-toggle="modal" data-target="#inTeam">
                  <div>
                    <span>팀 멤버 전체 보기</span>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" data-toggle="modal" data-target="#inviteTeam">
                  <div>
                 	<span>팀 초대하기</span>
                  </div>
                </a>
<!--                 <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a> -->
              </div>
            </li>
			<!-- 팀, 토픽 기능 종료-->
			
			
            <!-- Nav Item - Messages -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-user-plus fa-lg"></i>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="messagesDropdown">
<%--               <c:forEach var="tmList" items="${topicMemberList}"> --%>
				<c:set var="tmList" value="${topicMemberList.get(0)}"></c:set>
	              <c:choose>
	              		<c:when test="${tmList.topic_member_position eq '토픽소유자' }">
			                 <a class="dropdown-item d-flex align-items-center" data-toggle="modal" data-target="#inTopic">
				                  <div>
				                    <div class="text-truncate">토픽 멤버 보기</div>
				                  </div>
					        </a>
					        <a class="dropdown-item d-flex align-items-center" data-toggle="modal" data-target="#inviteTopic">
			                  <div>
			                    <div class="text-truncate">토픽 초대하기</div>
			                  </div>
			                </a>
			                <a class="dropdown-item d-flex align-items-center" data-toggle="modal" data-target="#editTopic">
			                  <div>
			                    <div class="text-truncate">토픽 정보 변경</div>
			                  </div>
			                </a>
			                <c:if test="${topicList.size() > 1}">
				                <a class="dropdown-item d-flex align-items-center" href="deletetopic?topic_no=${param.topic_no }&team_no=${param.team_no}">
				                  <div>
				                    <div class="text-truncate">토픽 삭제하기</div>
				                  </div>
				                </a>
			                </c:if>
			                <a class="dropdown-item d-flex align-items-center" data-toggle="modal" data-target="#topicMasterChange">
			                  <div>
			                    <div class="text-truncate">토픽 나가기</div>
			                  </div>
			                </a>
	              		</c:when>
	              		<c:otherwise>
			                <a class="dropdown-item d-flex align-items-center" data-toggle="modal" data-target="#inTopic">
			                  <div>
			                    <div class="text-truncate">토픽 멤버 보기</div>
			                  </div>
			                </a>
			                <a class="dropdown-item d-flex align-items-center" data-toggle="modal" data-target="#inviteTopic">
			                  <div>
			                    <div class="text-truncate">토픽 초대하기</div>
			                  </div>
			                </a>
			                <a class="dropdown-item d-flex align-items-center" href="outtopic?topic_no=${param.topic_no }&member_no=${sessionScope.member_no}">
			                  <div>
			                    <div class="text-truncate">토픽 나가기</div>
			                  </div>
			                </a>
	              		</c:otherwise>
	              </c:choose>
<%--               </c:forEach> --%>
                
              </div>
            </li>

            <li class="topbar-divider d-none d-sm-block"></li>

            <!-- Nav Item - User Information -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">사용자</span>
                <img class="img-profile rounded-circle" src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
                
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="${pageContext.request.contextPath}/member/modify">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                  내 정보보기
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="${pageContext.request.contextPath}/member/signout" >
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  로그아웃
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
        <div class="container-fluid" style="overflow:auto">
		
          	<article class="message-wrap">
<!-- 		          <h5 class="h5 mb-4 text-gray-800"> -->
<%-- 						 ${topicDto.topic_name}    --%>
<!-- 		          </h5> -->
                    
						<!-- 메세지 결과 창 -->          
                        <div class="message" style="text-align: left">
							<div id="chat-content">
								<c:forEach items="${topicChatList}" var="chatVo">
									<div class="msg-wrap">
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

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

 


<!-- ----------------------------------------------팀  모달 시작 ----------------------------------------------------- -->
<!-- 팀 리스트 -->
<div class="modal fade" id="inTeam" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">
				팀 멤버 보기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
  				<input type="search" value="멤버 찾기">
			  <c:forEach items="${memberList}" var="memberListVO">	
					<div class="dropdown-item"> 
						<c:out value="${memberListVO.member_name}">${memberListVO.member_name}</c:out>
						<c:out value="${memberListVO.member_position}">${memberListVO.member_position}</c:out> 
						<br>
					</div>
				</c:forEach>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 팀 리스트end -->
<!-- 팀 초대 -->
<div class="modal fade" id="inviteTeam" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle"> 팀 초대하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
			<form class="email-form" action="topic_main" method="post">
	      		<div class="modal-body">
	        	<input class="form-control" id="exampleInputEmail1"
							aria-describedby="emailHelp" name="cert_email" type="email"
							placeholder="Enter email"> <br> 
				<input type="hidden" value="${param.team_no}" name="team_no"> 
				<input type="hidden" value="${param.topic_no}" name="topic_no"> <br>
	<!-- 			<input type="submit" value="이메일전송" id="invite-send" -->
	<!-- 						class="invite-send" data-dismiss="modal"><span></span> -->
	      			</div>
			      <div class="modal-footer">
			        <button type="button" id="invite_close" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			        <input type="submit" id="invite-send" class="btn btn-primary invite-send" value="초대하기"><span></span>
			<!--       <button type="submit" class="btn btn-primary">초대하기</button> -->
			      </div>
			</form>
    </div>
  </div>
  </div>
<!-- 팀 초대 end -->
<!-- ----------------------------------------------팀  모달 종료 ----------------------------------------------------- -->



<!-- ----------------------------------------------토픽 모달 시작 ----------------------------------------------------- -->
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
			<!-- 내가 토픽 소유자일 때 나를 제외하고 내보내기 할 수 있는 기능 -->
				<c:forEach var="tmList" items="${topicMemberList}">
						   ${tmList.member_name}(${tmList.member_email})(${tmList.topic_member_position })
						<c:choose>
							   <c:when test="${tmList.topic_member_position ne '토픽소유자' and tmList.member_no ne sessionScope.member_no}">
							   		<a style="color:red" 
							   		href="outtopic?topic_no=${param.topic_no }&member_no=${tmList.member_no}&team_no=${tmList.team_no}">
							   		내보내기
							   		</a><br>
							   </c:when>
							   <c:otherwise>
									<br>
							   </c:otherwise>
						</c:choose>
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
<!-- ---------------------------------------------------------------토픽 모달 종료----------------------------------------------------------------- -->
  <!-- Bootstrap core JavaScript-->
  <script src="${pageContext.request.contextPath}/resources/js/design/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/design/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="${pageContext.request.contextPath}/resources/js/design/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="${pageContext.request.contextPath}/resources/js/design/sb-admin-2.min.js"></script>
</div>
</div>
</div>
</body>

</html>