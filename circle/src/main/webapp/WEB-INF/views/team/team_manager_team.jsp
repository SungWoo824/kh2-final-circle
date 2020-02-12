<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    
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


<body>
<p>${teamDto}</p>
<!-- 팀관리 부분 -->
<h1>팀관리</h1>
<h3>팀 이름 변경</h3>
<h3>팀 도메인 변경</h3>
<h3>팀 삭제</h3>
<span></span>
<button class="delete">팀 삭제</button>



<!-- 멤버 관리 부분 --> 


</body>
</html>