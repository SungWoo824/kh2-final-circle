<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<body>
<!-- 검색 결과 보기 -->
<h2>검색결과</h2>
	<c:forEach items="${searchTodo}" var="todoListJoinVO">
		<hr>	
		<a href="${pageContext.request.contextPath}/chat/todo_list_detail?todo_list_no=${todoListJoinVO.todo_list_no}">
		${todoListJoinVO.todo_list_content} ${todoListJoinVO.topic_name}
		</a>
		<hr>
	</c:forEach>
</body>
</html>