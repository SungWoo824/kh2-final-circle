<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>

</head>

<c:forEach items="${allList }" var="chatSearchDto">
	<c:out value="${chatSearchDto.member_name }"/><br>
	<c:out value="${chatSearchDto.chat_time }"/><br>
	<c:out value="${chatSearchDto.chat_content }"/><br>
	<c:out value="${chatSearchDto.topic_name }"/><br>
	<c:out value="${chatSearchDto.member_no }"/><br>
</c:forEach>


</html>