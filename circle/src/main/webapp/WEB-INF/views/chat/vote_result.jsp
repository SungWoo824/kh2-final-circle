<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<script>

</script>
<div id="bodyContents">
<h3>투표종료페이지</h3>

<%-- <c:if test="${compare=='y'}"> --%>
<!-- <button>투표 종료</button> -->
<%-- </c:if> --%>

<input type="button" value="투표하기" class="lock" onclick="MovePage(${no})">
</div>

</html>