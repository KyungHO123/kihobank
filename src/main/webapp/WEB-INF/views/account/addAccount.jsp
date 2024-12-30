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
    <style>
        .account-container {
            max-width: 700px;
            margin: 50px auto;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .account-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .account-header h2 {
            margin: 0;
        }
        .btn-submit {
            margin-top: 20px;
        }
            .keypad {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
        }
        .keypad button {
            font-size: 1.5rem;
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="account-container">
        <div class="account-header">
            <h2>계좌 개설</h2>
            <p class="text-muted">계좌 정보를 입력하고 개설하세요.</p>
        </div>

        <form action="<c:url value='/account/addAccount'/>" method="post">
        	<input type="hidden" name="acNum" id="acNum">
            <div class="mb-3">
                <label for="acName" class="form-label">계좌 별칭</label>
                <input type="text" class="form-control" id="acName" name="acName" placeholder="계좌 별칭을 입력하세요" value="${member.meName}님의 계좌" required>
            </div>
            <div class="mb-3">
                <label for="acPW" class="form-label">계좌 비밀번호</label>
                <input type="password" class="form-control" id="acPW" name="acPW" placeholder="4자리 숫자 비밀번호" minlength="4" maxlength="4" required readonly data-bs-toggle="modal" data-bs-target="#keypadModal">
            </div>
            <div class="mb-3">
                <label for="acInterest" class="form-label">이자율</label>
                <input type="text" step="0.01" class="form-control" id="acInterest" name="acInterest" value='3.50' readonly="readonly">
            </div>
            <div class="mb-3">
                <label for="acAclNum" class="form-label">계좌 한도</label>
                <select class="form-select" id="acAclNum" name="acAclNum" required>
                    <option value="" disabled selected>계좌 한도를 선택하세요</option>
                   	<c:forEach items="${acl}" var="acl">
                   		<option value="${acl.aclNum}">${acl.aclLimit}</option>
                   	</c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label for="acAclNum1" class="form-label">계좌 개설 목적</label>
                <select class="form-select" id="acAclNum1" name="acAclNum1" required>
                    <option value="" disabled selected>계좌 개설 목적</option>
                   	<option value="1">급여목적</option>
                   	<option value="2">투자목적</option>
                   	<option value="2">예,적금목적</option>
                   	<option value="2">노후자금마련</option>
                </select>
            </div>
            
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="terms" name="terms" required>
                <label class="form-check-label" for="terms">계좌 이용 약관 및 개인정보 처리방침에 동의합니다.</label>
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-primary btn-submit">계좌 개설</button>
            </div>
            <div class="d-grid mt-3">
           	 <a href="<c:url value='/member/mypage'/>" class="btn btn-secondary">취소</a>
       		 </div>
        </form>
	 <!-- Keypad Modal -->
    <div class="modal fade" id="keypadModal" tabindex="-1" aria-labelledby="keypadModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="keypadModalLabel">비밀번호 입력</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="text" id="keypadInput" class="form-control text-center mb-3" maxlength="4" readonly>
                    <div class="keypad">
                        <button class="btn btn-outline-primary">1</button>
                        <button class="btn btn-outline-primary">2</button>
                        <button class="btn btn-outline-primary">3</button>
                        <button class="btn btn-outline-primary">4</button>
                        <button class="btn btn-outline-primary">5</button>
                        <button class="btn btn-outline-primary">6</button>
                        <button class="btn btn-outline-primary">7</button>
                        <button class="btn btn-outline-primary">8</button>
                        <button class="btn btn-outline-primary">9</button>
                        <button class="btn btn-outline-danger">Clear</button>
                        <button class="btn btn-outline-primary">0</button>
                        <button class="btn btn-outline-success">OK</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
        

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const keypadInput = document.getElementById('keypadInput');
        const acPwInput = document.getElementById('acPW');
        const keypadButtons = document.querySelectorAll('.keypad button');

        keypadButtons.forEach(button => {
            button.addEventListener('click', () => {
                const value = button.textContent.trim();

                if (value === 'Clear') {
                    keypadInput.value = '';
                } else if (value === 'OK') {
                    if (keypadInput.value.length === 4) {
                        acPwInput.value = keypadInput.value;
                        const modalElement = document.getElementById('keypadModal');
                        const modal = bootstrap.Modal.getInstance(modalElement);
                        modal.hide();
                    } else {
                        alert('4자리 비밀번호를 입력해주세요.');
                    }
                } else {
                    if (keypadInput.value.length < 4) {
                        keypadInput.value += value;
                    }
                }
            });
        });
    });
    
    $(document).ready(function() {
        // 계좌번호 생성 함수
        function generateAccountNumber() {
            const prefix = "1100"; // 계좌번호 시작 부분
            let randomNumber = "";
            // 9자리의 랜덤 숫자 생성
            for (let i = 0; i < 9; i++) {
                randomNumber += Math.floor(Math.random() * 10); // 0~9 랜덤 숫자 추가
            }
            return prefix + randomNumber; // 시작 부분과 랜덤 숫자 결합
        }
        // 계좌번호를 생성하고 hidden input에 설정
        const accountNumber = generateAccountNumber();
        $("#acNum").val(accountNumber);

    });
</script>
</body>
</html>
