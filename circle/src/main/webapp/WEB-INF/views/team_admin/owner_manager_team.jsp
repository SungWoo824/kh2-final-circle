<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 관리 버튼 누르면 바로 나오는 팀 관리 메인 페이지</title>
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

//팀 네임 변경 중복검사 
$(function(){
	
		$("button[name=submitC]").attr('disabled',true);//첫 페이지부터 수정하버튼 비활성화
	 	$("input[name=team_name]").blur(function(){ //입력을 마치면(blur) 비동기통신으로 아이디 유무를 검사 
		var team_name = $(this).val();
		
		if(team_name == ""){   //빈칸이 공란일 때 = 비동기통신이 작동하지 않아서 팀이름 입력 비기와 알럿알
			team_name_check=false; //팀 이름 검사가 안
			$("button[name=submitC]").attr('disabled',true); //그러면 계속 버튼 비활성
			$("input[name=team_name]").next("span").text("팀이름 입력해주세요");
			alert("팀 이름을 입력해주세요"); //알림창 띄우
			return false;  //현재 페이지 계속 머물기 
			
		}		
// 		else{	//빈칸이 공란이아닐때 = 비동기통신이 작동하여 팀이름 사용유무 확인가능 / 잇어도 되는지 확인
			// 사용중 여부 비동기
			$.ajax({
				url:"${pageContext.request.contextPath}/team_admin/check",
				type:"get",
				data:{team_name : team_name},
				dataType:"text",
				success:function(resp){
	// 				console.log(resp);
					if(resp === "Y"){ //사용중이면  
						team_name_check=false;	
						$("input[name=team_name]").next("span").text("사용중인 팀이름");
						$('#submitC').prop('disabled',true);  //계속 수정하기 버튼 비활
							
					} else if(resp === "N"){ //사용가능하면  
						team_name_check=true;
						$("input[name=team_name]").next("span").text("사용가능합니다");
						$("button[name=submitC]").attr('disabled',false);  //버튼이 활성화
					} 
				}
			});
	 	});
	});

//팀 도메인 변경 스크립트 
$(function(){
	var team_domain_check = false;	//일단 도메인 체크 변수 만들기 , 사실 없어도 됨 
	 	
	  $("button[name=submitD]").attr('disabled',true);//첫 페이지부터 등록버튼 비활성화
	  $("input[name=team_domain]").blur(function(){
			var team_domain = $(this).val();
			
			if(team_domain == ""){   //빈칸이 공란일 때 = 비동기통신이 작동하지 않아서 도메인 입력 비기와 알럿알
				team_domain_check=false;	
				$("button[name=submitD]").attr('disabled',true);
				$("input[name=team_domain]").next("span").text("도메인을 입력해주세요");
				alert("도메인을 입력해주세요");
				return false;
		}
// 		else{	//빈칸이 공란이 아닐때= 비동기통신이 작동해서 도메인 이름 중복유무 확인가능
			$.ajax({
				url:"${pageContext.request.contextPath}/team_admin/check2",
				type:"get",
				data:{team_domain : team_domain},
				dataType:"text",
				success:function(resp){
	// 				console.log(resp);
					if(resp === "Y"){ //사용중
						team_name_check=false;	
						$("input[name=team_domain]").next("span").text("사용중인 도메인");
						$('#submitD').prop('disabled',true);
					} else if(resp === "N"){ //사용가능
						team_name_check=true;
						$("input[name=team_domain]").next("span").text("사용가능합니다");
						$("button[name=submitD]").attr('disabled',false);
					} 
				}
			});
	 	});
	});


// 클릭 하면 열고 닫기 
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

//팀 삭제시 비밀번호 확인 
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


//클릭 하면 열고 닫기 
$(function(){
	$(".navbar").hide();
	$(".navbar").show();

});
	
</script>

<body>
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
        
        
       
        <!-- 소유자 :팀 관리 설정-->
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
								        <a class="nav-link" href="${pageContext.request.contextPath}/team_admin/owner_manager_team?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}">팀관리 <span class="sr-only">(current)</span></a>
								      </li>
								      <li class="nav-item">
								    <a class="nav-link" href="${pageContext.request.contextPath}/team_admin/owner_manager_member?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}">멤버관리</a>
								     
								      </li>
								      <li class="nav-item">
								        <a class="nav-link" href="${pageContext.request.contextPath}/team_admin/owner_manager_per?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}">개인설정</a>
								      </li>
								<!--       <li class="nav-item"> -->
								<!--         <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a> -->
								<!--       </li> -->
								    </ul>
								  </div>
								  </c:forEach>
								</nav>	 

                                		<!-- 팀 정보 보기 -->
	                                    <div class="mypage-div">
                      
	                                    </div>
	                                    		
		                                  
	                                    
	                                    <!-- 변경하기 부분 -->
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
	                                    	    
			                               	    <!-- 팀 이름 변경하기 -->
												<div class="modify-items">
													<div class="modify-item-name">
														팀 이름  변경
														
														
													</div>
	                                        			<div class="modify-item-content modify-item2">
															<div class="modify-origin-div">
																${param.team_name}
															</div>
			                             					    <div class="modify-fix-div">
                                                   				    <form  action="edit_team_name" method="post"> 
                                                					     <input type="hidden" name="team_no" value="${param.team_no}">
                                                  						 <input type="hidden" name="team_domain" value="${param.team_domain}">
                                                      					 <input type="text" name="team_name" value="${teamDto.team_name}">
	                                                     				 <span name="team_nameN" id="team_nameS" class="team_nameS"></span>
                                                     					 <button type="submit" name="submitC" class="submitC" id="submitC">수정하기</button>
                                                    				 </form>
                                                    					 <button class="modify-cancel">취소</button>
	                                    						</div>
	                                    				</div>
	                                    	    </div>	
                                                     
	                                    		<!-- 팀 도메인 변경하기 -->
	                                    		<div class="modify-items">
	                                    			 <div class="modify-item-name">
	                                    			     팀 도메인
	                                    		    </div>
	                                    			    	<div class="modify-item-content modify-item4">
	                                    						<!--변경하기 버튼 부-->
	                                    						<div class="modify-origin-div">
																	${param.team_domain}  
																</div>
																      <div class="modify-fix-div">
	                                    								   <form  action="edit_team_domain" method="post"> 
							                                                     <input type="hidden" name="team_no" value="${param.team_no}">
							                                                     <input type="hidden" name="team_name" value="${param.team_name}">
							                                                     <input type="text" name="team_domain" value="${teamDto.team_domain}">
							                                                     <span name="team_domainN" id="team_domainS" class="team_domainS"></span>
							                                                     <button type="submit" name="submitD" class="submitD" id="submitD">수정하기</button>
							                                                </form>
																			 	 <button class="modify-cancel">취소</button>
	                                    							 </div>
	                                    				</div>
	                                    		</div>
	                                    	
	                                    	
<%-- 	                                    	</c:forEach> --%>
	                                    		<!-- 팀 영구 삭제하기 -->
												<div class="modify-items">
													<div class="modify-item-name">
														 팀삭제
													</div>
														 <div class="modify-item-content modify-item4">
															<!-- 팀 삭제하기 버튼을 누르면 -->
															<div class="modify-origin-div">
																팀 삭제하기
															</div>	
																 <div class="modify-fix-div">
																	 <form action="${pageContext.request.contextPath}/team_admin/edit_team_delete" method="post" id="modify-delete-member">
																		<h5>비밀번호</h5>
																		<input type="hidden" name="team_no" value="${param.team_no}">
		                                       							<input type="password" id="modify-delete-pw" name="member_pw" placeholder="비밀번호">
																			<div class="modify-alert">
																				<h4>"${param.team_name}" 팀의 모든 멤버가 같이 삭제됩니다. 그래도 원하신다면<br>
																	 				계정 비밀번호를 입력후 팀을 삭제해주세요</h4>
															 				</div>
																	</form>
											
					                                    				<button id="modify-delete-submit">팀 삭제하기</button>
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
	                                     
	                                        
	                                        



<!-- 멤버 관리 부분 --> 


</body>
</html>