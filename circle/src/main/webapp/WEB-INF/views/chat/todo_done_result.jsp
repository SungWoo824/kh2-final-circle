<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
// 투두 리스트 검색 결과 비동기
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
				$('#todo-list-search').html(data);
				$('#list-done-result').hide();
				
			});
		
}


</script>
<title>완료된 할일 </title>
</head>
<body>

				<!-- 할일 검색하기 비동기 -->
				<input type="text" id="todo_list_content" name="todo_list_content" placeholder="비동기 검색">
				<input type="submit" onclick="TodoSearch()" value="검색">
					<br><br>
					<!--비동기 검색 결과   -->
					<p>검색 결과 </p>
			   <div id="todo-list-search"></div>
			   

<!-- 완료 목록보기   -->		
<div id="list-done-result">
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
</div>
	
</body>
</html>