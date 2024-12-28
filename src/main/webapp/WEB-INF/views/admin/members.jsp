<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기호은행 - 회원관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resources/css/bankCss.css" rel="stylesheet">
      
</head>
<body>
      <div class="container mt-5">
        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
         	<h1 class="text-primary">회원 관리</h1>
	         <c:choose>	
	         	<c:when test="${members == null || member.meMaNum == 2 }">
	         		<p>(회원수 : 0)</p>
	         	</c:when>
	         	<c:otherwise>
		            <p>(회원수 : ${meSize})</p>
	         	</c:otherwise>
	         </c:choose>	
        </div>

        <!-- Search Bar -->
        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="회원 검색" aria-label="회원 검색">
            <button class="btn btn-outline-primary" type="button">검색</button>
        </div>

        <!-- Members Table -->
        <div class="table-responsive w-100">
            <table class="table table-striped table-hover">
                <thead class="table-primary">
                    <tr class="text-center">
                        <th scope="col">회원 ID</th>
                        <th scope="col">이름</th>
                        <th scope="col">대표계좌</th>
                        <th scope="col">이메일</th>
                        <th scope="col">전화번호</th>
                        <th scope="col">주소</th>
                        <th scope="col">회원상태</th>
                        <th scope="col">회원등급</th>
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
	
	$(document).on("click","#update-btn",function(){
		let member = {
				meID : $("#id").val(),
				meName : $("#name").val(),
				mePw : $("#pw").val(),
				meEmail : $("#email").val(),
				mePhone : $("#phone").val(),
				mePost : $("#post").val(),
				meStreet : $("#street").val(),
				meDetail : $("#detail").val(),
				meMsNum: $("#state").val(),
				meMaNum: $("#authority").val()
		}
		$.ajax({
	        url: '<c:url value="/admin/memberUpdate"/>', 
	        type: 'POST',
	        data: JSON.stringify(member),
	      	contentType: "application/json; charset=utf-8",
	      	dataType: "json",
	        success: function (data) {
	        	console.log(data);
	        	if(data.res){
	        		alert("회원 정보를 수정했습니다.");
	        	}else{
	        		alert("회원 정보 수정을 실패했습니다.");
	        	}
	         
	        },
	        error: function () {
	            alert('데이터를 가져오는 데 실패했습니다.');
	        }
	    });
		
	})
	let cri = {
			page :1
	}
	getMemberList(cri);
	function getMemberList(cri){
	
	      $.ajax({
	         async : true,
	         url : '<c:url value="/admin/memberList"/>', 
	         type : 'post', 
	         data : JSON.stringify(cri),
	         contentType : "application/json; charset=utf-8",
	         dataType : "json", 
	         success : function (data){
	        		
	        	 displayMemberPagination(data.pm); 
	        	 displayMemberList(data.memberList, data.state, data.authority);
	        	 
	         }, 
	         error : function(jqXHR, textStatus, errorThrown){

	         }
	      });
	   }
	getMemberList(cri);
	function displayMemberList(memberList, state, authority) {
		console.log(state);
	    let str = '';

	    if (memberList && memberList.length > 0) {
	    	memberList.forEach(function (member) {
	            if (member.meMaNum == 1) {
	            	let stateOption = state
	            	.filter(item => item.msNum != member.meMsNum)
	            	.map(item =>`
	            	  <option value="${item.msNum}" >
                  		  \${item.msName}
               		  </option>`).join('');
	            	
	            	let authorityOption = authority
	            	.filter(item => item.maNum != member.meMaNum)
	            	.map(item =>
	            	`
	            	 <option value="${item.maNum}" >
            		  \${item.maName}
         		 	 </option>	
	            	`).join('');
	                str += `
	                	  <input type="hidden" value="${member.meID}" id="id">
	                    <input type="hidden" value="${member.meName}" id="name">
	                    <input type="hidden" value="${member.mePw}" id="pw">
	                    <input type="hidden" value="${member.meEmail}" id="email">
	                    <input type="hidden" value="${member.mePhone}" id="phone">
	                    <input type="hidden" value="${member.mePost}" id="post">
	                    <input type="hidden" value="${member.meStreet}" id="street">
	                    <input type="hidden" value="${member.meDetail}" id="detail">
	                    <tr class="text-center">
	                    <th scope="row" id="meID-${member.meID}">\${member.meID}</th>
		                    <td>\${member.meName}</td>
		                    <td>\${member.account && member.account.acNum ? member.account.acNum : '없음'}</td>
		                    <td>${member.meEmail}</td>
		                    <td>${member.mePhone}</td>
		                    <td>${member.meStreet}${member.meDetail}</td>
		                    <td>
	                         <select class="form-select" id="state">
	                         	<option value="${member.meMsNum}" selected>\${member.meState.msName}</option>
	                            \${stateOption}
	                        </select> 
		                    </td>
		                    <td>
	                        <select class="form-select" id="authority">
	                            <option value="${member.meMaNum}" selected>\${member.meAuthority.maName}</option>
	                            \${authorityOption}
	                        </select> 
	                    </td>
	                    <td>${member.meSignup}</td>
	                    <td>
	                        <button id ="update-btn" class="btn btn-sm btn-outline-primary update-btn" data-id="${member.meID}">변경</button>
	                        <button class="btn btn-sm btn-outline-danger delete-btn" data-id="${member.meID}">삭제</button>
	                    </td>
	                </tr>
	                `;
	            }
	        });
	    } else {
	        str = `
	            <tr>
	                <td colspan="10" class="text-center">등록된 회원이 없습니다.</td>
	            </tr>
	        `;
	    }

	    // 테이블에 리스트 표시
	    $('#tbody').html(str);
	}
	
	 function displayMemberPagination(pm){
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
	      getMemberList(cri);
	   });  
	   
	   function selectList(members,state,authority){
		   let str = '';
		   for(let i of state)
			   str +=
				   `
				  <select class="form-select" id="state">
				 	 <option value="\${meState.msNum}">\${meState.msName}</option> 
				  </select>
			   `;
	   }
	   

</script>

</body>
</html>
