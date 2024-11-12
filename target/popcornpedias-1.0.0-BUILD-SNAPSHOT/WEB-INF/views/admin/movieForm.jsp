<%@page import="com.popcornpedia.movie.dto.MovieDTO"%>
<%@page import="org.springframework.web.servlet.ModelAndView"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%	
	MovieDTO dto =(MovieDTO) request.getAttribute("movieDTO");
	String action,readonly, showTm;
	int movie_id ;
	if(dto != null){
		action = "/admin/updateMovie.do";
		readonly = "readonly style='background-color:#dfdfdf;'";
		movie_id = dto.getMovie_id();
		showTm = dto.getShowTm();
	}
	else{
		action = "/admin/insertMovie.do";
		readonly = "";
		movie_id = 0;
		showTm = "0";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 공통 css include -->
<%@ include file="../common/common-css.jsp" %>
<link rel="stylesheet" href="<c:url value='/resources/css/listMovie.css'/>" />
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="container">
	<form method="post" action="${contextPath}<%=action%>" class="mt-5"> 
		<h1 align="center">
		<c:if test="${empty movieDTO  }">
		영화정보 추가페이지
		</c:if>
		<c:if test="${not empty movieDTO }">
		영화정보 수정 페이지
		</c:if>
		</h1> 
		<p align="center"><a href="https://kobis.or.kr/kobis/business/mast/mvie/searchMovieList.do" target="_blank">KOBIS 영화정보</a>	
		<div>
		<br><h4 align="center"><button onclick="goBack()" type="button" class="btn btn-primary">영화 목록으로 돌아가기</button></h4>
		<table class="table table-border tb-input align-middle" style="width:700px; align:center; margin:10px auto">
		   <tr>
		      <td width="200"><p align="right">영화명(국문)</td>
		      <td><input type="text" name="movieNm" id="movieNm" value="${movieDTO.movieNm }" <%=readonly %>> <button type="button" onclick="fn_getKobisAPI()" class="btn btn-secondary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">Kobis 정보 가져오기 (영화이름+감독명 필수)</button>
		      </td>
		   </tr>
		   <tr>
		      <td width="200"><p align="right">영화명(영문)</td>
		      <td><input type="text" name="movieNm_EN" id="movieNmEn" value="${movieDTO.movieNm_EN }" <%=readonly %>></td>
		    </tr>
			<tr>
			<td width="200"><p align="right">movie_id</td>
		      <td><input type="text" name="movie_id" value="<%=movie_id %>" placeholder="작성금지" <%=readonly %>></td>
		   	</tr>    
		   <tr>
		       <td width="200"><p align="right">개봉연도</td>
		       <td><input type="text" placeholder="숫자만 입력" name="movieYear" value="${movieDTO.movieYear }" ></td>
		    </tr>
		    <tr>
		    	<td width="200"><p align="right">제작국가</td>
		     	<td><input type="text" name="movieNation" value="${movieDTO.movieNation }" ></td>
		    </tr>
		    <tr>
		    	<td width="200"><p align="right">장르</td>
		     	<td><input type="text" name="movieGenre" value="${movieDTO.movieGenre }"></td>
		    </tr>
		    <tr>
		    	<td width="200"><p align="right">감독</td>
		     	<td><input type="text" name="movieDirector" id="directorNm" value="${movieDTO.movieDirector }" ></td>
		    </tr>
		    <tr>
		    	<td width="200"><p align="right">출연 배우</td>
		     	<td><input type="text" size="50" name="movieActor" id="actor" value="${movieDTO.movieActor }" ></td>
		    </tr>
		    <tr>
		    	<td width="200"><p align="right">관람 등급</td>
		     	<td><input type="text" size="50" id="grade" placeholder="전체관람가/12세이상관람가/15세이상관람가/청소년이용불가" name="movieGrade" value="${movieDTO.movieGrade }"></td>
		    </tr>
		   	<tr>
		       <td width="200"><p align="right">상영시간</td>
		       <td><input type="text" id="showTm" placeholder="숫자만 입력" name="showTm" value="<%=showTm %>"></td>
		    </tr>
		   	<tr>
		       <td width="200"><p align="right">영진위 영화코드</td>
		       <td><input type="text" id="movieCd" placeholder="숫자만 입력" name="movieCd" value="${movieDTO.movieCd }"></td>
		    </tr>
		    <tr>
		    	<td width="200"><p align="right" >-----TMDB 자료 가져오기</td>	
		     	<td>
		     	▶<a href="https://www.themoviedb.org/search?language=ko&query=${movieDTO.movieNm }" target="_blank"><b>TMDB로 이동하기</b></a><br>
		     	TMDB movieID <input type="text" id="moviecode" placeholder="숫자만 입력" size="10"> <button type="button" onclick="fn_getURL()" class="btn btn-secondary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">URL 가져오기</button></td>
		    </tr>
		    <tr>
		    	<td width="200"><p align="right" >영화 포스터 URL(자동입력)</td>	
		     	<td><input type="text" size="50" id="posterURL" placeholder="poster url" name="moviePosterPath" value="${movieDTO.moviePosterPath }"></td>
		    <tr>
		    	<td width="200"><p align="right" >영화 세부정보용 배경 URL(자동입력)</td>	
		     	<td><input type="text" size="50" id="backdropURL" placeholder="backdrop url" name="movieBackdropPath" value="${movieDTO.movieBackdropPath }"></td>
		    </tr>
		    <tr>
		    	<td width="200"><p align="right" >영화 줄거리(자동입력)</td>	
		     	<td><input type="text" size="50" id="overview" placeholder="줄거리" name="movieOverview" value="${movieDTO.movieOverview }" > </td>
		    </tr>
		    <tr>
		       <td width="200"><p>&nbsp;</p></td>
		       <td><input type="submit" class="btn btn-primary" value="<c:if test="${empty movieDTO  }">추가하기</c:if><c:if test="${not empty movieDTO }">수정하기</c:if>"></td>
		    </tr>
		</table>
	</form>
</div>
</div>

<%@ include file="../common/footer.jsp" %>	
<%@ include file="../common/common-js.jsp" %>	
	
</body>

<!-- -----------자바스크립트 시작------------- -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
function fn_getURL(){
	var _id = $("#moviecode").val();
	$.ajax({
		type:"post",
		url:"${contextPath}/admin/getposterurl",
		data: {movieID:_id},
		success: function (data, textStatus){
			var jsonInfo = JSON.parse(data);
			$("#posterURL").val(jsonInfo.url);
			$("#backdropURL").val(jsonInfo.backurl);
			$("#overview").val(jsonInfo.overview);	
		},
		error: function(data,textStatus){
			alert('moviecode를 입력해주세요')
		}
	});
}


function fn_getKobisAPI(){
	var _name = $("#movieNm").val();
	var _dire = $("#directorNm").val();
	$.ajax({
		type:"post",
		async:false,
		url:"${contextPath}/admin/getkobisAPI",
		data: {movieNm:_name, directorNm:_dire},
		success: function (data, textStatus){
			var jsonInfo = JSON.parse(data);
			alert('완료')
			$("#actor").val(jsonInfo.actors);
			$("#showTm").val(jsonInfo.showTm);
			$("#grade").val(jsonInfo.grade);
			$("#movieCd").val(jsonInfo.movieCd2);
			$("#movieNmEn").val(jsonInfo.movieNmEn);
		},
		error: function(data,textStatus){
			alert('에러')
		}
	});
}
function goBack() {
	  window.history.back();
	}
</script>
<!-- ------------자바스크립트 끝-------------- -->
</html>