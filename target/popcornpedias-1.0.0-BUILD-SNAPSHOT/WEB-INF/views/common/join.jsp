<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입하기 - 팝콘피디아</title>
<!-- 공통 css include -->
<%@ include file="../common/common-css.jsp" %>
<!-- login css -->
<link rel="stylesheet" href="<c:url value='/resources/css/login.css'/>" />
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="bg-body-tertiary" id="login-container">
	<div class="container col-6 bg-white border rounded p-5">
		<div class="logo px-5 mb-5 text-center">
			<img src="${contextPath}/resources/images/common/logo.png" alt="logo" width="200px">
		</div>
		<form name="joinForm" action="${contextPath}/user/join.do" method="post">
			<table class="table align-middle" style="width:500px; margin:0 auto;">
			  <tr>
			      <td align="right" class="fw-bold">아이디</td>
			      <td>
			      	<input type="text" class="join-form-input form-focus" name="member_id" onchange="checkCancel(this);" >
			      	<input type="button" class="btn btn-outline-primary fw-bold" value="중복검사" onclick="checkDuplicateId();" style="--bs-btn-padding-y: .45rem; --bs-btn-padding-x: .6rem; --bs-btn-font-size: .85rem;">
			      	<input type="checkbox" name="member_idCheckbox">
			      </td>
			   </tr>
			   <tr>
			      <td align="right" class="fw-bold">비밀번호</td>
			      <td>
			      	<input type="password" class="join-form-input" name="pwd">
			      </td>
			   </tr>
			   <tr>
			      <td align="right" class="fw-bold">비밀번호 확인</td>
			      <td>
			      	<input type="password" class="join-form-input" name="pwd_chk">
			      </td>
			   </tr>
			   <tr>
			      <td align="right" class="fw-bold">이메일</td>
			      <td>
			      	<input type="text" class="join-form-input" name="email" onchange="checkCancel(this);">
			      	<input type="button" class="btn btn-outline-primary fw-bold" value="중복검사" onclick="checkDuplicateEmail();" style="--bs-btn-padding-y: .45rem; --bs-btn-padding-x: .6rem; --bs-btn-font-size: .85rem;">
			      	<input type="checkbox" name="emailCheckbox">
			      </td>
			   </tr>
			   <tr>
			      <td align="right" class="fw-bold">별명</td>
			      <td>
			      	<input type="text" class="join-form-input" name="nickname" onchange="checkCancel(this);">
			      	<input type="button" class="btn btn-outline-primary fw-bold" value="중복검사" onclick="checkDuplicateNickname();" style="--bs-btn-padding-y: .45rem; --bs-btn-padding-x: .6rem; --bs-btn-font-size: .85rem;">
			      	<input type="checkbox" name="nicknameCheckbox">
			      </td>
			   </tr>
			   <tr>
			      <td align="right" class="fw-bold">성별</td>
			      <td class="gender-td">
			      	<input type="radio" name="gender" value="0" id="select1"><label for="select1">남자<br></label>
			      	<input type="radio" name="gender" value="1" id="select2"><label for="select2">여자<br></label>
			      	<input type="radio" name="gender" value="2" id="select3"><label for="select3">선택안함</label>
			      </td>
			   </tr>
			   <tr align="center">
			   	  <td colspan="2"><input type="button" value="가입하기" onclick="checkJoin();" class="btn btn-primary mt-5 fw-bold"></td>
			   </tr>
			</table>
		</form>
	</div>
</div>


<%@ include file="../common/common-js.jsp" %>		
</body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
const email = document.joinForm.email;
const nickname = document.joinForm.nickname;
const gender = document.joinForm.gender;
const member_idCheckbox = document.joinForm.member_idCheckbox;
const emailCheckbox = document.joinForm.emailCheckbox;
const nicknameCheckbox = document.joinForm.nicknameCheckbox;

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

// 아이디 유효성 검사
function checkValidId() {
	// 유효성 충족하면 true 리턴
	if(checkValid(member_id, idReg, '아이디는 8~20자로 영문, 숫자, 특수문자(-,_)만 포함해야 하며 영문으로 시작해야 합니다.')) return true;
	else return false;
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

function checkJoin() { // 최종 유효성 검사
	// 아이디, 이메일, 별명 중복검사(+유효성검사) 모두 완료되었는지 확인
	if(!checkValidId()) {
		return false;
	}
	else if(!member_idCheckbox.checked) {
		alert('아이디 중복검사 필요');
		return false;
	}
	else if(!checkValidEmail()) {
		return false;
	}
	else if(!emailCheckbox.checked) {
		alert('이메일 중복검사 필요');
		return false;
	}
	else if(!checkValidNickname()) {
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
		alert('회원가입을 요청합니다.');
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

// 아이디 중복 검사
function checkDuplicateId() {
    let member_id = document.joinForm.member_id;
    if(checkValidId()){ // 유효성 검사 먼저 실행
	    checkDuplicate(member_id, "${contextPath}/user/join/idCheck", "사용 가능한 아이디입니다.", "이미 존재하는 아이디입니다.", member_idCheckbox);
    }
}

// 이메일 중복 검사
function checkDuplicateEmail() {
	let email = document.joinForm.email;
	if(checkValidEmail()) {
	    checkDuplicate(email, "${contextPath}/user/join/emailCheck", "사용 가능한 이메일입니다.", "이미 존재하는 이메일입니다.", emailCheckbox);
	}
}

// 닉네임 중복 검사
function checkDuplicateNickname() {
	let nickname = document.joinForm.nickname;
	if(checkValidNickname()) {
	    checkDuplicate(nickname, "${contextPath}/user/join/nicknameCheck", "사용 가능한 닉네임입니다.", "이미 존재하는 닉네임입니다.", nicknameCheckbox);
	}
}

window.onload = function() {
    // 페이지가 로드될 때 자동으로 포커스를 주고 싶은 input 요소를 선택합니다.
    var inputElement = document.querySelector('input[name="member_id"]');
    
    // 선택한 input 요소에 포커스를 줍니다.
    if (inputElement) {
      inputElement.focus();
    }
  };
</script>
</html>