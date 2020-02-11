<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 멤버 리스트 보기</title>
</head>

<script>
//멤버 리스트 모달 화면
$(function(){
    //팝업 Show 기능(팀 멤버로 초대 버튼 누르면 모달 화면 열림)

      //팝업 Close 기능(닫기 버튼 누르면 닫아짐)
      $('#memberlist_close').click(function(){
           $('#modal2').hide();
      });
      $('#memberlist_btn').click(function(){
              $('#modal2').show();
      });
      
      //팝업 뒤로가기 (invite1 ajax)
      $(".memberlist_btn").click(function(){
      	 $.ajax({
               type : "GET", //전송방식을 지정한다 (POST,GET)
               url : "${pageContext.request.contextPath}/team/modal_invite1",//호출 URL을 설정한다. GET방식일경우 뒤에 파라티터를 붙여서 사용해도된다.
               dataType : "html",//호출한 페이지의 형식이다. xml,json,html,text등의 여러 방식을 사용할 수 있다.
               error : function(){
                   alert("통신실패!!!!");
               },
               success : function(data){
                   $("#Parse_Area").html(data); //div에 받아온 값을 넣는다.
    
               }
         		 });
//                $('.modal-fade').hide();
          });

});
</script>

<style>
        /* 소희 : 멤버초대 모달 화면 디자인 */
       .modal2{
            position: fixed;
            top:0;
            left:0;
            right:0;
            bottom:0;
            background-color:rgba(139, 133, 133, 0.5);
            
            display: none;
        }
        
         .modal2 > .modal-view2{
            position: fixed;
            width:300px;
            height:400px;
            background-color: white;
            border:1px solid; padding:10px;
            /* 가운데 배치 */
            top:50%;
            left:50%;
            margin-left: -150px;
            margin-top: -200px;
                       
        }
</style>
<body>

<!-- 멤버 목록보기 버튼 -->
<button type="button" id="memberlist_btn">참여중인멤버</button>	
						
<div id="modal2" class="modal2">
<!--모달창 디자인-->
<div class="modal-view2"></div> 
<div style="position: absolute; top: 50%; left: 50%; width: 300px; height: 400px; margin-left: -150px; margin-top: -200px;">
<div style="height: 30px;"></div>
<span>${memberDto.member_name}</span>

<button type="button" id="memberlist_close" class="memberlist_close">닫기</button>	

</body>

</div>
</html>