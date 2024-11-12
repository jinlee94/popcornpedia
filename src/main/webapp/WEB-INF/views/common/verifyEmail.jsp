<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 인증 완료 - 팝콘피디아</title>
<!-- 공통 css include -->
<%@ include file="../common/common-css.jsp" %>
</head>
<body>
<%@ include file="../common/nav.jsp" %>

<div class="container text-center" style="margin:200px auto;">
	<h4 class="mb-4">✅</h4>
	<h2 class="mb-5 pb-1 fw-bold">이메일 인증이 완료되었습니다.</h2>
	<div class="col-3 mx-auto">
		<a href="${contextPath}/" class="btn btn-primary d-block w-100">메인으로 가기</a>
	</div>
</div>

<%@ include file="../common/common-js.jsp" %>		
</body>
</html>