<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table {
	font-size:14px;
	border-collapse: collapse;
	border:1px solid grey;
}
td{
	border:1px solid grey;
	padding : 5px;
}
tr:hover{
	background-color: #f1f1f1;
}
img{
	margin-bottom:5px;
}
</style>
</head>
<body>

<h2>영진위 정보 데려옴</h2>

<c:if test="${not empty dto.moviePosterPath}">
<img src="http://image.tmdb.org/t/p/w300${dto.moviePosterPath }">
</c:if>
<br>
<table border="1" width="90%">
		<tr bgcolor='turquoise'>
			<td width="9%">구분</td>
			<td>내용</td>			

		</tr>
	<c:if test="${empty dto }">
		영화 정보가 없습니다.
	</c:if>
	<c:if test="${not empty dto}">
		<tr><td>영화제목</td><td>${dto.movieNm }</td></tr>
		<tr><td>제작연도</td><td>${dto.movieYear }</tr>
		<tr><td>감독</td><td>${dto.movieDirector }</td></tr>
		<tr><td>배우</td><td>${dto.movieActor }</td></tr>
		<tr><td>장르</td><td>${dto.movieGenre}</td></tr>
		<tr><td>국가</td><td>${dto.movieNation }</tr>	
		<c:if test="${not empty dto.movieOverview}">
		<tr><td>줄거리</td><td>${dto.movieOverview }</td></tr>
		</c:if>
	</c:if>
	</table>

</body>
</html>