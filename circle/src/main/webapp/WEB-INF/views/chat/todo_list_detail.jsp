<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="todo_list_create" method="post">
<input type="hidden" name="team_no"	value="${param.team_no}">
<input type="hidden" name="todo_list_no" value="${param.todo_list_no}">
<input type="submit" value="삭제">
								
</form>
</body>
</html>