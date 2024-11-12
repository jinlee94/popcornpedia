<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%request.setCharacterEncoding("UTF-8");%>    

<html>
<head>
<meta charset=UTF-8">
<title>영화 목록</title>
<!-- 공통 css include -->
<%@ include file="../common/common-css.jsp" %>
<link rel="stylesheet" href="<c:url value='/resources/css/listMovie.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/searchResult.css'/>" />

<script type="text/javascript">
function confirmDelete(event) {
    var confirmed = confirm("정말 삭제하시겠습니까?");

    // "예"를 눌렀을 때만 URL로 이동
    if (!confirmed) {
        event.preventDefault(); // 기본 동작(링크 이동)을 취소
    }
}
</script>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<h2 class="fw-bold text-center mt-5"><a href="${contextPath }/admin/listMovie">영화 조회</a></h2>

	
	<form method="get" action="${contextPath}/admin/searchMovie.do" align="center">
		<select name="searchType" class="searchForm">
		    <option value="movie_id" >movid_ID</option>
		    <option value="movieNm" selected="selected">국문명</option>
		    <option value="movieNm_EN">영문명</option>
		    <option value="movieDirector">감독명</option>
		</select>
		<input type="text" size="30" name="keyword" class="searchForm">
		<input type="submit" value="검색" class="btn btn-outline-primary"> 
	</form>
<div class="container">
	<div style="display: flex; justify-content: space-between;">
		<div id="resultText" class="fst-italic resultText" style="margin:auto 0;">
			<c:if test="${not empty total }">
			${total }개의 검색결과
			</c:if>
			<c:if test="${empty total }">
			</c:if>
		</div>	
		<div><a href="/popcornpedia/admin/movieForm" class="btn btn-primary mb-1">영화 추가하기</a></div>
	</div>
<table class="table table-border border table-hover align-middle">
    <tr align="center" class="table-light">
      <td width="60px" class="border"><b>movie_id</b></td>
      <td width="60px" class="border"><b>movieCd</b></td>
      <td style="max-width:200px; min-width:200px;"><b>국문명</b></td>
      <td width="150px" class="border"><b>장르</b></td>
      <td width="100px" class="border"><b>국가</b></td>
      <td width="150px" class="border"><b>배우</b></td>
      <td width="100px" class="border"><b>관람등급</b></td>
      <td width="100px" class="border"><b>상영시간</b></td>
      <td width="500px" class="border"><b>줄거리</b></td>
      <td width="90px" class="border"><b>관리</b></td>
   </tr>
   
 <c:forEach var="movie" items="${movieList}" >     
   <tr align="center" class="border">
      <td class="border">${movie.movie_id}</td>
      <td class="border">${movie.movieCd }</td>
      <td style="max-width:200px;" class="movieListImg border">
	      <a href="${contextPath}/movie/movieInfoByID.do?movie_id=${movie.movie_id}"> 
	      <!-- 포스터 이미지가 있는경우 -->
	      <c:if test="${not empty movie.moviePosterPath }">
	      <img src="https://image.tmdb.org/t/p/w200${movie.moviePosterPath}"><br>  
	      <div><span class="mb-1 fw-bold">${movie.movieNm }
	      <c:if test="${not empty movie.movieNm_EN }">[${movie.movieNm_EN}]</c:if>
	      </span></div>
	      <div class="small">
	      ${movie.movieYear } | ${movie.movieDirector }</a></div>	
	      </c:if>
	      <!-- 포스터 이미지 준비중.png인 경우 -->
	      <c:if test="${empty movie.moviePosterPath }"><br>  
	      ${movie.moviePosterPath}
	      <div><span class="mb-1 fw-bold">${movie.movieNm } \ ${movie.movieNm_EN}</span></div>
	      <div class="small">${movie.movieYear } | ${movie.movieDirector }</a></div>	
	      </c:if>
	      </a>
	  </td>
      <td class="border">${movie.movieGenre}</td>
      <td class="border">${movie.movieNation}</td>
      <td class="border">${movie.movieActor}</td>
      <td class="border">${movie.movieGrade}</td>
      <td class="border">${movie.showTm}</td>
      <td class="border">${movie.movieOverview }</td>
      <td class="border"><a href="${contextPath}/admin/updateMovieForm.do?movie_id=${movie.movie_id}" class="btn btn-secondary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .85rem;">수정</a><br><br>
      <a href="${contextPath}/admin/deleteMovie.do?movie_id=${movie.movie_id}" class="btn btn-danger" onclick="confirmDelete(event)" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .85rem;">삭제</a></td>
    </tr>
  </c:forEach>   
</table>
</div>
<br>
<!-- 페이징을 위한 변수 set -->
<c:choose>
	<c:when test="${not empty searchMap}">
		<c:set var="pageUrl" value="${contextPath}/admin/search.do?num="/>
		<c:set var="pageQuery" value="&searchType=${searchMap.searchType}&keyword=${searchMap.keyword}"/>
	</c:when>
	<c:otherwise>
		<c:set var="pageUrl" value="${contextPath}/admin/listMovie?num="/>
		<c:set var="pageQuery" value=""/>
	</c:otherwise>
</c:choose>

<div class="board-pagination-container mt-4 d-flex justify-content-center">
	<ul class="pagination justify-content-center paging">
		<c:if test="${page.prev}">
			<li class="page-item">
				<a class="page-link" href="${pageUrl}${page.startPageNum - 1}${pageQuery}">Prev</a>
			</li>
		</c:if>
		<c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
			<li class="page-item">
				<a class="page-link <c:if test='${selectPageNum == num}'>active</c:if>" href="${pageUrl}${num}${pageQuery}">${num}</a>
			</li>
		</c:forEach>			
		<c:if test="${page.next}">
			<li class="page-item">
				<a class="page-link" href="${pageUrl}${page.endPageNum + 1}${pageQuery}">Next</a>
			</li>
		</c:if>
	</ul>
</div>
<%@ include file="../common/footer.jsp" %>	
<%@ include file="../common/common-js.jsp" %>
	
</body>
</html>
