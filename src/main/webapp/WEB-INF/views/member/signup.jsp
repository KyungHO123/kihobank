<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기호은행 - 회원가입</title>
<link href="../resources/css/bankCss.css" rel="stylesheet">
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
	
</style>
</head>
<body>
	<div class="input-group-text signup-form-container">
		<form action="<c:url value="/member/signup"/>" name="form1" method="post" >
			<div class="signup-form-title">
				<p>회원가입</p>
			</div>
			<div>
				<input class="form-control mb-2" type="text" placeholder="아이디" name="meID">
			</div>
			<div>
				<input class="form-control mb-2" type="password" placeholder="비밀번호" name="mePw">
			</div>
			<div>
				<input class="form-control mb-2" type="password" placeholder="비밀번호확인"name="mePw2">
			</div>
			<div>
				<input class="form-control mb-2" type="text" placeholder="이름"name="meName">
			</div>
			<div>
				<input class="form-control mb-2" type="email" placeholder="이메일" name="meEmail">
			</div>
			<div>
				<input class="form-control mb-2" type="text" placeholder="휴대폰" name="mePhone">
			</div>
			<div  class="d-flex align-items-center">
				<input class="form-control mb-2" placeholder="우편번호" type="text" name="mePost" maxlength="5" class="" readonly="readonly"/>
				<input class="btn btn-outline-primary mb-2" type="button" value="주소찾기" id="btn"/><br>
			</div>
			<div>
				<input class="form-control mb-2 "  placeholder="도로명주소 및 지번주소" type="text" name="meStreet" readonly="readonly"/>
			</div>
			<div>
				<input class="form-control mb-2 " placeholder="상세주소를 입력하세요" type="text" name="meDetail" />
			</div>
			<button class="btn btn-primary w-100">회원가입</button>
		</form>
	</div>
<script>
	const btn =$('#btn');
	btn.on("click",function(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	console.log(data);
	        	let fullAddr = '';
	        	let extraAddr = '';
	        	if(data.userSelectedType === 'R'){
	        		fullAddr = data.roadAddress;
	        		if(data.buildingName !== ''){
	        			fullAddr += " " + data.buildingName;
	        		}
	        	}else{
	        		fullAddr = data.jibunAddress;
	        		if(data.buildingName !== ''){
	        			fullAddr += " " + data.buildingName;
	        		}
	        	}
	        	$('input[name="meStreet"]').val(fullAddr);
	        	$('input[name="mePost"]').val(data.zonecode);
	        	
	        }
	    }).open();
	});
</script>
</body>
</html>