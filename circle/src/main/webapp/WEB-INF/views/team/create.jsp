<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>   
<script>


	
$(function(){
	
	//등록버튼 비활성화를 위한 준비 
	$('#submitC').attr('disabled',true);//첫 페이지부터 등록버튼 비활성화
	var team_name_check = false;	//일단 네임 체크 변수 만들기
	var team_domain_check = false;	//일단 도메인 체크 변수 만들기
	
	//입력을 마치면(blur) 비동기통신으로 아이디 유무를 검사 
	$("input[name=team_name]").blur(function(){
		var team_name = $(this).val();
		
		if(team_name == ""){   //빈칸이 공란일 때 = 비동기통신이 작동하지 않아서 팀이름 입력
			$("input[name=team_name]").next("span").text("팀이름 입력해주세요");
			team_name_check=false;	
		}
		
		else{	//빈칸이 공란이아닐때 = 비동기통신이 작동하여 팀이름 사용유무 확인가능
			
			$.ajax({
				url:"${pageContext.request.contextPath}/team/check",
				type:"get",
				data:{team_name : team_name},
				dataType:"text",
				success:function(resp){
	// 				console.log(resp);
					if(resp === "Y"){ //사용중
						$("input[name=team_name]").next("span").text("사용중인 팀이름");
						team_name_check=false;	
					} else if(resp === "N"){ //사용가능
						team_name_check=true;
						if(team_name_check && team_domain_check){
							$('#submitC').attr('disabled',false);
						}
						$("input[name=team_name]").next("span").text("사용가능합니다");
						
					} 
				}
			});
		}
		
	});

	//팀 도메인 이름 중복 확인
	$("input[name=team_domain]").blur(function(){
		var team_domain = $(this).val();
		if(team_domain == ""){ //빈칸이 공란일 때 = 비동기통신이 작동하지 않아서 팀이름 입력
			$("input[name=team_domain]").next("span").text("팀이름 입력해주세요");
			team_domain_check=false;
		}
		else{	//빈칸이 공란이 아닐때= 비동기통신이 작동해서 도메인 이름 중복유무 확인가능
			
			$.ajax({
				url:"${pageContext.request.contextPath}/team/check2",
				type:"get",
				data:{team_domain : team_domain},
				dataType:"text",
				success:function(resp){
	// 				console.log(resp);
				if(resp === "Y"){ //사용중
					$("input[name=team_domain]").next("span").text("사용중인 도메인");
					team_domain_check=false;
					} else if(resp === "N"){ //사용가능
						$("input[name=team_domain]").next("span").text("사용가능합니다");
						team_domain_check=true;
						
						if(team_name_check && team_domain_check){
							$('#submitC').attr('disabled',false);
						}
					} 
				}
			});
		}
		
	});
	
});


		
			
		
</script>
 <form action="create" method="post">
<h1>팀생성 create 페이지</h1>

	팀 이름  <input type="text" name="team_name" class="team_nameC" id="team_nameC" required>
<span name="team_nameN" id="team_nameS" class="team_nameS"></span>
<br>
<br>

	<h1>팀 도메인</h1> <input type="text" name="team_domain" class="team_domainC" id="team_domainC" required>
<span name="team_domainN" id="team_domainS" class="team_domainS"></span>
<br>
<br>



<input type="submit" value="팀 생성하기" class="submitC" id="submitC">
<br>
<br>
 </form>