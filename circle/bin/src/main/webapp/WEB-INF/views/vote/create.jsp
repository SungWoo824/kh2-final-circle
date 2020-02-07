<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">   
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.addons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/layoutstyle.css">
    <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/toggle.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(function(){
		var seq=0;
        $(".option").click(function(e){
            console.log("click");
            var text = "<input type='text' name='category["+seq+"].vote_category_content' placeholder='보기를 입력하세요' required><br><br>";
            $(".ins").append(text);
            seq+=1;
        });
	});
	
	$(function(){
        // var check = $("input[type=checkbox]");
        // check.click(function(){
        //     var status = $(this).is(":checked");
        //     console.log(status);
        // });
        $(".switcha").change(function(){
            console.log($(this).prop("checked"));
        });    
        
        $(".switchp").change(function(){
            console.log($(this).prop("checked"));
        }); 
    });
	
</script>   
</head>

<form action="create" method="post">
<h3>투표 제목			<input type="text" name="vote_create_title" placeholder="제목을 입력하세요" required></h3><br><br>
<h3>투표 설명(옵션)			<input type="text" name="vote_create_detail" placeholder="설명을 입력하세요"></h3><br><br>
<h3>보기 목록</h3><br>
<!-- <input type="text" name="vote_create_option1" placeholder="보기를 입력하세요" required><br><br> -->
<!-- <input type="text" name="vote_create_option2" placeholder="보기를 입력하세요" required><br><br> -->
<div class="ins"></div>
<input type="button" value="+보기 추가" class="option"><br>
<h3>투표 옵션

<br><br>

익명투표</h3>
<label class="switch">
<input type="checkbox"  class="switcha" name="vote_create_anonymous" value="y">
<span class="slider round"></span>
</label>			
<h3>
복수선택</h3>	
<label class="switch">
<input type="checkbox"  class="switchp" name="vote_create_plural" value="y">
<span class="slider round"></span>
</label>
<br><br>

<h3>마감 시각			<input type="date" name="vote_create_date"></h3>
<span>
공유 대화방			
<c:if test="${empty typeList}" >
   <select name="selectBox">
      <c:forEach var="typeList" items="${typeList}" varStatus="i">
         <option value="${typeList.type}">${typeList.type}</option>
      </c:forEach>
   </select>
</c:if>
</span>
<br><br>
<button>취소</button>		<input type="submit" value="만들기">
</form>

</html>