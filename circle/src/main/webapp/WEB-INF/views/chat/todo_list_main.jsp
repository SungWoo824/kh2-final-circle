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

//검색 결과 비동기
function MovePage(no){
	var team_no = ${param.team_no};
	var member_no = ${member_no};
	var todo_list_content = $("#todo_list_content").val();  //인풋에 있는 벨류를 가져올게 

		var  ajaxOption = {
			url : "./todo_list_search_result?team=no"+no,
			type : "post",
			dataType : "html",
			data : {team_no:team_no, member_no:member_no, todo_list_content:todo_list_content},
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){
				$('#bodyContents').html(data);
				$('#list-content').hide();
			});
		
}

//완료된 할일 목록 비동기
function listDone(no){
	var team_no = ${param.team_no};
	var member_no = ${member_no};


		var  ajaxOption = {
			url : "./todo_done?team=no"+no,
			type : "get",
			dataType : "html",
			data : {team_no:team_no, member_no:member_no},
			cache : false 
	};
		$.ajax(ajaxOption).done(function(data){
				$('#list-done').html(data);
				$('#list-content').hide();
			});
		
}
// 	$('#submit-search').click(function(){
	
// 	//등록버튼 비활성화를 위한 준비 
// 	var team_no = ${param.team_no};
// 	var member_no = ${member_no};
// 	var todo_list_content = $("#todo_list_content").val();  //인풋에 있는 벨류를 가져올게 
	
// 	//입력을 마치면(blur) 비동기통신으로 아이디 유무를 검사 
// 	$("input[todo_list_content]").blur(function(){
// 		var todo_list_content = $(this).val();
		
// 		if(todo_list_content == ""){   //빈칸이 공란일 때 = 비동기통신이 작동하지 않아서 팀이름 입력
// 			$('#list-content').show();
// 			todo_list_content=false;	
// 		}
		
// 		else{	//빈칸이 공란이아닐때 = 비동기통신이 작동하여 팀이름 사용유무 확인가능

// 			$.ajax({
// 				url:"./todo_list_search_result",
// 				type:"get",
// 				dataType : "html",
// 	 			data : {team_no:team_no, member_no:member_no, todo_list_content:todo_list_content},
	 			
// 	 			success:function(data){
// 	 				$('#bodyContents').html(data);
// 	 				$('#list-content').hide();
						
// 	 			}
		
// 	 			});
// 		}
		
// 	});
// 	});	

		

</script>
</head>
<body>



						
				        

				<!-- 소희 : 투두 리스트 임시 버튼 -->
            	<div id="gnb-detail-slide">
			            <div class ="menu33-slide">d</div>
			            
			            <!-- 주소 변경했음 -->
	        			<div id="bodyContents22" class="menu33-slide">   
	        			
							<a href="./topic_main?team_no=${param.team_no }&topic_no=${param.topic_no }"><button id="golist" >목록으로</button></a>
	        				
				            <h3>투두 리스트</h3>
				            <!-- 개수 나오는 곳 출력 -->
				            <p>${countTodo} 개의 할일</p>
				            <br>
				            
				            <!-- 할일 검색하기 노비동기 -->
<!-- 				            <form action="todo_list_search" method="post"> -->
<%-- 				            	<input type="hidden" name="team_no" value="${param.team_no}"> --%>
<!-- 				            	<input type="text" name="todo_list_content" placeholder="할일의 제목을  검색하세요"> -->
<!-- 				            	<input type="submit" value="검색"> -->
<!-- 				            </form> -->
				            

				           <!-- 할일 검색하기 비동기 -->
				            	<input type="text" id="todo_list_content" name="todo_list_content" placeholder="비동기 검색">
				            	<input type="submit" id="submit-search" onclick="MovePage()" value="검색">
							<br><br>

					
							<!-- 할일 추가하기 버튼 -->
							<form action="todo_list_create" method="post">
								<input type="hidden" name="team_no" value="${param.team_no}">
								<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}">
								<input type="text" name="todo_list_content" placeholder="할일을 추가하세요" required>
								<input type="submit" value="추가">
							</form>
								<hr>
								
							<!-- 완료된 할일 목록 보기  비동기로 받기-->
							<input type="submit" id="submit-list-done" onclick="listDone()" value="완료된 목록 보기">
								<!-- 완료된 할일 목록 보기 결과창 -->
								<div id="list-done"></div>
								
									<hr>
								<!-- 할일 전체 목록 -->
								<div id="list-content">
									<p>할일 전체 목록보기	</p> 
										<c:forEach items="${todoPerAll}" var="todoListJoinVO">
										<!-- 진행중인 목록만 뽑는다 / 완료버튼 누르면 목록에서 사라짐-->
											<c:choose>
												<c:when test="${todoListJoinVO.todo_list_done=='진행'}">
												<hr> 
													<!-- 할일 목록 누르면 할일상세페이지(todo_list_detail)로 이동 -->
													<a href="${pageContext.request.contextPath}/chat/todo_list_detail?todo_list_no=${todoListJoinVO.todo_list_no}&team_no=${todoListJoinVO.team_no}&topic_no=${todoListJoinVO.topic_no}&todo_list_content=${todoListJoinVO.todo_list_content}">
													${todoListJoinVO.todo_list_content} ${todoListJoinVO.topic_name} / ${todoListJoinVO.todo_list_done}
													</a>
													<span></span>
											
										<!-- 할일 완료 시키기 -->	
										<form action="todo_done" method="post">
											<input type="hidden" name="team_no" value="${todoListJoinVO.team_no}">
											<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}">
											<input type="hidden" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
											<button id="done">완료</button>
										</form>
											<span></span>
											
										<form action="todo_back_done" method="post">
											<input type="hidden" name="team_no" value="${todoListJoinVO.team_no}">
											<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}">
											<input type="hidden" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
											<button id="done">진행으로 돌리기</button>
										</form>
													</c:when>
											</c:choose>
										
												<hr>
												
										</c:forEach>
														
								</div>
								
								<!--동기 검색 결과 보기 -->
									<c:forEach items="${searchTodo}" var="todoListJoinVO">
										<hr>	
										<a href="${pageContext.request.contextPath}/chat/todo_list_detail?todo_list_no=${todoListJoinVO.todo_list_no}">
											${todoListJoinVO.todo_list_content} ${todoListJoinVO.topic_name}
										</a>
									</c:forEach>	
							
							<!--비동기 검색 결과   -->
							<div id="bodyContents"></div>
							
							<!-- 완료된 할일 결과 -->
						
	        
				            </div>
			        </div>


            <!-- Page Title Header Ends-->      

			

                   	








      <!-- page-body-wrapper ends -->
    <script src="${pageContext.request.contextPath}/resources/js/design/vendor.bundle.base.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/design/vendor.bundle.addons.js"></script>
    


</body>
 </html>
