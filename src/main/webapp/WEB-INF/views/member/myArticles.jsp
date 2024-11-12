<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝콘피디아 - 게시판</title>
<style>
table {border-collapse:collapse;}
.searchForm {width:80%;margin:0 auto;}
</style>
</head>
<body>
<%@ include file="../common/common-css.jsp" %>
<%@ include file="../common/nav.jsp" %>
	<table border="1" align="center" width="80%">
	  <tr align="center" bgcolor="lightgreen">
	      <td><b>글번호</b></td>
	      <td><b>제목</b></td>
	      <td><b>닉네임(아이디)</b></td>
	      <td><b>작성일</b></td>
	      <td><b>조회수</b></td>
	      <td><b>추천수</b></td>
	      <td><b>수정</b></td>
	      <td><b>삭제</b></td>
	   </tr>
	   
	 <c:forEach var="article" items="${articleList}" >     
	   <tr align="center">
	      <td>${article.articleNO}</td>
	      <td>
	      	<a style="text-decoration:none;" href="${contextPath}/board/article?id=${article.articleNO}">${article.title} (${article.comments})</a>
	      </td>
	      <td>${article.nickname}(${article.member_id})</td>
	      <td>${article.writeDate}</td>
	      <td>${article.hit}</td>
	      <td>${article.likeNO}</td>
	      <td><a href="${contextPath}/board/writeArticle?id=${article.articleNO}">수정</a></td>
	      <td><a href="${contextPath}/board/deleteArticle.do?id=${article.articleNO}">삭제</a></td>
	    </tr>
	  </c:forEach>   
	</table>
	
	<!-- 검색창 -->
	<div class="searchForm">
	<form action="${contextPath}/board/search.do" method="post">
		<select name="searchType">
			<option value="all">통합</option>
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="writer">작성자</option>
		</select>
		<input type="text" name="keyword">
		<input type="submit" value="검색">
	</form>
	</div>
	
	<a href="${contextPath}/board/writeArticle"><h1 style="text-align:center">글쓰기</h1></a>

<%@ include file="../common/footer.jsp" %>	
<%@ include file="../common/common-js.jsp" %>	
	
</body>
</html>