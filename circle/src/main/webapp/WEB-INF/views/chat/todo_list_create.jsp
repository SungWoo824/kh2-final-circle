<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
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

<title>할일 추가하기 페이지</title>

<body>

				<!-- 개수 나오는 곳 출력 -->
	        	<div id="count_todo">
				<p>${countTodo} 개의 할일</p>
	        	</div>
	
			
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
										<textarea type="text" id="todo_list_content_edit" name="todo_list_content">${todoListJoinVO.todo_list_content}</textarea>
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
		  	   
		  	   
</body>
</html>