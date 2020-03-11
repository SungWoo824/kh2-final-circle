<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/image/logofavi.png">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
 <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/fullpage.css" />
 <script type="text/javascript" src=" ${pageContext.request.contextPath}/resources/js/design/fullpage.js"></script>
 <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/common.css" />
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>   
<script>


</script> 
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
                            <c:choose>
                            	<c:when	test="${not empty member_grade}">
                            		<li><a href="${pageContext.request.contextPath}/manager/main">관리자 페이지</a></li>
                            	</c:when>
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
        <div class="mypage-main">
                <div class="main-bg">
                    
                        <div id="fullpage">
                            <div class="section">
                                	<div class="mypage-main-content">
	                                    <div class="mypage-div">
	                                    	<div class="member-mypage-img">
	                                    		<img id="member-profile-img" src='download?member_no=${member_no}'>
	                                    	</div>
	                                    	<div class="mypage-name-div">
		                                        <span>${memberDto.member_name}</span>
		                                        <p>${memberDto.member_email}
	                                        </div>
	                                        <div class="mypage-profile-div">
	                                        	<a href="${pageContext.request.contextPath}/member/modify">프로필 설정</a>
	                                        </div>
	                                        
	                                    </div>
	                                   
			                                    <c:forEach items="${teamMainList}" var="teamMainVO">
			                                    	<div>
	                                    				<div class="mypage-div">	
	                                    					<div class="mypage-name-div">
																<h4>team_name = ${teamMainVO.team_name} team_domain = ${teamMainVO.team_domain}</h4>
															</div>
															
															<c:choose>
																<c:when test="${teamMainVO.member_position==null}">
																	<!-- 팀관리 : 비소유자가 보이는 버튼 -->
																	<form class="setting_submit" action="${pageContext.request.contextPath}/team_admin/member_manager_team" method="get">
																		 
																		<input type="hidden" name="team_no" class="team_no_value" value="${teamMainVO.team_no}">
																		<input type="hidden" name="team_name" class="team_name_value" value="${teamMainVO.team_name}">
																		<input type="hidden" name="team_domain" class="team_domain_value" value="${teamMainVO.team_domain}">
																		<div class="mypage-team-div">
																			<button type="submit">설정</button>
																		
																		</div>
																	</form>
																</c:when>
																


																<c:otherwise>
																	<!-- 팀관리 : 소유자만 보이는 버튼 -->
																	<form class="setting_submit" action="${pageContext.request.contextPath}/team_admin/owner_manager_team" method="get">
																		<input type="hidden" name="team_no" class="team_no_value" value="${teamMainVO.team_no}">
																		<input type="hidden" name="team_name" class="team_name_value" value="${teamMainVO.team_name}">
																		<input type="hidden" name="team_domain" class="team_domain_value" value="${teamMainVO.team_domain}">
																		<div class="mypage-team-div">
																			<button type="submit">소유자 설정</button>
																		</div>
																	</form>
																</c:otherwise>
																
																</c:choose>	


															
															
<!-- 															팀관리 : 소유자만 보이는 버튼 -->
<%-- 															<form class="setting_submit" action="${pageContext.request.contextPath}/team_admin/owner_manager_team" method="get"> --%>
<%-- 																<input type="hidden" name="team_no" class="team_no_value" value="${teamDto.team_no}"> --%>
<%-- 																<input type="hidden" name="team_name" class="team_name_value" value="${teamDto.team_name}"> --%>
<%-- 																<input type="hidden" name="team_domain" class="team_domain_value" value="${teamDto.team_domain}"> --%>
<!-- 																<div class="mypage-team-div"> -->
<!-- 																	<button type="submit">소유자관리</button> -->
<!-- 																</div> -->
																
<!-- 															</form> -->
																

															<form class="param_submit" action="${pageContext.request.contextPath}/chat/topic" method="get">
																<input type="hidden" name="team_no" class="team_no_value" value="${teamMainVO.team_no}">
																<input type="hidden" name="topic_no" class="topic_no_value" value="">
																<div class="mypage-team-div">
																	<button id="param_submit_btn" type="submit">이동하기</button>
																</div>
															</form>
															
														</div>
	                                    			</div>
												</c:forEach>
												<div class="mypage-team-create">
													<form action="${pageContext.request.contextPath}/team/create">
														<button class="mypage-team-create-submit" type="submit">팀생성</button>
													</form>
												</div>
									</div>
                            </div>
                            
                        </div>
                  
                </div>
        </div>
	
	<br><br>
	
</body>
</html>