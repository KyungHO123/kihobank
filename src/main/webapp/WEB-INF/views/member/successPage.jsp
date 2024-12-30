<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기호은행 - 회원가입성공</title>
<link href="../resources/css/bankCss.css" rel="stylesheet">
<style type="text/css">
	
</style>
</head>
<body>
<div class="input-group-text success-container" >
	<div class="success-group">
		<div class="success-text mb-5">
			<h1 class="mb-3">환영합니다!</h1>
			<p>회원가입 성공</p>
		</div>
		<div class="success-link">
			<a class="btn btn-success" href="<c:url value='/'/>">홈으로</a>
			<a class="btn btn-primary" href="<c:url value='/member/login'/>">로그인</a>
		</div>
	</div>
</div>
	
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>