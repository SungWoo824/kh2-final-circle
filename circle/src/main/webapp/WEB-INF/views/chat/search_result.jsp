<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>

</head>
<div align="center" style="font-size: 17px; font-weight: bold; border-top: 50px;">
<c:if test="${empty allList }">
'${param.keyword}'에 대한 검색결과가 없습니다
</c:if>
</div>
<div style="width:100%; height:378px; overflow:auto">
<div align="center" style="font-size: 17px; border-top: 20px;">
<c:forEach items="${allList }" var="chatSearchDto">
	<a style="font-weight: bold;">이름: </a><c:out value="${chatSearchDto.member_name }"/>
	<a style="font-weight: bold;">토픽: </a><c:out value="${chatSearchDto.topic_name }"/><br>
	<a style="font-weight: bold;">시간</a><br><c:out value="${chatSearchDto.chat_time }"/><br>
	<a style="font-weight: bold;">내용: </a><c:out value="${chatSearchDto.chat_content }"/><br><br>
</c:forEach>
</div>
</div>

</html>