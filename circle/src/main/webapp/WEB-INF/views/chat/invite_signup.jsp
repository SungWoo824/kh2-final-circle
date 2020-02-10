<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="${pageContext.request.contextPath}/resources/js/crypto/crypto-js.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/crypto/hmac-sha256.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/crypto/secom.js"></script>
</head>
<body>
	<form action="invite_signup" method="post" enctype="Multipart/form-data">
		<label>이메일</label><input type="email" name ="member_email"><br><br>
		<label>비밀번호</label><input type="password" name="member_pw"><br><br>
		<label>이름</label><input type="text" name="member_name"><br><br>
		<input type="file" name="file" accept="image/*"><br><br>
		<input type="submit">
	</form>
</body>
</html>