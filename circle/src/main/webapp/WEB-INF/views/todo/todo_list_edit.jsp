<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<html>

<!-- 투두 리스트 관련 스크립트 -->
<script>
// 검색 결과창 숨기기 
$(function(){
	$("#todo_search_result").hide();
});

//할일 추가 하기 열고 닫기 
$(function(){
	
	$("#todo_create_btn").show();
	$("#todo_create_show").hide();
	
		$("#todo_create_btn").click(function() {
			$("#todo_create_show").show('3000');
			$("#todo_create_btn").hide('fast');
	});
		$("#todo_create_btn").blur(function() {
			$("#todo_create_btn").show();
			$("#todo_create_show").hide();
		});	
		

		$("#create_cancle").click(function(){
// 			$(this).parent().parent().children("#todo_create_btn").show('3000');
// 	        $(this).parent().parent().children("#todo_create_show").hide('fast');
	        $("#todo_create_btn").show('3000');
			$("#todo_create_show").hide('fast');
		});
});


//클릭 하면 열고 닫기 : 할일 목록 상세보기 (Detail, Edit , Delete 있는 거 )

// $(function(){
// 	$(".modify-fix-div").hide();
// 	$(".modify-origin-div").show();
	
// 	$(".modify-origin-div").click(function() {
//       $(this).parent().children(".modify-fix-div").show('3000');
//       $(this).hide('fast');
// 	    $(".modify-origin-div").hide();
//   });
	
// 	//취소 버튼 
// 	$(".modify-cancel").click(function(){
// 		$(this).parent().parent().children(".modify-origin-div").show('3000');
//       $(this).parent().parent().children(".modify-fix-div").hide('fast');
//       $(".modify-origin-div").show();
// 	})
// });

//할일 클릭 하면 열고 닫기 : 할일완료 목록 보기 )
// $(function(){
// 	$("#list-done-result").hide();
// // 	$("#list-content").show();
	
// 	$(".todo_done_result").click(function() {
//         $("#list-done-result").show();
// //         $(this).hide('fast');
// 	    $("#todo_list_all").hide();
//     });
	
// 	//돌아가기 
// 	$(".todo_list").click(function(){
// 		$("#todo_list_all").show('3000');
// 		$("#list-done-result").hide();
// // 		$("#list-content").show();
// 	})
// });

$(function(){
	$("#list-done-result").hide();
	$("input[name=todo_done_result]").change(function(){	
		if($(this).prop("checked")){
			$("#list-done-result").show();
// 			 $(this).hide('fast');
// 		 	    $("#todo_main_list").hide();
		}
		else{
	 		$("#todo_list_all").show('3000');
	 		$("#list-done-result").hide();
// 			$("#todo_main_list").show();	
		}
	});
});

//완료 목록 삭제하기 
function TodoDoneDelete(team_no,topic_no,todo_list_no){
// 	var member_no = ${member_no};
// 	var todo_list_no = $("#todo_list_no_delete"+todo_list_no).val();  //인풋에 있는 벨류를 가져올게 
// 	var team_no = ${param.team_no};
// 	var topic_no = ${param.topic_no};

// 	var url=$('#form_todo_delete').attr('action');
// 		var deleteData=$('#form_todo_delete').serialize();
	
		var  ajaxOption = {
			url : "${pageContext.request.contextPath}/todo/todo_list_done_delete?team_no="+team_no+"&topic_no="+topic_no+"&todo_list_no="+todo_list_no,
			type : "post",
			dataType : "html",
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){
			$('#list-content').html(data);

			});
}


//진행중인 할일 보기 
$(function(){
	
// 	$("#todo_main_list").hide();
	$("input[name=before_todo_done]").change(function(){
		
		if($(this).prop("checked")){
		 	    $("#todo_main_list").show();
// 			$("#list-done-result").hide();
// 			 $(this).hide('fast');
		}
		else{
// 	 		$("#todo_list_all").hide('3000');
// 	 		$("#list-done-result").show();
			$("#todo_main_list").hide();
			
		}
		
	});
		
	
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
// 			$('#todo_list_all').html(data);
			$('#list-content').html(data);
			
		});
}


//할일 완료 버튼 누르기 
function TodoDone(team_no,topic_no,todo_list_no){
	
// 	var team_no = ${param.team_no};
// 	var topic_no = ${param.topic_no}
// 	var member_no = ${member_no};
// 	var todo_list_no = $("#todo_list_no_done").val();
	
	var  ajaxOption = {
			url : "${pageContext.request.contextPath}/todo/todo_done?team_no="+team_no+"&topic_no="+topic_no+"&todo_list_no="+todo_list_no,
			type : "post",
			dataType : "html",
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){
// 				$('#count-todo').hide();
				$('#list-content').html(data);
// 				$('#list-content').hide();
// 				$('#list-done').html(data);
			});
	
}


//할일 진행 버튼 누르기 
function TodoBackDone(team_no,topic_no,todo_list_no){
	
// 	var team_no = ${param.team_no};
// 	var topic_no = ${param.topic_no}
// 	var member_no = ${member_no};
// 	var todo_list_no = $("#todo_list_no_done").val();
	
	var  ajaxOption = {
			url : "${pageContext.request.contextPath}/todo/todo_back_done?team_no="+team_no+"&topic_no="+topic_no+"&todo_list_no="+todo_list_no,
			type : "post",
			dataType : "html",
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){
// 				$('#count-todo').hide();
								$('#list-done-result').html(data);
				$('#list-content').hide();
// 				$('#list-done').html(data);
			});
	
}

//투두 리스트 검색 결과 비동기
function TodoSearch(){
	
var topic_no = ${param.topic_no};
	var team_no = ${param.team_no};
	var member_no = ${member_no};
	var todo_list_content = $("#todo_list_content").val();  //인풋에 있는 벨류를 가져올게 

		var  ajaxOption = {
			url : "${pageContext.request.contextPath}/todo/todo_list_search_result",
			type : "post",
			dataType : "html",
			data : {team_no:team_no, member_no:member_no, todo_list_content:todo_list_content,topic_no:topic_no},
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){
// 				$('#todo-list-search').html(data);
// 				$('#list-content').hide();
				$('#list-content').html(data);
				$('#todo_main_list').hide();
// 				$('#todo_list_btn_all').hide();
			});
		
}



//할일 완료 목록 불러오
// function todoDoneList(){
// 	var member_no = ${member_no};
// 	var todo_list_no = $("#todo_list_no").val();  //인풋에 있는 벨류를 가져올게 
// 	var team_no = ${param.team_no};
// 	var topic_no = ${param.topic_no};
// 	var todo_list_content = $("#todo_list_content").val();


// 		var  ajaxOption = {
// 			url : "./todo_done_result",
// 			type : "GET",
// 			dataType : "html",
// 			data : {team_no:team_no, member_no:member_no,topic_no:topic_no, todo_list_no:todo_list_no,todo_list_content:todo_list_content},
// 			cache : false
// 	};
// 		$.ajax(ajaxOption).done(function(data){

			
// // 			if($("input[name=todo_done_list]").prop('checked', true)) {
// // 				$('#list-done-result').html(data);


// 				$('#list-done-result').html(data);
// 				$('#list-content').hide();
// 				$('#todo-list-search').hide();
// 			});
// }




//수정하기 상세페이지 이동 TodoDetail
// function TodoDetail(team_no,todo_list_no,topic_no,todo_list_content){

// 		var  ajaxOption = {
// 			url : "${pageContext.request.contextPath}/todo/todo_list_detail?team_no="+team_no+"&todo_list_no="+todo_list_no+"&topic_no="+topic_no+"&todo_list_content="+todo_list_content,
// 			type : "get",
// 			dataType : "html",
// 			cache : false
// 	};
// 		$.ajax(ajaxOption).done(function(data){

// // 				$('#todo-edit').html(data);
// 				$('#list-content').html(data);
				
// 			});
// }

//디테일 2번째 방법  : 현재는 이걸로 사용 중 
function TodoDetail(team_no,todo_list_no,topic_no){
// 	var todo_list_no = $("#todo_list_no_edit").val();  //인풋에 있는 벨류를 가져올게 
// 	var team_no = ${param.team_no};
// 	var topic_no = ${param.topic_no};
	var todo_list_content = $("#todo_list_content_detail"+todo_list_no).val(); 


		var  ajaxOption = {
			url :"${pageContext.request.contextPath}/todo/todo_list_detail?team_no="+team_no+"&todo_list_no="+todo_list_no+"&topic_no="+topic_no,
			type : "get",
			dataType : "html",
			data : {todo_list_content:todo_list_content},
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){
				$('#list-content').html(data);
// 				$('#todo-edit').html(data);
// 				$('#list-content').hide();
// 				$(".todo-title").hide();
				$(this).parent().children(".modify-fix-div").show();
			});
}



//할일 수정하기
function EditTodo(team_no,todo_list_no,topic_no){
// 	var todo_list_no = $("#todo_list_no_edit").val();  //인풋에 있는 벨류를 가져올게 
// 	var team_no = ${param.team_no};
// 	var topic_no = ${param.topic_no};
	var todo_list_content = $("#todo_list_content_edit"+todo_list_no).val(); 

	


		var  ajaxOption = {
			url :"${pageContext.request.contextPath}/todo/todo_list_edit?team_no="+team_no+"&todo_list_no="+todo_list_no+"&topic_no="+topic_no,
			type : "post",
			dataType : "html",
			data : {todo_list_content:todo_list_content},
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){
				$('#list-content').html(data);
// 				$('#todo-edit').html(data);
// 				$('#list-content').hide();
// 				$(".todo-title").hide();
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
		});
}


</script>

<body>


   	<!-- 할일 전체 목록 : 시작 -->
	<div id="list-content">
		
	   <!--  엑스버튼 / 할 일 제목 , 카운트 개수 : 시작  -->
	   <div class="slide-close"> 
	       <ul>
		       <li class="slide-close-btn">
		      		 <a class="fa fa-times" style="color: white" alt="닫기"> </a> 
		       </li>
	       </ul>
	       
	       	  
	       	  <!-- 할 일 제목 , 카운트 개수  -->
	       	  <div class="p-3 mb-2 bg-primary text-white" style="text-align:center; height: 70px" >
		      <p> 할 일<span class="badge badge-light">${countTodo} </span>       </p>
<!-- 	       		투두 리스트 메인목록보기 :시작 -->
			
						<span style="cursor:pointer; color: white;">할 일 메인 목록 보기
<!-- 						<i class="fas fa-fw fa-home"></i> -->
						<input type="checkbox" class="fas fa-fw fa-home" onclick="HomeTodo(${param.team_no},${param.topic_no},${todoListJoinVO.member_no})" value="처음으로" style="cursor:pointer; color: white;">
						</span>
<!-- 					투두 리스트 메인목록보기 : 종료 	 -->
	       	  </div>
	   </div>
	   <!--  엑스버튼 / 할 일 제목 , 카운트 개수 : 종료  -->   
   <br>
   

	
	<div id="todo_list_all">
		<div id="todo_list_btn_all"> 
			
			   <!-- 할일 추가하기 버튼 -->
			   <br>
			   <div id="todo_create_btn" style="text-align:center;">
			   <i class="fa fa-fw fa-plus"></i>
			   <span>할 일 추가하기 </span>
			   </div>
			   
			   <div id="todo_create_show" >
				   <form action="todo_list_create" method="post" id="form_todo_create">
						
						<input type="hidden" id="todo_list_no_create" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
						<input type="hidden" name="team_no" value="${param.team_no}">
						<input type="hidden" name="topic_no" value="${param.topic_no}">
	<!-- 					<input type="text" id="todo_list_content_create" name="todo_list_content" placeholder="할일을 추가하세요"> -->
	<!-- 					<input type="button" onclick="TodoCreate()" value="추가"> -->
						<input class="form-control mx-sm-3 mb-2" type="text" id="todo_list_content_create" name="todo_list_content" style="width:200;  float:left; margin-right:10px;" placeholder="할 일을 추가하세요">
							<span>
						<input class="btn btn-primary" type="button" onclick="TodoCreate()" style="float:left; margin-right:10px;" value="추가">
						<button class="btn btn-primary" id="create_cancle" type="button">닫기 </button>
							</span>
				   </form>
			   </div>
				<hr>
				
	
					<!-- 할일 검색하기 비동기 -->
					<input type="text" class="form-control mx-sm-5 mb-2" id="todo_list_content" name="todo_list_content" placeholder="검색" style="width:200; float:left; margin-right:10px;">
					<input type="submit" class="btn btn-primary" id="submit-search" onclick="TodoSearch()" value="검색" style="float:left; margin-right:10px;" >
				<br>
				<br>
				<br>
						
					<!--진행  목록 보기 체크박스 : 시작  -->
						 <span>진행중인 할일 보기</span>
						 <input type="checkbox" class="before_todo_done" name="before_todo_done" value="진행중인 할일 보기" checked>
					<!--진행  목록 보기 체크박스 : 종료  -->	
					
					<!--완료 목록 보기 체크박스 : 시작  -->
						<span> 완료된 할 일 보기</span> 
						<input type="checkbox" class="todo_done_result" name="todo_done_result" value="완료된 할일 보기">
					<!--완료 목록 보기 체크박스 : 종료  -->		
				<hr>
		</div>		
   	
	        <!-- 검색 결과 보기 : 시작  --> 
			<div id="todo_search_result">

				   	<!-- 검색 개수 출력 : 시작 -->
		        	<div id="count_search" style="text-align: center;">
		        		<h3 style="color: grey"> '${todo_list_content}' 검색 결과 </h3>
						<p>${countSearch} 개의 검색 결과가 있습니다</p>
		        	</div>
		        	
		        	<!-- 검색 개수 출력 : 종료 -->
						<c:forEach items="${searchTodo}" var="todoListJoinVO">
							<hr>	
							
							<!--할일 목록 누르면 할일상세페이지(<div id="show_detail">)로 이동 : 시작 -->
						<div class="all-div">
								<div class="modify-origin-div">
								
									<div class="todo-title" style=" margin-left:10px;">
											<span>할 일 제목 : [ ${todoListJoinVO.todo_list_content} ]</span>
											
											
											<input type="hidden" id="todo_list_content_detail${todoListJoinVO.todo_list_no}" name="todo_list_content" value="${todo_list_content}">
												<input type="checkbox" class="fa fa-fw fa-pen" style="float:right; margin-right:10px;" onclick="TodoDetail(${todoListJoinVO.team_no},${todoListJoinVO.todo_list_no},${todoListJoinVO.topic_no})" value="수정하기">
												<span style="float:right; margin-right:10px;">수정하기</span>
						
						<!--할일 목록 누르면 할일상세페이지(<div id="show_detail">)로 이동 : 종료 -->					
				   
											<br>
											<span> 토픽 방 이름 : [ ${todoListJoinVO.topic_name} ]</span>
											<!-- 할일 완료 시키기 : 시작 -->	
												<input type="checkbox"  class="fa fa-fw fa-heart fill" style="float:right; margin-right:10px;" onclick="TodoDone(${todoListJoinVO.team_no},${todoListJoinVO.topic_no},${todoListJoinVO.todo_list_no})" value="완료">
													<span style="float:right; margin-right:10px;">완료하기</span>
											<!-- 할일 완료 시키기 : 종료-->		
											
											<br>
											<!-- 진행중인 할일 삭제 하기 : 시작  -->
												<input type="checkbox"  class="fa fa-fw fa-trash fill" style="float:right; margin-right:10px;" onclick="TodoDelete(${todoListJoinVO.team_no},${todoListJoinVO.topic_no},${todoListJoinVO.todo_list_no})" value="완료">
												<span style="float:right; margin-right:10px;">삭제하기</span>
											<!-- 진행중인 할일 삭제 하기 : 종료  -->
											<br>
									</div>
			
							   </div>

					</div>
							
							
						</c:forEach>
			   	</div>
			   	<!-- 검색 결과 보기 :끝  --> 
					
			<!-- 할일 메인 리스트 : 시작  -->
			<div id="todo_main_list">
			
				<!-- 진행중인 할일 개수 나오는 곳 출력 -->
	        	<div id="count_todo" style="text-align: center;">
					<h3 style="color: grey"> 진행 중인 할 일 목록 </h3>
					<p>${countTodo} 개의 할 일이 있습니다</p>
	        	</div>

					<c:forEach items="${todoPerAll}" var="todoListJoinVO">
						
						<!-- 진행중인 목록만 뽑는다 / 완료버튼 누르면 목록에서 사라짐-->
						<c:choose>
							<c:when test="${todoListJoinVO.todo_list_done=='진행'}">
								<hr> 

						<!--할일 목록 누르면 할일상세페이지(<div id="show_detail">)로 이동 : 시작 -->
						<div class="all-div">
								<div class="modify-origin-div">
								
									<div class="todo-title" style=" margin-left:10px;">
											<span>할 일 제목 : [ ${todoListJoinVO.todo_list_content} ]</span>
											
												<input type="hidden" id="todo_list_content_detail${todoListJoinVO.todo_list_no}" name="todo_list_content" value="${todo_list_content}">
												<input type="checkbox" class="fa fa-fw fa-pen" style="float:right; margin-right:10px;" onclick="TodoDetail(${todoListJoinVO.team_no},${todoListJoinVO.todo_list_no},${todoListJoinVO.topic_no})" value="수정하기">
												<span style="float:right; margin-right:10px;">수정하기</span>
						<!--할일 목록 누르면 할일상세페이지(<div id="show_detail">)로 이동 : 종료 -->					
				   
											<br>
											<span> 토픽 방 이름 : [ ${todoListJoinVO.topic_name} ]</span>
											<!-- 할일 완료 시키기 : 시작 -->	
												<input type="checkbox"  class="fa fa-fw fa-heart fill" style="float:right; margin-right:10px;" onclick="TodoDone(${todoListJoinVO.team_no},${todoListJoinVO.topic_no},${todoListJoinVO.todo_list_no})" value="완료">
													<span style="float:right; margin-right:10px;">완료하기</span>
											<!-- 할일 완료 시키기 : 종료-->		
											
											<br>
											<!-- 진행중인 할일 삭제 하기 : 시작  -->
												<input type="checkbox"  class="fa fa-fw fa-trash fill" style="float:right; margin-right:10px;" onclick="TodoDelete(${todoListJoinVO.team_no},${todoListJoinVO.topic_no},${todoListJoinVO.todo_list_no})" value="완료">
												<span style="float:right; margin-right:10px;">삭제하기</span>
											<!-- 진행중인 할일 삭제 하기 : 종료  -->
											<br>
									</div>
			
							   </div>

					</div>

							</c:when>
						</c:choose>
					</c:forEach>
					
							<hr>
		  	   </div>
		 </div>
	</div> 	   
	<!-- 할일 메인 리스트 :  끝  --> 	  	   
	
			   
			   <!-- 완료 목록 보기 :시작  -->		
			   <div id="list-done-result">
			    <br>

				    <!-- 개수 나오는 곳 출력 -->
		        	<div id="count_done" style="text-align: center;">
		        		<h3 style="color: grey"> 완료된 할 일 목록 </h3>
						<p>${countDone} 개의 완료가 있습니다</p>
		        	</div>
			   	<hr>
						<c:forEach items="${todoPerAll}" var="todoListJoinVO">
							<c:choose>
								<c:when test="${todoListJoinVO.todo_list_done=='완료'}">
								
									<!--할일 목록 누르면 할일상세페이지(<div id="show_detail">)로 이동 -->
										<div class="all-div">
												<div class="modify-origin-div">
													<div class="todo-title" style=" margin-left:10px;">
														<span>할 일 제목 : [ ${todoListJoinVO.todo_list_content} ]</span>
														<br>
														<span>토픽 방 이름 : [ ${todoListJoinVO.topic_name} ] </span>
														
															
				
															<div style="float:right; margin-right:10px;">
																<!--할일 진행중으로 돌리기 -->			
	<%-- 															<input type="submit"  onclick="TodoBackDone(${todoListJoinVO.team_no},${todoListJoinVO.topic_no},${todoListJoinVO.todo_list_no})" value="진행"> --%>
																
																<!--  완료 목록 삭제하기 -->
																<input type="checkbox" class="fa fa-fw fa-trash fill" onclick="TodoDoneDelete(${todoListJoinVO.team_no},${todoListJoinVO.topic_no},${todoListJoinVO.todo_list_no})">
															</div>
				<hr>
													</div>
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