<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
</script>

<h3>팀번호 : ${param.team_no} / 폴더명 : ${param.drive_name }</h3>

<br>

<div id="fileview">
<c:forEach var="fileList" items="${fileList}">
<!-- 	<form action="download" method="post"> -->
			<input type="hidden" name="drive_file_no" value="${fileList.drive_file_no}">
		    <div>${fileList.drive_file_no }</div> 
		    
			<a href="download?drive_file_no=${fileList.drive_file_no}">
				<input type="checkbox" >
				<img src="drive_file_view?drive_file_no=${fileList.drive_file_no}"><br>
				다운로드
			</a>
			/<a href="filedelete?drive_file_no=${fileList.drive_file_no}&team_no=${fileList.team_no}&drive_name=${fileList.drive_name}">삭제</a>
<!-- 	</form> -->
	
</c:forEach>

</div>
