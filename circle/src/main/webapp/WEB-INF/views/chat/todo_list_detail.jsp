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
</script>
</head>
<body>
<h3>할일 상세보기 페이지</h3>

<!-- 할일 수정  -->
<p>할일 수정하기</p>
	<form action="todo_list_edit" method="post">
		<input type="hidden" name="team_no"	value="${todoListJoinVO.team_no}">
		<input type="hidden" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
		<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}">
		<textarea name="todo_list_content" value="${todoListJoinVO.todo_list_content}">${todoListJoinVO.todo_list_content}</textarea>
		<input type="submit" value="수정">
	</form>	

<br><hr>
	<form action="todo_list_delete" method="post">
		<input type="hidden" name="team_no"	value="${todoListJoinVO.team_no}">
		<input type="hidden" name="topic_no"	value="${todoListJoinVO.topic_no}">
		<input type="hidden" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
<%-- 		<input type="hidden" name="todo_list_content" value="${param.todo_list_content}"> --%>
	<input type="submit" onclick="TodoDelete" value="삭제">
								
</form>
</body>
</html>