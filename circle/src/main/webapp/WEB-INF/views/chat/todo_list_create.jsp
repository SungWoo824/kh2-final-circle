<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    

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
<!-- 								<hr>  -->

<!-- 								할일 목록 누르면 할일상세페이지(todo_list_detail)로 이동 -->
								<a href="${pageContext.request.contextPath}/chat/todo_list_detail?todo_list_no=${todoListJoinVO.todo_list_no}&team_no=${todoListJoinVO.team_no}&topic_no=${todoListJoinVO.topic_no}&todo_list_content=${todoListJoinVO.todo_list_content}">
								          ${todoListJoinVO.todo_list_content} ${todoListJoinVO.topic_name} / ${todoListJoinVO.todo_list_done}
								</a>
									<span></span>
											
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
							</c:when>
						</c:choose>
<!-- 							<hr> -->
					</c:forEach>
		  	   </div>
</body>
</html>