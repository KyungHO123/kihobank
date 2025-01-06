<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>기호은행 - 홈</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="<c:url value='/resources/css/bankCss'/>" rel="stylesheet">

<style>
body {
	background-color: #f8f9fa;
}

.navbar-brand {
	font-weight: bold;
	font-size: 1.5rem;
}

.hero-section {
	background: url('resources/img/background.png') no-repeat center center;
	background-size: cover;
	color: blue;
	text-align: center;
	padding: 100px 20px;
	height: 50%;
}

.hero-section h1 {
	font-size: 3rem;
}

.card img {
	height: 200px;
	object-fit: cover;
}

.hr {
	margin: 0px auto;
	border: 1px solid lightgray;
	width: 85%;
}
</style>
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
					<li class="nav-item"><a class="nav-link" href="#services">서비스</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="#about">소개</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="#contact">연락처</a>
					</li>
					<c:if test="${member.meMaNum eq 2}">
						<li class="nav-item"><a class="nav-link"
							href="<c:url value='/admin/main'/>">관리</a></li>
					</c:if>
					<c:if test="${member != null && member.meMaNum ne 2}">
						<li class="nav-item"><a class="nav-link"
							href="<c:url value='/member/mypage?meId=${member.meID}'/>">내정보</a>
						</li>
					</c:if>
					<c:if test="${member == null }">
						<li class="nav-item"><a class="nav-link"
							href='<c:url value="/member/login"/>'>로그인</a></li>
					</c:if>
					<c:if test="${member != null }">
						<li class="nav-item"><a class="nav-link"
							href='<c:url value="/logout"/>'>로그아웃</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</nav>

	<!-- 히어로 섹션 -->
	<section class="hero-section">
		<div class="container">
			<h1 class="mb-4">기호은행에 오신 것을 환영합니다</h1>
			<p class="lead mt-5">편리하고 안전한 금융 서비스를 경험하세요.</p>
		</div>
	</section>

	<!-- 서비스 섹션 -->
	<section id="services" class="py-5">
		<div class="container text-center">
			<h2 class="mb-4">주요 서비스</h2>
			<div class="row">
				<div class="col-md-4 mb-4">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">대출 서비스</h5>
							<p class="card-text">합리적인 이율과 다양한 상품을 제공하는 대출 서비스입니다.</p>
							<a href="<c:url value='/loan/list'/>" class="btn btn-primary">서비스
								조회</a>
						</div>
					</div>
				</div>
				<div class="col-md-4 mb-4">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">예금 상품</h5>
							<p class="card-text">안정적인 수익을 보장하는 다양한 예금 상품을 준비했습니다.</p>
							<a href="<c:url value='/deposit/list'/>" class="btn btn-primary">상품
								조회</a>
						</div>
					</div>
				</div>
				<div class="col-md-4 mb-4">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">계좌 이체</h5>
							<p class="card-text">편리하게 계좌이체 서비스를 이용하세요.</p>
							<a href="<c:url value='/member/mypage'/>" class="btn btn-primary">이체하기</a>
						</div>
					</div>
				</div>
				<div class="col-md-4 mb-4">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">빠른 조회</h5>
							<p class="card-text">편리하게 빠른 조회 서비스를 이용하세요.</p>
							<a href="<c:url value='/account/accountDetail'/>"
								class="btn btn-primary">조회하기</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<div class="hr"></div>
	<div class="container text-center">
		<h2 class="mb-4 mt-5">추천 대출 상품</h2>
		<c:choose>
			<c:when test="${loanList != null }">
				<c:forEach items="${loanList}" var="la">
					<div class="card mb-3">
						<div class="card-body">
							<h5 class="card-title">${la.laName}</h5>
							<p class="card-text">${la.laDetail}</p>
							<p class="card-text">연이율:${la.laInterest * 100}%</p>
							<p class="card-text">대출금액: 최소${la.laLimitMin}원 ~
								${la.laLimitMax}원</p>
							<a href="<c:url value='/loan/list'/>" class="btn btn-primary">더보기</a>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="card mb-3">
					<div class="card-body">
						<h5 class="card-title">상품이 없습니다.</h5>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		<h2 class="mb-4 mt-5">추천 적금 상품</h2>
		<c:choose>
			<c:when test="${depositList != null }">
				<c:forEach items="${depositList}" var="dp">
					<c:if test="${dp.dpDtNum == 2}">
						<div class="card mb-3">
							<div class="card-body">
								<h5 class="card-title">${dp.dpName}</h5>
								<p class="card-text">${dp.dpDetail}</p>
								<p class="card-text">연이율:${dp.dpInterest * 100}%</p>
								<a href="<c:url value='/deposit/list'/>" class="btn btn-primary">더보기</a>
							</div>
						</div>
					</c:if>

				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="card mb-3">
					<div class="card-body">
						<h5 class="card-title">상품이 없습니다.</h5>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		<h2 class="mb-4 mt-5">추천 예금 상품</h2>
		<c:choose>
			<c:when test="${depositList != null }">
				<c:forEach items="${depositList}" var="la">
					<c:if test="${dp.dpDtNum == 1}">
						<div class="card mb-3">
							<div class="card-body">
								<h5 class="card-title">${dp.dpName}</h5>
								<p class="card-text">${dp.dpDetail}</p>
								<p class="card-text">연이율:${dp.dpInterest *100}%</p>
								<a href="<c:url value='/deposit/list'/>" class="btn btn-primary">더보기</a>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="card mb-3">
					<div class="card-body">
						<h5 class="card-title">상품이 없습니다.</h5>
					</div>
				</div>
			</c:otherwise>
		</c:choose>


	</div>

	<!-- 푸터 -->
	<footer class="bg-dark text-white text-center py-4">
		<div class="container">
			<p class="mb-0">&copy; 2024 기호은행. 모든 권리 보유.</p>
			<p class="mb-0">TEL : 010 - 4407 - 1418</p>
		</div>
	</footer>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
