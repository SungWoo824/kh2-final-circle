<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소유자 팀관리 / 개인설정 페이지</title>
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
// 클릭 하면 열고 닫기 
$(function(){
	$(".modify-fix-div").hide();
	$(".modify-origin-div").show();
	
	$(".modify-origin-div").click(function() {
        $(this).parent().children(".modify-fix-div").show('3000');
        $(this).hide('fast');
    });
	
	//취소 버튼 
	$("button[name=modify-cancel]").click(function(){
		$(this).parent().parent().children(".modify-origin-div").show('3000');
        $(this).parent().parent().children(".modify-fix-div").hide('fast');
	})
});

//스크롤
$(function(){
    $(window).scroll(function(){
        console.log("scroll event");
        console.log($(this).scrollTop());

        if($(this).scroll > $(document).innerHeight()*0.9){
            console.log("더 불러오세요");
        }
    });
});  
</script>

<body style="height: 5000px">
<div style="width:100%; height:90%; overflow:auto">
 	 <!-- 상단 헤더 --> -->
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
         <!-- 소유자 : 개인 설정-->
        <div class="mypage-main">
             <div class="main-bg">
                    
                 <div id="fullpage">
                      <div class="section">
                           <div class="mypage-main-content">
                     <!-- 상단 네비바 -->
								<nav class="navbar navbar-expand-lg navbar-light bg-primary">
								  <a class="navbar-brand" href="#" style="color:white">개인설정</a>
								  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
								    <span class="navbar-toggler-icon"></span>
								  </button>
								  <div class="collapse navbar-collapse" id="navbarNav">
								    <ul class="navbar-nav">
								      <li class="nav-item">
								        <a class="nav-link" href="${pageContext.request.contextPath}/team_admin/owner_manager_team?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}">팀관리</a>
								      </li>
								      <li class="nav-item">
								        <a class="nav-link" href="${pageContext.request.contextPath}/team_admin/owner_manager_member?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}">멤버관리</a>
								      </li>
								      <li class="nav-item active">
								        <a class="nav-link" style="color:white" href="${pageContext.request.contextPath}/team_admin/owner_manager_per?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}">개인설정<span class="sr-only">(current)</span></a>
								      </li>
								      <li class="nav-item">
									    <a class="nav-link" href="${pageContext.request.contextPath}/plan/list?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}">보유중인 플랜 보기</a>
									  </li>
								    </ul>
								  </div>
								</nav>	 
								<div class="mypage-div">
<%-- 	                                    		<c:forEach var="teamDto" items="${teamDto}"> 메소드 반환이 리스트 형식일 때 쓰는거--%>
	                                    		<span> 팀 이름 = ${teamDto.team_name}</span>
	                                    		<br>
	                                    		<span> 내 등급 = ${teamMemberDto.member_position},</span>
	                                    		<span>${teamMemberDto.member_auth} </span>
	                                    </div>
                    					<!-- 변경하기 부분 -->
	                                    <article class="modify-article">
	                               		     <div>
	                               		     
	                               		    

	                                    		<!-- 팀 소유자 탈퇴하기 / 양도 해야 함 -->
												<div class="modify-items">
													<div class="modify-item-name">
														 팀탈퇴
													</div>
														 <div class="modify-item-content modify-item4">
															<!-- 팀 삭제하기 버튼을 누르면 -->
															<div class="modify-origin-div">
																팀 탈퇴하기
															</div>	
																 <div class="modify-fix-div">
																	 <form action="${pageContext.request.contextPath}/team_admin/edit_team_exit" method="post" id="modify-delete-member">
																		<h5>비밀번호</h5>
																		<input type="hidden" name="team_no" value="${param.team_no}">
		                                       							<input type="password" id="modify-delete-pw" name="member_pw" placeholder="비밀번호">
																			<div class="modify-alert">
																				<h4>"${param.team_name}" 팀에서 소유자를 양도하셔야 합니다.<br>
																	 				계정 비밀번호를 입력후 양도할 소유자를 선택해 주세요</h4>
															 				</div>
																	</form>
											
					                                    				<button id="modify-delete-submit" class="btn btn-primary">팀 탈퇴하기</button>
																		<button name="modify-cancel" class="btn btn-secondary">취소</button>
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
	                                     
</div>	                                        
	                                        



<!-- 멤버 관리 부분 --> 


</body>
</html>