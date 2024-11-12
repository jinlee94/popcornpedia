<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성 - 팝콘피디아</title>
<!-- 공통 css include -->
<%@ include file="../common/common-css.jsp" %>
<!-- board css -->
<link rel="stylesheet" href="<c:url value='/resources/css/article.css'/>" />
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<!-- 수정하는 경우 (바인딩된 DTO가 있는 경우) 기존 내용을 가져옴 -->
<!-- 새글 작성하는 경우 입력폼의 모든 값은 null 이거나 0(글번호) -->
<c:choose>
	<c:when test="${!empty boardDTO}">
		<c:set var="action" value="modArticle.do?id=${boardDTO.articleNO}"/>
		<c:set var="articleNO" value="${boardDTO.articleNO}"/>
		<c:set var="title" value="${boardDTO.title}"/>
		<c:set var="content" value="${boardDTO.content}"/>
		<c:set var="imgFileName" value="${boardDTO.imgFileName}"/>
		<c:set var="nickname" value="${boardDTO.nickname}"/>
		<c:set var="member_id" value="${boardDTO.member_id}"/>
	</c:when>
	<c:otherwise>
		<c:set var="action" value="writeArticle.do"/>
		<c:set var="articleNO" value="0"/>
		<c:set var="title" value=""/>
		<c:set var="content" value=""/>
		<c:set var="imgFileName" value=""/>
		<c:set var="nickname" value="${user.nickname}"/>
		<c:set var="member_id" value="${user.member_id}"/>
	</c:otherwise>
</c:choose>

<div id="articleForm-container" class="pt-5">
	<div class="container row gx-0 mx-auto">
		<div class="col">
			<div class="d-flex justify-content-end pe-5">
				<a href="${contextPath}/board/" class="btn btn-outline-secondary small opacity-75"><i class="fas fa-arrow-left"></i></a>
			</div>
		</div>
		<div class="col-9 mx-auto pt-5">
			<div class="articleForm">
				<form action="${contextPath}/board/${action}" method="post" enctype="multipart/form-data">
					<div>
						<input class="form-control" placeholder="제목을 입력하세요." type="text" name="title" value="${title}">
					</div>
					<div>
						<textarea class="form-control" name="content" placeholder="내용을 입력하세요." rows="15">${content}</textarea>
					</div>
					<div class="d-flex gx-0 justify-content-start">
						<div class="flex-fill me-2">
							<input class="form-control" id="imgFile" type="file" name="imgFile" onchange="showPreview(this);">
							<!-- 수정 전 파일명 -->
							<input id="oldFileName" type="hidden" name="oldFileName" value="${boardDTO.imgFileName}">
							<!-- 수정 시 파일 업데이트 여부, 기존 파일 삭제 여부 판단 -->
							<input id="updateFile" type="checkbox" name="updateFile">
							<input id="deleteFile" type="checkbox" name="deleteFile">
						</div>
						<div>
							<input class="btn btn-outline-primary" type="button" value="첨부파일 삭제" onclick="clearFile();">
						</div>
					</div>
					<div class="articleForm-preview">
						<img id="preview" src="" class="mw-100 mh-100" onerror="this.style.display='none';">
					</div>
					<div class="d-flex mb-0">
						<button class="btn btn-primary flex-fill" style="--bs-btn-padding-y: 0.5rem;" type="submit">✍ 작성하기</button>
					</div>
					<!-- 입력 없이 가져갈 값 -->
					<input type="hidden" name="nickname" value="${nickname}">
					<input type="hidden" name="member_id" value="${member_id}">
					<input type="hidden" name="articleNO" value="${articleNO}">
				</form>
			</div>
		</div>
		<div class="col"></div>
	</div>
</div>

<%@ include file="../common/footer.jsp" %>

<!-- 공통 js include -->
<%@ include file="../common/common-js.jsp" %>
<script>
function showPreview(input) {
	if(input.files && input.files[0]) {
		// 업로드된 파일이 존재하면
		let reader = new FileReader();
		reader.onload = function(e){
			$('#preview').attr('src', e.target.result);
			$('#preview').show();
			let updateFile = document.getElementById('updateFile');
			let deleteFile = document.getElementById('deleteFile');
			updateFile.checked = true;
			deleteFile.checked = false;
		}
		// reader로 파일을 읽어오면 load 이벤트 발생
		reader.readAsDataURL(input.files[0]);
	}
}

function clearFile() {
	let file = document.getElementById('imgFile');
	let deleteFile = document.getElementById('deleteFile');
	file.value = '';
	$('#preview').attr('src',''); // 미리보기 삭제
	// [TODO] 기존 파일 삭제 여부 변경 [DONE] 체크박스로 제어
	updateFile.checked = true;
	deleteFile.checked = true;
}

// 수정 요청일 때 업로드된 파일 있으면 미리보기
$(document).ready(function(){
	if('${boardDTO.imgFileName}' != null) {
		$('#preview').attr('src',"<c:url value='/resources/images/board/${boardDTO.articleNO}/${boardDTO.imgFileName}'/>");
		$('#preview').show();
	}
});
</script>
</body>
</html>