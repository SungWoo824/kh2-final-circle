<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">     -->
<!-- <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script> -->

<script>

</script>

<style>

  .topic-modal{
            position: fixed;
            top:0;
            left:0;
            right:0;
            bottom:0;
            background-color:rgba(139, 133, 133, 0.5);
/*             display: none; */
        }
        
        .topic-modal > .topic-modal-view{
            position: fixed;
            width:600px;
            height:400px;
            background-color: white;
            border:1px solid #ccc; 
            padding:10px;
            /* 가운데 배치 */
            top:50%;
            left:50%;
            margin-left: -150px;
            margin-top: -200px;
            
            
        }


</style>
    

<div class="topic-modal">

	<div class="topic-modal-view">
		<h1>토픽 생성하기</h1>
		<form action="topic_create" method="post">
			이름 :<input type="text" name="topic_name"><br><br>
			공개여부 :<input type="radio" name="topic_confidential" value="1" checked="checked">비공개
							<input type="radio" name="topic_confidential" value="0" >공개<br><br>
			토픽 설명 :<textarea name="topic_explain" rows="" cols=""></textarea><br><br>
			<input type="submit" value="생성하기">
			<input type="button" value="닫기"> 
		</form>
	
	</div>

</div>

	
