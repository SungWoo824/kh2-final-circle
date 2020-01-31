<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
 <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/fullpage.css" />
 <script type="text/javascript" src=" ${pageContext.request.contextPath}/resources/css/fullpage.js"></script>
 <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/common.css" />
    
</head>
<body>


	 <div class="circle-header">

                <div class="header-wrap">
                    <div class="header-logo">
                        <div class="mainlogo">
                            <img src="/image/logol.png">
                        </div>
                    </div>
                    <div class="header-gnb">
                        <ul class="gnb-menu">
                            <li><a href="#">제품소개</a></li>
                            <li><a href="#">요금안내</a></li>
                        </ul>
                        <ul class="gnb-menu">
                            <li class="login-btn"><a href="member/signin">로그인</a></li>
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
                                        <span>효과적인 팀워크, 가벼워진 업무</span>
                                        <p>이메일이 필요없는 간편한 소통과 파일 공유, 빠른 피드백 확인까지.
                                        <br>바라던 기능들을 모두 담아
                                        <br>업무에 최적화된 커뮤니케이션이 가능해집니다.</p>
                                    </div>
                                    <div class="main-btn">
                                        <div class="main-btn-bg">
                                            <a href="member/signup">무료 체험 시작</a>
												<h3>member_email = ${member_email }</h3>
												<h3>member_grade = ${member_grade }</h3>
                                        </div>
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
		

<script>
        new fullpage('#fullpage', {
			sectionsColor: ['#f9f9f9', '#2684fe','#f9f9f9'],
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