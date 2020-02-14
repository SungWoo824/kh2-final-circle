<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>이메일 초대 링크로 들어오기 성공 페이지 </title>
  
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/fullpage.css" />
<script type="text/javascript" src=" ${pageContext.request.contextPath}/resources/js/design/fullpage.js"></script>
<link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/common.css" />
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>   
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
							<h1> 써클에 오신것을 환영합니다</h1>
<div class="mypage-main">
	<div class="main-bg">
		                    
		<div id="fullpage">
			<div class="section">
		    	<div class="mypage-main-content">
			    	<div class="mypage-div">
			        	<div class="mypage-name-div">
							<br><br>
							
								<form action="invite_success" method="post">
							<c:forEach items="teamDetail"></c:forEach>
							<h3>${teamDto.team_name} 팀에 초대를 받으셨습니다</h3>
							<h3> 로그인 후 팀의 멤버가 되어보세요</h3>
							<br>
								<!-- 파라미터값의 cert_email과 db member테이블에 있는 memebr_email이 맞다면 회원이므로  --> 
								<input type="hidden" value="${param.cert_email}" name="cert_email">
								<input type="hidden" value="${param.team_no}" name="team_no">
								<input type="hidden" value="${param.topic_no}" name="topic_no">
								<a href="${pageContext.request.contextPath}/chat/invite_signin?cert_email=${param.cert_email}&team_no=${param.team_no}&topic_no=${param.topic_no}" class="btn btn-primary" role="button">로그인</a>
								

								<!-- 파라미터값의cert_email과 db member테이블에 있는 memebr_email이 틀리다면 비회원이므로  --> 
								<br><br>
							<h2>써클 회원이 아니신가요?</h2>
							<br>
								<input type="hidden" value="${param.cert_email}" name="cert_email">
								<input type="hidden" value="${param.team_no}" name="team_no">
								<input type="hidden" value="${param.topic_no}" name="topic_no">
								<a href="${pageContext.request.contextPath}/chat/invite_signup?cert_email=${param.cert_email}&team_no=${param.team_no}&topic_no=${param.topic_no}" class="btn btn-primary" role="button">회원가입</a>

							</form>
						</div>
					</div>
                </div>
             </div>
        </div>
     </div>
</div>

</body>
</html>
