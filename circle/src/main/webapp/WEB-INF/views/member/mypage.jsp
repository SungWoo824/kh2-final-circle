<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
                            <img src=" ${pageContext.request.contextPath}/resources/image/logol.png">
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
        <div class="circle-main-content">
                <div class="main-bg">
                    
                        <div id="fullpage">
                            <div class="section">
                                <div class="main-title">
                                    <div>
                                        <span>${memberDto.member_name}</span>
                                        <p>${memberDto.member_email}
                                        
                                    </div>
                                   
		                                    <c:forEach items="${teamList}" var="teamDto">
		                                    	<div class="main-btn">
                                    				<div class="main-btn-bg">
														<h3>${teamDto.team_name}</h3>
														<h3>${teamDto.team_domain}</h3>
														<a href="${pageContext.request.contextPath}/chat/topic_main?topic_no=1">무료 체험 시작</a><br><br>
														<br><br>
													</div>
                                    			</div>
											</c:forEach>
                                </div>
                            </div>
                            <div class="section">
                               
                            </div>
                            <div class="section">
                                
                            </div>
                        </div>
                  
                </div>
        </div>
	
	<br><br>
	
</body>
</html>