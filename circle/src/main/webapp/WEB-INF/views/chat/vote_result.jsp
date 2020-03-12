<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<link rel="icon" href="${pageContext.request.contextPath}/resources/image/logofavi.png">
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	
    <link href="${pageContext.request.contextPath}/resources/css/design/sb-admin-2.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/design/all.min.css" rel="stylesheet" type="text/css">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
   <link href="${pageContext.request.contextPath}/resources/css/design/common.css" rel="stylesheet" type="text/css">
</head>
<script>
$(function(){
	var plural = $('.pluralstatus').val();
	if(plural=="y"){
		$('.voteSelect').attr("type", "checkbox");
	}else{
		$('.voteSelect').attr("type", "radio");
	}
});
	function closevote(no){
		var team_no = ${param.team_no};
		var topic_no = ${param.topic_no};
		var  ajaxOption = {
				url : "./closevote?vote_create_no="+no,
				type : "GET",
				dataType : "html",
				data : {team_no:team_no, topic_no:topic_no},
				cache : false
				};
		$.ajax(ajaxOption).done(function(data){
			$('#bodyContents').html(data);
		});
	}
</script>
<h5 class="p-3 mb-2 bg-primary text-white" style="text-align:center;" >투표 결과 페이지</h5>

<ul>
	<c:forEach var="voteDetail" items="${voteDetail }">
		<li>
			<h4><img id="vote-creater-img" src='${pageContext.request.contextPath}/member/download?member_no=${voteDetail.vote_create_userno}'>
			<c:out value="${memberName }"/><a style="margin-left: 230px; font-size: 17px;"href="./topic_main?team_no=${param.team_no }&topic_no=${param.topic_no }">목록으로</a></h4>
		</li>
		<li>
			<span style="font-weight: bold; font-size: 20px">
			<c:out value="${voteDetail.vote_create_title }"></c:out>
			</span>
		</li>
		<li>
			<span style="font-size: 18px">
			<c:out value="${voteDetail.vote_create_detail }"></c:out>
			</span>
		</li>
		<li>
			<span style="font-size: 15px">
			공유된 곳 <c:out value="${voteDetail.vote_create_topic }"/>
			</span>
		</li>
	</c:forEach>
		<li>
			<c:forEach var="option" items="${voteCategoryDetail}" >
			<input type="radio" name="checkbox" class="voteSelect" value="${option.vote_category_content }"> <c:out value="${option.vote_category_content }"/><br><br>
			</c:forEach>
		</li>
		<c:forEach var="voteDetail" items="${voteDetail }">
			<li>
			<span style="font-size: 15px">
				<c:out value="${fn:substring(voteDetail.vote_create_date,0,11) }"/>
				<c:out value="${voteDetail.vote_create_time}"/>
			</span>
			</li>
			<li>
				<input type="hidden" class="pluralstatus" value="${voteDetail.vote_create_plural }">
				<c:if test="${!empty voteDetail.vote_create_plural }">
					복수투표가능			
				</c:if>
			</li>
		</c:forEach>
			
<c:choose>
	<c:when test="${complete=='y' }">
		투표완료
	</c:when>
	<c:when test="${compare=='y' and status=='y' }">
		<button type="button" class="btn btn-primary btn-sm" onclick="closevote(${no})">투표종료</button>
	</c:when>
</c:choose><br><br>
	<c:if test="${status=='n' }">
		<h4>투표 마감</h4>
		<h4>최다 득표 항목: <c:out value="${maxcount}">${maxcount}</c:out> </h4> 	
	</c:if>
</ul>

</html>