<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                            <c:when test="${not empty member_email}">
						        <li><a href="${pageContext.request.contextPath}/member/mypage">내정보</a></li>
						    </c:when>
                        </ul>
                        <ul class="gnb-menu">
                            <li class="login-btn"><a href="member/signin">로그인</a></li>
<!--                             <li class="logout-btn><a href="member/signout">로그아웃</a></li> -->
                        </ul>
                    </div>
                </div>        
        </div>
        <div class="signup-article">
			<form action="changepw" class="pw-form" method="post">
				<input type="password" class="change_pw" name="change_pw"><br><br>
				<input type="password" class="change_pw_check" name="change_pw_check"><br><br>
				
				<div id="alert-success">비밀번호가 일치합니다.</div>
				<div id="alert-danger">비밀번호가 일치하지 않습니다.</div>
		
				<input type="submit" id="submit">
			</form>
		</div>
</body>
</html>