<!-- 안하는 페이지, 이 디자인을 사용하지 않을 것이기 때문 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>모달화면</title>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>   

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
        
          .modal2{
            position: fixed;
            top:0;
            left:0;
            right:0;
            bottom:0;
            background-color:rgba(139, 133, 133, 0.5);
            
            display: none;
        }
    </style>

    <script>
        $(function(){
      //팝업 Show 기능(팀 멤버로 초대 버튼 누르면 모달 화면 열림)

        //팝업 Close 기능(닫기 버튼 누르면 닫아짐)
        $('#close_btn').click(function(){
             $('#modal').hide();
        });
        $('#invite_btn').click(function(){
                $('#modal').show();
        		});
       
      
//     $('#close_btn').click(function(){
//         $('#modal').attr("style", "display:none");
//     });      
//     $('#invite_btn').click(function(){
//         $('#modal').attr("style", "display:block");
//     });

$("#all-modalbtn").click(function(){
		$('#modal2').show();
});
   
        });
        
        
        
</script>




</head>
<body>

<h1>team main화면</h1>

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

<!-- 두번째 화면 -->

<form>

    
	<!-- 멤버초대 모달 만들기 -->
    <!-- 모달화면 일때 , 전체 색 -->
    <div id="modal2" class="modal2">

        <!--모달창 디자인-->
        <div class="modal-view2"></div> 
        <div style="position: absolute; top: 50%; left: 50%; width: 300px; height: 400px; margin-left: -150px; margin-top: -200px;">
        <div style="height: 30px;"></div>

        <!--글 색-->
        <div style="margin: 10px 10px; color: black;">
            <div style="text-align:center">
                <p>두번째화면</p>
            </div>
            <hr>
            
            <!--팀멤버로 초대 (모든 토픽참여가능)-->
            <div style="text-align: center;">
                <button class="all-modalbtn" name="all" >두번째화면</button>
            </div>

            <!--부분멤버로 초대 (부분토픽참여가능)-->

            <div style="text-align: center;">
                <button class="all-modalbtn" name="all" >두번째화면</button>
            </div>

            <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" id="close_btn">
                <span style="font-size: 13pt;" >닫기</span>
            </div>
        </div>
    </form>

       
            
</body>
</html>
