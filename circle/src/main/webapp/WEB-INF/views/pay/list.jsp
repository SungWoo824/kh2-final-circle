<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h1>결제 이력</h1>

<c:forEach var="pay" items="${list }">
	<div>
		<c:if test="${pay.status eq '완료'}">
			<ul>
				<li>
					플랜 옵션: ${pay.item_name }
				</li>
				<li>
					가격: ${pay.price }
				</li>
				<li>
					구매 개수: ${pay.quantity }
				</li>
				<li>
					총 결제 금액: ${pay.total_amount }
				</li>
				<li>
					<a href="revoke?no=${pay.no }">취소</a>				
				</li>
			</ul>
		</c:if>
	</div>
</c:forEach>