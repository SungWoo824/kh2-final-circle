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
        
	<article class="modify-article">
		<div>
			<div class="modify-items">
				<div class="modify-item-name">
					프로필사진
				</div>
				<div class="modify-item-content">
					<button class="modify-item-content-button"><img alt="" src=""></button>
				</div>
			</div>
			<div class="modify-items">
				<div class="modify-item-name">
					이름
				</div>
				<div class="modify-item-content">
					<button class="modify-item-content-button">
						<div>${memberDto.member_name}</div>
						<div>
							<form action="#">
								<input type="text" name="member_name" value="${memberDto.member_name }">
								<button>취소</button><button>확인</button>
							</form>
						</div>
					</button>
				</div>
			</div>
			<div class="modify-items">
				<div class="modify-item-name">
					이메일 관리
				</div>
				<div class="modify-item-content">
					<button class="modify-item-content-button">
						<div>${memberDto.member_email }</div>
						<div>
							<form action="#">
								<input type="text" name="member_email" value="${memberDto.member_email }">
								<button>취소</button><button>확인</button>
							</form>
						</div>
					</button>
				</div>
			</div>
			<div class="modify-items">
				<div class="modify-item-name">
					비밀번호 변경하기
				</div>
				<div class="modify-item-content">
					<button class="modify-item-content-button">
						<div>**********</div>
						<div>
							<form action="#">
								<h5>현재 비밀번호</h5>
								<input type="password" name="member_pw">
								<h5>새 비밀번호</h5>
								<input type="password" name="change_pw">
								<button>취소</button><button>확인</button>
							</form>
						</div>
					</button>
				</div>
			</div>
			<div class="modify-items">
				<div class="modify-item-name">
					Circle 계정 삭제
				</div>
				<div class="modify-item-content">
					<button class="modify-item-content-button">
					
					</button>
				</div>
			</div>
		</div>
	</article>
</body>
</html>