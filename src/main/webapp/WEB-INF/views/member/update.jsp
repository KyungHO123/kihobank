<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기호은행 - 정보수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resources/css/bankCss.css" rel="stylesheet">
    <style type="text/css">
        .update-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .update-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .update-header h2 {
            margin: 0;
        }
        .btn-save {
            margin-top: 20px;
        }
    </style>
</head>
<body>
      <div class="update-container">
        <div class="update-header">
            <h2>정보 수정</h2>
            <p class="text-muted">수정할 정보를 입력하세요</p>
        </div>

        <form action="<c:url value='/member/update'/>" method="post" name="form1">
            <div class="mb-3">
                <label for="meName" class="form-label">이름</label>
                <input type="text" class="form-control" id="meName" name="meName" value="${member.meName}" required>
            </div>
            <div class="mb-3">
                <label for="mePw" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="mePw" name="mePw" value="${member.mePw}" required readonly="readonly">
                <input type="button" class="btn btn-primary mt-2" id="update" data-bs-toggle="modal" data-bs-target="#passwordModal"
                 name="update" value="변경하기">
            </div>
	        <div class="mb-3">
	    	    <label for="meEmail" class="form-label">이메일</label>
	    	    <input type="email" class="form-control" id="meEmail" name="meEmail" value="${member.meEmail}" required>
	        </div>
            <div class="mb-3">
                <label for="mePhone" class="form-label">전화번호</label>
                <input type="text" class="form-control" id="mePhone" name="mePhone" value="${member.mePhone}" required>
            </div>
            <div class="mb-3">
                <label for="mePost" class="form-label">우편번호</label>
                <input class="btn btn-outline-primary mb-2" type="button" value="주소찾기" id="btn"/>
                <input type="text" class="form-control" id="mePost" name="mePost" value="${member.mePost}" required readonly="readonly">
            </div>
            <div class="mb-3">
                <label for="meStreet" class="form-label">거리 주소</label>
                <input type="text" class="form-control" id="meStreet" name="meStreet" value="${member.meStreet}" required readonly="readonly">
            </div>
            <div class="mb-3">
                <label for="meDetail" class="form-label">상세 주소</label>
                <input type="text" class="form-control" id="meDetail" name="meDetail" value="${member.meDetail}" required>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-primary btn-save">저장</button>
            </div>
        </form>

        <div class="d-grid mt-3">
            <a href="<c:url value='/member/mypage'/>" class="btn btn-secondary">취소</a>
        </div>
    </div>

 <div class="modal fade" id="passwordModal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="passwordModalLabel">비밀번호 변경</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="currentPassword" class="form-label">현재 비밀번호</label>
                    <input type="password" id="currentPassword" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="newPassword" class="form-label">새 비밀번호</label>
                    <input type="password" id="newPassword" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">새 비밀번호 확인</label>
                    <input type="password" id="confirmPassword" class="form-control">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="savePassword">저장</button>
            </div>
        </div>
    </div>
</div>



    	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	const btn =$('#btn');
	btn.on("click",function(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	console.log(data);
	        	let fullAddr = '';
	        	let extraAddr = '';
	        	if(data.userSelectedType === 'R'){
	        		fullAddr = data.roadAddress;
	        		if(data.buildingName !== ''){
	        			fullAddr += " " + data.buildingName;
	        		}
	        	}else{
	        		fullAddr = data.jibunAddress;
	        		if(data.buildingName !== ''){
	        			fullAddr += " " + data.buildingName;
	        		}
	        	}
	        	$('input[name="meStreet"]').val(fullAddr);
	        	$('input[name="mePost"]').val(data.zonecode);
	        	
	        }
	    }).open();
	});

    document.addEventListener('DOMContentLoaded', function () {
        const saveButton = document.getElementById('savePassword');
        if (saveButton) {
            saveButton.addEventListener('click', function () {
                const newPassword = document.getElementById('newPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;

                if (newPassword === confirmPassword) {
                    document.getElementById('mePw').value = newPassword; // 새 비밀번호를 비밀번호 필드에 설정
                    const modal = bootstrap.Modal.getInstance(document.getElementById('passwordModal'));
                    modal.hide(); // 모달 닫기
                } else {
                    alert('새 비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
                }
            });
        } else {
            console.error("savePassword 버튼이 존재하지 않습니다.");
        }
    });



</script>
</body>
</html>
