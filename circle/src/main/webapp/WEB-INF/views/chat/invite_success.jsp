<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h1> 써클에 오신것을 환영합니다</h1>


<h2>${team_name} 팀에 초대를 받으셨습니다</h2>
<h2> 로그인 후 팀의 멤버가 되어보세요</h2>

<!-- 파라미터값의 cert_email과 db member테이블에 있는 memebr_email이 맞다면 회원이므로  --> 
<form action="invite_success" method="post">
<input type="hidden" value="${param.cert_email}" name="cert_email">
<input type="hidden" value="${param.team_no}" name="team_no">
<input type="hidden" value="${param.topic_no}" name="topic_no">
<a href="${pageContext.request.contextPath}/chat/invite_signin?cert_email=${param.cert_email}&team_no=${param.team_no}&topic_no=${param.topic_no}">로그인</a>



<!-- 파라미터값의cert_email과 db member테이블에 있는 memebr_email이 틀리다면 비회원이므로  --> 
<h2>써클 회원이 아니신가요?</h2>
<input type="hidden" value="${param.cert_email}" name="cert_email">
<input type="hidden" value="${param.team_no}" name="team_no">
<input type="hidden" value="${param.topic_no}" name="topic_no">
<a href="${pageContext.request.contextPath}/chat/invite_signup?cert_email=${param.cert_email}&team_no=${param.team_no}&topic_no=${param.topic_no}">회원가입</a>

</form>
