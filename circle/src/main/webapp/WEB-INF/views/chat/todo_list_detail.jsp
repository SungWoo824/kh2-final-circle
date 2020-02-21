<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>할일 상세보기 페이지</title>
</head>
<body>
<h3>할일 상세보기 페이지</h3>

<!-- 할일 수정  -->
<p>할일 수정하기</p>
	<form action="todo_list_edit" method="post">
		<input type="hidden" name="team_no"	value="${param.team_no}">
		<input type="hidden" name="todo_list_no" value="${param.todo_list_no}">
		<input type="hidden" name="topic_no" value="${param.topic_no}">
		<textarea type="text" name="todo_list_content" value="${param.todo_list_content}">
			${param.todo_list_content}
		</textarea>
		<input type="submit" value="수정">
	</form>	

<br><hr>
	<form action="todo_list_delete" method="post">
		<input type="hidden" name="team_no"	value="${param.team_no}">
		<input type="hidden" name="topic_no"	value="${param.topic_no}">
		<input type="hidden" name="todo_list_no" value="${param.todo_list_no}">
<%-- 		<input type="hidden" name="todo_list_content" value="${param.todo_list_content}"> --%>
	<input type="submit" value="삭제">
								
</form>
</body>
</html>