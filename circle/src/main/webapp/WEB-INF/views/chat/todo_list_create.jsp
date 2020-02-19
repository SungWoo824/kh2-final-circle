<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
 
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">   
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.addons.css">

	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/layoutstyle.css">
    <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/common.css" />
    
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>


<script>
$(function(){
	$("#toggle1").click(function(){
		$(".menu1-slide").toggle();
	});
	
	$("#toggle4").click(function(){
		$(".menu4-slide").toggle();
	});
	
	$("#toggle33").click(function(){
		$(".menu33-slide").toggle();
	});
});
</script>
</head>
<body>



						
				        

				<!-- 소희 : 투두 리스트 임시 버튼 -->
            	<div id="gnb-detail-slide">
			            <div class ="menu33-slide">d</div>
			            
			            <!-- 주소 변경했음 -->
	        			<div id="bodyContents" class="menu33-slide">   
	        			
							<a href="./topic_main?team_no=${param.team_no }&topic_no=${param.topic_no }"><button id="golist" >목록으로</button></a>
	        				
				            <h3>투두 리스트</h3>
				            
				            <!-- 할일 검색하기 -->
				            <form action="todo_list_search" method="post">
				            	<input type="search" name="todo_list_content" placeholder="할일의 제목을 입력하세요">
				            	<input type="submit" value="검색">
				            </form>

							<!-- 할일 추가하기 버튼 -->
							<form action="todo_list_create" method="post">
								<input type="hidden" name="team_no" value="${param.team_no}">
								<input type="hidden" name="topic_no" value="${param.topic_no}">
								<input type="text" name="todo_list_content" required>
								<input type="submit" value="추가">
							</form>
								<!-- 할일 목록 -->
								<p>할일 목록보기	</p>
								
								<c:forEach items="${todoPerAll}" var="todoListJoinVO">
								<hr> 
									<!-- 할일 목록 누르면 할일상세페이지(todo_list_detail)로 이동 -->
									<a href="${pageContext.request.contextPath}/chat/todo_list_detail?todo_list_no=${todoListJoinVO.todo_list_no}">
									${todoListJoinVO.todo_list_content} ${todoListJoinVO.topic_name}
									</a>
									
								<hr>
								
								</c:forEach>						
								</div>
							
							
	        
				            </div>
			        </div>


            <!-- Page Title Header Ends-->      

			

                   	








      <!-- page-body-wrapper ends -->
    <script src="${pageContext.request.contextPath}/resources/js/design/vendor.bundle.base.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/design/vendor.bundle.addons.js"></script>
    


</body>
 </html>
