<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>   
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>


<script>
$(function(){
	
	$("#check-btn").attr("disabled",true);
	
	$("input[name=drive_name]").blur(function(){
		
		
		var drive_name = $(this).val();
		var team_no = $("input[name=team_no]").val();
		
		$.ajax({
			url : "${pageContext.request.contextPath}/drive/drive_namecheck",
			type:"get",
			data:{
				drive_name : drive_name,
				team_no: team_no
			},
			dataType:"text",
			success: function(resp){
				if(resp === "Y"){
					$("input[name=drive_name]").next("span").text("동일한 이름이 있습니다.");
					$("#check-btn").prop("disabled",true); 
				}
				else if(resp === "N"){
					$("input[name=drive_name]").next("span").text(" ");
					$("#check-btn").prop("disabled",false); 
				}
			}
		});			
	});
});
</script>



  
<h3>멤버 : ${param.member_no} / 팀 :${param.team_no }번 의 드라이브</h3>


<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newDrive">
	새 드라이브 생성
</button>

<form action="drive" method="post">

	
<!-- Modal -->
		<div class="modal fade" id="newDrive" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalCenterTitle">새 드라이브 생성</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		      			<input type="hidden" name="team_no" value="${param.team_no}">
						<input type="hidden" name="member_no" value="${param.member_no}">
		      		드라이브 이름 : <input type="text" name ="drive_name"><span></span><br><br>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		        <button type="submit" id="check-btn" class="btn btn-primary" >생성하기</button>
		      </div>
		    </div>
		  </div>
		</div>
		

</form>

