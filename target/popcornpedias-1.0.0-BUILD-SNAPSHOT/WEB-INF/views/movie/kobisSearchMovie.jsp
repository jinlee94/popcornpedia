<%@page import="info.movito.themoviedbapi.TmdbFind"%>
<%@page import="info.movito.themoviedbapi.TmdbApi"%>
<%@page import="info.movito.themoviedbapi.TmdbMovies"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝콘피디아 - Kobis 영화 검색</title>
<!-- 공통 css include -->
<%@ include file="../common/common-css.jsp" %>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="container mt-5 mb-3 px-4">
	<h3 class="fw-bold text-center mb-4 mt-5">Kobis 영화 검색</h3>
	<form method="get" action="${contextPath}/movie/searchResultKobis.do" class="row gx-2 justify-content-center">
	<div class="col-6">
		<input type="text" size="30" name="keyword" placeholder="'영화 제목'만 검색 가능" class="form-control form-control-lg">
	</div>
	<div class="col-1">
		<input type="submit" value="검색" class="btn btn-outline-primary w-100 h-100"> 
	</div>
	</form>
	<div style="min-height:60vh;"></div>
</div>
<%@ include file="../common/footer.jsp" %>
<%@ include file="../common/common-js.jsp" %>		

</body>
</html>