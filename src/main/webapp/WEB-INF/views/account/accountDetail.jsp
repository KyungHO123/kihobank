<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>기호은행 - 내 계좌</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="../resources/css/bankCss.css" rel="stylesheet">
</head>
<body>
	<div class="container mt-5">
		<h2 class="text-center mb-4">내 계좌 상세정보</h2>

		<div class="card">
			<div class="card-body">
				<h4 class="card-title p-1">계좌 정보</h4>
				<table class="table table-bordered mt-3">
					<tbody>
						<tr>
							<th scope="row">계좌 번호</th>
							<td id="num">${account.acNum}</td>
						</tr>
						<tr>
							<th scope="row">예금주</th>
							<td>${account.member.meName}</td>
						</tr>
						<tr>
							<th scope="row">계좌 별칭</th>
							<td>${account.acName}<a class="btn btn-primary">변경하기</a></td>
						</tr>
						<tr>
							<th scope="row">잔액</th>
							<td id="balance">${account.acBalance}원</td>
						</tr>
						<tr>
							<th scope="row">이체 한도</th>
							<td><span id="limit"> ${acl.aclLimit}원 </span> <a
								class="btn btn-primary">변경하기</a></td>

						</tr>
						<tr>
							<th scope="row">이자율</th>
							<td id="interest">연${account.acInterest * 100}%</td>
						</tr>
						<tr>
							<th scope="row">계좌 개설일</th>
							<td>${account.acCreate}</td>
						</tr>
					</tbody>
				</table>
				<a href="<c:url value='/member/mypage'/>" class="btn btn-success ">돌아가기</a>
				<a href="#" class="btn btn-danger ">해지하기</a>
			</div>
		</div>

		<div class="card mt-4">
			<div class="card-body">
				<h4 class="card-title p-2">거래 내역</h4>
				<hr>

				<table class="table table-striped mt-3">
					<thead>
						<tr class="text-center">
							<th scope="col">거래번호</th>
							<th scope="col">날짜</th>
							<th scope="col">금액</th>
							<th scope="col">보내는사람</th>
							<th scope="col">받는사람</th>
							<th scope="col">계좌번호</th>
							<th scope="col">잔액</th>
							<th scope="col">메모</th>
							<th scope="col">기타</th>
						</tr>
					</thead>
					<tbody id="transactionBody">

					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript">

function formatAccount(num) {
    const str = num.toString();
    const firstPart = str.substring(0, 4); // 앞 4자리
    const secondPart = str.substring(4, 7); // 그다음 3자리
    const remaining = str.substring(7); // 나머지 숫자
    const formattedRemaining = remaining.replace(/\B(?=(\d{4})+(?!\d))/g, "-");
    return firstPart+"-"+secondPart+"-"+formattedRemaining;
}
$('#num').text(formatAccount(${account.acNum}));
	function formatNum(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	$('#balance').text(formatNum(${account.acBalance}) + "원");
	$('#limit').text(formatNum(${acl.aclLimit}) + "원");
	

	
	let cri = {
			page :1
	}
	getTransactionList(cri);
	function getTransactionList(cri){
	
	      $.ajax({
	         async : true,
	         url : '<c:url value="/myTransaction"/>', 
	         type : 'post', 
	         data : JSON.stringify(cri),
	         contentType : "application/json; charset=utf-8",
	         dataType : "json", 
	         success : function (data){
	        	console.log(data.transaction);
	        	 displayTransactionPagination(data.pm); 
	        	 displayTransactionList(data.transaction);
	        	 
	         }, 
	         error : function(jqXHR, textStatus, errorThrown){

	         }
	      });
	   }
	function displayTransactionList(transaction) {
	    let str = '';

	    if (transaction && transaction.length > 0) {
	    	transaction.forEach(function (tr) {
	    		let balance = tr.acTtNum == 3?`-\${tr.trBalance}원`:`+\${tr.trBalance}원`;
	          	let account = tr.acTtNum == 3?`\${tr.trAcNum}`:`\${tr.trMyAccount}`;
	          	let Receiver = tr.acTtNum == 3?`\${tr.trName}`:`\${tr.trSender}`;
	          	let Sender = tr.acTtNum == 3?`\${tr.trSender}`:`\${tr.trName}`;
	                str += `
	                	
	                    <tr class="text-center">
	                    <th scope="row" id="trNum-${tr.trNum}">\${tr.trNum}</th>
		                    <td>\${tr.changeDate}</td>
		                    <td>\${tr.trBalance}원</td>
		                    <td>\${Sender}</td>
		                    <td>\${Receiver}</td>
		                    <td>\${account}</td>
		                    <td>\${tr.trAfter}원(\${balance})</td>
		                    <td>\${tr.trMemo}</td>
		                    <td>\${tr.type.ttName}</td>
	                    </td>
	                </tr>
	                `;
	        });
	    } else {
	        str = `
	            <tr>
	                <td colspan="8" class="text-center">거래 내역이 없습니다.</td>
	            </tr>
	        `;
	    }

	    // 테이블에 리스트 표시
	    $('#transactionBody').html(str);
	}
	
	 function displayTransactionPagination(pm){
	      let str = '';
	      if(pm.prev){
	         str += `
	         <li class="page-item">
	            <a class="page-link" href="javascript:void(0);" data-page="\${pm.startPage - 1}">이전</a>
	         </li>`;      
	      }
	      for(let i = pm.startPage; i<= pm.endPage; i++){
	         let active = pm.cri.page == i ? 'active' : '';
	         str += `
	         <li class="page-item \${active}">
	            <a class="page-link" href="javascript:void(0);" data-page="\${i}">\${i}</a>
	         </li>`;   
	      }
	      
	      if(pm.next){
	         str += `
	         <li class="page-item">
	            <a class="page-link" href="javascript:void(0);" data-page="\${pm.endPage + 1}">다음</a>
	         </li>`;   
	      }
	      $('.box-pagination>ul').html(str);
	   }
	   $(document).on('click','.box-pagination .page-link',function(){
	      cri.page = $(this).data('page');
	      getTransactionList(cri);
	   });  
	   
	
</script>
</body>
</html>
