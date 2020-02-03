<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>



<!-- <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>    -->
<script>

$(function(){
    $('#invite_btn').click(function(){
        $('#modal').fadeIn();
		});
    
	
});


</script>
</head>
<style>
        .modal{
            position: fixed;
            top:0;
            left:0;
            right:0;
            bottom:0;
            background-color:rgba(139, 133, 133, 0.5);
            
            display: none;
        }
        
        .modal > .modal-view{
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

<form>
	<!-- 멤버 초대하기 버튼 -->
 	<div>
 	<button type="button" id="invite_btn">팀 멤버 초대하기</button>
    
 	</div>
    
	<!-- 멤버초대 모달 만들기 -->
    <!-- 모달화면 일때 , 전체 색 -->
    <div id="modal" class="modal">

        <!--모달창 디자인-->
        <div class="modal-view"></div> 
        <div style="position: absolute; top: 50%; left: 50%; width: 300px; height: 400px; margin-left: -150px; margin-top: -200px;">
        <div style="height: 30px;"></div>

        <!--글 색-->
        <div style="margin: 10px 10px; color: black;">
            <div style="text-align:center">
                <p>멤버 초대하기</p>
            </div>
            <hr>
            
            <!--팀멤버로 초대 (모든 토픽참여가능)-->
            <div style="text-align: center;">
                <button id="all-modalbtn" class="all-modalbtn" name="all" >팀멤버로 초대</button>
            </div>

            <!--부분멤버로 초대 (부분토픽참여가능)-->

            <div style="text-align: center;">
                <button class="all-modalbtn" name="all" >부분멤버로 초대</button>
            </div>

            <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" id="close_btn">
                <span style="font-size: 13pt;" >닫기</span>
            </div>
        </div>
    </form>

</body>
</html>