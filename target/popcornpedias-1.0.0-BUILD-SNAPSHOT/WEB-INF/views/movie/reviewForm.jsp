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
	<c:choose>
		<c:when test="${empty param.reviewNO}">

			<form action="${contextPath }/movie/writeReview.do" method="post">
				영화 ID : <input type="number" id="movie_id" name="movie_id"> <br>
				내용 : <textarea id="content" name="content"></textarea> <br>
				회원 ID : <input type="text" id="member_id" name="member_id"> <br>
				닉네임 : <input type="text" id="nickname" name="nickname"> <br>
				<input type="submit" value="리뷰 작성">
			</form>

		</c:when>
		<c:otherwise>
			<form action="${contextPath}/movie/modReview.do" method="post">
				영화 ID : <input type="number" id="movie_id" name="movie_id" value="${reviewDTO.movie_id}" readonly>  <br>
				내용 : <textarea id="content" name="content">${reviewDTO.content}</textarea> <br>
				회원 ID : <input type="text" id="member_id" name="member_id" value="${reviewDTO.member_id}" readonly>  <br>
				닉네임 : <input type="text" id="nickname" name="nickname" value="${reviewDTO.nickname}" readonly>  <br>
				<input type="hidden" name="reviewNO" value="${reviewDTO.reviewNO}">

				<input type="submit" value="리뷰 수정">
			</form>
		</c:otherwise>
	</c:choose>

</body>
</html>