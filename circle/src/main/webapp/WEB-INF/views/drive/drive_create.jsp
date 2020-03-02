<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="${pageContext.request.contextPath}/resources/css/design/sb-admin-2.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/design/all.min.css" rel="stylesheet" type="text/css">

 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<link href="${pageContext.request.contextPath}/resources/css/design/common.css" rel="stylesheet" type="text/css">

<script>
$(function(){
	
	$("#check-btn").attr("disabled",true);
	
	$("input[name=drive_name]").blur(function(){
		
		
		var drive_name = $(this).val();
		var team_no = $("input[name=team_no]").val();
		
		$.ajax({
			url : "${pageContext.request.contextPath}/drive/drive_namecheck",
			type:"get",
			data:{
				drive_name : drive_name,
				team_no: team_no
			},
			dataType:"text",
			success: function(resp){
				if(resp === "Y"){
					$("input[name=drive_name]").next("span").text("동일한 이름이 있습니다.");
					$("#check-btn").prop("disabled",true); 
				}
				else if(resp === "N"){
					$("input[name=drive_name]").next("span").text(" ");
					$("#check-btn").prop("disabled",false); 
				}
			}
		});			
	});
});
</script>



