<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
//클릭 하면 열고 닫기 : 할일 목록 상세보기 (Detail, Edit , Delete 있는 거 )
$(function(){
	$(".modify-fix-div").hide();
	$(".modify-origin-div").show();
	
	$(".modify-origin-div").click(function() {
        $(this).parent().children(".modify-fix-div").show('3000');
        $(this).hide('fast');
	    $(".modify-origin-div").hide();
    });
	
	//취소 버튼 
	$(".modify-cancel").click(function(){
		$(this).parent().parent().children(".modify-origin-div").show('3000');
        $(this).parent().parent().children(".modify-fix-div").hide('fast');
        $(".modify-origin-div").show();
	})
});


</script>

<body>
<!-- 할일 전체 목록 -->
				<div id="list-content">
					
				돌아가기  <span></span> <input type="checkbox" class="todo_list" value="돌아가기">	
			   <h2> 완료 목록 </h2>
			   
		<c:forEach items="${todoPerAll}" var="todoListJoinVO">
			<c:choose>
				<c:when test="${todoListJoinVO.todo_list_done=='완료'}">
				
					<!--할일 목록 누르면 할일상세페이지(<div id="show_detail">)로 이동 -->
						<div class="all-div">
								<div class="modify-origin-div">
								
									<div class="todo-title">
											<span> ${todoListJoinVO.todo_list_content} ${todoListJoinVO.topic_name} / ${todoListJoinVO.todo_list_done}"</span>
										
											<br>
											
											

											<!--할일 진행중으로 돌리기 -->			
												<input type="submit" onclick="TodoBackDone(${todoListJoinVO.team_no},${todoListJoinVO.topic_no},${todoListJoinVO.todo_list_no})" value="진행">
											
								<span></span>
								<!-- 할일 삭제하기 -->

									<input type="button" onclick="TodoDelete(${todoListJoinVO.team_no},${todoListJoinVO.topic_no},${todoListJoinVO.todo_list_no})" value="삭제">


									</div>
								
							</div>
	


							<!-- todo_list_detail 부분 -->
							<div class="modify-fix-div">

									<button class="modify-cancel">닫기 </button>
								
									

								
							</div>
					</div>
												
	
	
		
		</c:when>
		</c:choose>
	</c:forEach>
			   </div>
			   

     <!-- 투두리스트 종료 -->
</body>
