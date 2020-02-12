<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(function(){
// 		.validate-form은 처음에 숨기고 이메일 전송시만 표시
		$(".validate-form").hide();
		$(".success-form").hide();
// 		.email-form이 전송되면 send 주소로 비동기 신호를 전송(ajax)
		$(".email-form").submit(function(e){
			e.preventDefault();
			
			$(this).find("input[type=submit]").prop("disabled", true);
			$(this).find("input[type=submit]").val("인증번호 발송중...");
			
			var url = $(this).attr("action"); 
			var method = $(this).attr("method");
			var data = $(this).serialize();
			
			$.ajax({
				url: url,
				type:"get",
				data:data,
				success:function(resp){
					//console.log(resp);
					if(resp == "success"){
						$(".validate-form").show();
						$(".email-form-email").prop("disabled", true);
					}
				}
			});
		});
		
// 		validate-form이 전송되면 /validate로 비동기 요청을 전송
		$(".validate-form").submit(function(e){
			e.preventDefault();
			
			var url = $(this).attr("action"); 
			var method = $(this).attr("method");
			var data = $(this).serialize();
			
			$.ajax({
				url:url,
				type:"get",
				data:data,
				success:function(resp){
// 					console.log(resp);
					if(resp == "success"){
						alert("인증 완료");
						$(".success-form").show();
					}
					else{
						alert("잘못된 인증번호 입니다. 다시입력해 주세요");
					}
				}
			});
		});
	});
</script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
 <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/fullpage.css" />
 <script type="text/javascript" src=" ${pageContext.request.contextPath}/resources/js/design/fullpage.js"></script>
 <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/common.css" />
    
</head>
<body>


	 <div class="circle-header">

                <div class="header-wrap">
                    <div class="header-logo">
                        <div class="mainlogo">
                            <a href="${pageContext.request.contextPath}"><img src=" ${pageContext.request.contextPath}/resources/image/logol.png"></a>
                        </div>
                    </div>
                    <div class="header-gnb">
                        <ul class="gnb-menu">
                            <li><a href="#">제품소개</a></li>
                            <li><a href="#">요금안내</a></li>
                        </ul>
                        <ul class="gnb-menu">
                            <li class="login-btn"><a href="member/signin">로그인</a></li>
<!--                             <li class="logout-btn><a href="member/signout">로그아웃</a></li> -->
                        </ul>
                    </div>
                </div>        
        </div>
        <div class="signup-article">
			<h3>비밀번호 찾기</h3>
			<form class="email-form" action="send" method="get">
				<input type="email" class="email-form-email" name="email" placeholder="이메일 입력">
				<input type="submit" value="인증번호 보내기">
			</form>
		
			<hr>
			<form class="validate-form" action="validate" method="get">
				<input type="text" name="cert" placeholder="인증번호 입력">
				<input type="submit" value="인증하기">
			</form>
			<form class="success-form" action="changepw" method="get">
				<input type="submit" value="변경 페이지로 이동">
			</form>
		</div>
</body>
</html>