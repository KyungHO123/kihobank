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
        <div class="mb-3">
            <h6>대출 약관</h6>
            <p>
                1. 대출 상품은 신청자의 신용 상태 및 기타 심사 기준에 따라 승인 여부가 결정됩니다.<br>
                2. 대출 금액은 신청한 금액과 다르게 조정될 수 있으며, 이에 대한 결정 권한은 은행에 있습니다.<br>
                3. 대출 이자율은 고정 금리 또는 변동 금리로 적용되며, 상세 사항은 신청 후 안내됩니다.<br>
                4. 연체 시 추가 이자 및 연체료가 부과될 수 있으며, 일정 기간 연체 시 법적 절차가 진행될 수 있습니다.<br>
                5. 대출 상환 조건(기간, 금액, 방식 등)은 계약 시 확정되며, 변경 시 사전 협의가 필요합니다.<br>
                6. 제공된 개인정보는 대출 심사 및 관리 목적으로만 사용되며, 관련 법률에 따라 보호됩니다.<br>
            </p>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="checkbox" id="agreeTerms" required="required">
            <label class="form-check-label" for="agreeTerms">
                약관에 동의합니다.
            </label>
        </div>
    </div>

    <!-- 대출 신청 폼 -->
    <div class="form-container">
        <form action="<c:url value='/loan/apply'/>" method="post">
        	<input value="${member.meID}" type="hidden" name="lsMeID">
        	<input  type="hidden" name="lsAccount" id="account">
            <div class="mb-3">
                <label for="loanType" class="form-label">선택한 대출 상품</label>
                 <input type="hidden" class="form-control" name="lsLaNum" value="${loan.laNum}" readonly="readonly">
                 <input type="text" class="form-control" value="${loan.laName}" readonly="readonly">
            </div>
            <div class="mb-3">
                <label for="loanAmount" class="form-label">대출 금액</label><br>
                <strong>(최소${loan.laLimitMin}원 ~ 최대${loan.laLimitMax}원)</strong>
                <input type="text" class="form-control amount" id="loanAmount" name="lsAmount" placeholder="대출 금액을 입력하세요" required>
            </div>
            <div class="mb-3">
            	<label for="" class="form-label">상환 개월</label>
            	<select name="lsMdNum" class="form-select">
            		<option selected disabled>상환개월을 선택해주세요</option>
            		<c:forEach items="${date}" var="md">
            			<option value="${md.mdNum}">${md.mdDate}년</option>
            		</c:forEach>
            	</select>
            </div>
            <div class="mb-3">
            	<label for="" class="form-label">상환 방식</label>
            	<select name="lsReNum" class="form-select">
            		<option selected disabled>상환방식을 선택해주세요</option>
            		<c:forEach items="${repayMent}" var="re">
	            		<option value="${re.reNum}">${re.reName}</option>
            		</c:forEach>
            	</select>
            </div>
            <button type="submit" class="btn btn-primary w-100">대출 신청</button>
        </form>
    </div>
</div>
<script type="text/javascript">
	$(document).on("keyup",".amount",function(){
		let amount = $(this).val();
		amount.replace(/[^0-9]/g, "");
		$(this).val(amount);
		if(amount < ${loan.laLimitMin}){
			alert("최소 대출 금액보다 적은 금액이 입력됬습니다.");
			$('.amount').val("");
			return;
		}
		if(amount > ${loan.laLimitMax}){
			alert("최대 대출 금액보다 많은 금액이 입력됬습니다.");
			$('.amount').val("");
			return;
		}if(amount == null){
			alert("대출 금액을 입력해야 합니다.")
		}
	})
	 $(document).ready(function() {
        // 계좌번호 생성 함수
        function generateAccountNumber() {
            const prefix = "2102"; // 계좌번호 시작 부분
            let randomNumber = "";
            // 9자리의 랜덤 숫자 생성
            for (let i = 0; i < 9; i++) {
                randomNumber += Math.floor(Math.random() * 10); // 0~9 랜덤 숫자 추가
            }
            return prefix + randomNumber; // 시작 부분과 랜덤 숫자 결합
        }
        // 계좌번호를 생성하고 hidden input에 설정
        const accountNumber = generateAccountNumber();
        $("#account").val(accountNumber);

    });
</script>
</body>
</html>
