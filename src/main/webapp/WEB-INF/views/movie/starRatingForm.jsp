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
    <c:when test="${empty param.ratingNO}">
        <form action="${contextPath}/movie/writeStarRating.do" method="post">
            movie_id: <input type="number" id="movie_id" name="movie_id"> <br>
           
            회원 ID: <input type="text" id="member_id" name="member_id"> <br>
            닉네임: <input type="text" id="nickname" name="nickname"> <br>
            
            별점: <input type="number" step="0.5" id="rating" name="rating"> <br>
            OST: <input type="number" id="detailOST" name="detailOST"> <br>
            연출: <input type="number" id="detailDirection" name="detailDirection"> <br>
            영상미: <input type="number" id="detailVisual" name="detailVisual"> <br>
            연기: <input type="number" id="detailActing" name="detailActing"> <br>
            스토리: <input type="number" id="detailStory" name="detailStory"> <br>
            
            <input type="submit" value="별점 작성">
        </form>
    </c:when>
    <c:otherwise>
        <form action="${contextPath}/movie/modStarRating.do" method="post">
            영화 ID: <input type="number" id="movie_id" name="movie_id" value="${starRatingDTO.movie_id}" readonly> <br>
            
            회원 ID: <input type="text" id="member_id" name="member_id" value="${starRatingDTO.member_id}" readonly> <br>
            닉네임: <input type="text" id="nickname" name="nickname" value="${starRatingDTO.nickname}" readonly> <br>
            
            별점: <input type="number" step="0.5" id="rating" name="rating" value="${starRatingDTO.rating}"> <br>
            OST: <input type="number" id="detailOST" name="detailOST" value="${starRatingDTO.detailOST}"> <br>
            연출: <input type="number" id="detailDirection" name="detailDirection" value="${starRatingDTO.detailDirection}"> <br>
            영상미: <input type="number" id="detailVisual" name="detailVisual" value="${starRatingDTO.detailVisual}"> <br>
            연기: <input type="number" id="detailActing" name="detailActing" value="${starRatingDTO.detailActing}"> <br>
            스토리: <input type="number" id="detailStory" name="detailStory" value="${starRatingDTO.detailStory}"> <br>
            
            <input type="hidden" name="ratingNO" value="${starRatingDTO.ratingNO}">
            <input type="submit" value="별점 수정">
        </form>
    </c:otherwise>
</c:choose>

</body>
</html>