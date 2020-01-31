<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/crypto/crypto-js.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/crypto/hmac-sha256.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/crypto/secom.js"></script>
<script>
$(function(){
	$("#alert-success").hide();
	$("#alert-danger").hide();
	$("input").keyup(function(){
		var pwd1=$(".change_pw").val();
		var pwd2=$(".change_pw_check").val();
		
		if(pwd1 != "" || pwd2 != ""){
			if(pwd1 == pwd2){
				$("#alert-success").show();
				$("#alert-danger").hide();
				$("#submit").removeAttr("disabled");
			}else{
				$("#alert-success").hide();
				$("#alert-danger").show();
				$("#submit").attr("disabled", "disabled");
				}
			}
		});
	});
	
	$(function(){
		$("#submit").click(function(){
			alert("변경완료. 변경된 비밀번호로 로그인해 주세요.");
		});
	});

</script>
</head>
<body>
	<form action="changepw" class="pw-form" method="post">
		<input type="password" class="change_pw" name="change_pw"><br><br>
		<input type="password" class="change_pw_check" name="change_pw_check"><br><br>
		
		<div id="alert-success">비밀번호가 일치합니다.</div>
		<div id="alert-danger">비밀번호가 일치하지 않습니다.</div>

		<input type="submit" id="submit">
	</form>
</body>
</html>