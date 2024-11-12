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
<title>게시판 - 팝콘피디아</title>
<!-- 공통 css include -->
<%@ include file="../common/common-css.jsp" %>
<!-- board css -->
<link rel="stylesheet" href="<c:url value='/resources/css/board.css'/>" />
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div id="board-container" class="pt-5">
	<div class="container row gx-0 mx-auto">
		<div class="col">
		</div>
		
		<div class="col-9 mx-auto pt-5">
			<c:choose>
				<c:when test="${not empty myArticle or not empty userArticle}">
					<!-- 아무것도 표시하지 않음  -->
				</c:when>
				<c:otherwise>
			        <div class="board-search-container d-flex justify-content-between align-items-center mb-4">
					<form class="d-flex justify-content-start" action="${contextPath}/board/search.do" method="post">
						<div class="me-1">
							<select class="form-select form-select-sm" name="searchType">
								<option value="all">통합</option>
								<option value="title">제목</option>
								<option value="content">내용</option>
								<option value="writer">작성자</option>
							</select>
						</div>
						<div class="me-1">
							<input class="form-control form-control-sm me-1 col-6" type="text" name="keyword">
						</div>
						<div>
							<button class="btn btn-sm btn-outline-primary" style="--bs-btn-padding-x: 1rem;" type="submit">검색</button>
						</div>
					</form>
					<div>
						<a class="btn btn-primary w-100" style="--bs-btn-padding-x: 1.25rem;--bs-btn-padding-y: 0.4rem;" href="${contextPath}/board/writeArticle">
							<span class="small">✍ 글쓰기</span>
						</a>
					</div>
				</div>
			    </c:otherwise>
			</c:choose>
			<div class="board-list-container">
				<div class="board-list-head row border-bottom py-3 gx-0 text-center fw-bold small">
					<div class="col">번호</div>
					<div class="col-6">제목</div>
					<div class="col-2">글쓴이</div>
					<div class="col">날짜</div>
					<div class="col">조회수</div>
					<div class="col">추천수</div>
				</div>
				<c:forEach var="article" items="${boardList}" >
					<a href="${contextPath}/board/article?id=${article.articleNO}" class="board-list-body row align-items-center border-bottom border-light-subtle gx-0 text-center">
						<div class="col xsmall">${article.articleNO}</div>
						<div class="col-6 text-start medium d-flex align-items-center">
							<span class="board-title me-2 text-truncate">${article.title}</span>
							<span class="board-comments small">[${article.comments}]</span>
							<c:if test="${!empty article.imgFileName}">
								<span class="board-file small ms-2"><i class="fas fa-image"></i></span>
							</c:if>
						</div>
						<c:choose>
							<c:when test="${!empty article.memberImgName}">
								<c:set var="writerImgPath" value="${contextPath}/resources/images/member/${article.member_id}/${article.memberImgName}"/>
							</c:when>
							<c:otherwise>
								<c:set var="writerImgPath" value="${contextPath}/resources/images/common/default-profile.png"/>
							</c:otherwise>
						</c:choose>
						<div class="col-2 d-flex ps-3 pe-1 align-items-center">
							<div class="board-user rounded-circle flex-shrink-0"><img src="${writerImgPath}" class="w-100" onerror="this.style.display='none';"/></div>
							<span class="text-truncate small">${article.nickname}</span>
						</div>
						<div class="col small"><fmt:formatDate value="${article.writeDate}" pattern="yy-MM-dd" type="date"/></div>
						<div class="col small">${article.hit}</div>
						<div class="col small">${article.likeNO}</div>
					</a>
				</c:forEach>
	
				<!-- 페이징을 위한 변수 set -->
				<c:choose>
					<c:when test="${not empty searchMap}">
						<c:set var="pageUrl" value="${contextPath}/board/search.do?num="/>
						<c:set var="pageQuery" value="&searchType=${searchMap.searchType}&keyword=${searchMap.keyword}"/>
					</c:when>
					<c:when test="${not empty myArticle}">
						<c:set var="pageUrl" value="${contextPath}/user/myArticles.do?num="/>
						<c:set var="pageQuery" value=""/>
					</c:when>
					<c:when test="${not empty userArticle}">
						<c:set var="pageUrl" value="${contextPath}/user/userArticles?num="/>
						<c:set var="pageQuery" value="&nickname=${userArticle }"/>
					</c:when>
					<c:otherwise>
						<c:set var="pageUrl" value="${contextPath}/board/?num="/>
						<c:set var="pageQuery" value=""/>
					</c:otherwise>
				</c:choose>
	
				<div class="board-pagination-container mt-4 d-flex justify-content-center">
					<c:if test="${page.prev}">
						<div class="page-btn">
							<a class="small me-2" href="${pageUrl}${page.startPageNum - 1}${pageQuery}"><i class="fas fa-arrow-left"></i></a>
						</div>
					</c:if>
					<ul class="page-list d-flex justify-content-center">
						<c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
							<li class="mx-1">
								<a class="<c:if test='${selectPageNum == num}'>on</c:if>" href="${pageUrl}${num}${pageQuery}">${num}</a>
							</li>
						</c:forEach>
					</ul>
					<c:if test="${page.next}">
						<div class="page-btn">
							<a class="small ms-2" href="${pageUrl}${page.endPageNum + 1}${pageQuery}"><i class="fas fa-arrow-right"></i></a>
						</div>
					</c:if>
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
</body>
</html>