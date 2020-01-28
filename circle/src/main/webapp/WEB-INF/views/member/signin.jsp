<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
</head>
<body>
	<form action="signin" method="post">
		<label>이메일</label><input type="text" name="member_email"><br><br>
		<label>비밀번호</label><input type="password" name="member_pw"><br><br>
		<input type="submit" value="로그인">
	</form>
	<a href="findpw">비밀번호찾기</a>
</body>
</html>