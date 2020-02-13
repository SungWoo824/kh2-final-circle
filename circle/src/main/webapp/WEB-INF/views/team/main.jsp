<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">   
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.addons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/layoutstyle.css">
     <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/common.css" />
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

    <script>


$(function(){
// 		var data = $("form[name=invite-form]").serialize();

            $(".container").click(function(){
            $.ajax({
            type : "GET", //전송방식을 지정한다 (POST,GET)
            url : "${pageContext.request.contextPath}/team/modal_invite1",//호출 URL을 설정한다. GET방식일경우 뒤에 파라티터를 붙여서 사용해도된다.
//             data : data
            dataType : "html",//호출한 페이지의 형식이다. xml,json,html,text등의 여러 방식을 사용할 수 있다.
            error : function(){
                alert("통신실패!!!!");
            },
            success : function(data){
                $("#Parse_Area").html(data); //div에 받아온 값을 넣는다.
 
            }

        });
    });
//  $(function(){
//         $(".container").click(function(){
        	
//   $(".container").show();
// });
// });



});

</script>

    <style>
     .container{
        display: block;

    </style>
</head>
<body>


<!-- 멤버 초대하기 버튼 -->
<div class="container">
<form class="invite-form" action="main" method="post" name="invite-form">
   <!--  버튼이 클릭되면 show 메소드가 호출된다.   show메서드를 호출할때 원하는 값을 넣어 보낸다.-->
<%--     <input type="hidden" value="${team_no}" name="team_no" id="team_no" class="team_no"> --%>
     <a href="${pageContext.request.contextPath}/team/modal_invite1?team_no=${param.team_no}" type="button" class="btn btn-primary btn-lg" >팀 멤버 초대하기</a>
<!--     <button type="button" class="btn btn-primary btn-lg" name="invite">팀 멤버 초대하기</button> -->
<!-- modal_invite1 화면이 나타날 자리 -->
<div id="Parse_Area"gt;lt;></div>
</form>
    </div>

<h5>team_no = ${team_no}</h5>

</body>

        <!-- main-panel ends -->
      <!-- page-body-wrapper ends -->
    <script src="${pageContext.request.contextPath}/resources/js/design/vendor.bundle.base.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/design/vendor.bundle.addons.js"></script>
</html>