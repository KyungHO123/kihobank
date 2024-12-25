<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
<style type="text/css">
h1,h2,h3,h4,h5{color:rgba(0, 128, 0, 0.5);
}
</style>
<title>
<c:choose>
  <c:when test="${title != null }">${title}</c:when>
  <c:otherwise>기호은행</c:otherwise>
</c:choose>
</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="http://fastly.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="http://fastly.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>


<!-- Popper JS -->
<script src="http://fastly.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="http://fastly.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

</head>
<body>
    <tiles:insertAttribute name="header"/>
    <div style="min-height: calc(100vh - 290px)">
      <tiles:insertAttribute name="body" />
    </div>
    <tiles:insertAttribute name="footer" />
</body>
</html>