<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
 
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">   
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.addons.css">

	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/layoutstyle.css">
    <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/common.css" />
    
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>


<script>
$(function(){
	$("#toggle1").click(function(){
		$(".menu1-slide").toggle();
	});
	
	$("#toggle4").click(function(){
		$(".menu4-slide").toggle();
	});
	
	$("#toggle33").click(function(){
		$(".menu33-slide").toggle();
	});
});
</script>
</head>

<div class="menu-wrap">
<div class="menu-con bg-base">
    <div class="menu-top">
        <ul class="menu-bar">
            <li class="gnb-btn">
                    <i class="fa fa-bars"></i>
            </li>
        </ul>
    </div>
    <div class="menu-bottom">
        <ul class="menu-bar">
             <li id="toggle1" class="gnb-btn menu1">
                <a class="fa fa-search"></a>
            </li>
            <li class="gnb-btn">
                <a class="fa fa-file"></a>
            </li>
            <li class="gnb-btn">
                <a class="fa fa-list-ul"></a>
            </li>
            <li id="toggle4" class="gnb-btn menu4">
                <a class="fa fa-check-square"></a>
            </li>
            <li class="gnb-btn">
                <a class="fa fa-plug"></a>
            </li>
            <li class="gnb-btn">
                <a class="fa fa-hdd"></a>
            </li>
            <li id="toggle-33" class="gnb-btn menu33">
                <a class="fa fa-hdd"></a>
            </li>
        </ul>
    </div>
</div>
</div>
<!-- partial -->

<div class="contents-wrap">
        <aside class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-top">
            <div class="brand-logo-wapper">
                <div class="dropdown">
                    <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">  
                        <div class="brand-topic-list" href="index.html">
                            <div class="navbar-brand">
                                <img src="${pageContext.request.contextPath}/resources/image/logo.png" alt="logo" />
                            </div>
                            <span class="brand-topic-name">test</span>
                            <i class="fa fa-caret-down" aria-hidden="true"></i>
                        </div>
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
                            <h6 class="dropdown-header">팀 리스트</h6>
                            <a class="dropdown-item" href="#">test</a>
                            <a class="dropdown-item" href="#">test2</a>
                            <a class="dropdown-item" href="#">test3</a>
                            <!-- <div class="dropdown-divider"></div> -->
                            <!-- <a class="dropdown-item" href="#">Separated link</a> -->
                        </div> 
                  </div>
                </div>
        </div>
        <!-- partial:partials/_sidebar.html -->
        <nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">
            <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/member/mypage">
                <i class="menu-icon typcn typcn-document-text"></i>
                <span class="menu-title">메인으로</span>
            </a>
            </li>
            <li class="nav-item" id="topic-create">
            	<a data-toggle="modal" data-target="#exampleModalCenter">
					새 토픽 생성
            	</a>	<i class="fa fa-plus"></i>
            </li>
            <!-- 등급이 소유자 또는 정회원만 초대 가능하게 if문 걸어야 한다 -->
            <li class="nav-item" id="invite-create">
            	<a id="invite_btn" data-toggle="modal"> 멤버 초대하기
				</a>	<i class="fa fa-plus"></i>
            </li>
            
            <div class="collapse" id="ui-basic">
                <ul class="nav flex-column sub-menu">

                	<c:forEach items="${topicList}" var="topicListDto">  

                		<li class="nav-item">
		                    <a class="nav-link" href="${pageContext.request.contextPath}/chat/topic?team_no=${param.team_no }&topic_no=${topicListDto.topic_no}">${topicListDto.topic_name}</a>
		                </li>
                	</c:forEach>

                </ul>
            </div>
            
            </li>
            <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#auth" aria-expanded="false" aria-controls="auth">
                <i class="menu-icon typcn typcn-document-add"></i>
                <span class="menu-title">채팅</span>
                <i class="menu-arrow fa fa-caret-down" aria-hidden="true"></i>
                <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="auth">
                <ul class="nav flex-column sub-menu">
                <li class="nav-item">
                    <a class="nav-link" href="pages/samples/blank-page.html">채팅</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="pages/samples/login.html"> test </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="pages/samples/register.html"> test </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="pages/samples/error-404.html"> test </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="pages/samples/error-500.html"> test </a>
                </li>
                </ul>
            </div>
            </li>
        </ul>
        </nav>
          </aside>  
        
        
	

    
    <!-- partial -->
    
  
            <div class="chat-wrap">
            	<div class="chat-aside">
                    <div class="chat-menu-bar">
        
                 <div>  

                    <article class="message-wrap">
                    
                        <div class="message" style="text-align: right">

							<h1>${topicDto.topic_name}</h1>
							<div id="chat-content">
								<c:forEach items="${topicChatList}" var="chatVo">
									<p>[${chatVo.member_name}] ${chatVo.chat_content}
								</c:forEach>
							</div>
							<div class="chat-send-content">
								<div class="chat-send-text">

									<input type="text" class="user-input">
								</div>
								<div class="chat-send-button">
									<button class="send-btn" type="submit">보내기</button>
								</div>
							</div>
									
						</div>
					</article>
					
				</div>
				
						
				        


            	<div id="gnb-detail-slide">
			            <div class ="menu33-slide">d</div>
			            <!-- 주소 변경했음 -->
	        			<div id="bodyContents" class="menu33-slide">   
	<!-- 			       		<button id="movelist" onclick="MoveList()">목록으로..</button> -->
							<a href="./topic_main?team_no=${param.team_no }&topic_no=${param.topic_no }"><button id="golist" >목록으로</button></a>
	        				<!-- 목록으로 버튼 if처리해야함 -->
				            <h3>투두 리스트</h3>
				            <a href="./vote_create?team_no=${param.team_no }&topic_no=${param.topic_no }">+할일 추가하기 </a><br><br>
							
							<!-- 할일 추가하기 버튼 -->
							<form action="todo_list_create" method="post">
							<input type="text" name="todo_list_content" >
							<button type="submit" class="todo-btn">추가</button>
							</form>
							
							<!-- 추가된 것 목록 리스트 -->
							
							
	        <!-- 화면 동적 전환(투표 상세 페이지) -->
				            		<ul>
				            	<c:forEach var="voteList" items="${voteList }" >
				            		<fmt:formatNumber type="number" var="no">${voteList.vote_create_team_no}</fmt:formatNumber>
				            		<li>
	        					<c:if test="${param.team_no eq no}">
				            		<c:out value="${voteList.vote_create_no}"/>번 투표
				            		<input type="button" name="${voteList.vote_create_no }" value="${voteList.vote_create_title}" onclick="MovePage(${voteList.vote_create_no })">     		
				            	</c:if>
				            		</li>
				            		<br>
				            	</c:forEach>   	
				            		</ul>
				            </div>
			        </div>
            </div>

            <!-- Page Title Header Ends-->      

			

                   	







        <!-- main-panel ends -->
      <!-- page-body-wrapper ends -->
    <script src="${pageContext.request.contextPath}/resources/js/design/vendor.bundle.base.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/design/vendor.bundle.addons.js"></script>
    



 </html>
