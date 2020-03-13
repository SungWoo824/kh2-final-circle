<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소유자 팀관리 / 멤버설정 페이지 / 정회원 리스트 보기</title>
</head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
 <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/fullpage.css" />
 <script type="text/javascript" src=" ${pageContext.request.contextPath}/resources/js/design/fullpage.js"></script>
 <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/common.css" />
<script src="${pageContext.request.contextPath}/resources/js/crypto/crypto-js.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/crypto/hmac-sha256.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>   
<script src="${pageContext.request.contextPath}/resources/js/crypto/secom.js"></script>   
<script>
// 클릭 하면 열고 닫기 
$(function(){
	$(".modify-fix-div").hide();
	$(".modify-origin-div").show();
	
	$(".modify-origin-div").click(function() {
        $(this).parent().children(".modify-fix-div").show('3000');
        $(this).hide('fast');
    });
	
	//취소 버튼 
	$(".modify-cancel").click(function(){
		$(this).parent().parent().children(".modify-origin-div").show('3000');
        $(this).parent().parent().children(".modify-fix-div").hide('fast');
	})
	
	
	$(".modify-fix-div").hide();
	$(".modify-origin-div").show();
	
	$(".modify-origin-div").click(function() {
        $(this).parent().children(".modify-fix-div").show('3000');
        $(this).hide('fast');
    });
	
	//취소 버튼 
	$(".modify-cancel").click(function(){
		$(this).parent().parent().children(".modify-origin-div").show('3000');
        $(this).parent().parent().children(".modify-fix-div").hide('fast');
	})
	

	

});

//스크롤
$(function(){
    $(window).scroll(function(){
        console.log("scroll event");
        console.log($(this).scrollTop());

        if($(this).scroll > $(document).innerHeight()*0.9){
            console.log("더 불러오세요");
        }
    });
}); 

</script>

<body style="height: 5000px;  background-color: #F6F6F6;">
<div style="width:100%; height:90%; overflow:auto">
 	 <!-- 상단 헤더 --> -->
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
         <!-- 소유자 : 멤버 관리 설정-->
        <div class="mypage-main">
             <div class="main-bg">
                    
                 <div id="fullpage">
                      <div class="section">
                           <div class="mypage-main-content">
                           
								<!-- 상단 네비바 -->
								<nav class="navbar navbar-expand-lg navbar-light bg-primary">
								  <a class="navbar-brand" href="#" style="color:white">멤버관리</a>
								  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
								    <span class="navbar-toggler-icon"></span>
								  </button>
								  
								    <div class="collapse navbar-collapse" id="navbarSupportedContent">
								     <ul class="navbar-nav mr-auto">
								      <li class="nav-item">
								        <a class="nav-link" href="${pageContext.request.contextPath}/team_admin/owner_manager_team?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}">팀관리</a>
								      </li>
								      <li class="nav-item active">
								        <a class="nav-link" style="color:white" href="${pageContext.request.contextPath}/team_admin/owner_manager_member?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}">멤버관리<span class="sr-only">(current)</span></a>
								      </li>
								      <li class="nav-item">
								        <a class="nav-link" href="${pageContext.request.contextPath}/team_admin/owner_manager_per?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}">개인설정</a>
								      </li>
								      <li class="nav-item"><a class="nav-link"
											href="${pageContext.request.contextPath}/plan/list?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}">보유중인
												플랜 보기</a></li>
								    </ul>
								    <form class="form-inline my-2 my-lg-0">
								      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
								      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
								    </form>
								  </div>
								</nav>
								

	<!-- 팀 멤버 리스트 보기 : 정회원 -->
						
<div class="row">
  <div class="col-3">
    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
      <a class="nav-link" id="v-pills-home-tab" data-toggle="pill" href="${pageContext.request.contextPath}/team_admin/owner_manager_member?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}" role="tab" aria-controls="v-pills-home" aria-selected="true">참여중인 팀멤버</a>
      <a class="nav-link active" id="v-pills-profile-tab" data-toggle="pill" href="${pageContext.request.contextPath}/team_admin/member_list_regular?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}" role="tab" aria-controls="v-pills-profile" aria-selected="false">정회원</a>
      <a class="nav-link" id="v-pills-messages-tab" data-toggle="pill" href="${pageContext.request.contextPath}/team_admin/member_list_associate?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}" role="tab" aria-controls="v-pills-messages" aria-selected="false">준회원</a>
      <a class="nav-link" id="v-pills-messages-tab" data-toggle="pill" href="${pageContext.request.contextPath}/team_admin/member_list_owner?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}" role="tab" aria-controls="v-pills-messages" aria-selected="false">소유자</a>
      <a class="nav-link" id="v-pills-messages-tab" data-toggle="pill" href="${pageContext.request.contextPath}/team_admin/grant_position?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}" role="tab" aria-controls="v-pills-messages" aria-selected="false">권한부여</a>	
    </div>
  </div>
  <div class="col-9" style="background-color: white; border:30px solid #F6F6F6; padding:10px;" >
    <div class="tab-content" id="v-pills-tabContent">
      <div class="tab-pane active" id="home" role="tabpanel" aria-labelledby="home-tab">
      </div>
      
      <br>
      <!-- 								멤버관리 : 정보보기 -->
			                                   <br>
		                                   <h2> ${teamDto.team_name}팀 정회원 멤버 목록 입니다.</h2>
		                                   	
		                                  	   <br>
		                                  	   <hr>
		                         
      		<h3>정회원 보기  </h3>
      		<br>
			<c:forEach items="${memberListRegular}" var="memberListVO">	
   				<c:out value="${memberListVO.member_name}">${memberListVO.member_name}</c:out>
				<span class="badge badge-primary">${memberListVO.member_position}</span>
				<span class="badge badge-pill badge-light">${memberListVO.member_auth}</span>
				<c:out value="${memberListVO.member_grade}">${memberListVO.member_grade}</c:out> 
				<c:out value="${memberListVO.member_email}">${memberListVO.member_email}</c:out> 
				<br><br><hr>
   			</c:forEach>
    </div>
  </div>
</div>	 

										
                     
       					   </div>
					</div>
			</div>
		</div>
</div>	                              
</div>

</body>
</html>