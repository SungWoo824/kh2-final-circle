
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<!--     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>   
  
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
  
    <script>


$(function(){
            $(".container").click(function(){
            	
        $('#Parse_Area').load('invite1.html');
    });
});

</script>
</head>
<body>
<!-- <button class="load-btn">팀 멤버 초대하기</button> -->

<div class="container">

    <h2>Modal Example</h2>
  
   <!--  버튼이 클릭되면 show 메소드가 호출된다.   show메서드를 호출할때 원하는 값을 넣어 보낸다.  show메서드의 인자로 넘어가는 aaa 는 동적으로 바뀌어야 함.  -->
  
    <button type="button" class="btn btn-info btn-lg" >팀 멤버 초대하기</button>
    </div>

<div id="Parse_Area"> </div>
</body>
</html>