<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기호은행 - 관리자 메인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resources/css/bankCss.css" rel="stylesheet">
    <style>
        .main-container {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .card-title {
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
    <div class="container mt-5">
        <div class="main-container">
            <h1 class="text-center mb-4">기호은행 관리자 메인 페이지</h1>
            <div class="row">
                <div class="col-md-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <h5 class="card-title">대출상품 관리</h5>
                            <p class="card-text">대출상품을 추가, 수정, 삭제할 수 있습니다.</p>
                            <a href="<c:url value='/admin/loanProduct' />" class="btn btn-primary">관리</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <h5 class="card-title">저축상품 관리</h5>
                            <p class="card-text">저축상품을 추가, 수정, 삭제할 수 있습니다.</p>
                            <a href="<c:url value='/admin/depositProduct' />" class="btn btn-primary">관리</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <h5 class="card-title">회원 관리</h5>
                            <p class="card-text">회원 정보를 조회 및 관리할 수 있습니다.</p>
                            <a href="<c:url value='/admin/members' />" class="btn btn-primary">관리</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <h5 class="card-title">로그인 로그</h5>
                            <p class="card-text">회원의 로그인 기록을 확인할 수 있습니다.</p>
                            <a href="<c:url value='/admin/loginLogs' />" class="btn btn-primary">관리</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <h5 class="card-title">대출 관리</h5>
                            <p class="card-text">대출 현황을 확인하고 처리할 수 있습니다.</p>
                            <a href="<c:url value='/admin/loanList' />" class="btn btn-primary">관리</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <h5 class="card-title">저축 관리</h5>
                            <p class="card-text">저축 현황을 확인하고 처리할 수 있습니다.</p>
                            <a href="<c:url value='/admin/depositList' />" class="btn btn-primary">관리</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
