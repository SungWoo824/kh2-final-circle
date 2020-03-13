<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href=" ${pageContext.request.contextPath}/resources/css/design/fullpage.css" />
<script type="text/javascript"
	src=" ${pageContext.request.contextPath}/resources/js/design/fullpage.js"></script>
<link rel="stylesheet" type="text/css"
	href=" ${pageContext.request.contextPath}/resources/css/design/common.css" />
<script
	src="${pageContext.request.contextPath}/resources/js/crypto/crypto-js.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/crypto/hmac-sha256.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/crypto/secom.js"></script>
<body style="background-color:#F6F6F6; ">

	<!-- 상단 헤더 -->
	-->
	<div class="circle-header">

		<div class="header-wrap">
			<div class="header-logo">
				<div class="mainlogo">
					<a href="${pageContext.request.contextPath}"><img
						src=" ${pageContext.request.contextPath}/resources/image/logol.png"></a>
				</div>
			</div>
			<div class="header-gnb">
				<ul class="gnb-menu">
					<li><a href="#">제품소개</a></li>
					<li><a href="#">요금안내</a></li>
					<c:choose>
						<c:when test="${not empty member_email}">
							<li><a
								href="${pageContext.request.contextPath}/member/mypage">내정보</a></li>
						</c:when>
					</c:choose>
				</ul>
				<ul class="gnb-menu">
					<c:choose>
						<c:when test="${not empty member_email}">
							<li class="logout-btn"><a
								href="${pageContext.request.contextPath}/member/signout">로그아웃</a></li>
						</c:when>
						<c:otherwise>
							<li class="login-btn"><a
								href="${pageContext.request.contextPath}/member/signin">로그인</a></li>
						</c:otherwise>


					</c:choose>
				</ul>
			</div>
		</div>
	</div>
	<!-- 소유자 :옵션 리스트 및 권한 부여 설정-->
	<div class="mypage-main">
		<div class="main-bg">

			<div id="fullpage">
				<div class="section">
					<div class="mypage-main-content">

						<!-- 상단 네비바 -->
						<nav class="navbar navbar-expand-lg navbar-light bg-primary">
							<a class="navbar-brand" href="#" style="color:white" >팀관리</a>
							<button class="navbar-toggler" type="button"
								data-toggle="collapse" data-target="#navbarNav"
								aria-controls="navbarNav" aria-expanded="false"
								aria-label="Toggle navigation">
								<span class="navbar-toggler-icon"></span>
							</button>
<%-- 							<c:forEach items="${teamlist}" var="teamDto"> --%>
								<div class="collapse navbar-collapse" id="navbarNav">
									<ul class="navbar-nav">
										<li class="nav-item"><a class="nav-link"
											href="${pageContext.request.contextPath}/team_admin/owner_manager_team?team_no=${param.team_no}&team_name=${teamDto.team_name}&team_domain=${param.team_domain}">팀관리
												<span class="sr-only">(current)</span>
										</a></li>
										<li class="nav-item"><a class="nav-link"
											href="${pageContext.request.contextPath}/team_admin/owner_manager_member?team_no=${param.team_no}&team_name=${param.team_name}&team_domain=${teamDto.team_domain}">멤버관리</a>

										</li>
										<li class="nav-item"><a class="nav-link"
											href="${pageContext.request.contextPath}/team_admin/owner_manager_per?team_no=${param.team_no}&team_name=${param.team_name}&team_domain=${teamDto.team_domain}">개인설정</a>
										</li>
										<li class="nav-item active"><a class="nav-link" style="color:white"
											href="${pageContext.request.contextPath}/plan/list?team_no=${param.team_no}&team_name=${param.team_name}&team_domain=${teamDto.team_domain}">보유중인
												플랜 보기</a></li>
										<!--       <li class="nav-item"> -->
										<!--         <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a> -->
										<!--       </li> -->
									</ul>
								</div>
<%-- 							</c:forEach> --%>
						</nav>
						<div class="row">
  <div class="col-3">
    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
      <a class="nav-link active" id="v-pills-messages-tab" data-toggle="pill" href="${pageContext.request.contextPath}/plan/list?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}" role="tab" aria-controls="v-pills-messages" aria-selected="false">보유중인 플랜</a>
      <a class="nav-link" id="v-pills-messages-tab" data-toggle="pill" href="${pageContext.request.contextPath}/plan/change_auth?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}" role="tab" aria-controls="v-pills-messages" aria-selected="false">권한부여</a>	
      <a class="nav-link" id="v-pills-messages-tab" data-toggle="pill" href="${pageContext.request.contextPath}/pay/pay_detail?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}" role="tab" aria-controls="v-pills-messages" aria-selected="false">플랜 추가 구매하기</a>
       <a class="nav-link" id="v-pills-messages-tab" data-toggle="pill" href="${pageContext.request.contextPath}/pay/list?team_no=${teamDto.team_no}&team_name=${teamDto.team_name}&team_domain=${teamDto.team_domain}" role="tab" aria-controls="v-pills-messages" aria-selected="false">구매 내역</a>	
    </div>
  </div>
  <div class="col-9" style="background-color: white; border:30px solid #F6F6F6; padding:10px;" >
    <div class="tab-content" id="v-pills-tabContent"  >
      		<div class="tab-pane active" id="home" role="tabpanel" aria-labelledby="home-tab" style="background-color: white">
							<br>
							<h2>보유중인 플랜 옵션</h2>
							<br>
							<hr>
							
							<ul>
							
								<h4>
									<li>1개월권: <c:out value="${oneMonth }" />개
									</li>
								</h4>
										<br><hr>
								<h4>	
									<li>6개월권: <c:out value="${sixMonth }" />개
									</li>
								</h4>	
										<br><hr>
								<h4>	
									<li>1년권: <c:out value="${oneYear }" />개
									</li>
								</h4>
								<br>	
							</ul>
							
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