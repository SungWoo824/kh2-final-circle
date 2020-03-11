<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">   
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.addons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/layoutstyle.css">
    <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/toggle.css">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/image/logofavi.png">
    
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script>
	$(function(){
		var seq=2;
        $(".option").click(function(e){
            console.log("click");
            var text = "<input type='text' name='category["+seq+"].vote_category_content' placeholder='보기를 입력하세요' required><br><br>";
            $(".ins").append(text);
            seq+=1;
        });
	});
	
	$(function(){
        $(".switcha").change(function(){
            console.log($(this).prop("checked"));
        });    
        
        $(".switchp").change(function(){
            console.log($(this).prop("checked"));
        }); 
        
	$('input[name=vote_create_date]').change(function(){
        function getToday(){
        	var date = new Date();
        	return date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0"+date.getDate()).slice(-2);
        };
		var today=getToday();
        var now = Date.now();
        var selected = Date.parse($('input[name=vote_create_date]').val());
        
        if(now>selected) {           
            alert("현재 시간 보다 이전의 시간은 선택할 수 없습니다.");
            $('input[name=vote_create_date]').val(today);
        }
    });
 
});
</script>   
</head>

<div align="center">
 
<form action="vote_create" method="post">
  <a class="list-group-item list-group-item-action">투표 제목: <input type="text" name="vote_create_title" placeholder="제목을 입력하세요" required style="border: none;"></a><br>
  <a class="list-group-item list-group-item-action">투표 설명(옵션)	: <input type="text" name="vote_create_detail" placeholder="설명을 입력하세요" required style="border: none;"></a><br>
  <a class="list-group-item list-group-item-action">보기 목록<br>
  <div style="width:100%; height:130px; overflow:auto">
  	<input type='text' name='category[0].vote_category_content' placeholder='보기를 입력하세요' required style="border: none;"><br><br>
	<input type='text' name='category[1].vote_category_content' placeholder='보기를 입력하세요' required style="border: none;"><br><br>
	<div class="ins"></div>
	</div>
	<input type="button" value="+보기 추가" class="option"><br>
	<br><br>
</a><br>
  <a class="list-group-item list-group-item-action">Dapibus ac facilisis in</a><br>
  <a class="list-group-item list-group-item-action">Dapibus ac facilisis in</a><br>
  <a class="list-group-item list-group-item-action">Dapibus ac facilisis in</a><br>
  <a class="list-group-item list-group-item-action">Dapibus ac facilisis in</a><br>
  <a class="list-group-item list-group-item-action">Dapibus ac facilisis in</a><br>
</form>
	</div>

<h3>투표 제목			<input type="text" name="vote_create_title" placeholder="제목을 입력하세요" required></h3><br><br>
<h3>투표 설명(옵션)			<input type="text" name="vote_create_detail" placeholder="설명을 입력하세요"></h3><br><br>
<h3>보기 목록</h3><br>
<!-- <input type="text" name="vote_create_option1" placeholder="보기를 입력하세요" required><br><br> -->
<!-- <input type="text" name="vote_create_option2" placeholder="보기를 입력하세요" required><br><br> -->
<input type='text' name='category[0].vote_category_content' placeholder='보기를 입력하세요' required><br><br>
<input type='text' name='category[1].vote_category_content' placeholder='보기를 입력하세요' required><br><br>
<input type="button" value="+보기 추가" class="option"><br>
<br><br>
<h3>
복수선택</h3>	
<label class="switch">
<input type="checkbox"  class="switchp" name="vote_create_plural" value="y">
<span class="slider round"></span>
</label>
<br><br>

<h3>마감 시각			
<input type="date" name="vote_create_date" required>	
<select name="vote_create_time">
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

   <select name="vote_create_topic" >
      <c:forEach var="topicList" items="${topicList}">
         <option value="<c:out value='${topicList }'/>"><c:out value="${topicList}"/></option>
      </c:forEach>
   </select>

</span>
<br><br>
		
		<input type="hidden" name="vote_create_status" id="create" value="y">
		<input type="hidden" name="team_no" value="${param.team_no }">
		<input type="hidden" name="topic_no" value="${param.topic_no }">
		
		<input type="submit" value="만들기">

<a href="topic_main?team_no=${param.team_no }&topic_no=${param.topic_no }"><button>취소</button></a>
</html>