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
<title>팝콘피디아 - 내 정보 수정</title>
	<link rel="stylesheet" href="<c:url value='/resources/css/myProfile.css'/>" />
</head>
<body>
<%@ include file="../common/common-css.jsp" %>

<%@ include file="../common/nav.jsp" %>

<div id="modMyInfo" class="px-3 mx-auto bg-body-tertiary">	
	<div class="container bg-white set-width border rounded-3 p-4">
	    <form name="joinForm" action="${contextPath}/user/updateMyInfo.do" method="post">
			 <div class="row mb-4">
					<div class="col-12">
						<label class="form-label fw-semibold">아이디</label>
						<input type="text" name="member_id" value="${user.member_id}" class="form-control" readonly>
					</div>
				</div>
		        
				<div class="row mb-4">
					<div class="col-12">
						<label class="form-label fw-semibold">비밀번호</label>
						<input type="password" value="${user.pwd}" name="pwd" class="form-control">
					</div>
				</div>
		        
				<div class="row mb-4">
					<div class="col-12">
						<label class="form-label fw-semibold">비밀번호 확인</label>
						<input type="password" value="${user.pwd}" name="pwd_chk" class="form-control">
					</div>
				</div>
		        
				<c:choose>
					<c:when test="${user.email_verified}">
						<c:set var="verifiedText" value="✅ 인증 완료"/>
						<c:set var="verifiedClass" value="d-none"/>
					</c:when>
					<c:otherwise>
						<c:set var="verifiedText" value="⛔ 인증되지 않음"/>
						<c:set var="verifiedClass" value=""/>
					</c:otherwise>
				</c:choose>
				
				<div class="row mb-4">
					<div class="col-12">
						<label class="form-label fw-semibold">이메일
							<span id="emailVerifiedText" class="xsmall text-secondary ps-2 fw-normal">${verifiedText}</span>
						</label>
						<div class="input-group" id="emailInputGroup">
							<input type="text" name="email" value="${user.email}" class="form-control" readonly>						
							<button type="button" class="btn btn-outline-primary ${verifiedClass}" onclick="sendVerificationEmail();">인증 메일 발송</button>
						</div>
						<div class="form-text"><a class="xsmall" data-bs-toggle="modal" data-bs-target="#modEmailModal">이메일 수정하기</a></div>
						<div class="form-text"><a class="xsmall" href="${contextPath}/user/verifyEmailTest.do?id=${user.member_id}">이메일 바로 인증하기</a></div>
					</div>
				</div>

				<!-- 이메일 수정 Modal -->
				<div class="modal fade" id="modEmailModal" tabindex="-1" aria-labelledby="modEmailModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content py-2">
							<div class="modal-body">
								<label class="form-label fw-semibold mb-2">이메일 수정하기</label>
								<div class="input-group">
									<input type="text" name="modalEmail" value="${user.email}" class="form-control" onchange="checkCancel(this);">
									<button type="button" class="btn btn-outline-primary" onclick="checkDuplicateEmail();">중복검사</button>
								</div>
								<div class="mt-2 form-text">변경할 이메일을 입력하세요. (* 이메일 변경 시 인증 정보가 초기화됩니다.)</div>
								<div class="form-check mt-2 d-none">
									<input type="checkbox" name="modalEmailCheckbox" class="form-check-input">
									<label for="modalEmailCheckbox" class="form-check-label">중복 검사 결과</label>
								</div>
								<button type="button" class="btn btn-primary w-100 mt-4" onclick="modEmail();">수정하기</button>
							</div>
						</div>
					</div>
				</div>
		        
				<div class="row mb-4">
					<div class="col-12">
						<label class="form-label fw-semibold">별명</label>
						<div class="input-group">
							<input type="text" name="nickname" value="${user.nickname}" class="form-control" onchange="checkCancel(this);">
							<button type="button" class="btn btn-outline-primary" onclick="checkDuplicateNickname();">중복검사</button>
						</div>
						<div class="form-check mt-2 d-none">
							<input type="checkbox" name="nicknameCheckbox" class="form-check-input" checked>
							<label for="nicknameCheckbox" class="form-check-label">중복 검사 결과</label>
						</div>
					</div>
				</div>
		        
				<div class="row mb-3">
					<div class="col-12">
						<label class="form-label fw-semibold">성별</label>
						<div class="form-check">
							<input id="genderCheckbox-0" type="radio" name="gender" value="0" class="form-check-input" ${user.gender == '0' ? 'checked' : ''}> 
								<label class="form-check-label" for="genderCheckbox-0">남자</label>
						</div>
						<div class="form-check">
							<input id="genderCheckbox-1" type="radio" name="gender" value="1" class="form-check-input" ${user.gender == '1' ? 'checked' : ''}>
							<label class="form-check-label" for="genderCheckbox-1">여자</label>
						</div>
						<div class="form-check">
							<input id="genderCheckbox-2" type="radio" name="gender" value="2" class="form-check-input" ${user.gender == '2' ? 'checked' : ''}>
							<label class="form-check-label" for="genderCheckbox-2"><span>선택안함</span></label>
						</div>
					</div>
				</div>
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
const idReg = /^[a-zA-Z]{1}[a-zA-Z0-9-_]{7,19}$/; // 8~20자, 영문자로 시작, 영문 or 숫자 or -_ 사용가능
const pwdReg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*+=-])[A-Za-z\d!@#$%^&*+=-]{8,20}$/; // 8~20자, 영문+숫자+특수문자 모두 포함
const emailReg = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{1,40}$/; // 1~40자, @기호 포함, @앞뒤에 영문 or 숫자 or 특수문자 포함
const nicknameReg = /^.{1,20}$/; // 1~20자

// input
const member_id = document.joinForm.member_id;
const pwd = document.joinForm.pwd;
const pwd_chk = document.joinForm.pwd_chk;
const email = document.joinForm.modalEmail;
const nickname = document.joinForm.nickname;
const gender = document.joinForm.gender;
const member_idCheckbox = document.joinForm.member_idCheckbox;
const emailCheckbox = document.joinForm.modalEmailCheckbox;
const nicknameCheckbox = document.joinForm.nicknameCheckbox;

let gender_check = "${user.gender}";


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

// 이메일 유효성 검사
function checkValidEmail() {
	if(checkValid(email, emailReg, '이메일은 40자 이내로 이메일 형식을 지켜야 합니다.')) return true;
	else return false;
}

// 닉네임 유효성 검사
function checkValidNickname() {
	if(checkValid(nickname, nicknameReg, '닉네임은 20자 이내로 입력해야 합니다.')) return true;
	else return false;
}

// 성별 유효성 검사
function checkValidGender() {
	if(!gender.value) {
		alert('성별을 선택하세요.');
		return false;
	} else {
		return true;
	}
}

function checkModInfo() { // 최종 유효성 검사

	if(!checkValidNickname()) {
		return false;
	}
	else if(!nicknameCheckbox.checked) {
		alert('닉네임 중복검사 필요');
		return false;
	}
	else if(!checkValidPwd()) { // 비밀번호 유효성 검사
		return false;
	}
	else if(!checkValidGender()) { // 성별 유효성 검사
		return false;
	}
	else {
		alert('수정을 요청합니다.');
		document.joinForm.submit();
	}
}

// 중복 검사 공통 함수
function checkDuplicate(field, url, successMessage, duplicateMessage, checkbox) {
    const value = field.value.trim();
	// 입력값이 이미 존재하는지 확인 요청하고 받은 내용을 중복 여부 체크박스에 적용
    url += '?value=' + encodeURIComponent(value);
    $.get(url)
        .done(function(isDuplicated) {
            alert(isDuplicated ? duplicateMessage : successMessage);
            checkbox.checked = !isDuplicated;
        })
        .fail(function() {
            alert("통신 에러");
        });
}

// 입력값이 변하면 중복 검사 완료 취소
function checkCancel(field) {
	// field : 이벤트를 발생시킨 button
	const checkboxName = field.name + "Checkbox"; // ex. member_idCheckbox
	const checkbox = document.getElementsByName(checkboxName)[0];
	if(checkbox) { // 해당 체크박스가 있으면
	    checkbox.checked = false;
	}
}


// 닉네임 중복 검사
function checkDuplicateNickname() {
	let nickname = document.joinForm.nickname;
	if(checkValidNickname()) {
	    checkDuplicate(nickname, "${contextPath}/user/join/nicknameCheck", "사용 가능한 닉네임입니다.", "이미 존재하는 닉네임입니다.", nicknameCheckbox);
	}
}

// 이메일 중복 검사
function checkDuplicateEmail() {
	let email = document.joinForm.modalEmail;
	if(checkValidEmail()) {
	    checkDuplicate(email, "${contextPath}/user/join/emailCheck", "사용 가능한 이메일입니다.", "이미 존재하는 이메일입니다.", emailCheckbox);
	}
}

// 이메일 수정 전 유효성 검사
function checkModEmail() {
	if(!checkValidEmail()) {
		return false;
	}
	else if(!emailCheckbox.checked) {
		alert('이메일 중복검사 필요');
		return false;
	}
	return true;
}

// 이메일 수정하기
function modEmail() {
	if(checkModEmail()) {
		$.ajax({
			type : "POST",  
			url : "${contextPath}/user/updateEmail.do",
			async: false,
			// 전달할 데이터 타입
			contentType:'application/json; charset=utf-8',
			data : JSON.stringify(
					{
						"member_id" : member_id.value,
						"email" : email.value
					}
				),
			error : function(e){
				if(e.status == 401) { // 로그인 상태가 아님
					alert("로그인이 필요합니다.");
					location.href="${contextPath}/user/login";
				}
				else {
					alert("통신 에러");
				}
			},
			success : function(newEmail) {
				alert('이메일이 변경되었습니다.');
				$('#modEmailModal').modal('hide');
				document.joinForm.email.value = newEmail;
				$('#emailVerifiedText').text('⛔ 인증되지 않음');
				$('#emailInputGroup button').removeClass('d-none');
			}
		});
	}
	else {
		return false;
	}
}

// 인증 메일 보내기
function sendVerificationEmail() {
	// 회원 아이디, 이메일 정보 필요
	$.ajax({
		type : "POST",  
		url : "${contextPath}/user/sendVerificationEmail.do",
		async: false,
		// 전달할 데이터 타입
		contentType:'application/json; charset=utf-8',
		data : JSON.stringify(
				{
					"member_id" : member_id.value,
					"email" : document.joinForm.email.value
				}
			),
		error : function(e){
				if(e.status == 401) { // 로그인 상태가 아님
					alert("로그인이 필요합니다.");
					location.href="${contextPath}/user/login";
				}
				else {
					alert("통신 에러");
				}
		},
		success : function() {
			alert('인증 메일을 발송했습니다.');
		}
	});
}
</script>
</body>
</html>