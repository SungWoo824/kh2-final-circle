<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>모달화면</title>
    <script src="https://code.jquery.com/jquery-latest.js"></script> 

  <style>
        .modal{
            position: fixed;
            top:0;
            left:0;
            right:0;
            bottom:0;
/*            background-color: black;*/
            background-color:rgba(139, 133, 133, 0.5);
            
/*            display: none;*/
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

    <script>
    $(function(){
    	$('#modal').hide();	
    	

        $('#inviteBtn').click(function(){

                $('#modal').show();
       		 });
    $('#inviteBtn').click(function(){

        $('#modal').hide();
		 });
    

});
    
//     onClick="close_pop();"
       

    </script>


</head>
<body>

<h1>team main화면</h1>
<!-- 멤버초대 모달 만들기 -->

<!-- 모든 토픽에 참여 가능한 멤버 -->
<form>
 
    <input type="button" id="inviteBtn" value="팀멤버초대하기" >
    
    <!-- 모달화면 일때 , 전체 색 -->
    <div id="modal" class="modal">

        <!--모달창 디자인-->
        <div class="modal-view"></div> 
        <div
        style="position: absolute; top: 50%; left: 50%; width: 300px; height: 400px; margin-left: -150px; margin-top: -200px;">
        <div style="height: 30px;"></div>

        <!--글 색-->
        <div style="margin: 10px 10px; color: black;">
            
            <div style="text-align:center">
                <p>멤버 초대하기</p>
            </div>
            <hr>
            <!--팀멤버로 초대 (모든 토픽참여가능)-->
            <div style="text-align: center;">
                <button class="all-modalbtn" name="all" >팀멤버로 초대</button>
            </div>

            <!--부분멤버로 초대 (부분토픽참여가능)-->

            <div style="text-align: center;">
                <button class="all-modalbtn" name="all" >부분멤버로 초대</button>
            </div>

            <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;">
                <span class="pop_bt" style="font-size: 13pt;" >
                     닫기
                </span>
            </div>


       
            
        </div>
    </form>
</body>
</html>