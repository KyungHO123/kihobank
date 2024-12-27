<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기호은행 - 대출상품관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resources/css/bankCss.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .main-container {
            background-color: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }
        .form-label {
            font-weight: bold;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="main-container">
            <h2 class="text-center mb-4">저축상품 관리</h2>

            <!-- 대출상품 추가 폼 -->
            <h4 class="mb-4">저축상품 추가</h4>
            <hr >
            <div id="addForm">
                <div class="mb-3">
                    <label for="laName" class="form-label">상품명</label>
                    <input type="text" class="form-control loan-input" id="laName" name="laName" placeholder="저축상품명을 입력하세요" required>
                </div>
                <div class="mb-3">
                    <label for="laDetail" class="form-label">상품 설명</label>
                    <textarea  class="form-control loan-input" id="laDetail" name="laDetail" placeholder="저축상품설명을 입력하세요" required></textarea>
                </div>
                <div class="mb-3">
                    <label for="laInterest" class="form-label">이자율 (%)</label>
                    <input type="number" class="form-control loan-input" id="laInterest" name="laInterest" placeholder="이자율을 입력하세요" step="0.01" required>
                </div>
                
               </div>
               <div style="display: flex;justify-content: space-between;">
                <a href="../admin/main" class="btn btn-success">이전으로</a>
                <button type="button" id="addBtn" class="btn btn-primary w-40">추가</button>
                </div>

            <hr class="mt-4 mb-4">

            <!-- 대출상품 목록 -->
            <h4>저축상품 목록</h4>
            <table class="table table-striped " id="table-body">
                 <thead>
                    <tr class="text-center">
                        <th>상품 번호</th>
			            <th>상품명</th>
			            <th>이자율</th>
			            <th>최소 한도</th>
			            <th>최대 한도</th>
			            <th>연체 이자율</th>
			            <th>등록일</th>
			            <th>관리</th>
                    </tr>
                </thead>
                <tbody id="tbody" class="text-center">
                </tbody> 
            </table>
            <div class="box-pagination">
                  <ul class="pagination justify-content-center"></ul>
               </div>
               <div id="modal">
                        <div class="modal fade" id="editLoanModal" tabindex="-1" aria-labelledby="editLoanModalLabel" aria-hidden="true">
					    <div class="modal-dialog">
					        <div class="modal-content">
					            <div class="modal-header">
					                <h5 class="modal-title" id="editLoanModalLabel">대출상품 수정</h5>
					                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					            </div>
					            <div class="modal-body">
					                    <input type="hidden" name="laNum" id="laNum1">
					                    <div class="mb-3">
					                        <label for="laName" class="form-label">상품명</label>
					                        <input type="text"  class="form-control" id="laName1" name="laName" required>
					                    </div>
					                    <div class="mb-3">
					                        <label for="laDetail1" class="form-label">상품설명</label>
					                        <textarea  class="form-control" id="laDetail1" name="laDetail" required></textarea>
					                    </div>
					                    <div class="mb-3">
					                        <label for="laInterest" class="form-label">이자율 (%)</label>
					                        <input type="number" class="form-control" id="laInterest1" name="laInterest" step="0.01" required>
					                    </div>
					                    <div class="mb-3">
					                        <label for="laLimitMax" class="form-label">대출한도</label>
					                        <input type="number" class="form-control" id="laLimitMin1" name="laLimitMin" required>
					                        <input type="number" class="form-control" id="laLimitMax1" name="laLimitMax" required>
					                    </div>
					                     <div class="mb-3">
					                        <label for="laOverdue" class="form-label">연체이자율 (%)</label>
					                        <input type="number" class="form-control" id="laOverdue1" name="laOverdue" step="0.01" required>
					                    </div>
					                    <button type="button" id="update" class="btn btn-primary w-100">저장</button>
					            </div>
					        </div>
					    </div>
					</div>
               </div>
        </div>
    </div> 
<script type="text/javascript">

const modal = new bootstrap.Modal(document.getElementById('editLoanModal'));
function addProducts() {
	$('#addBtn').on("click",function(){
		let loan = {
				 laName: $('#laName').val().trim(), 
		         laDetail: $('#laDetail').val().trim(),
		         laInterest: $('#laInterest').val().trim(),
		         laLimitMax: $('#laLimitMax').val().trim(),
		         laOverdue: $('#laOverdue').val().trim(),
		         laLimitMin: $('#laLimitMin').val().trim()
		}
		if(loan.laName.length === 0 ||
				loan.laDetail.length === 0||
				loan.laInterest.length === 0 ||
				loan.laLimitMax.length === 0||
				loan.laOverdue.length === 0 ||
				loan.laLimitMin.length === 0){
			alert("빈 칸을 작성해주세요.");
			return;
		}
		 $.ajax({
		      async: true,
		      url: '<c:url value="/admin/loanAdd"/>',
		      type: 'post',
		      data: JSON.stringify(loan),
		      contentType: "application/json; charset=utf-8",
		      dataType: "json",
		      success: function (data){
		    	  if(data.res){
		    		  alert("대출 상품이 성공적으로 추가되었습니다!");
		    		  $('.loan-input').val('');
		    		  getLoanList(cri);
		    	  }else{
		    		  alert("대출 상품 추가에 실패했습니다.");
		    	  }
		      },
		      error: function(xhr, textStatus, errorThrown){
		         console.log(xhr);
		         console.log(textStatus);
		      }
		   });
		
	});
	
}
addProducts();

let cri = {
	      page : 1,
	      search : "${laNum}"
	   }

getLoanList(cri);

	   function getLoanList(cri){
	      $.ajax({
	         async : true,
	         url : '<c:url value="/admin/loanList"/>', 
	         type : 'post', 
	         data : JSON.stringify(cri),
	         contentType : "application/json; charset=utf-8",
	         dataType : "json", 
	         success : function (data){
	        	 displayLoanList(data.loanList);
	        	 displayLoanPagination(data.pm);
	        	 
	         }, 
	         error : function(jqXHR, textStatus, errorThrown){

	         }
	      });
	   }
	   function displayLoanList(loanList) {
		    let str = '';

		    if (loanList && loanList.length > 0) {
		        loanList.forEach(function (loan) {
		            str += `
		                <tr>
		                    <td>\${loan.laNum}</td>
		                    <td>\${loan.laName}</td>
		                    <td>\${loan.laInterest * 100}%</td>
		                    <td>\${loan.laLimitMin}</td>
		                    <td>\${loan.laLimitMax}</td>
		                    <td>\${loan.laOverdue * 100}</td>
		                    <td>\${loan.changeDate}</td>
		                    <td>
		                        <button class="btn btn-warning btn-sm " id="btn-btn-update" data-num="\${loan.laNum}">수정</button>
		                        <button class="btn btn-danger btn-sm"  id="btn-delete" data-num="\${loan.laNum}">삭제</button>
		                    </td>
		                </tr>
		            `;
		        });
		    } else {
		        str = `
		            <tr>
		                <td colspan="6" class="text-center">등록된 대출 상품이 없습니다.</td>
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
		      getLoanList(cri);
		   });  
		  
			$(document).on('click','#btn-btn-update',function(){
				let laNum = $(this).data('num');
				$.ajax({
			        url: '<c:url value="/admin/getLoanNum"/>', // 대출 상품 데이터를 가져올 API
			        type: 'GET',
			        data: { laNum: laNum },
			        success: function (data) {
			        	
			            $('#laNum1').val(data.laNum); // 대출 상품 번호
			            $('#laName1').val(data.laName); // 상품명
			            $('#laDetail1').val(data.laDetail); // 상품명
			            $('#laInterest1').val(data.laInterest); // 이자율
			            $('#laLimitMax1').val(data.laLimitMax); // 대출 한도
			            $('#laLimitMin1').val(data.laLimitMin); // 대출 한도
			            $('#laOverdue1').val(data.laOverdue); // 대출 한도

			            // 모달 창 열기
			         
			            modal.show();
			        },
			        error: function () {
			            alert('대출 상품 데이터를 가져오는 데 실패했습니다.');
			        }
			    });
			})
			
	$(document).on('click','#btn-delete',function(){
		let laNum = $(this).data('num');
		let c = confirm("정말 삭제하시겠습니까?");
		if(!c){
			return
		}else{
			$.ajax({
		        url: '<c:url value="/admin/deleteLoan"/>', // 대출 상품 데이터를 가져올 API
		        type: 'POST',
		        data: { laNum: laNum },
		        success: function (data) {
		        	console.log(data.loan);
		        	if(data.loan){
		        		alert("대출 상품을 삭제했습니다.");
		        		getLoanList(cri)
		        	}else{
		        		alert("대출 상품 삭제에 실패했습니다.");
		        	}
		         
		        },
		        error: function () {
		            alert('대출 상품 데이터를 가져오는 데 실패했습니다.');
		        }
		    });
		}
		
	});		
	$(document).on("click","#update",function(){
		let la = {
				laNum: $("#laNum1").val(),
				laName: $("#laName1").val(),
		        laDetail: $("#laDetail1").val(),
		        laInterest: parseFloat($("#laInterest1").val()),
		        laLimitMin: parseFloat($("#laLimitMin1").val()),
		        laLimitMax: parseFloat($("#laLimitMax1").val()),
		        laOverdue: parseFloat($("#laOverdue1").val())
		}
		
		$.ajax({
	        url: '<c:url value="/admin/loanUpdate"/>', 
	        type: 'POST',
	        data: JSON.stringify(la),
	      	contentType: "application/json; charset=utf-8",
	      	dataType: "json",
	        success: function (data) {
	        	if(data.res){
	        		alert("대출 상품을 수정했습니다.");
	        		getLoanList(cri)
	        		modal.hide();
	        	}else{
	        		alert("대출 상품 수정에 실패했습니다.");
	        	}
	         
	        },
	        error: function () {
	            alert('대출 상품 데이터를 가져오는 데 실패했습니다.');
	        }
	    });
		
	})
			  
</script>
</body>
</html>
