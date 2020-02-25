<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$(function(){
	
	
});
</script>


<h3>팀번호 : ${param.team_no} </h3>
<br>

<c:forEach var="folderList" items="${driveFolderList}">
<!-- 		   <input type="checkbox" > -->
		   <a  href="drive_view?team_no=${param.team_no}&drive_name=${driveFolderList}">
		   <h3>${folderList}</h3>
		   </a>
<%-- 		   		   <a href="drivedelete?team_no=${param.team_no}&drive_name=${driveFolderList}&drive_file_no=${param.drive_file_no}">삭제</a> --%>
<%-- 		   <a href="drivedelete?team_no=${param.team_no}&drive_name=${driveFolderList}">삭제</a> --%>
		   <a href="drivedelete?drive_file_no=${param.drive_file_no}&team_no=${param.team_no}&drive_name=${driveFolderList}">삭제</a>

</c:forEach>
			<hr>




