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
			type : "post",
			dataType : "html",
			data : {todo_list_content:todo_list_content},
			cache : false
	};
		$.ajax(ajaxOption).done(function(data){
// 				$('#list-content').html(data);
// 				$('#todo-edit').html(data);
				$('#list-content').html(data);
// 				$(".todo-title").hide();
// 				$(this).parent().children(".modify-fix-div").show();
			});
}

</script>


</head>
<body>

<!-- 할일 수정  -->
<p>디테일 페이지</p>
<!-- 	<form action="todo_list_edit" method="post"> -->
<%-- 		<input type="hidden" name="team_no"	value="${todoListJoinVO.team_no}"> --%>
<%-- 		<input type="hidden" name="todo_list_no" value="${todoListJoinVO.todo_list_no}"> --%>
<%-- 		<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}"> --%>
<%-- 		<textarea name="todo_list_content" value="${todoListJoinVO.todo_list_content}">${todoListJoinVO.todo_list_content}</textarea> --%>
<!-- 		<input type="submit" value="수정"> -->
<!-- 	</form>	 -->

<!-- <br><hr> -->
<!-- 	<form action="todo_list_delete" method="post"> -->
<%-- 		<input type="hidden" name="team_no"	value="${todoListJoinVO.team_no}"> --%>
<%-- 		<input type="hidden" name="topic_no"	value="${todoListJoinVO.topic_no}"> --%>
<%-- 		<input type="hidden" name="todo_list_no" value="${todoListJoinVO.todo_list_no}"> --%>
<%-- <%-- 		<input type="hidden" name="todo_list_content" value="${param.todo_list_content}"> --%> 
<!-- 	<input type="submit" onclick="TodoDelete" value="삭제"> -->
<!-- </form> -->


								<!-- 할일 수정  -->
								<p>할일 수정하기 메인 페이</p>

<%-- 										<input type="hidden" name="team_no"	value="${todoListJoinVO.team_no}"> --%>
<%-- 										<input type="hidden" id="todo_list_no_edit" name="todo_list_no" value="${todoListJoinVO.todo_list_no}"> --%>
<%-- 										<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}"> --%>
										<textarea type="text" id="todo_list_content_edit${todoListJoinVO.todo_list_no}" name="todo_list_content">${todoListJoinVO.todo_list_content}</textarea>
										<input type="button" onclick="EditTodo(${todoListJoinVO.team_no},${todoListJoinVO.todo_list_no},${todoListJoinVO.topic_no})" value="수정">

<!-- 									<form action="todo_list_edit" id="form_todo_edit" method="post">  -->
<%-- 										<input type="hidden" name="team_no"	value="${todoListJoinVO.team_no}"> --%>
<%-- 										<input type="hidden" id="todo_list_no_edit" name="todo_list_no" value="${todoListJoinVO.todo_list_no}"> --%>
<%-- 										<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}"> --%>
<%-- 										<textarea id="todo_list_content_edit" name="todo_list_content" value="${todoListJoinVO.todo_list_content}">${todoListJoinVO.todo_list_content}</textarea> --%>
<%-- <%-- 										<input type="button" onclick="EditTodo(${todoListJoinVO.team_no},${todoListJoinVO.todo_list_no},${todoListJoinVO.topic_no})" value="수정"> --%> 
<!-- 											<button type="submit" id="submit_todo_edit">수정 </button> -->
<!-- 									</form> -->
									

								
								<!-- 할일 삭제하기 -->
								<br>
<!-- 								<form action="todo_list_delete" method="get" id="form_todo_delete"> -->
<%-- 									<input type="hidden" name="team_no"	value="${todoListJoinVO.team_no}"> --%>
<%-- 									<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}"> --%>
<%-- 									<input type="hidden" id="todo_list_no_delete${todoListJoinVO.todo_list_no}" name="todo_list_no" value="${todoListJoinVO.todo_list_no}"> --%>
									<input type="button" onclick="TodoDelete(${todoListJoinVO.team_no},${todoListJoinVO.topic_no},${todoListJoinVO.todo_list_no})" value="삭제">
									<button class="modify-cancel">닫기 </button>
<!-- 								</form> -->
							
								
</body>
</html>