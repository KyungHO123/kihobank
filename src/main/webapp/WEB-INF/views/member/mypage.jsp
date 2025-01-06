<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기호은행 - 내정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resources/css/bankCss.css" rel="stylesheet">
    <style type="text/css">
        .profile-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .profile-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .profile-header h2 {
            margin: 0;
        }


    </style>
</head>
<body>
    <div class="profile-container">
        <div class="profile-header">
            <h2 class="mb-3">내 정보</h2>
            <p class="text-muted">환영합니다, <strong>${member.meName}님</strong></p>
        </div>
      <div class="card text-center mb-5 shadow-sm" style="max-width: 400px; margin: 0 auto; border-radius: 15px; background: #f8f9fa;">
    	<div class="card-body">
    		<c:choose>
	    		<c:when test="${account != null }">
			        <h4 class="card-title text-primary mb-3">내 계좌</h4>
			        <p id="num"class="text-muted mt-2" style="font-size: 1.3rem;">${account.acNum}</p>
			        <p class="text-muted mt-2" style="font-size: 0.9rem;">계좌 잔액</p>
			        <h5 id="balance"class="card-text text-primary fw-bold mt-3">${account.acBalance}원</h5>
			        <button class="btn btn-outline-primary mt-4" id="tr">이체하기</button>
			        <a href="<c:url value='/account/accountDetail'/>" class="btn btn-outline-success mt-4">상세보기</a>
		        </c:when>
		        <c:otherwise>
		        	<h4 class="text-success mt-3 mb-4">계좌가 없습니다.</h4>
		        	<a href="<c:url value='/account/addAccount'/>" class="btn btn-primary">계좌개설</a>
		        </c:otherwise>
	        </c:choose>
   		</div>
	  </div>


        <table class="table table-bordered mb-0">
            <tbody>
                <tr>
                    <th scope="row">아이디</th>
                    <td>${member.meID}</td>
                </tr>
                <tr>
                    <th scope="row">이메일</th>
                    <td>${member.meEmail}</td>
                </tr>
                <tr>
                    <th scope="row">전화번호</th>
                    <td>${member.mePhone}</td>
                </tr>
                <tr>
                    <th scope="row">가입 날짜</th>
                    <td>${member.meSignup}</td>
                </tr>
                <tr>
                    <th scope="row">주소</th>
                    <td>(${member.mePost}) ${member.meStreet} ${member.meDetail}</td>
                </tr>
            </tbody>
        </table>

        <div class="d-grid mb-2 mt-4">
            <a href="<c:url value='/member/asset'/>" class="btn btn-primary btn-logout">내 자산 관리</a>
        </div>
        <div class="d-grid mb-2">
            <a href="<c:url value='/member/update'/>" class="btn btn-success btn-logout">정보수정</a>
        </div>
         <div class="d-grid">
            <a href="<c:url value='/member/delete'/>" id="delete" class="btn btn-danger btn-delete">회원탈퇴</a>
        </div> 
    </div>
    
    
    <div id="modal">
        <div class="modal fade" id="editLoanModal" tabindex="-1" aria-labelledby="editLoanModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="editLoanModalLabel">계좌이체</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
	                    <input type="hidden" name="trNum" id="trNum">
	                    <div class="mb-3">
	                        <label for="trAcNum" class="form-label">계좌번호</label>
	                        <input type="text"  class="form-control" id="trAcNum" name="trAcNum" required>
	                        <button class="btn btn-success" id="search-btn" >계좌조회</button>
	                    </div>
	                    <div class="mb-3">
	                        <label for="trBalance" class="form-label">이체금액</label>
	                        <input  type="text" class="form-control" id="trBalance" name="trBalance" required>
	                    </div>
	                    <div class="mb-3">
	                        <label for="trMemo" class="form-label">메모</label>
	                        <textarea  placeholder="메모를 입력하세요" class="form-control" id="trMemo" name="trMemo" required></textarea>
	                    </div>
	                    <input type="hidden" name="trName" id="trName">
	                    <input type="hidden" name="trAcHeadNum" id="trAcHeadNum">
	                    <input type="hidden" name="trMyAccount" id="trMyAccount" >
	                    <input type="hidden" name="trSender" id="trSender" >
	                    <button type="button" id="transaction" class="btn btn-primary w-100">이체하기</button>
		            </div>
		        </div>
		    </div>
		</div>
     </div>
<script type="text/javascript">
const modal = new bootstrap.Modal(document.getElementById('editLoanModal'));


	let btn = $('#delete');
	btn.on('click',function(event){
		let ans = confirm("정말 탈퇴하시겠습니까?");
		if(ans){
			return true;
		}else{
			 event.preventDefault();
		}
	});
	
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
	
	$(document).on("click","#tr",function(){
		modal.show();
	});
	
	//검색 ajax
	$(document).on("click","#search-btn",function(){
		let transaction = {
				
				trAcNum : $("#trAcNum").val()
				
				
		}
		if(!transaction.trAcNum){
			alert("계좌번호를 입력해주세요.");
			return;
		}else if(transaction.trAcNum.length > 13){
			alert("계좌번호를 다시 입력해주세요\n13자 초과입력");
			return;
		}
		 else if(transaction.trAcNum.length < 13){
			alert("계좌번호를 다시 입력해주세요\n13자 미만입력");
			return;
		} 
		 $.ajax({ 
	         async : true,
	         url : '<c:url value="/searchAccount"/>', 
	         type : 'post', 
	         data : JSON.stringify(transaction),
	         contentType : "application/json; charset=utf-8",
	         dataType : "json", 
	         success : function (data){
	        	if(data.error){
	        		alert(data.error);
	        		return;
	        	}
	        	if(confirm("이름 : " + data.meAc.member.meName + "\n" +
	        			"계좌번호 : " + data.meAc.acNum + "\n" + 
	        			"위 정보가 맞습니까?")){
	        		alert("정보가 확인되었습니다.");
	        		$("#trName").val(data.meAc.member.meName);
	        		$("#trAcHeadNum").val(data.meAc.acHeadNum);
	        		$("#trAcNum").prop("readonly", true);
	        	}else{
	        		return;
	        	}
	         }, 
	         error : function(jqXHR, textStatus, errorThrown){

	         }
	      });
	});
	$(document).on("click","#transaction",function(){
		if(!$("#trName").val()){
			alert("계좌조회를 먼저 해주세요.");
			return
		}
		let ac = {
				acHeadNum : '${account.acHeadNum}',
				acNum : '${account.acNum}',
				acName : '${account.member.meName}'
				
		}
		let tr = {
			trAcNum : $("#trAcNum").val(),
			trName : $("#trName").val(),
			trMemo : $("#trMemo").val(),
			trBalance : $("#trBalance").val(),
			trAcHeadNum : $("#trAcHeadNum").val(),
			trNum : $("#trNum").val(),
			trMyAccount : ac.acNum,
			trSender : ac.acName
		}
		if(!tr.trBalance){
			alert("이체 금액을 입력하세요.");
			return;
		}else if(!tr.trMemo){
			alert("메모를 입력하세요.");
			return;
		}
		 $.ajax({ 
	         async : true,
	         url : '<c:url value="/transaction"/>', 
	         type : 'post', 
	         data : JSON.stringify(tr),
	         contentType : "application/json; charset=utf-8",
	         dataType : "json", 
	         success : function (data){
	        	 console.log(data);
	        	 console.log(data.res);
	        	 if(data.error){
	        		 alert(data.error);
	        	 }
				if(data.res){
					alert("송금완료");
					modal.hide();
					return
				}else{
					alert("송금실패");
				}
	         }, 
	         error : function(jqXHR, textStatus, errorThrown){

	         }
	      });
	})
</script>
</body>
</html>
