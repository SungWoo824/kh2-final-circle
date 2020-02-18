<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>논소유자(멤버) 관리 페이지</title>
</head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
 <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/fullpage.css" />
 <script type="text/javascript" src=" ${pageContext.request.contextPath}/resources/js/design/fullpage.js"></script>
 <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/common.css" />
<script src="${pageContext.request.contextPath}/resources/js/crypto/crypto-js.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/crypto/hmac-sha256.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>   
<script src="${pageContext.request.contextPath}/resources/js/crypto/secom.js"></script>   

<script>

//클릭 하면 열고 닫기 
$(function(){
	$(".modify-fix-div").hide();
	$(".modify-origin-div").show();
	
	$(".modify-origin-div").click(function() {

        $(this).parent().children(".modify-fix-div").show('3000');

        $(this).hide('fast');

    });
	
	//취소 버튼
	$(".modify-cancel").click(function(){
		$(this).parent().parent().children(".modify-origin-div").show('3000');

        $(this).parent().parent().children(".modify-fix-div").hide('fast');
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





</script>

<body>
<!-- 헤더 -->
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
                       
                        
<!-- 팀 관리 부분 -->
<div class="mypage-main">
     <div class="main-bg">
          <div id="fullpage">
                <div class="section">
                      <div class="mypage-main-content">
                      <!-- 상단 네비바 -->
								<nav class="navbar navbar-expand-lg navbar-light bg-light">
								  <a class="navbar-brand" href="#">팀관리</a>
								  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
								    <span class="navbar-toggler-icon"></span>
								  </button>
								 <c:forEach items="${teamlist}" var="teamDto">
								  <div class="collapse navbar-collapse" id="navbarNav">
								    <ul class="navbar-nav">
								      <li class="nav-item active">
								        <a class="nav-link" href="${pageContext.request.contextPath}/team_admin/member_manager_team?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}">팀관리 <span class="sr-only">(current)</span></a>
								      </li>
								    </ul>
								  </div>
								   </c:forEach>
								</nav>	 
                      
       					   <!-- 팀 정보 보기 -->
        				   <div class="mypage-div">
	                
		                        <form class="param_submit" action="${pageContext.request.contextPath}/chat/topic" method="get">
									<input type="hidden" name="team_no" class="team_no_value" value="${teamDto.team_no}">
																
										<div class="mypage-team-div">
											<button id="param_submit_btn" type="submit">이동하기</button>
										</div>
								</form>                
	                       </div>
	                       
  						   <!-- 정보보기 시작 -->    
						   <article class="modify-article">
						   		<div>
						   		<!-- 팀 정보보기  -->
								<div class="modify-items">
									<div class="modify-item-name">
											팀 정보보기  
									</div>
	                                     <div class="modify-item-content modify-item2">
												<div class="modify-origin-div">
													보기 
												</div>
			                             			<div class="modify-fix-div">
	                                                   	 팀 이름 : ${teamDto.team_name}
	                                                   		<hr><br>
	                                                   	 등급 : ${teamMemberDto.member_position}  
	                                                  	  	  ${teamMemberDto.member_auth}  
	                                                   		  ${teamMemberDto.member_grade}
	                                                   		<hr><br>
	                                                   	이메일 : ${memberDto.member_email}
	                                                   		<hr><br>
	                                                    <button class="modify-cancel">닫기 </button>
	                                    			</div>
	                                    </div>
	                                 </div>	
									
			
				<!-- 팀 탈퇴하기 -->
				<div class="modify-items">
					<div class="modify-item-name">
						팀 탈퇴
					</div>
						<div class="modify-item-content modify-item4">
							<!-- 탈퇴하기 버튼 부분 -->
							<div class="modify-origin-div">
								탈퇴하기
							</div>
							<div class="modify-fix-div">
								<form action="${pageContext.request.contextPath}/team_admin/edit_team_exit" method="post" id="modify-delete-member">
									<h5>비밀번호</h5>
								    <input type="hidden" name="member_no" value="${memberDto.member_no}">
									<input type="hidden" name="team_no" value="${param.team_no}">
									<input type="password" id="modify-delete-pw" name="member_pw" placeholder="비밀번호">
										<div class="modify-alert">
											${teamDto.team_name}팀에서 탈퇴합니다<br>
											정말로 팀 탈퇴를 원하신다면 계정 비밀번호를 입력해주세요.
										</div>
								</form>
											<button id="modify-delete-submit">틸탈퇴</button>
											<button class="modify-cancel">취소</button>
							</div>
						</div>
				</div>
		</div>
	</article>
	</div>
	</div>
	</div>
	</div>
	</div>
</body>
</html>