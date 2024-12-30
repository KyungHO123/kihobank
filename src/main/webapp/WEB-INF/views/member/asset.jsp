<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기호은행 - 자산관리</title>
<link href="../resources/css/bankCss.css" rel="stylesheet">
<style>
  body {
      background-color: #f8f9fa;
  }
  .section-title {
      margin-bottom: 20px;
      font-weight: bold;
      font-size: 1.8rem;
      text-align: center;
      color: #343a40;
  }
  .profile-container {
      max-width: 800px;
      margin: 50px auto;
      padding: 20px;
      background: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }
  .card {
      border-radius: 15px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      transition: transform 0.2s, box-shadow 0.2s;
  }
  .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
  }
  .card-body {
      padding: 20px;
      text-align: center;
  }
</style>
</head>
<body>
<div class="profile-container">
    <h1 class="text-center mb-4">자산관리</h1>

    <!-- 내 계좌 정보 -->
    <section class="mb-5">
        <h2 class="section-title">내 계좌 정보</h2>
        <div class="card text-center mb-5 shadow-sm" style="max-width: 600px; margin: 0 auto; border-radius: 15px; background: #f8f9fa;">
            <div class="card-body">
                <c:choose>
                    <c:when test="${account != null }">
                        <h4 class="card-title text-primary mb-3">계좌 이름: ${account.acName}</h4>
                        <p class="text-muted mt-2" id="num" style="font-size: 1.3rem;">계좌 번호: ${account.acNum}</p>
                        <p class="text-muted mt-2" style="font-size: 0.9rem;">계좌 잔액</p>
                        <h5 class="card-text text-primary fw-bold mt-3" id="balance">${account.acBalance}원</h5>
                    </c:when>
                    <c:otherwise>
                        <h4 class="text-success mt-3 mb-4">계좌가 없습니다.</h4>
                        <a href="<c:url value='/account/addAccount'/>" class="btn btn-primary">계좌개설</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <!-- 대출 목록 -->
    <section class="mb-5">
        <h2 class="section-title">대출 목록</h2>
        <div class="card text-center mb-5 shadow-sm" style="max-width: 600px; margin: 0 auto; border-radius: 15px; background: #f8f9fa;">
            <div class="card-body">
            	<c:choose >
            		<c:when test="${laSub != null }">
		                <h5 class="card-title">${laSub.lsName}</h5>
		                <p class="card-text">
		                    <strong>대출 금액:</strong> ${laSub.lsBalance}<br>
		                    <strong>이자율:</strong> ${laSub.lsAmount}<br>
		                    <strong>상환 기간:</strong> 10년
		                </p>
	                </c:when> 
	                 <c:otherwise>
                        <h4 class="text-success mt-3 mb-4">대출이 없습니다.</h4>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <!-- 예·적금 목록 -->
    <section>
        <h2 class="section-title">예·적금 목록</h2>
        <div class="card text-center mb-5 shadow-sm" style="max-width: 600px; margin: 0 auto; border-radius: 15px; background: #f8f9fa;">
            <div class="card-body">
                <h5 class="card-title">고금리 정기예금</h5>
                <p class="card-text">
                    <strong>금액:</strong> 10,000,000원<br>
                    <strong>이자율:</strong> 4.0%<br>
                    <strong>만기일:</strong> 2025-12-31
                </p>
            </div>
        </div>
        <div class="card text-center mb-5 shadow-sm" style="max-width: 600px; margin: 0 auto; border-radius: 15px; background: #f8f9fa;">
            <div class="card-body">
                <h5 class="card-title">여행 적금</h5>
                <p class="card-text">
                    <strong>월 납입액:</strong> 200,000원<br>
                    <strong>이자율:</strong> 3.5%<br>
                    <strong>만기일:</strong> 2025-06-30
                </p>
            </div>
        </div>
    </section>
</div>
<script type="text/javascript">
function format1(num) {
    const str = num.toString();
    const firstPart = str.substring(0, 4); // 앞 4자리
    const secondPart = str.substring(4, 7); // 그다음 3자리
    const remaining = str.substring(7); // 나머지 숫자
    const formattedRemaining = remaining.replace(/\B(?=(\d{4})+(?!\d))/g, "-");
    return firstPart+"-"+secondPart+"-"+formattedRemaining;
}
if(${account.acNum != null}){
	$('#num').text(format1(${account.acNum}));
}
function format(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
if(${account.acBalance != null}){
	$('#balance').text(format(${account.acBalance}) + "원");
}
</script>
</body>
</html>
