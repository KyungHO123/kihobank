<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기호은행 - 로그인</title>
<link href="../resources/css/bankCss.css" rel="stylesheet">
<style>
    .login-container {
    	margin:auto;
        background: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 400px;
    }
    .login-container h2 {
        margin-bottom: 20px;
    }
</style>
</head>
<body>
<div class="login-container mt-5">
    <h2 class="text-center">로그인</h2>
    <form action="<c:url value='/member/login'/>" method="post" >
        <div class="mb-3">
            <label for="username" class="form-label">아이디</label>
            <input type="text" name="id" value="rudgh12" class="form-control" id="id" placeholder="아이디를 입력하세요">
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" value="rudgh12" name="pw" class="form-control" id="pw" placeholder="비밀번호를 입력하세요">
        </div>
        <div class="d-grid">
            <button type="submit" class="btn btn-primary">로그인</button>
        </div>
        <p class="mt-3" style="font-size:12px;color:gray">아직 회원이 아니시라면 <a href='<c:url value="/member/signup"/>'>회원가입</a></p>
    </form>
    
</div>
</body>
</html>