<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
</head>
<body>
<h2>홈 화면</h2>

<a href="member/signup">회원가입</a><br><br>
<a href="member/signin">로그인</a>
<a href="member/signout">로그아웃</a>

<h3>member_email = ${member_email }</h3>
<h3>member_grade = ${member_grade }</h3>
</body>
</html>