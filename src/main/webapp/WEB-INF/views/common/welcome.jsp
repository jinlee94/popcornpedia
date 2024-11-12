<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 완료 - 팝콘피디아</title>
<!-- 공통 css include -->
<%@ include file="../common/common-css.jsp" %>
</head>
<body>
<%@ include file="../common/nav.jsp" %>

<div class="container text-center" style="margin:200px auto;">
	<h4 class="mb-4">✅</h4>
	<h2 class="mb-4 pb-1 fw-bold">회원가입이 완료되었습니다.</h2>
	<h5 class="mb-5 lh-base fw-normal">이메일 인증을 완료해야 게시글/댓글 작성이 가능합니다.<br>입력하신 이메일로 발송된 인증 메일을 확인해 주세요.</h5>
	<div class="col-3 mx-auto">
		<a href="${contextPath}/" class="btn btn-primary d-block w-100">메인으로 가기</a>
	</div>
</div>

<%@ include file="../common/common-js.jsp" %>		
</body>
</html>