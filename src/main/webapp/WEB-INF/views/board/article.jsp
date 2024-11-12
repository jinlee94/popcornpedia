<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${article.title} - 팝콘피디아</title>
<!-- 공통 css include -->
<%@ include file="../common/common-css.jsp" %>
<!-- board css -->
<link rel="stylesheet" href="<c:url value='/resources/css/article.css'/>" />
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div id="article-container" class="pt-5">
	<div class="container row gx-0 mx-auto">
		<div class="col">
			<div class="d-flex justify-content-end pe-5">
				<a href="${contextPath}/board/" class="btn btn-outline-secondary small opacity-75"><i class="fas fa-arrow-left"></i></a>
			</div>
		</div>
		<div class="col-9 mx-auto pt-5">
			<!-- 게시글 -->
			<div class="article">
				<div class="article-title">
					<h3 class="fw-bold">${article.title}</h3>
				</div>
				<div class="article-info d-flex justify-content-between align-items-center mb-5 border-bottom">
					<a class="article-writer text-dark" href="${contextPath }/user/userPage?nickname=${article.nickname}">
						<div class="d-flex align-items-center">
						
							<c:choose>
								<c:when test="${!empty article.memberImgName}">
									<c:set var="writerImgPath" value="${contextPath}/resources/images/member/${article.member_id}/${article.memberImgName}"/>
								</c:when>
								<c:otherwise>
									<c:set var="writerImgPath" value="${contextPath}/resources/images/common/default-profile.png"/>
								</c:otherwise>
							</c:choose>
							
							<div class="writer-profile rounded-circle flex-shrink-0"><img src="${writerImgPath}" class="w-100" onerror="this.style.display='none';"/></div>
							<div class="writer-info">
								<div class="writer-nickname fw-bold">${article.nickname}</div>
								<div class="writer-count xsmall text-black-50">
									<span><i class="far fa-eye"></i>${article.hit}</span>
									<span><i class="far fa-comment-dots"></i>${article.comments}</span>
									<span><i class="fas fa-heart"></i>${article.likeNO}</span>
								</div>
							</div>
						</div>
					</a>
					<div class="text-black-50 small pe-1">
						<span><fmt:formatDate value="${article.writeDate}" pattern="yyyy-MM-dd HH:mm" type="date"/></span>
					</div>
				</div>
				
				<div class="mb-4">
					<div class="article-content">
						<!-- 첨부파일이 존재하면 표시하기 -->
						<c:if test="${!empty article.imgFileName}">
						<div class="article-file mb-5 text-center">
							<img src="<c:url value='/resources/images/board/${article.articleNO}/${article.imgFileName}'/>">
						</div>
						</c:if>
		
						<div class="article-text mb-4 lh-base">
							<c:out value="${article.content}" escapeXml="false" />
						</div>
					</div>
	
					<div class="article-like">
						<!-- 멤버 아이디 가져와서 추천 여부에 따라 다른 버튼 보이게 하기 -->
						<button id="article-like-btn" type="button" onclick="updateLike();" class="btn btn-outline-primary mx-auto px-4 py-3 d-flex align-items-center justify-content-center"><i class="fas fa-heart small"></i><span id="article-like-number">${article.likeNO}</span></button>
					</div>
					
					<!-- 작성자와 접속중인 사용자가 같은지 확인하고 수정/삭제 버튼 출력 -->
					<div class="d-flex justify-content-end">
						<c:if test="${article.member_id eq user.member_id}">
						<a href="${contextPath}/board/modArticle?id=${article.articleNO}" class="btn btn-sm btn-outline-primary me-1">수정</a>
						<a href="${contextPath}/board/deleteArticle.do?id=${article.articleNO}" class="btn btn-sm btn-outline-primary">삭제</a>
						</c:if>
					</div>
				</div>
				
			</div>
			
			<!-- 댓글 -->
			<div class="comment">
				<p class="fw-bold pb-3 border-bottom"><span id="commentsNum"></span></p>
				<div class="comment-list-container">
					<ul id="comment-list"></ul>
				</div>

				<div class="comment-pagination-container d-flex justify-content-center">
					<div class="page-btn" id="prevPage" onclick="prevPage();">
						<a class="small me-2"><i class="fas fa-arrow-left"></i></a>
					</div>
					<ul class="page-list d-flex justify-content-center" id="pageNumbers"></ul>
					<div class="page-btn" id="nextPage" onclick="nextPage();">
						<a class="small ms-2"><i class="fas fa-arrow-right"></i></a>
					</div>
				</div>
				<div class="comment-input d-flex mt-3">
					<div class="flex-fill me-2">
						<textarea class="form-control" id="cmtContent" placeholder="댓글을 입력하세요." rows="1"></textarea>
					</div>
					<div>
						<button class="btn btn-primary w-100 h-100" style="--bs-btn-padding-x:1.2rem;" type="button" onclick="insertComment();"><span class="small">작성하기</span></button>
					</div>
				</div>
			</div>
	</div>
		<div class="col">
		</div>
	</div>
</div>

<%@ include file="../common/footer.jsp" %>

<!-- 공통 js include -->
<%@ include file="../common/common-js.jsp" %>
<script>
// 글번호, 추천여부 변수 설정
let articleNO = "${article.articleNO}";
let likeCheck = "${likeCheck}";
let member_id = "${user.member_id}";
let nickname = "${user.nickname}";
let nowPage;
let endPage;

//페이지 로딩 시
$(document).ready(function(){
	// 추천 여부 확인해 버튼 색 반영
	if(likeCheck == "1") {
		$('#article-like-btn').removeClass('btn-outline-primary');
		$('#article-like-btn').addClass('btn-primary');
	}
	
	// 댓글 가져오기
	getPageComment(1);

});

// 게시글 추천, 추천 취소
function updateLike() {
	$.ajax({
		type : "GET",
		url : "${contextPath}/board/updateLike",
		async: false,
		// 전달할 데이터 타입
		contentType:'application/json; charset=utf-8',
		// @Controller 에서 받는거라 json 변환하지 않음
		data : {
					"articleNO" : articleNO,
					"member_id" : member_id,
					"likeCheck" : likeCheck
				},
		error : function(e){
			if(e.status == 401) { // 로그인 상태가 아님
				alert("로그인이 필요합니다.");
				location.href="${contextPath}/user/login";
			}
			else {
				alert("에러가 발생했습니다.");
			}
		},
		
		// [TODO] 추천수 반영 및 버튼 색 변경을 위해 location.reload() 시 조회수가 올라가므로 다른 방법을 찾아야 함
		// ==> [DONE] 컨트롤러에서 return시 최종 추천수를 가져와서 현재 페이지에 반영하고
		//     추천 버튼 누를 때마다 likeCheck 값 바꿔서 다시 컨트롤러에 요청
		success : function(likeNO) {
			$('#article-like-btn').toggleClass('btn-primary');
			$('#article-like-btn').toggleClass('btn-outline-primary');
			$('#article-like-number').text(likeNO);
			if(likeCheck == 0){
				likeCheck = 1;
			}
			else if (likeCheck == 1){
				likeCheck = 0;
		 	}
		}
	});
}

// 댓글 작성
function insertComment() {
	// 아이디, 닉네임, 글번호 변수는 위에 있음
	// 댓글내용 변수 선언
	let cmtContent = $('#cmtContent').val();
	
	// 댓글 객체 생성
	$.ajax({
		type : "POST",  
		url : "${contextPath}/board/writeComment.do",
		async: false,
		// 전달할 데이터 타입
		contentType:'application/json; charset=utf-8',
		data : JSON.stringify(
				{
					"cmtContent" : cmtContent,
					"member_id" : member_id,
					"nickname" : nickname,
					"articleNO" : articleNO
				}
			),
		error : function(e){
				if(e.status == 401) { // 로그인 상태가 아님
					alert("로그인이 필요합니다.");
					location.href="${contextPath}/user/login";
				}
				else if(e.status == 400) { // 이메일 인증 안함
					alert("이메일 인증을 완료해주세요.");
				}
				else {
					alert("에러가 발생했습니다.");
				}
		},
		success : function() {
			$('#cmtContent').val(""); // 댓글창 초기화
			if(endPage==0){
	            getPageComment(1);
	        }
	        else{
	         getPageComment(endPage);
	        }
			// 댓글 추가, 삭제할때 updateComments 실행되게 하기
		}
	});
}

// 댓글 수정
function modComment(btn) {
	// 수정할 댓글 내용, 댓글 번호 가져오기
	// 함수를 호출한 수정 버튼의 근처 textarea의 값 찾기
	let cmtContent = btn.closest('.comment-mod-form').querySelector('textarea').value;
	let commentNO = btn.closest('.comment-list-item').querySelector('input[name="commentNO"]').value;
	
	$.ajax({
		type : "POST",  
		url : "${contextPath}/board/modComment.do?cmtId=" + commentNO,
		async: false,
		// 전달할 데이터 타입
		contentType:'application/json; charset=utf-8',
		data : JSON.stringify(
				{
					"cmtContent" : cmtContent,
					"commentNO" : commentNO
				}
			),
		error : function(e){
			if(e.status == 401) { // 로그인 상태가 아님
				alert("로그인이 필요합니다.");
				location.href="${contextPath}/user/login";
			}
			else if(e.status == 403) { // 사용자가 다름
				alert("권한이 없습니다.");
			}
			else if(e.status == 400) { // 이메일 인증 안함
				alert("이메일 인증을 완료해주세요.");
			}
			else {
				alert("통신 에러");
			}
		},
		success : function() {
			getPageComment(nowPage);
		}
	});
}

// 댓글 삭제
function deleteComment(btn) {
	if(confirm('해당 댓글을 삭제하시겠습니까?')) {
		// 댓글 번호 가져오기
		let commentNO = btn.closest('.comment-list-item').querySelector('input[name="commentNO"]').value;
		
		$.ajax({
			type : "DELETE",  
			url : "${contextPath}/board/deleteComment.do?cmtId=" + commentNO,
			async: false,
			// 전달할 데이터 타입
			contentType:'application/json; charset=utf-8',
			data : JSON.stringify(
					{
						"articleNO" : articleNO,
						"commentNO" : commentNO
					}
				),
			error : function(e){
				if(e.status == 401) { // 로그인 상태가 아님
					alert("로그인이 필요합니다.");
					location.href="${contextPath}/user/login";
				}
				else if(e.status == 403) { // 사용자가 다름
					alert("권한이 없습니다.");
				}
				else if(e.status == 400) { // 이메일 인증 안함
					alert("이메일 인증을 완료해주세요.");
				}
				else {
					alert("통신 에러");
				}
			},
			success : function() {
				getPageComment(nowPage);
			}
		});
	}
	else {
		return false;
	}
}

// 댓글 리스트 가져오기
function getPageComment(num) {
	let user_id = "${user.member_id}";
	
	// $.getJSON(url, function(data)) : url로 요청해 받아온 json 데이터로 함수 실행
	$.getJSON(
		"${contextPath}/board/getPageComment.do/" + articleNO+"?num="+num,
		function(commentMap){
			// cmtList : 받아온 댓글(json) 리스트
			
			let cmtList = commentMap.cmtList;
			let page = commentMap.page;	
			let cmtHtml = "";
			
			if(cmtList == null || cmtList.length == 0) {
				// 댓글 목록이 없으면 아무것도 하지 않음
				$('#comment-list').html(cmtHtml);
				$('#commentsNum').html(cmtList.length);
			}
			else {
				// for문으로 댓글 컨테이너 하나씩 붙이기
				for(let cmt of cmtList) {
					// 프로필 url 지정
					let cmtWriterImgPath = "";
					if(cmt.memberImgName) {
						cmtWriterImgPath = `${contextPath}/resources/images/member/${'${cmt.member_id}'}/${'${cmt.memberImgName}'}`;
					}
					else {
						cmtWriterImgPath = `${contextPath}/resources/images/common/default-profile.png`;
					}
					
					cmtHtml += `<li class="comment-list-item py-3 border-bottom">
									<div class="comment-info d-flex justify-content-between align-items-start mb-3">
										<a class="comment-writer text-dark d-flex align-items-center" href="#">
											<div class="d-flex align-items-center">
												<div class="cmtWriter-profile rounded-circle flex-shrink-0">
													<img src="${'${cmtWriterImgPath}'}" class="w-100" onerror="this.style.display='none';"/>
												</div>
												<div class="cmtWriter-nickname fw-bold me-2">
													<span>${'${cmt.nickname}'}</span>
												</div>
											</div>
											<div class="text-black-50 xsmall">
												<span>${'${cmt.cmtWriteDate}'}</span>
											</div>
										</a>`;

					// 작성자와 접속중인 사용자가 같은지 확인하고 수정/삭제 버튼 추가
					if(user_id == cmt.member_id) {
						cmtHtml += `<div class="d-flex">
										<button class="comment-mod-toggle btn btn-sm btn-outline-secondary me-1" type="button">수정</button>
										<button class="btn btn-sm btn-outline-secondary" type="button" onclick="deleteComment(this);">삭제</button>
										<input type="hidden" value="${'${cmt.commentNO}'}" name="commentNO">
									</div>`
					};
					cmtHtml += `</div>
									<div class="comment-content">
									<p class="lh-base">${'${cmt.cmtContent}'}</p>`;
					if(user_id == cmt.member_id) {
						cmtHtml += `<div class="comment-mod-form mt-3">
										<div class="row gx-0 mb-2">
											<div class="col-11 me-2">
												<textarea class="form-control">${'${cmt.cmtContent}'}</textarea>
											</div>
											<div class="col">
												<button class="btn btn-sm btn-outline-primary w-100 h-100" type="button" onclick="modComment(this);">수정</button>
											</div>
										</div>
								</div>`;
					};
					cmtHtml += `</div></li>`;
				}

				// 전체 댓글 컨테이너 안의 html 대체하기
				$('#comment-list').html(cmtHtml);
				// 페이지에 보여주는 댓글 총 개수는 sql 실행 대신 list의 길이로 계산해 나타냄
				$('#commentsNum').html(cmtList.length);
				// 댓글 버튼 클릭 이벤트 추가하기(동적으로 생성된 html 태그에 적용해야 함)
				$('.comment-mod-toggle').on('click',function(){
					// 수정 버튼 누르면 수정창 show/hide, 버튼 문구 변경
					$(this).closest('.comment-list-item').find('.comment-mod-form').toggle();
					let btnText = $(this).text();
					btnText = (btnText == '수정') ? '취소' : '수정';
					$(this).text(btnText);
				});
			}
			
			// 페이징 기능 구현 
			let startPageNum = page.startPageNum;
			let endPageNum = page.endPageNum;
			let prev = page.prev;
			let next = page.next;
			let count = page.count;
			
			let pageNumbersHtml = "";
			
	    	if(endPageNum > 1) {
	            for (let i = startPageNum; i <= endPageNum; i++) {
	
	                if (i === num) {
										pageNumbersHtml += `<li class="mx-1"><a class="on">${'${i}'}</a></li>`;
	                } else {
										pageNumbersHtml += `<li class="mx-1"><a href="javascript:void(0);" onclick="getPageComment(${'${i}'})">${'${i}'}</a></li>`;
	                }
	            }
            	$('#pageNumbers').html(pageNumbersHtml);
	    	}
			
            // 다음페이지 이전페이지 이동 
            if (page.prev) {
                $('#prevPage').show();
                $('#prevPage').click(function () {
                        getPageComment(startPageNum - 1);
                    
                });
            } else {
                $('#prevPage').hide();
            }

            if (page.next) {
                $('#nextPage').show();
                $('#nextPage').click(function () {
                        getPageComment(endPageNum + 1);
                    
                });
            } else {
                $('#nextPage').hide();
            }
       
            let commentsNumElement = document.getElementById("commentsNum");
            commentsNumElement.textContent = count + "개의 댓글이 있습니다.";
            
            nowPage= num;
            endPage= endPageNum;
		}
	);
}
</script>
</body>
</html>