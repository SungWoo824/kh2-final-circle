<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">    

<title>이메일 링크 만료 페이지 </title>
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
<div class="mypage-main">
	<div class="main-bg">
		                    
		<div id="fullpage">
			<div class="section">
		    	<div class="mypage-main-content">
			    	<div class="mypage-div">
			        	<div class="mypage-name-div">
					    	<h1>만료된 페이지 입니다.</h1>
						</div>
					</div>
                </div>
             </div>
        </div>
     </div>
</div>
	
</body>
</html>