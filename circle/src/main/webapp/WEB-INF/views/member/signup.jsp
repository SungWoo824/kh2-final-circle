<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<form action="signup" method="post" enctype="Multipart/form-data">
		<label>이메일</label><input type="text" name ="member_email"><br><br>
		<label>비밀번호</label><input type="password" name="member_pw"><br><br>
		<label>이름</label><input type="text" name="member_name"><br><br>
		<input type="file" name="file" accept="image/*"><br><br>
		<input type="submit">
	</form>
</body>
</html>