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
function MovePage(no){
	var str = "";
	$('.voteSelect:checked').each(function(){
		str +=$(this).val();
	});
	var selection = 0;
	if($(".voteSelect").is(":checked") == true) {
		  var selection=selection+1; 
		}
	var  ajaxOption = {
			url : "./voteselect?vote_create_no="+no,
			type : "GET",
			dataType : "html",
			cache : false,
			data : {
					  member_no:${member_no},
					  vote_category_content:str,
					  vote_select_true:selection,
					  member_name:"${memberName}",
					}
			};
	$.ajax(ajaxOption).done(function(data){
		$('#bodyContents').html(data);
	});
	
	$(function(){
		$('.lock').attr('disabled', false);
		$('.lock').click(function(){
			$(this).attr('disabled', true);
		});
	});
};
</script>
<div id="bodyContents">
<h3>투표상세페이지</h3>
<c:if test="${compare=='y'}">
<a href="./vote_result"><button>투표 종료</button></a>
</c:if>
<c:out value="${member_no }" />

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
			<input type="checkbox" class="voteSelect" value="${option.vote_category_content }"> <c:out value="${option.vote_category_content }"/><br><br>
			</c:forEach>
		</li>
		<c:forEach var="voteDetail" items="${voteDetail }">
			<li>
				<c:out value="${fn:substring(voteDetail.vote_create_date,0,11) }"/>
				<c:out value="${voteDetail.vote_create_time}"/>
			</li>
			<li>
				<c:if test="${!empty voteDetail.vote_create_anonymous }">
					익명투표			
				</c:if>
			</li>
			<li>
				<c:if test="${!empty voteDetail.vote_create_plural }">
					복수투표가능			
				</c:if>
			</li>
		</c:forEach>
</ul>
		<input type="button" value="투표하기" class="lock" onclick="MovePage(${no})">
</div>

</html>






