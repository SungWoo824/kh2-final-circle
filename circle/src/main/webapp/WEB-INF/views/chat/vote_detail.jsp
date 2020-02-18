<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">   
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.addons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/layoutstyle.css">
    <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/common.css" />
    
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
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

function MovePage(no){
	var str = new Array();
	$('.voteSelect:checked').each(function(){
		str +=$(this).val()+",";
	});
	
	var selection = 0;
	
	if($(".voteSelect").is(":checked") == true) {
		  var selection=selection+1; 
		};
		
	var  ajaxOption = {
			url:"./voteselect?vote_create_no="+no,
			type:"GET",
			dataType:"html",
			cache:false,
			data:{
					  member_no:${member_no},
					  vote_category_content:str,
					  vote_select_true:selection,
					  member_name:'${memberName}',
					  team_no:${param.team_no}, 
					  topic_no:${param.topic_no}
					}
			};
	
	$.ajax(ajaxOption).done(function(data){
		$('#bodyContents').html(data);
	});
}
</script>
<script>
function closevote(no){
	var  ajaxOption = {
			url : "./closevote?vote_create_no="+no,
			type : "GET",
			dataType : "html",
			cache : false,
			data : {
					member_no:${member_no},
					team_no:${param.team_no}, 
					topic_no:${param.topic_no}
					}
	};
	$.ajax(ajaxOption).done(function(data){
		$('#bodyContents').html(data);
	});
}
</script>
<div id="bodyContents">
<h3>투표상세페이지</h3><br>
<a href="./topic_main?team_no=${param.team_no }&topic_no=${param.topic_no }"><button id="golist" >목록으로</button></a>
<ul>
	<li>
		<c:out value="${memberName }"/>
	</li>
	<c:forEach var="voteDetail" items="${voteDetail }">
		<li>
			<c:out value="${voteDetail.vote_create_title }"></c:out>
		</li>
		<li>
			<c:out value="${voteDetail.vote_create_detail }"></c:out>
		</li>
		<li>
			공유된 곳 <c:out value="${voteDetail.vote_create_topic }"/>
		</li>
	</c:forEach>
		<li>
			<c:forEach var="option" items="${voteCategoryDetail}" >
			<input type="radio" name="checkbox" class="voteSelect" value="${option.vote_category_content }" > <c:out value="${option.vote_category_content }"/><br><br>
			</c:forEach>
		</li>
		<c:forEach var="voteDetail" items="${voteDetail }">
			<li>
				<c:out value="${fn:substring(voteDetail.vote_create_date,0,11) }"/>
				<c:out value="${voteDetail.vote_create_time}"/>
			</li>
			<li>
				<input type="hidden" class="pluralstatus" value="${voteDetail.vote_create_plural }">
				<c:if test="${!empty voteDetail.vote_create_plural }">
					복수투표가능			
				</c:if>
			</li>
		</c:forEach>
</ul>


<c:choose>
	<c:when test="${complete=='n' }">
		<input type="button" value="투표하기" onclick="MovePage(${no})">
	</c:when>
	<c:otherwise>
		투표완료	
	</c:otherwise>
</c:choose>
	<c:if test="${compare=='y' and status=='y' }">
		<input type="button" value="투표종료" onclick="closevote(${no})">
	</c:if>
	<c:if test="${status=='n' }">
		<h4>투표 마감</h4>
		<h4>최다 득표 항목: <c:out value="${maxcount}">${maxcount}</c:out> </h4> 
	</c:if>

</div>

</html>






