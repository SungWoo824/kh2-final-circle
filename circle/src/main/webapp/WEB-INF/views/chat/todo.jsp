<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>할일 목록 to do list</title>
</head>


    <style>
        *{
            box-sizing:border-box;

        }
        .form-input{
            width:100%;
            margin:10px 0px;
            padding:5px;
        }
    </style>
    
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script>
        $(function(){
            //목표 : .add-btn을 클릭하면 input 태그를 만들어 .reult-form에 추가
            $(".add-btn").click(function(){
                var tag = $("<input>").attr("placeholder","할일을 입력하세요")
                                 .attr("name","sample")
                                 .prop("required",true)
                                 .addClass("form-input");

                //tag를 .result-form에 추가하세요                 
                //tag.appendTo(".result-form");

                //result-form에 tag를 추가하세요
                $(".result-form").append(tag);
	
            });
        	$(".add-btn").click(function(){
        		$(tag).hide();
        	});
        });
        

    </script>
<body>
<button class="add-btn">할일 입력하기</button>
	<!-- 할일 인풋 생성 -->
	<form action="todo"></form> 
    <input type="text">
</body>
</html>