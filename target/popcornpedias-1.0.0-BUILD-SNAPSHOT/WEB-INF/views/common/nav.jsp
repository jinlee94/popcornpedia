<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:choose>
	<c:when test="${!empty user.memberImgName}">
		<c:set var="imgPath" value="${contextPath}/resources/images/member/${user.member_id}/${user.memberImgName}"/>
	</c:when>
	<c:otherwise>
		<c:set var="imgPath" value="${contextPath}/resources/images/common/default-profile.png"/>
	</c:otherwise>
</c:choose>
<nav class="navbar navbar-expand-md py-3 border-bottom" id="navbar">
	<div class="container p-0">
		<a id="navbar-logo" class="navbar-brand" href="${contextPath}/movie/mainMovie">
			<img src="${contextPath}/resources/images/common/logo.png" alt="logo" class="h-100">
		</a>

		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navContent" aria-controls="navContent" aria-expanded="false" aria-label="Toggle navigation">
      		<span class="navbar-toggler-icon"></span>
    	</button>

		<div class="collapse navbar-collapse" id="leftNav">
			<ul class="navbar-nav">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">관리자</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="${contextPath}/admin/listMember.do">회원 조회</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item" href="${contextPath}/admin/listMovie">영화 조회</a></li>
						<li><a class="dropdown-item" href="${contextPath}/movie/search">Kobis 영화 검색</a></li>
					</ul>
				</li>

				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">🎬 영화</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="${contextPath}/movie/movieSearch?keyword=미스터리&page=1">키워드별 영화 검색</a></li>
					</ul>
				</li>

				<li class="nav-item">
					<a class="nav-link" href="${contextPath}/board/">✍ 게시판</a>
				</li>
			</ul>
		</div>

		<ul class="navbar-nav align-items-center" id="rightNav">
			<li class="nav-item me-3">
				<form class="d-flex align-items-center" role="search" method="get" action="${contextPath}/movie/movieSearch">
					<input class="form-control me-1" type="text" name="keyword" placeholder="영화명 / 감독명 / 배우명" aria-label="Search" required="required">
					<button class="btn btn-outline-primary text-nowrap" style="--bs-btn-padding-x: 1.25rem;" type="submit">검색</button>
				</form>
			</li>
			<li class="nav-item">
				<ul class="navbar-nav">
					<!-- 접속 회원 확인 (컨트롤러에서 설정한 @SessionAttributes에서 값 가져오기) -->
					<c:choose>
						<c:when test="${!empty user.member_id && !empty user.nickname}">
							<li class="nav-item mx-0 dropdown">
								<a data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false" class="nav-link dropdown-toggle nav-user py-0 d-flex align-items-center">
								<div class="rounded-circle me-2"><img src="${imgPath}" class="w-100" onerror="this.style.display='none';"/></div>
									<span>${user.nickname}(${user.member_id}) 님</span>
								</a>
								<ul class="dropdown-menu">
									<li><a class="dropdown-item" href="${contextPath }/user/myPage.do">마이페이지</a></li>
									<li><a class="dropdown-item" href="${contextPath}/user/logout">로그아웃</a></li>
								</ul>
							</li>
						</c:when>
						<c:otherwise>
							<li class="nav-item">
								<a class="nav-link" href="${contextPath}/user/login">로그인</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="${contextPath}/user/join">✅ 회원가입</a>
							</li>
						</c:otherwise>
					</c:choose>
				</ul>
			</li>
		</ul>
	</div>
</nav>