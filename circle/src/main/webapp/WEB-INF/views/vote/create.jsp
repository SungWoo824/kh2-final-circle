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

<h3>마감 시각			<input type="date" name="vote_create_date">	<select name="vote_create_time">
<option value="00:00">12:00 AM</option>
<option value="01:00">01:00 AM</option>
<option value="02:00">02:00 AM</option>
<option value="03:00">03:00 AM</option>
<option value="04:00">04:00 AM</option>
<option value="05:00">05:00 AM</option>
<option value="06:00">06:00 AM</option>
<option value="07:00">07:00 AM</option>
<option value="08:00">08:00 AM</option>
<option value="09:00">09:00 AM</option>
<option value="10:00">10:00 AM</option>
<option value="11:00">11:00 AM</option>
<option value="12:00">12:00 PM</option>
<option value="13:00">01:00 PM</option>
<option value="14:00">02:00 PM</option>
<option value="15:00">03:00 PM</option>
<option value="16:00">04:00 PM</option>
<option value="17:00">05:00 PM</option>
<option value="18:00">06:00 PM</option>
<option value="19:00">07:00 PM</option>
<option value="20:00">08:00 PM</option>
<option value="21:00">09:00 PM</option>
<option value="22:00">10:00 PM</option>
<option value="23:00">11:00 PM</option>
</select> </h3>
<span>
공유 대화방			

   <select name="selectBox">
      <c:forEach var="topicList" items="${voteCreateDao.getTopicList()}" >
         <option value="${topicList}">${topicList}</option>
      </c:forEach>
   </select>

</span>
<br><br>
<button>취소</button>		<input type="submit" value="만들기">
</form>

</html>