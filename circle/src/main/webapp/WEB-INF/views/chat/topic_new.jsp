<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<h1>토픽 생성하기</h1>
<form action="topic_new" method="post">
	이름 :<input type="text" name="topic_name"><br><br>
	공개여부 :<input type="radio" name="topic_confidential" checked="checked">비공개
					<input type="radio" name="topic_confidential" >공개<br><br>
	토픽 설명<textarea name="topic_explain" rows="" cols=""></textarea><br><br>
	<input type="submit" value="생성하기">
	<input type="button" value="닫기"> 
</form>
