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
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script> 
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script>
        $(function(){
      //팝업 Show 기능(팀 멤버로 초대 버튼 누르면 모달 화면 열림)

        //팝업 Close 기능(닫기 버튼 누르면 닫아짐)
        $(".modal-footer").click(function(){
             $('.modal-fade').hide();
        });
        //팝업 Close 기능(X 버튼 누르면 닫아짐)
        $(".modal-header").click(function(){
             $('.modal-fade').hide();
        });
        //팝업 뒤로가기 (invite1 ajax)
        $(".modal-back").click(function(){
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
                 $('.modal-fade').hide();
            });
        
        //이메일 보내기 버튼을 누르면 send주소로 비동기 신호를 전송 
        $('.email-form').submit(function(e){
        	e.preventDefault();
        	
        	$(this).find("input[type=submit]").prop("disabled", true);
			$(this).find("input[type=submit]").val("인증번호 발송중...");
       
			var url = $(this).attr("action"); 
			var method = $(this).attr("method");
			var data = $(this).serialize();
			
			$.ajax({
                type : "POST", //전송방식을 지정한다 (POST,GET)
                url : url,
                data : data,
                error : function(){
                    alert("통신실패!!!!");
                },
                success : function(resp){
                    //console.log(resp);
        
                    	$("input[type=submit]").next("span").text("전송완료되었습니다");
                    	//추후에 전송 완료되었습니다라는 메시지와 이메일을 확인해달라는 모달팝업창 띄우기
                }
     
            });
//                 $('.modal-fade').hide();
            });


    });
    
    </script>

<!--      <style> 
      .container{ 
         display: none; 

    </style>  -->

</head>

<body>
    <div class="container">

      
        <!-- Modal -->
      
        <div class="modal-fade" id="myModal" role="dialog">
          <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" id="title">멤버 초대하기2</h4>
      
              </div>

              <div class="top-notice">
            </div>
            
            <div class="modal-body">
                
                <p id="content"></p>
                <p>모든 토픽에 멤버를 초대하실 수 있습니다</p>
                <p>초대 메일 보내기</p>
            </div>
                
              
    		  <!-- 이메일 전송 폼 -->	
              <form class="email-form" action="modal_invite2" method="post">
              	<input class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="cert_email" type="email" placeholder="Enter email">
              	<input type="hidden" value="${param.team_no}" name="team_no">
              	<input type="hidden" value="${param.topic_no}" name="team_no">
                <input type="submit" value="이메일전송" class="btn btn-primary" data-dismiss="modal">
                <span></span>
              </form>

      		  <!-- CLOSE버튼 -->
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
              
              <!-- 뒤로가기 버튼 -->
      		  <div class="modal-back">
                <button type="button" class="btn btn-default" data-dismiss="modal">뒤로가기</button>
      		  </div>	
      
            </div>
      
            
      
          </div>
      
        </div>  
      
      </div>
	<div id="Parse_Area"gt;lt;></div>
    
</body>
</html>