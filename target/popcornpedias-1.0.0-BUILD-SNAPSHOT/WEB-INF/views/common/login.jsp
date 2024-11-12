<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 - 팝콘피디아</title>
<!-- 공통 css include -->
<%@ include file="../common/common-css.jsp" %>
<!-- login css -->
<link rel="stylesheet" href="<c:url value='/resources/css/login.css'/>" />
</head>

<body>
<%@ include file="../common/nav.jsp" %>
<div class="bg-body-tertiary" id="login-container">
	<div class="container col-lg-3 g-0 bg-white border rounded">
		<div class="logo px-5 text-center mb-5">
			<img src="${contextPath}/resources/images/common/logo.png" alt="logo" class="w-100">
		</div>
		<h5 class="mb-4 fw-bold text-center">로그인하기</h5>
		<form class="">
			<input type="text" class="form-control my-2" placeholder="아이디" name="member_id" onkeyup="enterLogin(this.form);" autofocus>
			<input type="password" class="form-control my-2" placeholder="비밀번호" name="pwd" onkeyup="enterLogin(this.form);">
			<button class="btn btn-primary w-100 mt-2" type="button" onclick="checkLogin(this.form);">로그인</button>
		</form>
		<div class="mt-4">
			<ul class="d-flex justify-content-center small login-modal-list fw-semibold">
				<li><a data-bs-toggle="modal" data-bs-target="#findIdModal">아이디 찾기</a></li>
				<li><a data-bs-toggle="modal" data-bs-target="#findPwdModal">비밀번호 찾기</a></li>
				<li><a href="${contextPath}/user/join">회원가입</a></li>
			</ul>
		</div>

		<!-- 아이디 찾기 Modal -->
		<div class="modal fade" id="findIdModal" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content py-2">
					<div class="modal-body px-4">
						<h5 class="fw-bold mb-2 text-center">아이디 찾기</h5>
						<div class="modal-default">
							<div class="mb-3 form-text text-center">가입 시 입력한 이메일 주소로 아이디를 찾을 수 있습니다.</div>
							<label class="form-label fw-semibold mb-2">이메일</label>
							<div class="input-group">
								<input id="emailForFindId" type="text" class="form-control" placeholder="이메일을 입력해주세요.">
							</div>
							<button type="button" class="btn btn-primary w-100 mt-4" onclick="findId();">아이디 찾기</button>
						</div>
						<div class="modal-result d-none">
							<h5 class="fw-bold text-center pt-4 pb-3"></h5>
							<button type="button" class="btn btn-primary w-100 mt-4" data-bs-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 비밀번호 찾기 Modal -->
		<div class="modal fade" id="findPwdModal" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content py-2">
					<div class="modal-body px-4">
						<h5 class="fw-bold mb-2 text-center">비밀번호 찾기</h5>
						<div class="modal-default">
							<div class="mb-3 form-text text-center">입력하신 이메일 주소로 비밀번호 변경 메일을 보내드립니다.</div>
							<label class="form-label fw-semibold mb-2">아이디</label>
							<div class="input-group mb-3">
								<input id="idForFindPwd" type="text" class="form-control" placeholder="아이디를 입력해주세요.">
							</div>
							<label class="form-label fw-semibold mb-2">이메일</label>
							<div class="input-group">
								<input id="emailForFindPwd" type="text" class="form-control" placeholder="이메일을 입력해주세요.">
							</div>
							<button type="button" class="btn btn-primary w-100 mt-4" onclick="findPwd();">비밀번호 찾기</button>
						</div>
						<div class="modal-result d-none">
							<h6 class="fw-bold text-center pt-4 pb-3">입력하신 이메일 주소로 비밀번호 변경 메일을 보냈습니다.<br>메일함을 확인해주세요.</h6>
							<button type="button" class="btn btn-primary w-100 mt-4" data-bs-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 공통 js include -->
<%@ include file="../common/common-js.jsp" %>
<script>
// 로그인 요청
function checkLogin(form) {
    let member_id = form.member_id.value;
    let pwd = form.pwd.value;
    
    if((member_id.trim().length == 0) || (pwd.trim().length == 0)) {
    	alert('아이디 또는 비밀번호를 입력하세요.');
    }
    else {
	   	$.ajax({
	   		type : "POST",
	   		url : "${contextPath}/user/login.do",
	   		async: false,
	   		// 전달할 데이터 타입
	   		contentType:'application/json; charset=utf-8',
	   		data : JSON.stringify(
	   				{
	   					"member_id" : member_id,
	   					"pwd" : pwd
	   				}
				),
	   		error : function(){
	   				alert("아이디와 비밀번호가 일치하지 않습니다.");
	   		},
	   		success : function() {
	   			location.href = '${contextPath}/';
	   		}
	   	});
    }
}

// 입력폼에서 엔터 시 로그인 요청
function enterLogin(form) {
	if (window.event.keyCode == 13) { // 엔터키를 눌렸을 때
		checkLogin(form);
	}
}

// 아이디 찾기
function findId() {
	let email = document.getElementById('emailForFindId');
	$.ajax({
   		type : "POST",
   		url : "${contextPath}/user/findId.do",
   		async: false,
   		// 전달할 데이터 타입
   		contentType:'application/json; charset=utf-8',
   		data : JSON.stringify(
   				{
   					"email" : email.value
   				}
			),
   		error : function(){
   				alert("통신 에러");
   		},
   		success : function(member_id) {
   			if(member_id) {
  				// 아이디가 존재하는 경우
  				let resultHtml = `가입하신 아이디는 <span class="text-primary">${'${member_id}'}</span> 입니다.`;
	   			$('#findIdModal .modal-result h5').html(resultHtml);
	   			$('#findIdModal .modal-default').addClass('d-none');
	   			$('#findIdModal .modal-result').removeClass('d-none');
			} else {
				alert('일치하는 아이디가 존재하지 않습니다.');
   			}
   		}
   	});
}

// 비밀번호 찾기
function findPwd() {
	let member_id = document.getElementById('idForFindPwd');
	let email = document.getElementById('emailForFindPwd');
	$.ajax({
   		type : "POST",
   		url : "${contextPath}/user/findPwd.do",
   		async: false,
   		// 전달할 데이터 타입
   		contentType:'application/json; charset=utf-8',
   		data : JSON.stringify(
   				{
   					"member_id" : member_id.value,
   					"email" : email.value
   				}
			),
   		error : function(){
   			alert('일치하는 아이디가 존재하지 않습니다.');
   		},
   		success : function() {
   			// 아이디가 존재하는 경우
   			$('#findPwdModal .modal-default').addClass('d-none');
   			$('#findPwdModal .modal-result').removeClass('d-none');
   		}
   	});
}

// 모달 닫기 이벤트
$('.modal').on('hidden.bs.modal', function () {
	// 닫으면서 모달 초기화하기
	$(this).find('.input-group input').val("");
	$(this).find('.modal-default').removeClass('d-none');
	$(this).find('.modal-result').addClass('d-none');
});
</script>
</body>
</html>