<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
	<script src="${pageContext.request.contextPath}/resources/js/crypto/crypto-js.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/crypto/hmac-sha256.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/crypto/secom.js"></script>
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
                            
                        </ul>
                        <ul class="gnb-menu">
                            <li class="login-btn"><a href=" ${pageContext.request.contextPath}/member/signin">로그인</a></li>
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
                                <form action="signin" method="post">
                                    <div>
                                        <span>로그인</span>
                                        
                                        <div class="form-group signin-form-group">
									      <label for="exampleInputEmail1"></label>
									      <input type="email" class="form-control" id="exampleInputEmail1" name="member_email" aria-describedby="emailHelp" placeholder="Enter email">
									      
									    </div>
									    <div class="form-group signin-form-group">
									      <label for="exampleInputPassword1"></label>
									      <input type="password" class="form-control" id="exampleInputPassword1" name="member_pw" placeholder="Password">
									    </div>
                                       
                                    </div>
                                    <div>
                                        <div>
                   
											<button type="submit" class="btn btn-primary signin-submit">로그인</button>
										
                                           
                                        </div>
                                    </div>
                                    </form>
                                </div>
                            </div>
                            <div class="section">
                               
                            </div>
                            <div class="section">
                                
                            </div>
                        </div>
                  
                </div>
        </div>
     
</body>
</html>