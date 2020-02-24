<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<title>완료된 할일 </title>
</head>
<body>
<!-- 완료된 할일 보기 -->
<h2>완료된 할일</h2>
	<c:forEach items="${todoPerAll}" var="todoListJoinVO">
			<c:choose>
				<c:when test="${todoListJoinVO.todo_list_done=='완료'}">
												
		<hr>	
		<a href="${pageContext.request.contextPath}/chat/todo_list_detail?todo_list_no=${todoListJoinVO.todo_list_no}">
		${todoListJoinVO.todo_list_content} ${todoListJoinVO.topic_name} /${todoListJoinVO.todo_list_done}
		</a>
		<!--할일 진행중으로 돌리기 -->			
		<form action="${pageContext.request.contextPath}/todo_list/todo_back_done" method="post">
			<input type="hidden" name="team_no" value="${todoListJoinVO.team_no}">
			<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}">
			<input type="hidden" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
			<button id="done">재진행</button>
		</form>
		<hr>
		
		</c:when>
		</c:choose>
	</c:forEach>
</body>
</html>