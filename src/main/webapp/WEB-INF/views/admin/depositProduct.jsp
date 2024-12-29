<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기호은행 - 저축상품관리</title>
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

            <!-- 저축상품 추가 폼 -->
            <h4 class="mb-4">저축상품 추가</h4>
            <hr >
            <div id="addForm">
                <div class="mb-3">
                    <label for="dpName" class="form-label">상품명</label>
                    <input type="text" class="form-control deposit-input" id="dpName" name="dpName" placeholder="저축상품명을 입력하세요" required>
                </div>
                <div class="mb-3">
                    <label for="dpDetail" class="form-label">상품 설명</label>
                    <textarea  class="form-control deposit-input" id="dpDetail" name="dpDetail" placeholder="저축상품설명을 입력하세요" required></textarea>
                </div>
                <div class="mb-3">
                    <label for="dpInterest" class="form-label">이자율 (%)</label>
                    <input type="number" class="form-control deposit-input" id="dpInterest" name="dpInterest" placeholder="이자율을 입력하세요" step="0.01" required>
                </div>
                <div class="mb-3">
	                <select class="form-control" name="dpDtNum" id="dpDtNum">
	                		<option value="" disabled selected>저축 상품 종류를 선택하세요.</option>
		               	<c:forEach items="${type}" var="type">
		               		<option value="${type.dtNum }">${type.dtName}</option>
		               	</c:forEach>
	               	</select>
               	</div>
               </div>
               <div style="display: flex;justify-content: space-between;">
                <a href="../admin/main" class="btn btn-success">이전으로</a>
                <button type="button" id="addBtn" class="btn btn-primary w-40">추가</button>
                </div>

            <hr class="mt-4 mb-4">

            <!-- 저축상품 목록 -->
            <h4>저축상품 목록</h4>
            <table class="table table-striped " id="table-body">
                 <thead>
                    <tr class="text-center">
                        <th>상품 번호</th>
			            <th>상품명</th>
			            <th>이자율</th>
			            <th>종류</th>
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
					                <h5 class="modal-title" id="editLoanModalLabel">저축상품 수정</h5>
					                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					            </div>
					            <div class="modal-body">
					                    <input type="hidden" name="dpNum" id="laNum1">
					                    <div class="mb-3">
					                        <label for="laName" class="form-label">상품명</label>
					                        <input type="text"  class="form-control" id="laName1" name="dpName" required>
					                    </div>
					                    <div class="mb-3">
					                        <label for="laDetail1" class="form-label">상품설명</label>
					                        <textarea  class="form-control" id="laDetail1" name="dpDetail" required></textarea>
					                    </div>
					                    <div class="mb-3">
					                        <label for="laInterest" class="form-label">이자율 (%)</label>
					                        <input type="number" class="form-control" id="laInterest1" name="dpInterest" step="0.01" required>
					                    </div>
					                   
					                     <div class="mb-3">
					                        <label for="laOverdue" class="form-label">상품 종류</label>
					                        <select name="dpDtNum" class="form-control">
					                        	<option disabled>저축 한도를 선택하세요</option>
					                        	<c:forEach items="${type}" var="dt">
					                        		<option  value="${dt.dtNum}" >${dt.dtName}</option>
					                        	</c:forEach>
					                        </select>
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
function addDeposit() {
	$(document).on("click","#addBtn",function(){
		let deposit = {
				 dpName: $('#dpName').val().trim(), 
		         dpDetail: $('#dpDetail').val().trim(),
		         dpInterest: $('#dpInterest').val().trim(),
		         dpDtNum: $('#dpDtNum').val()
		}
		if(deposit.dpName.length === 0 ||
				deposit.dpDetail.length === 0||
				deposit.dpInterest.length === 0){
				alert("빈 칸을 작성해주세요.");
				return;
		}
		 $.ajax({
		      async: true,
		      url: '<c:url value="/admin/depositAdd"/>',
		      type: 'post',
		      data: JSON.stringify(deposit),
		      contentType: "application/json; charset=utf-8",
		      dataType: "json",
		      success: function (data){
		    	  console.log(data)
		    	  if(data.res){
		    		  alert("저축 상품이 성공적으로 추가되었습니다!");
		    		  $('.deposit-input').val('');
		    		  getDepositList(cri)
		    	  }else{
		    		  alert("저축 상품 추가에 실패했습니다.");
		    	  }
		      },
		      error: function(xhr, textStatus, errorThrown){
		         console.log(xhr);
		         console.log(textStatus);
		      }
		   });
		
	})
}	
addDeposit();

let cri = {
	      page : 1
	   }
getDepositList(cri);

	   function getDepositList(cri){
	      $.ajax({
	         async : true,
	         url : '<c:url value="/admin/depositList"/>', 
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
		    	depositList.forEach(function (dp) {
		            str += `
		                <tr>
		                    <td>\${dp.dpNum}</td>
		                    <td>\${dp.dpName}</td>
		                    <td>\${dp.dpInterest * 100}%</td>
		                    <td>\${dp.depositType.dtName}</td>
		                    <td>\${dp.changeDate}</td>
		                    <td>
		                        <button class="btn btn-warning btn-sm " id="btn-btn-update" data-num="\${dp.dpNum}">수정</button>
		                        <button class="btn btn-danger btn-sm"  id="btn-delete" data-num="\${dp.dpNum}">삭제</button>
		                    </td>
		                </tr>
		            `;
		        });
		    } else {
		        str = `
		            <tr>
		                <td colspan="6" class="text-center">등록된 저축 상품이 없습니다.</td>
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
		      getDepositList(cri);
		   });  
   
   $(document).on("click","#btn-btn-update",function(){
		let dpNum = $(this).data('num');
		$.ajax({
	        url: '<c:url value="/admin/getDpNum"/>', // 저축 상품 데이터를 가져올 API
	        type: 'GET',
	        data: { dpNum: dpNum },
	        success: function (data) {
	       
	            $('#laNum1').val(data.dp.dpNum); // 저축 상품 번호
	            $('#laName1').val(data.dp.dpName); // 상품명
	            $('#laDetail1').val(data.dp.dpDetail); // 상품명
	            $('#laInterest1').val(data.dp.dpInterest); // 이자율
	            $('select[name="dpDtNum"]').val(data.dp.dpDtNum); // 저축 
	         
	            modal.show();
	        },
	        error: function () {
	            alert('저축 상품 데이터를 가져오는 데 실패했습니다.');
	        }
	    });
   })
    $(document).on("click","#update",function(){
    	let dp = {
    			dpNum: $("#laNum1").val(),
    			dpName: $("#laName1").val(),
    			dpDetail: $("#laDetail1").val(),
    			dpInterest: parseFloat($("#laInterest1").val()),
    			dpDtNum: $('select[name="dpDtNum"]').val()
		}
		
		$.ajax({
	        url: '<c:url value="/admin/dpUpdate"/>', 
	        type: 'POST',
	        data: JSON.stringify(dp),
	      	contentType: "application/json; charset=utf-8",
	      	dataType: "json",
	        success: function (data) {
	        	if(data.res){
	        		alert("저축 상품을 수정했습니다.");
	        		getDepositList(cri);
	        		modal.hide();
	        	}else{
	        		alert("저축 상품 수정에 실패했습니다.");
	        	}
	         
	        },
	        error: function () {
	            alert('저축 상품 데이터를 가져오는 데 실패했습니다.');
	        }
	    });
    })
    
    $(document).on('click','#btn-delete',function(){
		let dpNum = $(this).data('num');
		let c = confirm("정말 삭제하시겠습니까?");
		if(!c){
			return
		}else{
			$.ajax({
		        url: '<c:url value="/admin/deleteDeposit"/>', // 저축 상품 데이터를 가져올 API
		        type: 'POST',
		        data: { dpNum: dpNum },
		        success: function (data) {
		        	if(data.deposit){
		        		alert("저축 상품을 삭제했습니다.");
		        		getDepositList(cri);
		        	}else{
		        		alert("저축 상품 삭제에 실패했습니다.");
		        	}
		         
		        },
		        error: function () {
		            alert('저축 상품 데이터를 가져오는 데 실패했습니다.');
		        }
		    });
		}
		
	});		
</script>
</body>
</html>
