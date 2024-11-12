<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝콘피디아 - 나의 프로필</title>
   <link rel="stylesheet" href="<c:url value='/resources/css/myProfile.css'/>" />
</head>
<body>
<%@ include file="../common/common-css.jsp" %>
<%@ include file="../common/nav.jsp" %>
  <div class=" p-3 mx-auto bg-body-tertiary  ">
   	<div class="container bg-white set-width border rounded-3 p-3">
	    <div id="profilesection" class="mb-4 "> 
				<p><img id="preview" src="<c:url value='/resources/images/member/${user.member_id }/${user.memberImgName }'/>" width="100" height="100"  ></p>
			
				<P id="nicknameText"> ${user.nickname } </P>
				<p id="profileMessageText"> ${user.profileMessage } </p>
			</div>
	    
	    
	    <form name="updateMyProfileForm" action="${contextPath}/user/updateMyProfile" method="post" enctype="multipart/form-data">
	        <input type="hidden" name="email" value="${user.email}">
	        <input type="hidden" name="member_id" value="${user.member_id}">
	       	
	       		<div class="row mb-3">
	           		<label class=" col-form-label">프로필 사진</label>
	                <div class="input-group col-12">
		            	<input id="imgFile" type="file" name="profileImg" onchange="showPreview(this);" class="form-control">
						<button type="button" onclick="clearFile();" class="btn btn-light border">프로필 사진 내리기</button>
	                </div>
	                <input id="deleteFile" type="checkbox" name="deleteFile" class="d-none">
				 </div>
	                
	            <div class="row mb-3">
						<label class=" col-form-label">별명</label>
					<div class="input-group col-12">
						<input type="text" name="nickname" value="${user.nickname}" class="form-control">
						<button type="button" class="btn btn-primary" onclick="checkDuplicateNickname();">중복검사</button>
					</div>
					<div class="form-check mt-2 d-none">
						<input type="checkbox" name="nicknameCheckbox" class="form-check-input ">
						 <label for="nicknameCheckbox" class="form-check-label ">중복 검사 결과</label>
					</div>
				</div>
				
				<div class="row mb-3">
					<label class="col-form-label">프로필 메시지</label>
					<textarea id="profileMessage" name="profileMessage" rows="4" cols="50" maxlength="200" class="form-control col-12" >${user.profileMessage}</textarea>
				</div>				
				
				<div class="text-center">	
					<input type="submit" value="수정하기" class="btn btn-primary col-4">
				</div>		
		</form>
	</div>
</div>

<%@ include file="../common/footer.jsp" %>	
<%@ include file="../common/common-js.jsp" %>
</body>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
	const nicknameReg = /^.{1,20}$/;
	const nickname = document.updateMyProfileForm.nickname;
	const nicknameCheckbox = document.updateMyProfileForm.nicknameCheckbox;

	function checkValid(field, reg, invalidMessage) {
		// 정규 표현식 테스트
		if (!reg.test(field.value)) {
			alert(invalidMessage);
			field.focus();
			return false;
		} else {
			// 표현식 만족하면 true 리턴
			return true;
		}
	}

	function checkValidNickname() {
		if (checkValid(nickname, nicknameReg, '닉네임은 20자 이내로 입력해야 합니다.'))
			return true;
		else
			return false;
	}

	function checkDuplicate(field, url, successMessage, duplicateMessage,
			checkbox) {
		const value = field.value.trim();
		// 입력값이 이미 존재하는지 확인 요청하고 받은 내용을 중복 여부 체크박스에 적용
		url += '?value=' + encodeURIComponent(value);
		$.get(url).done(function(isDuplicated) {
			alert(isDuplicated ? duplicateMessage : successMessage);
			checkbox.checked = !isDuplicated;
		}).fail(function() {
			alert("통신 에러");
		});
	}

	function checkDuplicateNickname() {
		let nickname = document.updateMyProfileForm.nickname;
		if (checkValidNickname()) {
			checkDuplicate(nickname, "${contextPath}/user/join/nicknameCheck",
					"사용 가능한 닉네임입니다.", "이미 존재하는 닉네임입니다.", nicknameCheckbox);
		}
	}

	function clearFile() {
		let file = document.getElementById('imgFile');
		let deleteFile = document.getElementById('deleteFile');
		file.value = '';
		$('#preview').attr('src', ''); // 미리보기 삭제
		// [TODO] 기존 파일 삭제 여부 변경 [DONE] 체크박스로 제어
		deleteFile.checked = true;
	}

	$(document)
			.ready(
					function() {
						if ('${boardDTO.imgFileName}' != null) {
							$('#preview')
									.attr(
											'src',
											"<c:url value='/resources/images/member/${user.member_id}/${user.memberImgName}'/>");
						}
					});

	function showPreview(input) {
		if (input.files && input.files[0]) {
			// 업로드된 파일이 존재하면
			let reader = new FileReader();
			reader.onload = function(e) {
				$('#preview').attr('src', e.target.result);
				let updateFile = document.getElementById('updateFile');
				let deleteFile = document.getElementById('deleteFile');

				deleteFile.checked = false;
			}
			// reader로 파일을 읽어오면 load 이벤트 발생
			reader.readAsDataURL(input.files[0]);
		}
	}

	// 별명 변경 감지 및 업데이트
	$('input[name="nickname"]').on('input', function() {
		var newNickname = $(this).val();
		$('#nicknameText').text(newNickname);
	});

	// 프로필 메시지 변경 감지 및 업데이트
	$('textarea[name="profileMessage"]').on('input', function() {
		var newProfileMessage = $(this).val();
		$('#profileMessageText').text(newProfileMessage);
	});
</script>
</html>