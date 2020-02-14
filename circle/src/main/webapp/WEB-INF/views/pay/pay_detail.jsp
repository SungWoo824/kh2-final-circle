<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>


</head>
<br>
<br>

<div align="center"><h2>플랜 옵션</h2></div>
<br>
<div align="center">
<h3>혜택</h3>
<h4>
할 일 생성 개수 100개 -> 무제한<br>
무제한 업로드 및 다운로드<br>
토픽 생성 가능<br>
투표 기능 이용 가능</h4>
<form action="pay_detail" method="post">
<h3>1개월<br>
5000원/명<br>
수량: <input type="text" name="quantity">
</h3>
<input type="hidden" name="partner_user_id" value="${member_email }">
<input type="hidden" name="partner_order_id" value="1">
<input type="hidden" name="price" value="5000">
<input type="hidden" name="term" value="30">
<input type="hidden" name="total_amount" value="5000">
<input type="hidden" name="vat_amount" value="500">
<input type="hidden" name="tax_free_amount" value="0">
<input type="hidden" name="item_name" value="1개월권">
<input type="submit" value="선택">
</form>
<!-- 위의 폼은 테스트용임 js로 .val()해서 총금액 구해줘야함 -->
<form action="pay_detail" method="post">
<h3>6개월<br>
27000원/명<br>
수량: <input type="text" name="quantity">
</h3>
<input type="hidden" name="price" value="27000">
<input type="hidden" name="term" value="182">
<input type="submit" value="선택">
</form>

<form action="pay_detail" method="post">
<h3>1년<br>
48000원/명<br>
수량: <input type="text" name="quantity">
</h3>
<input type="hidden" name="price" value="48000">
<input type="hidden" name="term" value="365">
<input type="submit" value="선택">
</form>

</div>
</html>