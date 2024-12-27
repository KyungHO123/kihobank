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
            <h2 class="text-center mb-4">대출상품 관리</h2>

            <!-- 대출상품 추가 폼 -->
            <h4 class="mb-4">대출상품 추가</h4>
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
	                <select class="form-control" name="dpDtNum">
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

            <!-- 대출상품 목록 -->
            <h4>저축상품 목록</h4>
            <table class="table table-striped " id="table-body">
                 <thead>
                    <tr class="text-center">
                        <th>상품 번호</th>
			            <th>상품명</th>
			            <th>이자율</th>
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

			  
</script>
</body>
</html>
