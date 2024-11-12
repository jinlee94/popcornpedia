<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
  request.setCharacterEncoding("UTF-8");
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1"  align="center"  width="80%">
    <tr align="center"   bgcolor="lightgreen">
      <td ><b>영화 id </b></td>
      <td><b>별점 </b></td>
      <td><b>수정</b> </td>
      <td><b>삭제</b> </td>
   </tr>
   
 <c:forEach var="starRating" items="${starRatingList}" >     
   <tr align="center">
     <td>${starRating.movie_id}</td>
     <td>${starRating.rating}</td>
   	 <td><a href="${contextPath }/movie/starRatingForm.do?member_id=${starRating.member_id }&ratingNO=${starRating.ratingNO } ">수정하기</a>
   	 <td><a href="${contextPath}/movie/deleteStarRating.do?member_id=${starRating.member_id }&ratingNO=${starRating.ratingNO}">삭제하기</a></td>
   
    </tr>
  </c:forEach>   
</table>
<a href="${contextPath }/movie/index.do "> 테스트하러가기</a>

</body>
</html>