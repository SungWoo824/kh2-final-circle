<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
$(function(){

        $(".invite-form").click(function(){
        $.ajax({
        type : "GET", //전송방식을 지정한다 (POST,GET)
        url : "${pageContext.request.contextPath}/chat/invite_modal1",//호출 URL을 설정한다. GET방식일경우 뒤에 파라티터를 붙여서 사용해도된다.
        dataType : "html",//호출한 페이지의 형식이다. xml,json,html,text등의 여러 방식을 사용할 수 있다.
        error : function(){
            alert("통신실패!!!!");
        },
        success : function(data){
            $("#Parse_Area").html(data); //div에 받아온 값을 넣는다.

        }

    });
});
});
</script>
</head>
<body>
<!-- 혹시 몰라서 아직 남겨두는 코드 -->
<!-- 						<form class="invite-form" action="topic_main" method="post" name="invite-form"> -->
						   <!--  버튼이 클릭되면 show 메소드가 호출된다.   show메서드를 호출할때 원하는 값을 넣어 보낸다.-->
<%-- 						    <input type="hidden" value="${param.team_no}" name="team_no" id="team_no" class="team_no"> --%>
<%-- 						     <input type="hidden" value="${param.topic_no}" name="topic_no" id="team_no" class="topic_no"> --%>
<%-- 						     <a href="${pageContext.request.contextPath}/chat/invite_modal1" type="button" class="btn btn-primary btn-lg" >팀 멤버 초대하기</a> --%>
						<!--     <button type="button" class="btn btn-primary btn-lg" name="invite">팀 멤버 초대하기</button> -->
						<!-- modal_invite1 화면이 나타날 자리 -->
<!-- 						<div id="Parse_Area"gt;lt;></div> -->
<!-- 						</form> -->
</body>
</html>