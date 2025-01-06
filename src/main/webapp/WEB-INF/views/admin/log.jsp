<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기호은행 - 로그관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resources/css/bankCss.css" rel="stylesheet">
      
</head>
<body>
      <div class="container mt-5" style="max-width: 1500px;">
        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
         	<h1 class="text-primary">로그 관리</h1>
        </div>
        <!-- Search Bar -->
        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="회원 검색" aria-label="회원 검색">
            <button class="btn btn-outline-primary" type="button">검색</button>
        </div>

        <!-- Members Table -->
        <div class="table-responsive w-100">
        	<h2 class="text-primary">로그 리스트</h2>
        	<hr>
            <table class="table table-striped table-hover">
                <thead class="table-primary">
                    <tr class="text-center">
                        <th scope="col">번호</th>
                        <th scope="col">ID</th>
                        <th scope="col">로그인 시간</th>
                        <th scope="col">로그아웃 시간</th>
                        <th scope="col">IP</th>
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
	getLogList(cri);
	function getLogList(cri){
	
	      $.ajax({
	         async : true,
	         url : '<c:url value="/admin/ajaxLogList"/>', 
	         type : 'post', 
	         data : JSON.stringify(cri),
	         contentType : "application/json; charset=utf-8",
	         dataType : "json", 
	         success : function (data){
	        		
	        	 displayLogPagination(data.pm); 
	        	 displayLogList(data.log);
	        	 
	         }, 
	         error : function(jqXHR, textStatus, errorThrown){

	         }
	      });
	   }
	function displayLogList(log) {
	    let str = '';

	    if (log && log.length > 0) {
	    	log.forEach(function (log) {
	          
	                str += `
	                	
                    <tr class="text-center">
	                    <th scope="row" id="logNum-${log.logNum}">\${log.logNum}</th>
		                    <td>\${log.logMeID}</td>
		                    <td>\${log.changeLogDate}</td>
		                    <td>\${log.changeLogOutDate}</td>
		                    <td>\${log.logIP}</td>
	                    </td>
	                </tr>
	                `;
	        });
	    } else {
	        str = `
	            <tr>
	                <td colspan="8" class="text-center">로그가 없습니다.</td>
	            </tr>
	        `;
	    }

	    // 테이블에 리스트 표시
	    $('#tbody').html(str);
	}
	
	 function displayLogPagination(pm){
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
	      getLogList(cri);
	   });  
	   
	 

</script>

</body>
</html>
