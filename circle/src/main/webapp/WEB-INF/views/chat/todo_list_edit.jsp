<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>할일 수정 페이지 결과</title>
</head>
<body>
<p>수정 완료 페이지 입니다 </p>
							<!-- todo_list_detail 부분 -->
							<div class="modify-fix-div">

								<!-- 할일 수정  -->
								<p>할일 수정하기</p>
<!-- 									<form action="todo_list_edit" method="post"> -->
										<input type="hidden" name="team_no"	value="${todoListJoinVO.team_no}">
										<input type="hidden" id="todo_list_no_edit" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
										<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}">
										<textarea id="todo_list_content_edit" name="todo_list_content" value="${todoListJoinVO.todo_list_content}">${todoListJoinVO.todo_list_content}</textarea>
										<input type="submit" onclick="EditTodo()" value="수정">
<!-- 									</form>	 -->
								
								<!-- 할일 삭제하기 -->
								<br>
									<input type="hidden" name="team_no"	value="${todoListJoinVO.team_no}">
									<input type="hidden" name="topic_no" value="${todoListJoinVO.topic_no}">
									<input type="hidden" id="todo_list_no_delete" name="todo_list_no" value="${todoListJoinVO.todo_list_no}">
									<input type="submit" onclick="TodoDelete()" value="삭제">
									<button class="modify-cancel">닫기 </button>
							</div>
			

</body>
</html>