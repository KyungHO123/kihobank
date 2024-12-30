<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>기호은행 - 대출 신청</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="<c:url value='/resources/css/bankCss'/>" rel="stylesheet">
<style>
    body {
        background-color: #f8f9fa;
    }
    .terms-container {
        background: #fff;
        border: 1px solid #ddd;
        border-radius: 10px;
        padding: 20px;
        margin-bottom: 30px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .form-container {
        background: #fff;
        border: 1px solid #ddd;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
</style>
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center mb-4">대출 신청</h1>

    <!-- 약관 동의 영역 -->
    <div class="terms-container">
        <h5>약관 동의</h5>
        <p>대출 신청 전에 아래 약관을 반드시 읽어보시고 동의해 주세요.</p>
        <div class="form-check">
            <input class="form-check-input" type="checkbox" id="agreeTerms">
            <label class="form-check-label" for="agreeTerms">
                약관에 동의합니다.
            </label>
        </div>
    </div>

    <!-- 대출 신청 폼 -->
    <div class="form-container">
        <form action="/loan/apply" method="post">
            <div class="mb-3">
                <label for="name" class="form-label">이름</label>
                <input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하세요" required>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">전화번호</label>
                <input type="text" class="form-control" id="phone" name="phone" placeholder="전화번호를 입력하세요" required>
            </div>

            <div class="mb-3">
                <label for="loanAmount" class="form-label">대출 금액</label>
                <input type="number" class="form-control" id="loanAmount" name="loanAmount" placeholder="대출 금액을 입력하세요" required>
            </div>

            <div class="mb-3">
                <label for="loanType" class="form-label">대출 상품 선택</label>
                <select class="form-select" id="loanType" name="loanType" required>
                    <option value="" disabled selected>대출 상품을 선택하세요</option>
                    <option value="premium">프리미엄 대출</option>
                    <option value="standard">스탠다드 대출</option>
                    <option value="basic">베이직 대출</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary w-100">대출 신청</button>
        </form>
    </div>
</div>

</body>
</html>
