<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$(function(){
	
	
});
</script>


<h1>${param.drive_name}</h1>    
<h3>멤버 : ${param.member_no} / 팀 :${param.team_no }번 의 드라이브</h3><br><br>

 <form action="drive_create" method="post" enctype="multipart/form-data">
 	<input type="hidden" name="drive_name" value="${param.drive_name}">
	<input type="hidden" name="team_no" value="${param.team_no}">
	<input type="hidden"  name="member_no"  value="${param.member_no}">
	<input type="file" name ="file" multiple="multiple" ><br><br>
	<input id="check-btn" type="submit" value="업로드">
</form>

<%-- <c:forEach var="driveFolderList" items="${driveFolderList}"> --%>
<%-- 	<a href="${pageContext.request.contextPath }/drive/drive_view"> --%>
<%-- 	드라이브 : ${driveFolderList.drive_name } --%>
<!-- 	</a> -->
<%-- </c:forEach>     --%>
<!-- 	<a href="drivedelete?">삭제</a><br> -->

