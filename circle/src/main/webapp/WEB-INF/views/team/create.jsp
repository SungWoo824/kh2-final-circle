<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>   
<script>
$(function(){
	//입력을 마치면(blur) 비동기통신으로 아이디 유무를 검사 
	$("input[name=team_name]").blur(function(){
		var team_name = $(this).val();
		$.ajax({
			url:"${pageContext.request.contextPath}/team/check",
			type:"get",
			data:{team_name : team_name},
			dataType:"text",
			success:function(resp){
// 				console.log(resp);
			if(resp === "Y"){ //사용중
				$("input[name=team_name]").next("span").text("사용중인 팀이름");
			}
				
			else if(resp === "N"){ //사용가능
				$("input[name=team_name]").next("span").text("사용가능합니다");
			} 
			
			}
		});
	});
});
$(function(){
	//팀 도메인 이름 중복 확인
	$("input[name=team_domain]").blur(function(){
		var team_domain = $(this).val();
		$.ajax({
			url:"${pageContext.request.contextPath}/team/check2",
			type:"get",
			data:{team_domain : team_domain},
			dataType:"text",
			success:function(resp){
// 				console.log(resp);
			if(resp === "Y"){ //사용중
				$("input[name=team_domain]").next("span").text("사용중인 도메인");
			}
				
			else if(resp === "N"){ //사용가능
				$("input[name=team_domain]").next("span").text("사용가능합니다");
			} 
			
		
			}
		});
	});


});
</script>
 <form action="create" method="post">
<h1>팀생성 create 페이지</h1>

	<h1>팀 이름</h1> <input type="text" name="team_name" required>
<span></span>
<br>
<br>

	<h1>팀 도메인</h1> <input type="text" name="team_domain" required>
<span></span>
<br>
<br>



<input type="submit" value="팀 생성하기">
<br>
<br>
 </form>