<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>할일 상세보기 페이지</title>
<script>

//검색 결과창 숨기기 
$(function(){
	$("#todo_search_result").hide();
});


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

//할일 클릭 하면 열고 닫기 : 할일완료 목록 보기 )
$(function(){
	$("#list-done-result").hide();
//	$("#list-content").show();
	
	$(".todo_done_result").click(function() {
      $("#list-done-result").show();
//       $(this).hide('fast');
	    $("#todo_list_all").hide();
  });
	
	//돌아가기 
	$(".todo_list").click(function(){
		$("#todo_list_all").show('3000');
		$("#list-done-result").hide();
//		$("#list-content").show();
	})
});

//투두리스트 메인으로 이동 
function HomeTodo(team_no,topic_no,member_no){

	var  ajaxOption = {
		url : "${pageContext.request.contextPath}/todo/todo_list_main?team_no="+team_no+"&topic_no="+topic_no+"&member_no="+member_no,
		type : "get",
		dataType : "html",
		cache : false
};
	$.ajax(ajaxOption).done(function(data){

//				$('#todo-edit').html(data);
//			$('#todo_list_all').html(data);
			$('#list-content').html(data);
			
		});
}


//할일 완료 버튼 누르기 
function TodoDone(team_no,topic_no,todo_list_no){
	
//	var team_no = ${param.team_no};
//	var topic_no = ${param.topic_no}
//	var member_no = ${member_no};
//	var todo_list_no = $("#todo_list_no_done").val();
	
	var  ajaxOption = {
			url : "${pageContext.request.contextPath}/todo/todo_done?team_no="+team_no+"&topic_no="+topic_no+"&todo_list_no="+todo_list_no,
			type : "post",
			dataType : "html",
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){
//				$('#count-todo').hide();
								$('#list-content').html(data);
//				$('#list-content').hide();
//				$('#list-done').html(data);
			});
	
}


//할일 진행 버튼 누르기 
function TodoBackDone(team_no,topic_no,todo_list_no){
	
//	var team_no = ${param.team_no};
//	var topic_no = ${param.topic_no}
//	var member_no = ${member_no};
//	var todo_list_no = $("#todo_list_no_done").val();
	
	var  ajaxOption = {
			url : "${pageContext.request.contextPath}/todo/todo_back_done?team_no="+team_no+"&topic_no="+topic_no+"&todo_list_no="+todo_list_no,
			type : "post",
			dataType : "html",
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){
//				$('#count-todo').hide();
								$('#list-done-result').html(data);
				$('#list-content').hide();
//				$('#list-done').html(data);
			});
	
}

//투두 리스트 검색 결과 비동기
function TodoSearch(){

	var team_no = ${param.team_no};
	var member_no = ${member_no};
	var todo_list_content = $("#todo_list_content").val();  //인풋에 있는 벨류를 가져올게 

		var  ajaxOption = {
			url : "${pageContext.request.contextPath}/todo/todo_list_search_result",
			type : "post",
			dataType : "html",
			data : {team_no:team_no, member_no:member_no, todo_list_content:todo_list_content},
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){
//				$('#todo-list-search').html(data);
//				$('#list-content').hide();
				$('#list-content').html(data);
				$('#todo_main_list').hide();
//				$('#todo_list_btn_all').hide();
			});
		
}



//할일 완료 목록 불러오
//function todoDoneList(){
//	var member_no = ${member_no};
//	var todo_list_no = $("#todo_list_no").val();  //인풋에 있는 벨류를 가져올게 
//	var team_no = ${param.team_no};
//	var topic_no = ${param.topic_no};
//	var todo_list_content = $("#todo_list_content").val();


//		var  ajaxOption = {
//			url : "./todo_done_result",
//			type : "GET",
//			dataType : "html",
//			data : {team_no:team_no, member_no:member_no,topic_no:topic_no, todo_list_no:todo_list_no,todo_list_content:todo_list_content},
//			cache : false
//	};
//		$.ajax(ajaxOption).done(function(data){

			
//// 			if($("input[name=todo_done_list]").prop('checked', true)) {
//// 				$('#list-done-result').html(data);


//				$('#list-done-result').html(data);
//				$('#list-content').hide();
//				$('#todo-list-search').hide();
//			});
//}




//수정하기 상세페이지 이동 TodoDetail
function TodoDetail(team_no,todo_list_no,topic_no,todo_list_content){

		var  ajaxOption = {
			url : "${pageContext.request.contextPath}/todo/todo_list_detail?team_no="+team_no+"&todo_list_no="+todo_list_no+"&topic_no="+topic_no+"&todo_list_content="+todo_list_content,
			type : "get",
			dataType : "html",
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){

//				$('#todo-edit').html(data);
				$('#list-content').html(data);
				
			});
}


//할일 수정하기
function EditTodo(team_no,todo_list_no,topic_no){
	console.log("11111team_no"+team_no);
	console.log("t22222odo_list_content"+todo_list_content);
	console.log("t333333topic_no"+topic_no);
//	var todo_list_no = $("#todo_list_no_edit").val();  //인풋에 있는 벨류를 가져올게 
//	var team_no = ${param.team_no};
//	var topic_no = ${param.topic_no};
	var todo_list_content = $("#todo_list_content_edit"+todo_list_no).val(); 

	


		var  ajaxOption = {
			url : "${pageContext.request.contextPath}/todo/todo_list_edit?team_no="+team_no+"&todo_list_no="+todo_list_no+"&topic_no="+topic_no,
			type : "post",
			dataType : "html",
			data : {todo_list_content:todo_list_content},
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){
				$('#list-content').html(data);
// 				$('#todo-edit').html(data);
// 				$('#list-content').hide();
//				$(".todo-title").hide();
				$(this).parent().children(".modify-fix-div").show();
			});
}


</script>
<script>
// 할일 추가 
function TodoCreate(){
// 	var member_no = ${member_no};
// 	var todo_list_no = $("#todo_list_no_create").val();  //인풋에 있는 벨류를 가져올게 
// 	var team_no = ${param.team_no};
// 	var topic_no = ${param.topic_no};
// 	var todo_list_content = $("#todo_list_content_create").val();

// 	var url=$('#form_todo_create').attr('action');
		var createData=$('#form_todo_create').serialize();

		var  ajaxOption = {
			url : "${pageContext.request.contextPath}/todo/todo_list_create",
			type : "POST",
			dataType : "html",
// 			contentType:"application/json",
			data :createData,
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
function TodoDelete(team_no,topic_no,todo_list_no){
// 	var member_no = ${member_no};
// 	var todo_list_no = $("#todo_list_no_delete"+todo_list_no).val();  //인풋에 있는 벨류를 가져올게 
// 	var team_no = ${param.team_no};
// 	var topic_no = ${param.topic_no};

// 	var url=$('#form_todo_delete').attr('action');
// 		var deleteData=$('#form_todo_delete').serialize();

		var  ajaxOption = {
			url : "${pageContext.request.contextPath}/todo/todo_list_delete?team_no="+team_no+"&topic_no="+topic_no+"&todo_list_no="+todo_list_no,
			type : "post",
			dataType : "html",
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){

			$('#list-content').html(data);
// 				$('#todo-delete').html(data);
// 				$('#list-content').hide();
// 				$('#list-done-result').html(data);
// 				$('#todo-list-search').hide();
			});
}

</script>  


</head>
<body>

<!--투두리스트 시작 -->

   	<!-- 할일 전체 목록 -->
	<div id="list-content">
	   <div class="slide-close"> 

	       <ul>
		       <li class="slide-close-btn">
		       <a class="fa fa-times" style="color: white" alt="닫기"> </a> 
		       </li>
	       </ul>
		      <p class="p-3 mb-2 bg-primary text-white" style="text-align:center;"> 할 일  
		      	<span class="badge badge-light">${countTodo} </span> 
		      </p>
	   </div>   
   
   <br>

	<div id="todo_list_all">
			<div id="todo_list_btn_all"> 
				<p> 할일 디테일 페이지에 있음 </p> 
				<!--투두 리스트 메인가기 -->
		        <input type="button" onclick="HomeTodo(${param.team_no},${param.topic_no},${todoListJoinVO.member_no})" value="처음으로">
		        
		        <br>     
				
					   		
					      
					<!-- 할일 검색하기 비동기 -->
					<input type="text" id="todo_list_content" name="todo_list_content" placeholder="비동기 검색">
					<input type="submit" id="submit-search" onclick="TodoSearch()" value="검색">
						<br><br>
								
						<!-- 할일 추가하기 버튼 -->
						<form action="todo_list_create" method="post" id="form_todo_create">
							 <input type="hidden" id="todo_list_no_create" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
							 <input type="hidden" name="team_no" value="${param.team_no}">
							 <input type="hidden" name="topic_no" value="${param.topic_no}">
							 <input type="text" id="todo_list_content_create" name="todo_list_content" placeholder="할일을 추가하세요" required>
							 <input type="button" onclick="TodoCreate()" value="추가">
						</form>
						
						 <br>
				

			</div>		
				
				<!-- 완료 목록 보기 누르면 이부분 없어 져야 함   -->
			   <div id="todo_list_all"> 
				
	        	
			   <!-- 완료 버튼 누르면 목록에서 사라지기  -->
			   <div id="list-done"></div>	
	        	
			   	<br><br>
					완료된 할일 보기 <span></span> <input type="checkbox" class="todo_done_result" value="완료된 할일 보기">		
				
				<!-- 개수 나오는 곳 출력 -->
	        	<div id="count_todo">
				<p>${countTodo} 개의 할일</p>
	        	</div>
					
					<p>할일 디테일 페이지에 있음 </p>
					<p>할일 전체 목록보기	</p> 

<%-- 					<c:forEach items="${todoPerAll}" var="todoListJoinVO"> --%>
						
<!-- 						진행중인 목록만 뽑는다 / 완료버튼 누르면 목록에서 사라짐 -->
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${todoListJoinVO.todo_list_done=='진행'}"> --%>
<!-- 								<hr>  -->

<!-- 						할일 목록 누르면 할일상세페이지(<div id="show_detail">)로 이동 -->
<!-- 						<div class="all-div"> -->
<!-- 								<div class="modify-origin-div"> -->
								
<!-- 									<div class="todo-title"> -->
<%-- 											<span> ${todoListJoinVO.todo_list_content} ${todoListJoinVO.topic_name} / ${todoListJoinVO.todo_list_done}"</span> --%>
											
											
<%-- 											<button type="button" class="btn btn-primary" onclick="TodoDetail(${todoListJoinVO.team_no},${todoListJoinVO.todo_list_no},${todoListJoinVO.topic_no},${todoListJoinVO.todo_list_content})">수정</button> --%>
											
										
<!-- 											<br> -->
<!-- 											할일 완료 시키기	 -->
<%-- <%-- 												<input type="hidden" name="team_no" value="${todoListJoinVO.team_no}"> --%> --%>
<%-- <%-- 												<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}"> --%> --%>
<%-- <%-- 												<input type="hidden" id="todo_list_no_done" name="todo_list_no" value="${todoListJoinVO.todo_list_no}"> --%> --%>
<%-- 												<input type="checkbox" onclick="TodoDone(${todoListJoinVO.team_no},${todoListJoinVO.topic_no},${todoListJoinVO.todo_list_no})" value="완료"> --%>
<!-- 												<span>완료하기</span> -->
												
											
											
<!-- 									</div> -->
								
<!-- 							</div> -->
	


							<!-- todo_list_detail 부분 -->
<!-- 							<div class="modify-fix-div"> -->
								<!-- 할일 수정  -->
								<p>할일 수정하기 메인 페이</p>
								
										<textarea type="text" id="todo_list_content_edit${todoListJoinVO.todo_list_no}" name="todo_list_content">${todoListJoinVO.todo_list_content}</textarea>
										<input type="button" onclick="EditTodo(${todoListJoinVO.team_no},${todoListJoinVO.todo_list_no},${todoListJoinVO.topic_no})" value="수정">
								
								
								<!-- 할일 삭제하기 -->
								<br>
									<input type="button" onclick="TodoDelete(${todoListJoinVO.team_no},${todoListJoinVO.topic_no},${todoListJoinVO.todo_list_no})" value="삭제">
									<button class="modify-cancel">닫기 </button>
							</div>
					</div>


<%-- 							</c:when> --%>
<%-- 						</c:choose> --%>
<%-- 					</c:forEach> --%>
							<hr>
		  	   </div>
<!-- 		 </div> -->
		  	   
		  	   
					   <!-- 할일 수정 결과 -->
					   <div id="todo-edit"></div>
				  	   
					   <!--비동기 검색 결과   -->
					   <div id="todo-list-search"></div>
												
					   <!-- 할일 추가 된 것 결과 -->									
					   <div id="todo-create"></div>				
					   
					   <!--할일 삭제 결과 -->					
					   <div id="todo-delete"></div>			
			   
			   <!-- 완료 목록 보기 :시작  -->		
			   <div id="list-done-result">
			   
			   		 <!-- 돌아가기 버튼 -->
			   		 <span> 돌아가기 </span> <input type="checkbox" class="todo_list" value="돌아가기">	
			    		 <br>
			    		 <h2>완료된 할일</h2>
			   
						<c:forEach items="${todoPerAll}" var="todoListJoinVO">
							<c:choose>
								<c:when test="${todoListJoinVO.todo_list_done=='완료'}">
								
									<!--할일 목록 누르면 할일상세페이지(<div id="show_detail">)로 이동 -->
										<div class="all-div">
												<div class="modify-origin-div">
													<div class="todo-title">
															<span> ${todoListJoinVO.todo_list_content} ${todoListJoinVO.topic_name} / ${todoListJoinVO.todo_list_done}"</span>
														
															<br>
				
															<!--할일 진행중으로 돌리기 -->			
															<input type="submit"  onclick="TodoBackDone(${todoListJoinVO.team_no},${todoListJoinVO.topic_no},${todoListJoinVO.todo_list_no})" value="진행">
															
															<!-- 할일 삭제하기 -->
															<input type="button" onclick="TodoDelete(${todoListJoinVO.team_no},${todoListJoinVO.topic_no},${todoListJoinVO.todo_list_no})" value="삭제">
													</div>
												</div>
				\
				
											<!-- todo_list_detail 부분 -->
											<div class="modify-fix-div">
													<button class="modify-cancel">닫기 </button>
											</div>
									</div>
																
						
								</c:when>
							</c:choose>
						</c:forEach>
				</div>
				<!-- 완료 목록 보기 : 끝  -->
							   
</div>
<!-- 투두리스트 종료 -->			
</body>
</html>