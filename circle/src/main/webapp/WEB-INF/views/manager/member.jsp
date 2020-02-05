<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>회원목록</h2>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>이메일</th>
				<th>이름</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${memberList}" var="memberDto">
				<tr>
					<td>${memberDto.member_no}</td>
					<td>${memberDto.member_email}</td>
					<td>${memberDto.member_name}</td>
				</tr>
			</c:forEach>
			
		</tbody>
	</table>
</body>
</html>