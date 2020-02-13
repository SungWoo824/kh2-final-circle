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
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>   
<script>
	$(function(){
		 //수정하기 기능

            var input = $("<input>");
            $(".edit-name").click(function(){  //수정 버튼을 누르면 
            	
            //result-form에 입력창과 수정하기버튼을 생성
            	var input = $("<input/>").attr("placeholder","변경할 이름을 입력해주세요").prop("required",true).appendTo(".result-form");
                var button = $("<button/>").text("수정하기").appendTo(".result-form");
            });
           
//             수정하기 버튼을 누르면 
           $(".edit-name").click(function(){
                $(this).remove();
           });

        });
</script>

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
        		<!-- 팀 관리 부분 -->
                <div class="mypage-main">
                <div class="main-bg">
                    
                        <div id="fullpage">
                            <div class="section">
                                	<div class="mypage-main-content">
	                                    <div class="mypage-div">
	                                    		<h1>팀관리</h1>
	                                    		<c:forEach var="teamDto" items="${getDetail}">
	                                    		<span> 팀 이름 = ${teamDto.team_name}</span>
	                                    		</c:forEach>
		                                        <span>${memberDto.member_name}</span>
		                                        <p>${memberDto.member_email}</p>
	                                    </div>
        									<div class="mypage-profile-div">
	                                        </div>
	                                        
			                                 
			                                 <div class="mypage-name-div">
			                                 <c:forEach var="teamDto" items="${getDetail}">
	                                    	 <h3>팀 이름= ${teamDto.team_name}</h3>
	                                    	
                                                     <button class="edit-name">이름 변경하기</button>
                                                     
                                                     <form class="result-form" action="team_manager_team" method="get"> 
                                                     
                                                     </form>
	                                    	 </c:forEach>
	                                    			
	                                    	</div>
	                                    	
	                                    	 <div class="mypage-name-div">
	                                    	<h3>팀 도메인</h3>
	                                    			<span>
													<button type="submit">도메인 변경하기</button>
	                                    			</span>
	                                    	</div>
	                                    	
	                                    	
												
		                                       	
	                                    	<div class="mypage-name-div">
	                                    	<span>팀삭제</span>
		                                       	<form class="delete_submit" action="team_manager_team" method="post">

													<button type="submit">팀삭제</button>
												</form>
			                                 </div>
													
													
													
			                                  </div>
	                                        </div>
	                                        </div>
	                                        </div>
	                                        </div>
	                                     
	                                        
	                                        



<!-- 멤버 관리 부분 --> 


</body>
</html>