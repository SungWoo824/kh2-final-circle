<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
		

</script>

<body>
<div id = todo_list_all>
	<div id="todo_list_btn_all"> 
				 <p> 검색결과 페이지에 있음 </p>              
				<!-- 할일 검색하기 비동기 -->
				<input type="text" id="todo_list_content" name="todo_list_content" placeholder="비동기 검색">
				<input type="submit" id="submit-search" onclick="TodoSearch()" value="검색">
					<br><br>
							
				<!-- 할일 추가하기 버튼 -->
<!-- 				<form action="todo_list_create" method="post"> -->
					 <input type="hidden" id="todo_list_no_create" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
					 <input type="hidden" name="team_no" value="${param.team_no}">
					 <input type="hidden" name="topic_no" value="${param.topic_no}">
					 <input type="text" id="todo_list_content_create" name="todo_list_content" placeholder="할일을 추가하세요" required>
					 <input type="submit" onclick="TodoCreate()" value="추가">
<!-- 				</form> -->
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
			</div>		
			
	        	
			   <!-- 완료 버튼 누르면 목록에서 사라지기  -->
			   <div id="list-done"></div>	
			   
				<!-- 개수 나오는 곳 출력 -->
	        	<div id="count_todo">
				<p>${countTodo} 개의 할일</p>
	        	</div>
	        	
			   	<br><br>
			   	
			   	<!-- 검색 결과 보기 -->
				<h2>검색결과</h2>
					<c:forEach items="${searchTodo}" var="todoListJoinVO">
						<hr>	
						<a href="${pageContext.request.contextPath}/chat/todo_list_detail?todo_list_no=${todoListJoinVO.todo_list_no}">
						${todoListJoinVO.todo_list_content} ${todoListJoinVO.topic_name} / ${todoListJoinVO.todo_list_done}
						</a>
						<hr>
					</c:forEach>
	
				<!-- 할일 전체 목록 -->
				<div id="list-content">
					
					<p>할일 전체 목록보기	</p> 
							
							
					<c:forEach items="${todoPerAll}" var="todoListJoinVO">
						
						<!-- 진행중인 목록만 뽑는다 / 완료버튼 누르면 목록에서 사라짐-->
						<c:choose>
							<c:when test="${todoListJoinVO.todo_list_done=='진행'}">
<!-- 								<hr>  -->
								
								<form action ="todo_list_detail" method="get">
								
								
								</form>
								
<!-- 								할일 목록 누르면 할일상세페이지(todo_list_detail)로 이동 -->
								<a href="${pageContext.request.contextPath}/chat/todo_list_detail?todo_list_no=${todoListJoinVO.todo_list_no}&team_no=${todoListJoinVO.team_no}&topic_no=${todoListJoinVO.topic_no}&todo_list_content=${todoListJoinVO.todo_list_content}">
								          ${todoListJoinVO.todo_list_content} ${todoListJoinVO.topic_name} / ${todoListJoinVO.todo_list_done}
								</a>
									<span></span>
											
								<!-- 할일 완료 시키기 -->	
<!-- 								<form action="todo_done" method="get"> -->
									<input type="hidden" name="team_no" value="${todoListJoinVO.team_no}">
									<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}">
									<input type="hidden" id="todo_list_no_done" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
<%-- 									<input type="hidden" name="member_no" value="${todoListJoinVO.member_no}"> --%>
									<input type="submit" onclick="TodoDone()" value="완료">
<!-- 								</form> -->
									<span></span>
								
								<!--할일 진행중으로 돌리기 -->			
								<form action="todo_back_done" method="post">
									<input type="hidden" name="team_no" value="${todoListJoinVO.team_no}">
									<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}">
									<input type="hidden" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
									<input type="submit" id="submit-back-done" onclick="TodoBackDone()" value="진행으로 돌리">
								</form>
							</c:when>
						</c:choose>
<!-- 							<hr> -->
					</c:forEach>
		  	   </div>
		  	   
		  	   <!-- 투두 메인으로 돌아오기 -->
			   <!--비동기 검색 결과   -->
			   <div id="todo-list-search"></div>
			 	
										
			   <!-- 할일 추가 된 것 결과 -->									
			   <div id="todo-create"></div>				
								
							
			   
			   <!-- 완료 목록보기   -->		
			   <div id="list-done-result"></div>

     </div>
  
     <!-- 투두리스트 종료 -->
     

</body>
</html>