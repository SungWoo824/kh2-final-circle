<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>   
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script>
        $(function(){

        
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

<style>

#topic-create{
 cursor: pointer;
border-top:1px solid #eee;
border-bottom: 1px solid #eee;
background-color:#f8f8f8;
 height:40px;
}

#topic-create a{
		position:absolute;
      	display:inline-block;
      	line-height:40px;
      	left:55px;
      	
}


</style>
</head>
<body>

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal1" data-target="#exampleModalCenter2">
멤버 초대하기
</button>

<!-- 이메일 전송 폼 -->
<form class="email-form" action="invite_create" method="post">
<!-- Modal -->
		<div class="modal fade" id="exampleModalCenter2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalCenterTitle">멤버초대하기</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>

		       <!-- 이메일 전송 폼 -->	
		      <div class="modal-body">
              <input class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="cert_email" type="email" placeholder="Enter email">
              	<input type="hidden" value="${team_no}" name="team_no">
                <input type="submit" value="이메일전송" class="btn btn-primary" data-dismiss="modal">
                <span></span>
		      </div>

		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		        <button type="submit" id="check-btn" class="btn btn-primary" >생성하기</button>
		      </div>
		    </div>
		  </div>
		</div>
</form>

	