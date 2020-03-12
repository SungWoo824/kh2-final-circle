<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">   
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/vendor.bundle.addons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/design/layoutstyle.css">
    <link  rel = "stylesheet"  type ="text/css"  href =" ${pageContext.request.contextPath}/resources/css/design/common.css" />
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
</head>
<script>
function rs(){
	var chars="0123456789abcdefghifklmnopqrstuvwxyz";
	var string_length=10;
	var randomstring="";
	for(var i=0; i<string_length; i++){
		var rnum = Math.floor(Math.random()*chars.length);
		randomstring +=chars.substring(rnum,rnum+1);
	}
	return randomstring;
	console.log(randomstring);
	};
	
	$(function(){
		$('#quantity1').on('keyup', function(){
				var qty = $('.quantity1').val();
				console.log(qty);
				var price = $('.price1').val();	
				var sum=qty*price;
				console.log(sum);
			$('#total_amount1').val(sum);
			$("input[name=total_amount]").val(sum);
			$("input[name=partner_order_id]").val(rs().toString());
		});
	});
	
	$(function(){
		$('#quantity6').on('keyup', function(){
			var qty = $('.quantity6').val();
			console.log(qty);
			var price = $('.price6').val();
			var sum=qty*price;
			console.log(sum);
		$('#total_amount6').val(sum);
		$("input[name=total_amount]").val(sum);
		$("input[name=partner_order_id]").val(rs().toString());
		});
	});
	
	$(function(){
		$('#quantity12').on('keyup', function(){
			var qty = $('.quantity12').val();
			console.log(qty);
			var price = $('.price12').val();
			var sum=qty*price;
			console.log(sum);
		$('#total_amount12').val(sum);
		$("input[name=total_amount]").val(sum);
		$("input[name=partner_order_id]").val(rs().toString());
		});
	});
</script>
<!-- <nav class="navbar navbar-expand-lg navbar-light bg-light"> -->
<!-- </nav> -->
	<div align="center" style="margin-top: 4%; margin-bottom: 80px; background-color: #2FA4E7;">
		<span style ="display:block;width:100%;height:50px;font-size:30px">플랜 옵션</span>
	</div>
<div style="background-color: #e9ecef">
<div class="container-fluid" style="overflow:auto">
		
          	<article class="admin-wrap" style="padding-top: 5rem;">
                    
						<div class="card border-primary mb-3 admin-cardy" style="width: 20rem; height: 30rem; margin:auto;">
						  <div class="card-header">1개월권<br>개당:5000\</div>
						  <div class="card-body admin-card-body">
						    <form action="pay_detail" method="post">
						    	<h4 class="card-title">
						    		혜택<br>
								  	할 일 생성 개수 100개 -> 무제한<br>
									무제한 업로드 및 다운로드<br>
									토픽 생성 가능<br>
									투표 생성 가능<br>
								<input type="hidden" class="price1" value="5000"><br>
								수량<br>
								<input type="text" name="quantity" class="quantity1" id="quantity1"><br><br>
								총 금액<br>
								<input type="text" id="total_amount1" value="" disabled="disabled">
								<input type="hidden" name="partner_user_id" value="${member_email }">
								<input type="hidden" name="partner_order_id" value="">
								<input type="hidden" name="price" value="5000">
								<input type="hidden" name="term" value="30">
								<input type="hidden" name="total_amount" id="total_amount1" value=1>
								<input type="hidden" name="vat_amount" value="500">
								<input type="hidden" name="tax_free_amount" value="0">
								<input type="hidden" name="item_name" value="1개월권">
								<input type="hidden" name="team_no" value="${param.team_no }">
								<input type="hidden" name="team_name" value="${param.team_name }">
								<input type="hidden" name="team_domain" value="${param.team_domain }">
								<br><br>
								<input type="submit" value="선택">
								<br>
								</h4>
							</form>
						  </div>
						</div>
						                    
						<div class="card border-primary mb-3 admin-cardy" style="width: 20rem; height: 30rem;  margin:auto;">
						  <div class="card-header">6개월권<br>개당:27000\</div>
						  <div class="card-body admin-card-body">
						    <form action="pay_detail" method="post">
						    	<h4 class="card-title">
						    		혜택<br>
								  	할 일 생성 개수 100개 -> 무제한<br>
									무제한 업로드 및 다운로드<br>
									토픽 생성 가능<br>
									투표 생성 가능<br><br>
								<input type="hidden" class="price6" value="27000">
								수량<br> <input type="text" name="quantity" class="quantity6" id="quantity6"><br><br>
								총 금액<br> <input type="text" id="total_amount6" value="" disabled="disabled">
								<input type="hidden" name="partner_user_id" value="${member_email }">
								<input type="hidden" name="partner_order_id" value="">
								<input type="hidden" name="price" value="27000">
								<input type="hidden" name="term" value="182">
								<input type="hidden" name="total_amount" id="total_amount6" value=1> 
								<input type="hidden" name="vat_amount" value="500">
								<input type="hidden" name="tax_free_amount" value="0">
								<input type="hidden" name="item_name" value="6개월권">
								<input type="hidden" name="team_no" value="${param.team_no }">
								<input type="hidden" name="team_name" value="${param.team_name }">
								<input type="hidden" name="team_domain" value="${param.team_domain }">
								<br><br>
								<input type="submit" value="선택">
								<br>
								</h4>
							</form>
						  </div>
						</div>
						                    
						<div class="card border-primary mb-3 admin-cardy" style="width: 20rem; height: 30rem; margin:auto;">
						  <div class="card-header">1년권<br>개당:48000\</div>
						  <div class="card-body admin-card-body">
						    <form action="pay_detail" method="post">
						    	<h4 class="card-title">
						    		혜택<br>
								  	할 일 생성 개수 100개 -> 무제한<br>
									무제한 업로드 및 다운로드<br>
									토픽 생성 가능<br>
									투표 생성 가능<br><br>
								<input type="hidden" class="price12" value="48000">
								수량<br><input type="text" name="quantity" class="quantity12" id="quantity12"><br><br>
								총 금액<br><input type="text" id="total_amount12" value="" disabled="disabled">								
								<input type="hidden" name="partner_user_id" value="${member_email }">
								<input type="hidden" name="partner_order_id" value="">
								<input type="hidden" name="price" value="48000">
								<input type="hidden" name="term" value="365">
								<input type="hidden" name="total_amount" id="total_amount12" value=1> 
								<input type="hidden" name="vat_amount" value="500">
								<input type="hidden" name="tax_free_amount" value="0">
								<input type="hidden" name="item_name" value="1년권">
								<input type="hidden" name="team_no" value="${param.team_no }">
								<input type="hidden" name="team_name" value="${param.team_name }">
								<input type="hidden" name="team_domain" value="${param.team_domain }">
								<br><br>
								<input type="submit" value="선택">
								<br>
								</h4>
							</form>
						  </div>
						</div>	
			</article>	
</div>
</div>
</html>