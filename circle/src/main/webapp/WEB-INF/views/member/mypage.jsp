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
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>   
<script>
$(function(){
	$(".param_submit").submit(function(e){
		e.preventDefault();
		
		var team_no = $(".team_no_value").attr("value")
		var url = "${pageContext.request.contextPath}/team/connect"; 
		var method = $(this).attr("method");
		var data = $(this).serialize();
		
		$.ajax({
			url:url,
			type:"get",
			data:data,
			success:function(resp){
				$(".topic_no_value").attr("value",resp);
			},
			error:function(resp){
				console.log("error")
			}
		})
		
		this.submit();
	})
})
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
		                        <c:when test="${not empty member_email}">
							        <li><a href="${pageContext.request.contextPath}/member/mypage">내정보</a></li>
							    </c:when>
						    </c:choose>
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
                                   
		                                    <c:forEach items="${teamlist}" var="teamDto">
		                                    	<div>
                                    				<div>
														<h4>team_name = ${teamDto.team_name} team_domain = ${teamDto.team_domain}</h4>
														<form class="param_submit" action="${pageContext.request.contextPath}/chat/topic_main">
															<input type="hidden" name="team_no" class="team_no_value" value="${teamDto.team_no}">
															<input type="hidden" name="topic_no" class="topic_no_value" value="">
															<button type="submit">이동하기</button>
														</form>
														<br><br>
													</div>
                                    			</div>
											</c:forEach>
											<div>
											<form action="${pageContext.request.contextPath}/team/create">
												<button type="submit">팀생성</button>
											</form>
											</div>
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