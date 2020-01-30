<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<form action="create" method="post">
<h3>투표 제목			<input type="text" name="vote_create_title" placeholder="제목을 입력하세요" required></h3><br><br>
<h3>투표 설명(옵션)			<input type="text" name="vote_create_detail" placeholder="설명을 입력하세요"></h3><br><br>
<h3>보기 목록</h3><br>
<input type="text" name="vote_category_content" placeholder="보기를 입력하세요" required><br><br>
<input type="text" name="vote_category_content" placeholder="보기를 입력하세요" required><br><br>
<button>+보기 추가</button><br><br>
<h3>투표 옵션			<button>익명투표</button>	<button>복수선택</button></h3><br><br>
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