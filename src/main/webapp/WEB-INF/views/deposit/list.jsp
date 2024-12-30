<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>기호은행 - 저축 리스트</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="<c:url value='/resources/css/bankCss'/>" rel="stylesheet">
</head>
<style>
body {
	background-color: #f8f9fa;
}

.card {
	border: none;
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s;
}

.card:hover {
	transform: translateY(-10px);
}

.card-title {
	font-size: 1.5rem;
	font-weight: bold;
}

.card-subtitle {
	font-size: 1.2rem;
	color: #6c757d;
}

.card-text {
	font-size: 1rem;
	color: #495057;
}

</style>
	<body>
	<div class="container  table mt-5">
			<h1 class="text-center mb-4">저축 상품 리스트</h1>
			<div class="row mt-5 card-container">
				
			</div>
			 <div class="box-pagination">
                  <ul class="pagination justify-content-center"></ul>
             </div>
		</div>
		<!-- modal창 -->
		 <div class="modal fade" id="editDepositModal" tabindex="-1" aria-labelledby="editDepositModalLabel" aria-hidden="true">
					    <div class="modal-dialog">
					        <div class="modal-content">
					            <div class="modal-header">
					                <h5 class="modal-title" id="editDepositModalLabel">저축상품 상세보기</h5>
					                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					            </div>
					            <div class="modal-body">
					                    <input type="hidden" name="laNum" id="laNum1">
					                    <div class="mb-3">
					                        <label for="laName" class="form-label">상품명</label>
					                        <input type="text"  class="form-control" id="laName1" name="laName" readonly="readonly">
					                    </div>
					                    <div class="mb-3">
					                        <label for="laDetail1" class="form-label">상품설명</label>
					                        <textarea  class="form-control" id="laDetail1" name="laDetail" readonly="readonly"></textarea>
					                    </div>
					                    <div class="mb-3">
					                        <label for="laInterest" class="form-label">이자율 (%)</label>
					                        <input type="number" class="form-control" id="laInterest1" name="laInterest" step="0.01" readonly="readonly">
					                    </div>
					                    <div class="mb-3">
					                        <label for="laLimitMax" class="form-label">저축한도</label>
					                        <input type="number" class="form-control" id="laLimitMin1" name="laLimitMin" readonly="readonly">
					                        <input type="number" class="form-control" id="laLimitMax1" name="laLimitMax" readonly="readonly">
					                    </div>
					                     <div class="mb-3">
					                        <label for="laOverdue" class="form-label">연체이자율 (%)</label>
					                        <input type="number" class="form-control" id="laOverdue1" name="laOverdue" step="0.01" readonly="readonly">
					                    </div>
					                    <button type="button" id="app" class="btn btn-primary w-100">저축 신청</button>
					            </div>
					        </div>
					    </div>
					</div>
					
					
<script type="text/javascript">
const modal = new bootstrap.Modal(document.getElementById('editDepositModal'));
let cri = {
	      page : 1,
	      search : "${dpNum}"
	   }

getDepositList(cri);

	   function getDepositList(cri){
	      $.ajax({
	         async : true,
	         url : '<c:url value="/deposit/ajaxList"/>', 
	         type : 'post', 
	         data : JSON.stringify(cri),
	         contentType : "application/json; charset=utf-8",
	         dataType : "json", 
	         success : function (data){
	        	 displayDepositList(data.depositList);
	        	 displayDepositPagination(data.pm);
	        	 
	         }, 
	         error : function(jqXHR, textStatus, errorThrown){

	         }
	      });
	   }
	   function displayDepositList(depositList) {
		    let str = '';

		    if (depositList && depositList.length > 0) {
		    	depositList.forEach(function (deposit) {
		            str +=
		            	`
			            	<div class="col-md-4 mb-4">
							<div class="card h-100">
								<div class="card-body">
									<h6 class="card-subtitle mb-2 text-muted">상품명: \${deposit.dpName}</h6>
									<p class="card-text">
										<strong>상세 설명:</strong>\${deposit.dpDetail}<br> 
										<strong>상품 종류:</strong>\${deposit.depositType.dtName}<br> 
										<strong>이자율:</strong>
										\${deposit.dpInterest * 100}%<br>
										<button type="button" data-num="\${deposit.dpNum}" 
										class="btn btn-outline-success mt-3 detail-btn w-100">상세보기</button>
									</p>
								</div>
									
							</div>
						</div>
			            
			            `;
		        });
		    } else {
		        str = `
		            <h4>
		                <td colspan="6" class="text-center">등록된 저축 상품이 없습니다.</td>
		            </h4>
		        `;
		    }

		    // 테이블에 리스트 표시
		    $('.card-container').html(str);
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
		      getDepositList(cri);
		   });  

$(document).on("click",".detail-btn",function(){
	let laNum = $(this).data("num");
	
	$.ajax({
        url: '<c:url value="/Deposit/getDepositNum"/>', // 저축 상품 데이터를 가져올 API
        type: 'GET',
        data: { laNum: laNum },
        success: function (data) {
        	
            $('#laNum1').val(data.laNum); // 저축 상품 번호
            $('#laName1').val(data.laName); // 상품명
            $('#laDetail1').val(data.laDetail); // 상품명
            $('#laInterest1').val(data.laInterest); // 이자율
            $('#laLimitMax1').val(data.laLimitMax); // 저축 한도
            $('#laLimitMin1').val(data.laLimitMin); // 저축 한도
            $('#laOverdue1').val(data.laOverdue); // 저축 한도

            // 모달 창 열기
         
            modal.show();
        },
        error: function () {
            alert('저축 상품 데이터를 가져오는 데 실패했습니다.');
        }
    });
	
});

$(document).on("click", "#app", function () {
    // 모달 내 입력 필드 값 가져오기
    let laNum = $('#laNum1').val();

    // URL 생성 및 페이지 이동
    window.location.href = '<c:url value="/deposit/app?dpNum="/>' + encodeURIComponent(dpNum);
});
</script>
</body>
</html>
