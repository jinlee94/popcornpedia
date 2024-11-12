<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>팝콘피디아 - Kobis 영화 검색 결과</title>
<!-- 공통 css include -->
<%@ include file="../common/common-css.jsp" %>
<link rel="stylesheet" href="<c:url value='/resources/css/searchResult.css'/>" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
var result = JSON.parse('${result}');
</script>
</head>
<!-- 
------------------------------------------------------------
* 여기서부터 body
------------------------------------------------------------
 -->
<body>
<%@ include file="../common/nav.jsp" %>
<div class="searchWrap">
	<h3 class="fw-bold text-center mb-4 mt-5">Kobis 영화 검색</h3>
	<form method="get" action="${contextPath}/movie/searchResultKobis.do" class="row gx-2 justify-content-center">
	<div class="col-6">
		<input type="text" size="30" name="keyword" placeholder="영화 제목" class="form-control form-control-lg">
	</div>
	<div class="col-1">
		<input type="submit" value="검색" class="btn btn-outline-primary w-100 h-100"> 
	</div>
	</form>
</div>
 <br>
<div class="container"> 
	<c:choose>
   	<c:when test="${result.movieListResult.totCnt==0}">
      <div class="noResultBox">
		<div class="noResult alert alert-secondary" >
		검색 결과가 없습니다.
		</div>
	  </div>
      <br>
   </c:when>
   <c:otherwise>
	<div class="container text-center ">
  		<div class="row row-cols-5" id="container"  style="min-height:60vh;">
			<c:if test="${not empty result.movieListResult.movieList}">
			<c:forEach items="${result.movieListResult.movieList}" var="movie">
				<c:if test="${not empty movie.openDt and not empty movie.directors}">
				
				<div class="resultImg col ">
					<a href="${contextPath }/movie/movieInfoInsert.do?movieCd=${movie.movieCd}">
					<img src="${movie.posterPath }" class="rounded">
					<div><span class="mb-1 fw-bold">${movie.movieNm }</span></div>	
					<c:if test="${ not empty movie.movieYear }">${movie.movieYear } | </c:if> <c:forEach items="${movie.directors}" var="director">${director.peopleNm}</c:forEach></a>
				</div>

				</c:if>
			</c:forEach>
			</c:if>
		</div>		
	</div>
	</c:otherwise>
	</c:choose>
	<br>
</div>
<%@ include file="../common/footer.jsp" %>	
<%@ include file="../common/common-js.jsp" %>	

</body>
</html>