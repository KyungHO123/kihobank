<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기호은행 - 계좌개설</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resources/css/bankCss.css" rel="stylesheet">
    <style type="text/css">
        .account-opening-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .account-opening-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .account-opening-header h2 {
            margin: 0;
        }
        .btn-agree {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="account-opening-container">
        <div class="account-opening-header">
            <h2>계좌 개설 동의</h2>
            <p class="text-muted">계좌 개설을 진행하기 위해 아래 내용을 확인하고 동의해주세요.</p>
        </div>
           <div class="terms-container">
    <h4 class="mb-3">기호은행 계좌 이용 약관 및 개인정보 처리방침</h4>
    <div class="terms-content" style="max-height: 300px; overflow-y: auto; border: 1px solid #ddd; padding: 15px; background: #f9f9f9;">
        <h5>제 1조 목적</h5>
        <p>이 약관은 기호은행(이하 "은행")이 제공하는 금융 서비스(이하 "서비스")를 이용함에 있어, 이용자(이하 "고객")와 은행 간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.</p>

        <h5>제 2조 용어의 정의</h5>
        <p>
            1. <strong>서비스</strong>: 은행이 제공하는 계좌 개설, 입출금, 이체, 대출, 예금 등의 금융 서비스.<br>
            2. <strong>고객</strong>: 본 약관에 동의하고 은행의 서비스를 이용하는 개인 또는 법인.<br>
            3. <strong>개인정보</strong>: 고객의 신분을 식별할 수 있는 정보로, 이름, 연락처, 계좌번호, 금융거래정보 등을 포함합니다.
        </p>

        <h5>제 3조 서비스 이용</h5>
        <p>
            1. 고객은 본 약관에 동의한 후 서비스를 이용할 수 있습니다.<br>
            2. 고객은 서비스 이용 시 법령을 준수하고, 타인의 권리를 침해하지 않아야 합니다.<br>
            3. 은행은 고객의 동의 없이 서비스를 변경하거나 중단하지 않으며, 불가피한 사유로 변경이 필요한 경우 고객에게 사전 공지합니다.
        </p>

        <h5>제 4조 개인정보 처리</h5>
        <p>
            1. 은행은 고객의 개인정보를 관련 법령에 따라 적법하고 안전하게 처리합니다.<br>
            2. 개인정보의 수집 및 이용 목적:<br>
            &nbsp;&nbsp;- 금융거래의 실행 및 관리<br>
            &nbsp;&nbsp;- 법령에서 정한 바에 따른 의무 준수<br>
            &nbsp;&nbsp;- 고객 문의 및 불만 처리<br>
            &nbsp;&nbsp;- 마케팅 및 서비스 개선 (선택적 동의 사항)<br>
            3. 개인정보 보유 기간:<br>
            &nbsp;&nbsp;- 법령에서 정한 기간 또는 서비스 제공 목적 달성 시까지 보관합니다.<br>
            4. 고객의 권리:<br>
            &nbsp;&nbsp;- 개인정보 열람, 수정, 삭제를 요청할 수 있으며, 이에 대해 은행은 법령에 따라 신속히 처리합니다.
        </p>

        <h5>제 5조 고객의 의무</h5>
        <p>
            1. 고객은 계좌 개설 및 서비스 이용 시 정확한 정보를 제공해야 합니다.<br>
            2. 고객의 계정 및 인증 정보는 본인만이 사용해야 하며, 이를 제3자와 공유하거나 양도할 수 없습니다.<br>
            3. 고객의 고의 또는 과실로 인해 발생한 모든 손해는 고객의 책임으로 합니다.
        </p>

        <h5>제 6조 은행의 책임</h5>
        <p>
            1. 은행은 고객의 개인정보를 보호하기 위해 최선의 보안 조치를 강구합니다.<br>
            2. 은행은 서비스를 안정적으로 제공하기 위해 노력하며, 불가항력적인 사유로 인한 서비스 중단 시 고객에게 신속히 알립니다.
        </p>

        <h5>제 7조 마케팅 정보 수신</h5>
        <p>
            1. 고객이 마케팅 정보 수신에 동의한 경우, 은행은 서비스 관련 소식, 이벤트, 혜택 정보를 제공할 수 있습니다.<br>
            2. 고객은 언제든지 마케팅 수신 동의를 철회할 수 있습니다.
        </p>

        <h5>제 8조 약관의 변경</h5>
        <p>
            1. 은행은 약관을 변경할 경우, 최소 7일 전부터 변경 내용을 고객에게 공지합니다.<br>
            2. 고객이 변경된 약관에 동의하지 않는 경우, 서비스 이용을 중단하고 해지할 수 있습니다.
        </p>

        <h5>부칙</h5>
        <p>본 약관은 2024년 1월 1일부터 시행됩니다.</p>
    </div>
</div>


            <div class="d-grid">
                <a href="<c:url value='/account/addAccount'/>" class="btn btn-primary btn-agree">동의하고 진행</a>
            </div>

            <div class="d-grid mt-3">
                <a href="<c:url value='/member/mypage'/>" class="btn btn-secondary">취소</a>
            </div>
    </div>
</body>
</html>
