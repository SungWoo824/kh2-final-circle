<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/image/logofavi.png">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
 <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/fullpage.css" />
 <script type="text/javascript" src=" ${pageContext.request.contextPath}/resources/js/design/fullpage.js"></script>
 <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/common.css" />
    
</head>
<body class="home-body">
    <div class="circle-header">

                <div class="header-wrap">
                    <div class="header-logo">
                        <div class="mainlogo">
                            <a href="${pageContext.request.contextPath}"><img src=" ${pageContext.request.contextPath}/resources/image/logol.png"></a>
                        </div>
                    </div>
                    <div class="header-gnb">
                        <ul class="gnb-menu">
                         	<li><a href="#test1" data-menuanchor="test1">무료체험하기</a></li>
                            <li><a href="#test2" data-menuanchor="test2">CIRCLE소개</a></li>
                            <li><a href="#test3" data-menuanchor="test3">요금안내</a></li>
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
        <div class="circle-main-content">
                <div class="main-bg">
                    
                        <div id="fullpage">
                            <div class="section" data-anchor="test1">
                        <img class="home-img" src="${pageContext.request.contextPath}/resources/image/bg.png">
                        <img class="home-img2" src="${pageContext.request.contextPath}/resources/image/bg2.png">   
                                <div class="main-title">
                                    <div>
                                        <span>효과적인 팀워크, 가벼워진 업무</span>
                                        <p>이메일이 필요없는 간편한 소통과 파일 공유, 빠른 피드백 확인까지.
                                        <br>바라던 기능들을 모두 담아
                                        <br>업무에 최적화된 커뮤니케이션이 가능해집니다.</p>
                                    </div>
                                    <div class="main-btn">
                                        <div class="main-btn-bg">
                                            <a href="member/signup">무료 체험 시작</a><br><br>
                                    <h5>member_email = ${member_email }</h5>
                                    <h5>member_grade = ${member_grade }</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="section" data-anchor="test2">
                            <div class="about-title">
                               <span>ABOUT CIRCLE</span>
                               <p>우리는 팀 커뮤니케이션을 위한 새롭고 혁신적인 방법을 제공하고자 합니다.<br>
                        그룹중심의 메신저 기반으로 빠른 소통과 간편한 프로젝트 관리가 가능해집니다.<br>
                        써클(circle)을 통해 함께 일하는 것이 어떻게 달라질 수 있는지 경험해 보세요.</p>
                            </div>
                             <img class="home-img3" src="${pageContext.request.contextPath}/resources/image/bg5.png">
                               
                            </div>
                            <div class="section" data-anchor="test3">
                                <div class="pay-title">
                               <span>요금 안내</span>
                               <p>써클을 함께 사용할 멤버는 몇 명인가요?</p>
                            	</div>
                            	<div class="pay-">
                            		<div >
	     <div align="center" style="margin-top: 4%; margin-bottom: 60px;">

	</div>
			
			<br>
			<div style="margin: 0 auto; width: 1200px;" >
          	<article class="admin-wrap" style="padding-top: 5rem; width: 1200px;" >
                    
						<div class="card border-primary mb-3 admin-cardy">
						  <div class="card-header">1개월권<br>개당:5000\</div>
						  <div class="card-body admin-cardy-body">
						    <form action="pay_detail" method="post">
						    	<h5 class="card-title">
						    		<br>혜택<br>
								  	할 일 생성 개수 100개<br>->무제한<br>
									무제한 업로드 및 다운로드<br><br>
									토픽 생성 가능<br><br>
									투표 생성 가능<br><br>
								
								<br><br>	
								<button type="button" class="btn btn-primary btn-lg" >지금 문의 하기 </button>
							
							
								<br>
								</h5>
							</form>
						  </div>
						</div>
						                    
						<div class="card border-primary mb-3 admin-cardy">
						  <div class="card-header">6개월권<br>개당:27000\</div>
						  <div class="card-body admin-cardy-body">
						    <form action="pay_detail" method="post">
						    	<h5 class="card-title">
						    		<br>혜택<br>
								  	할 일 생성 개수 100개 -> 무제한<br>
									무제한 업로드 및 다운로드<br><br>
									토픽 생성 가능<br><br>
									투표 생성 가능<br><br>
							
							<br><br>
							<button type="button" class="btn btn-primary btn-lg">지금 문의 하기 </button>
								<br>
								</h5>
							</form>
						  </div>
						</div>
						                    
						<div class="card border-primary mb-3 admin-cardy">
						  <div class="card-header">1년권<br>개당:48000\</div>
						  <div class="card-body admin-cardy-body">
						    <form action="pay_detail" method="post">
						    	<h5 class="card-title">
						    		<br>혜택<br>
								  	할 일 생성 개수 100개 -> 무제한<br>
									무제한 업로드 및 다운로드<br><br>
									토픽 생성 가능<br><br>
									투표 생성 가능<br><br>
							
								<br><br>	
								<button type="button" class="btn btn-primary btn-lg">지금 문의 하기 </button>
								<br>
								</h5>
							</form>
						  </div>
						</div>	
			</article>	
			</div>
	                            		
                            		</div>
                            	</div>
                            </div>
                        </div>
                  
                </div>
        </div>
      
<!-- 메인 패럴렉스 -->
<script>
        new fullpage('#fullpage', {
        	navigation:true,
        	anchors:['test1', 'test2', 'test3'],
         sectionsColor: ['#f9fafc', '#f9f9f9','#ffffff'],
         });
      
         $(document).ready(function() {
            $('#fullpage').fullpage({
               //options here
               autoScrolling:true,
               scrollHorizontally: true
            });
   
            //methods
            $.fn.fullpage.setAllowScrolling(false);
         });
    </script>
</body>
</html>