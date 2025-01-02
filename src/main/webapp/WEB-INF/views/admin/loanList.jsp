<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기호은행 - 대출관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resources/css/bankCss.css" rel="stylesheet">
      
</head>
<body>
      <div class="container mt-5" style="max-width: 1500px;">
        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
         	<h1 class="text-primary">대출 관리</h1>
        </div>
        <!-- Search Bar -->
        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="회원 검색" aria-label="회원 검색">
            <button class="btn btn-outline-primary" type="button">검색</button>
        </div>

        <!-- Members Table -->
        <div class="table-responsive w-100">
        	<h2 class="text-primary">대출 리스트</h2>
        	<hr>
            <table class="table table-striped table-hover">
                <thead class="table-primary">
                    <tr class="text-center">
                        <th scope="col">번호</th>
                        <th scope="col">ID</th>
                        <th scope="col">이름</th>
                        <th scope="col">대출명</th>
                        <th scope="col">대출금액</th>
                        <th scope="col">상환방식</th>
                        <th scope="col">신청일</th>
                        <th scope="col">관리</th>
                    </tr>
                </thead>
                <tbody id="tbody">
              
                </tbody>
            </table>
           	<div class="box-pagination">
               <ul class="pagination justify-content-center"></ul>
            </div>
        </div>
    </div>
<script type="text/javascript">
	
	
	let cri = {
			page :1
	}
	getLoanSubList(cri);
	function getLoanSubList(cri){
	
	      $.ajax({
	         async : true,
	         url : '<c:url value="/admin/ajaxLoanList"/>', 
	         type : 'post', 
	         data : JSON.stringify(cri),
	         contentType : "application/json; charset=utf-8",
	         dataType : "json", 
	         success : function (data){
	        		
	        	 displayLoanPagination(data.pm); 
	        	 displayLoanSubList(data.laSub);
	        	 
	         }, 
	         error : function(jqXHR, textStatus, errorThrown){

	         }
	      });
	   }
	function displayLoanSubList(laSub) {
	    let str = '';

	    if (laSub && laSub.length > 0) {
	    	laSub.forEach(function (ls) {
	          
	                str += `
	                	
	                    <tr class="text-center">
	                    <th scope="row" id="lsNum-${ls.lsNum}">\${ls.lsNum}</th>
		                    <td>\${ls.lsMeID}</td>
		                    <td>\${ls.member.meName}</td>
		                    <td>\${ls.loan.laName}</td>
		                    <td>\${ls.lsAmount}</td>
		                    <td>\${ls.repayMent.reName}</td>
		                    <td>\${ls.changeDate}</td>
	                    </td>
	                    <td>
	                        <button class="btn btn-sm btn-outline-primary app-btn" id="app-btnBtn" data-id="\${ls.lsNum}">승인</button>
	                    </td>
	                </tr>
	                <input type="hidden" value="\${ls.lsAmount}" id="lsAmount"/>
	                <input type="hidden" value="\${ls.lsMeID}" id="lsMeID"/>
	                `;
	        });
	    } else {
	        str = `
	            <tr>
	                <td colspan="8" class="text-center">승인 할 대출이 없습니다.</td>
	            </tr>
	        `;
	    }

	    // 테이블에 리스트 표시
	    $('#tbody').html(str);
	}
	
	 function displayLoanPagination(pm){
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
	      getLoanSubList(cri);
	   });  
	   
	 
$(document).on("click","#app-btnBtn",function(){
	let laSub = {
			lsNum : $(this).data("id"),
			lsAmount : $("#lsAmount").val(),
			lsMeID : $("#lsMeID").val()
	}
	
	$.ajax({
        url: '<c:url value="/admin/lsOk"/>', 
        type: 'POST',
        data: JSON.stringify(laSub),
      	contentType: "application/json; charset=utf-8",
      	dataType: "json",
        success: function (data) {
        	console.log(data);
        	if(data.res){
        		alert("승인 완료 되었습니다.");
        		getLoanSubList(cri);
        	}else{
        		alert("승인에 실패 했습니다.");
        	}
         
        },
        error: function () {
            alert('대출 상품 데이터를 가져오는 데 실패했습니다.');
        }
    });
	
	
});
	   

</script>

</body>
</html>
