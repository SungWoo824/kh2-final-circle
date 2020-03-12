<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
 <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/fullpage.css" />
 <script type="text/javascript" src=" ${pageContext.request.contextPath}/resources/js/design/fullpage.js"></script>
 <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/common.css" />
<script src="${pageContext.request.contextPath}/resources/js/crypto/crypto-js.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/crypto/hmac-sha256.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/crypto/secom.js"></script>   
<script>
	$(function(){
		$(".modify-fix-div").hide();
		$(".modify-origin-div").show();
		
		$(".modify-origin-div").click(function() {

            $(this).parent().children(".modify-fix-div").show('3000');

            $(this).hide('fast');

        });
		
		$(".modify-cancel").click(function(){
			$(this).parent().parent().children(".modify-origin-div").show('3000');

            $(this).parent().parent().children(".modify-fix-div").hide('fast');
		})
		
		$(".modify-cancel-img").click(function(){
			$(this).parent().parent().parent().children(".modify-origin-div").show('3000');

            $(this).parent().parent().parent().children(".modify-fix-div").hide('fast');
		})
		
	});
	
	$(function(){
		$("#modify-change-pw-submit").click(function(e){
			
			var url = "${pageContext.request.contextPath}/member/checkpw"; 
			var method = "get";
			var text = $("#modify-member_pw").val();
	
			text = CryptoJS.HmacSHA256(text, "kh");
			text = CryptoJS.enc.Base64.stringify(text);
			var member_pw = text;
			
			$.ajax({
				url: url,
				type:method,
				data:{member_pw:member_pw},//member_pw=aaa
				success:function(resp){
					if(resp == "fail"){
						alert("비밀번호가 틀렸습니다");
						
					}else{
						$("#modify-change-pw-form").submit();
					}
				}
			});
		})
	});
	$(function(){
		$("#modify-delete-submit").click(function(e){
			
			var url = "${pageContext.request.contextPath}/member/checkpw"; 
			var method = "get";
			var text = $("#modify-delete-pw").val();
	
			text = CryptoJS.HmacSHA256(text, "kh");
			text = CryptoJS.enc.Base64.stringify(text);
			var member_pw = text;
			
			$.ajax({
				url: url,
				type:method,
				data:{member_pw:member_pw},//member_pw=aaa
				success:function(resp){
					if(resp == "fail"){
						alert("비밀번호가 틀렸습니다");
						
					}else{
						var con = confirm("삭제하시겠습니까?");
						if(con){
							$("#modify-delete-member").submit();
						}
					}
				}
			});
		})
		
		$(".modify-img-submit").click(function(){
			$(".change-profle-form").submit();
		})
	});
	
	function previewImage(target){
	    
	    if(target.files && target.files[0]){
	        
	        var reader = new FileReader();

	        reader.onload = function(data){

	            var img = document.querySelector("#preview");
	            img.src = data.target.result;
	            
	        }
	        reader.readAsDataURL(target.files[0]);
	    }
	}
    
	
</script>
</head>
<body>
		<div class="circle-header">

                <div class="header-wrap">
                    <div class="header-logo">
                        <div class="mainlogo">
                            <a href="${pageContext.request.contextPath}/member/mypage"><img src=" ${pageContext.request.contextPath}/resources/image/logol.png"></a>
                        </div>
                    </div>
                    <div class="header-gnb">
                        <ul class="gnb-menu">
                            <li><a href="#">제품소개</a></li>
                            <li><a href="#">요금안내</a></li>
                            <c:choose>
		                        <c:when test="${not empty member_email}">
							        <li><a href="${pageContext.request.contextPath}/member/mypage">내정보</a></li>
							    </c:when>
						    </c:choose>
                        </ul>
                        <ul class="gnb-menu">
                           <c:choose>
	                        <c:when test="${not empty member_email}">
						        <li class="logout-btn"><a href="${pageContext.request.contextPath}/member/signout">로그아웃</a></li>
						    </c:when>
							<c:otherwise>
								<li class="login-btn"><a href="${pageContext.request.contextPath}/member/signin">로그인</a></li>	
							</c:otherwise>
                       
                        
                        </c:choose>
                        </ul>
                    </div>
                </div>        
        </div>
        
	<article class="modify-article">
		<div>
			<div class="modify-items">
				<div class="modify-item-name">
					프로필사진
				</div>
				<div class="modify-item-content">
					<div class="modify-origin-div">
						<img id="member-profile-img" src='download?member_no=${member_no}'>
					</div>
					<div class="modify-fix-div">
						<div class="mypage-div">
							<div class="mypage-profile-img-div">
								<img id="preview" src='download?member_no=${member_no}' class="preview-img">
							</div>
							<div class="mypage-profile-img-div">
								<form action="mypagechangeprofile" method="post" class="change-profle-form" enctype="Multipart/form-data">
									<input type='file' id='modify-upload' name='member_profile' onchange="previewImage(this);">
								</form>
							</div>
						</div>
						<div class="mypage-profile-img-button">
							<button class="modify-img-submit">확인</button>
							<button class="modify-cancel-img">취소</button>
						</div>
					</div>
				</div>
			</div>
			<div class="modify-items">
				<div class="modify-item-name">
					이름
				</div>
				<div class="modify-item-content modify-item1">
					<div class="modify-origin-div">
						${memberDto.member_name}
					</div>
					
					<div class="modify-fix-div">
							<form action="mypagechangename" method="post">
								<input type="text" name="member_name" value="${memberDto.member_name }">
								<button>확인</button>
							</form>
							
							<button class="modify-cancel">취소</button>
					</div>
				</div>
			</div>
			<div class="modify-items">
				<div class="modify-item-name">
					이메일 관리
				</div>
				<div class="modify-item-content modify-item2">
					<div class="modify-origin-div">
						${memberDto.member_email }
					</div>
				
					<div class="modify-fix-div">
						<form action="#">
							<input type="text" name="member_email" value="${memberDto.member_email }">
							<button>확인</button>
						</form>
						<button class="modify-cancel">취소</button>
					</div>
				</div>
			</div>
			<div class="modify-items">
				<div class="modify-item-name">
					비밀번호 변경하기
				</div>
				<div class="modify-item-content modify-item3">
					<div class="modify-origin-div">
						**********
					</div>
					
					<div class="modify-fix-div">
						<form id="modify-change-pw-form" action="${pageContext.request.contextPath}/member/mypagechangepw" method="post">
							<h5>현재 비밀번호</h5>
							<input type="password" id="modify-member_pw" name="member_pw">
							<h5>새 비밀번호</h5>
							<input type="password" name="change_pw"><br><br>
						</form>
						<button id="modify-change-pw-submit">확인</button>
						<button class="modify-cancel">취소</button>
					</div>
				</div>
			</div>
			<div class="modify-items">
				<div class="modify-item-name">
					Circle 계정 삭제
				</div>
				<div class="modify-item-content modify-item4">
					<div class="modify-origin-div">
						탈퇴하기
					</div>
					<div class="modify-fix-div">
						<form action="${pageContext.request.contextPath}/member/mypagedeletemember" method="post" id="modify-delete-member">
							<h5>비밀번호</h5>
							<input type="password" id="modify-delete-pw" name="member_pw" placeholder="비밀번호">
							<div class="modify-alert">
								Circle 계정이 영구 삭제됩니다.<br>
								정말로 Circle 계정 삭제를 원하신다면 계정 비밀번호를 입력해주세요.
							</div>
						</form>
						<button id="modify-delete-submit">잔디 계정 삭제</button>
						<button class="modify-cancel">취소</button>
					</div>
				</div>
			</div>
		</div>
	</article>
</body>
</html>