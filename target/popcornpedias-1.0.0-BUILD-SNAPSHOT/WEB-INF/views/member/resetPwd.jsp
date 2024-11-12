<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
 	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
  request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정 - 팝콘피디아</title>
	<link rel="stylesheet" href="<c:url value='/resources/css/myProfile.css'/>" />
</head>
<body>
<%@ include file="../common/common-css.jsp" %>

<%@ include file="../common/nav.jsp" %>

<div id="modMyInfo" class="px-3 mx-auto bg-body-tertiary">	
	<div class="container bg-white set-width border rounded-3 p-4">
	    <form name="joinForm" action="${contextPath}/user/resetPassword.do" method="post">
	    	<h5 class="fw-bold mb-4 text-center">비밀번호 재설정</h5>
			<div class="row mb-4">
				<div class="col-12">
					<label class="form-label fw-semibold">새 비밀번호</label>
					<input type="password" name="pwd" class="form-control">
				</div>
			</div>
			<div class="row mb-4">
				<div class="col-12">
					<label class="form-label fw-semibold">새 비밀번호 확인</label>
					<input type="password" name="pwd_chk" class="form-control">
				</div>
			</div>
			<input type="hidden" value="${member_id}" name="member_id" class="form-control">
 		 	<div class="text-center">
				<button type="button" class="btn btn-primary col-4" onclick="checkModInfo();">수정하기</button>
			</div>
	    </form>
	</div>
</div>

<%@ include file="../common/footer.jsp" %>

<!-- 공통 js include -->
<%@ include file="../common/common-js.jsp" %>
<script>
// 정규 표현식
const pwdReg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*+=-])[A-Za-z\d!@#$%^&*+=-]{8,20}$/; // 8~20자, 영문+숫자+특수문자 모두 포함

// input
const member_id = document.joinForm.member_id;
const pwd = document.joinForm.pwd;
const pwd_chk = document.joinForm.pwd_chk;

// 유효성 검사 공통 함수
function checkValid(field, reg, invalidMessage) {
	// 정규 표현식 테스트
	if(!reg.test(field.value)) {
		alert(invalidMessage);
		field.focus();
		return false;
	}
	else {
		// 표현식 만족하면 true 리턴
		return true;
	}
}

// 비밀번호 유효성 검사
function checkValidPwd() {
	if(pwd.value != pwd_chk.value) { // 비밀번호 대조 먼저 하고 유효성 검사
		alert('입력한 비밀번호가 서로 다릅니다.');
		pwd.focus();
		return false;
	} else {
		if(checkValid(pwd, pwdReg, '비밀번호는 8~20자로 영문, 숫자, 특수문자를 포함해야 합니다.')) return true;
		else return false;
	}
}

function checkModInfo() { // 최종 유효성 검사
	if(!checkValidPwd()) { // 비밀번호 유효성 검사
		return false;
	}
	else {
		document.joinForm.submit();
	}
}
</script>
</body>
</html>