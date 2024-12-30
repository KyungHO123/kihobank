<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>기호은행 - 대출 리스트</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="<c:url value='/resources/css/bankCss'/>" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center mb-4">대출 상품 리스트</h1>

    <!-- 대출 상품 카드 리스트 -->
    <div class="row">
        <c:forEach items="${loanList}" var="loan">
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <h5 class="card-title">${loan.dpName}</h5>
                        <h6 class="card-subtitle mb-2 text-muted">상품 번호: ${loan.dpNum}</h6>
                        <p class="card-text">
                            <strong>상세 설명:</strong> ${loan.dpDetail}<br>
                            <strong>이자율:</strong> ${loan.dpInterest}%<br>
                            <strong>대출 한도:</strong> ${loan.depositType.dtName}
                        </p>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty loanList}">
            <div class="col-12">
                <p class="text-center">대출 상품이 없습니다.</p>
            </div>
        </c:if>
    </div>
</div>

</body>
</html>
