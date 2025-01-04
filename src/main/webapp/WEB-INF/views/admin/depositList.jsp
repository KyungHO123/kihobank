<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기호은행 - 저축관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resources/css/bankCss.css" rel="stylesheet">
      
</head>
<body>
      <div class="container mt-5" style="max-width: 1500px;">
        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
         	<h1 class="text-primary">저축 관리</h1>
        </div>
        <!-- Search Bar -->
        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="회원 검색" aria-label="회원 검색">
            <button class="btn btn-outline-primary" type="button">검색</button>
        </div>

        <!-- Members Table -->
        <div class="table-responsive w-100">
        	<h2 class="text-primary">저축 리스트</h2>
        	<hr>
            <table class="table table-striped table-hover">
                <thead class="table-primary">
                    <tr class="text-center">
                        <th scope="col">번호</th>
                        <th scope="col">ID</th>
                        <th scope="col">이름</th>
                        <th scope="col">저축상품명</th>
                        <th scope="col">저축금액</th>
                        <th scope="col">상태</th>
                        <th scope="col">가입일</th>
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
	getDepositSubList(cri);
	function getDepositSubList(cri){
	
	      $.ajax({
	         async : true,
	         url : '<c:url value="/admin/ajaxDepositList"/>', 
	         type : 'post', 
	         data : JSON.stringify(cri),
	         contentType : "application/json; charset=utf-8",
	         dataType : "json", 
	         success : function (data){
	        		
	        	 displayDepositPagination(data.pm); 
	        	 displayDepositSubList(data.dpSub);
	        	 
	         }, 
	         error : function(jqXHR, textStatus, errorThrown){

	         }
	      });
	   }
	function displayDepositSubList(dpSub) {
	    let str = '';

	    if (dpSub && dpSub.length > 0) {
	    	dpSub.forEach(function (ds) {
	          
	                str += `
	                	
	                    <tr class="text-center">
	                    <th scope="row" id="dsNum-${ds.dsNum}">\${ds.dsNum}</th>
		                    <td>\${ds.dsMeID}</td>
		                    <td>\${ds.member.meName}</td>
		                    <td>\${ds.deposit.dpName}</td>
		                    <td>\${ds.dsAmount}</td>
		                    <td>\${ds.state.ssName}</td>
		                    <td>\${ds.changeDate}</td>
	                    </td>
	                    <td>
	                        <button class="btn btn-sm btn-outline-primary app-btn" id="app-btnBtn" data-id="\${ds.dsNum}">삭제</button>
	                    </td>
	                </tr>
	                `;
	        });
	    } else {
	        str = `
	            <tr>
	                <td colspan="8" class="text-center">가입 된 저축 상품이 없습니다.</td>
	            </tr>
	        `;
	    }

	    // 테이블에 리스트 표시
	    $('#tbody').html(str);
	}
	
	 function displayDepositPagination(pm){
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
	      getDepositSubList(cri);
	   });  
	   
	 
$(document).on("click","#app-btnBtn",function(){
	let laSub = {
			lsNum : $(this).data("id"),
			lsAmount : $("#lsAmount").val(),
			lsMeID : $("#lsMeID").val()
	}
	
	$.ajax({
        url: '<c:url value="/admin/dpOk"/>', 
        type: 'POST',
        data: JSON.stringify(laSub),
      	contentType: "application/json; charset=utf-8",
      	dataType: "json",
        success: function (data) {
        	console.log(data);
        	if(data.res){
        		alert("승인 완료 되었습니다.");
        		getDepositSubList(cri);
        	}else{
        		alert("승인에 실패 했습니다.");
        	}
         
        },
        error: function () {
            alert('저축 상품 데이터를 가져오는 데 실패했습니다.');
        }
    });
	
	
});
	   

</script>

</body>
</html>
