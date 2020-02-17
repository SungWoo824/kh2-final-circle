<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>   
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script>
$(function(){
	
	//입력을 마치면(blur) 비동기통신으로 아이디 유무를 검사
	$("#check-btn").attr("disabled",true);
	
	$("input[name=topic_name]").blur(function(){
		
		
		var topic_name = $(this).val();
		var team_no = $("input[name=team_no]").val();
		
		$.ajax({
			url : "${pageContext.request.contextPath}/chat/topic_namecheck",
			type:"get",
			data:{
				topic_name :topic_name,
				team_no: team_no
			},
			dataType:"text",
			success: function(resp){
				if(resp === "Y"){
					$("input[name=topic_name]").next("span").text("동일한 이름이 있습니다.");
					$("#check-btn").prop("disabled",true); 
				}
				else if(resp === "N"){
					$("input[name=topic_name]").next("span").text("토픽생성가능");
					$("#check-btn").prop("disabled",false); 
				}
			}
		});			
	});
});

</script>



	<h3>팀 : ${param.team_no }</h3>
    <h3>토픽 : ${param.topic_no}</h3>
    <h3>토픽 명 : ${param.topic_name }</h3>
    
    <!-- 참여멤버-->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#inTopic">
 토픽 참여 멤버 보기
</button>

<div class="modal fade" id="inTopic" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle"> 토픽 참여 멤버 보기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
	        <c:forEach var="memberDto" items="${topicMemberList}">
<!-- 	        	<input type="checkbox"> -->
	        	<a href="#">${memberDto.member_name}-${memberDto.member_email}(${memberDto.topic_member_position })</a>
	        	<br>
	        </c:forEach>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>



<!-- 토픽 초대 -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#topicInvite">
 토픽 초대하기
</button>

<!-- <form action="invitetopic" method="post"> -->

<div class="modal fade" id="topicInvite" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle"> 토픽 멤버 초대하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
	        <c:forEach var="team" items="${memberList}">
<%-- 	        	<input type="checkbox" name="member_no" value="${team.member_no }"> --%>
<%-- 	        	<input type="hidden" name="team_no" value="${team.team_no }"> --%>
<%-- 	        	<input type="hidden" name="topic_no" value="${team.topic_no }"> --%>
 	        		<span>${team}</span>
	        	<br>
	        </c:forEach>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary">초대하기</button>
      </div>
    </div>
  </div>
</div>

<!-- </form> -->


<!-- 토픽 나가기 -->
<%--  <a href="outtopic?topic_no=${param.topic_no}"><button type="button" class="btn btn-primary"> --%>
<!-- 토픽 삭제 -->
<!-- </button></a> -->

<!-- 토픽 삭제하기 -->

<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#outTopic">
 토픽 나가기
</button>
<form action="topic_masterchange" method="post">
<div class="modal fade" id="outTopic" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle"> 토픽 관리자 변경</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">
       		<c:if test="${memberDto.topic_member_position=='토픽소유자'}">
		        <span>토픽을 인계할 사람을 선택해주세요</span><br><hr>
	    		<c:forEach var="memberDto" items="${topicMemberList}">
	<%-- 	        	<a href="topic_masterchange?member_no=${param.member_no}&topic_no=${param.topic_no}"> --%>
				        	<input type="checkbox" name="">
				        		<span>
				        			${memberDto.member_name}-${memberDto.member_email}(${memberDto.topic_member_position })
				        		</span>
	<!-- 	        	</a> -->
		        	<br>
		        </c:forEach>
       		</c:if>
       		<c:choose>
				<c:when test="${memberDto.topic_member_position=='토픽소유자'}">
					<span>토픽을 인계할 사람을 선택해주세요</span><br><hr>
			    		<c:forEach var="memberDto" items="${topicMemberList}">
					        	<input type="checkbox" name="">
					        	<span>
					        		${memberDto.member_name}-${memberDto.member_email}(${memberDto.topic_member_position })
					        	</span>
				        	<br>
				        </c:forEach>
				</c:when>
				<c:otherwise>
					<span>정말 나가시겠습니까?</span><br><hr>
				</c:otherwise>
			</c:choose>

		 </div>
		 <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		        <button type="submit"  class="btn btn-primary" >토픽 나가기</button>
		</div>
      </div>
    </div>
  </div>
</form>



<!-- 토픽 정보변경 -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editTopic">
 토픽 정보변경
</button>
<form action="topic_invite" method="post">
<div class="modal fade" id="editTopic" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle"> 토픽 정보 변경</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">
       				<input type="hidden" name="topic_no" value="${param.topic_no}">
					이름 :<input type="text" name="topic_name"><span></span><br><br>
					토픽 설명 :<textarea name="topic_explain" rows="" cols=""></textarea><br><br>
		 </div>
		 <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		        <button type="submit" id="check-btn" class="btn btn-primary" >수정하기</button>
		</div>
      </div>
    </div>
  </div>
</form>
