<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="${pageContext.request.contextPath}/chat/todo_list_delete" method="post">
<input type="hidden" name="team_no"	value="${param.team_no}">
<input type="hidden" name="topic_no"	value="${param.topic_no}">
<%-- <input type="hidden" name="todo_list_no" value="${param.todo_list_no}"> --%>
<input type="submit" value="삭제">
								
</form>
</body>
</html>