<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>헤더</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="../resources/css/bankCss.css" rel="stylesheet">
</head>
<body> 
<!-- 네비게이션 바 -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<div class="container">
			<a class="navbar-brand" href='<c:url value="/"/>'>기호은행</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false" aria-label="메뉴 토글">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item">
						<a class="nav-link" href="#services">서비스</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#about">소개</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#contact">연락처</a>
					</li>
					<c:if test="${member.meMaNum eq 2}">
						<li class="nav-item">
							<a class="nav-link" href="<c:url value='/admin/main'/>">관리</a>
						</li>
					</c:if>
					<c:if test="${member != null }">
						<li class="nav-item">
							<a class="nav-link" href="<c:url value='/member/mypage'/>">내정보</a>
						</li>
					</c:if>
					<c:if test="${member == null }">
						<li class="nav-item">
							<a class="nav-link" href='<c:url value="/member/login"/>'>로그인</a>
						</li>
					</c:if>	
					<c:if test="${member != null }">
						<li class="nav-item">
							<a class="nav-link" href='<c:url value="/logout"/>'>로그아웃</a>
						</li>
					</c:if>	
				</ul>
			</div>
		</div>
	</nav>
<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>