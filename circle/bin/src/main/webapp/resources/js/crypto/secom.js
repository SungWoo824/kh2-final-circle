//목표 : 화면에 존재하는 
//모든 form에 있는 input[type=password]가 전송될 때 암호화
$(function(){
	$("form").submit(function(e){
		e.preventDefault();//기본작업 중지
		//this : 폼
		
		$(this).find("input[type=password]").each(function(){
			//this : 입력창
			var text = $(this).val();
			text = CryptoJS.HmacSHA256(text, "kh");
			text = CryptoJS.enc.Base64.stringify(text);
			$(this).val(text);
		});
		
		//보낸다(자바스크립트 명령)
		this.submit();
	});
});	