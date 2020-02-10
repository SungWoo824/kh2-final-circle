<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
</head>
<h1>로그인이 완료되셨습니다</h1>
<h1>이제 팀 멤버로 등록하세요</h1>
<form action="team_member_regist" method="post">
<input type="hidden" value="${param.team_no}" name="team_no">
<input type="hidden" value="${param.topic_no}" name="topic_no">
<input type="submit" value="가입하기">
</form>
</html>