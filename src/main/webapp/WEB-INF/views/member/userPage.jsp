<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%request.setCharacterEncoding("UTF-8");%> 
    
<!DOCTYPE html>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta charset="UTF-8">
<title>${otherUser.nickname }님의 프로필 - 팝콘피디아 </title>

    <style>
    .container.test {width:800px;}
    </style>
   <link rel="stylesheet" href="<c:url value='/resources/css/myPage.css'/>" />
</head>
<body>

<%@ include file="../common/nav.jsp" %>
<%@ include file="../common/common-css.jsp" %>

	<div id="myPageSection" class="h-auto rounded-2 p-3 mx-auto bg-body-tertiary vh-75 ">
		<div class="container border bg-white rounded-3 g-0 set-width">
 			<div id="profilesection" class=" mb-4 "> 
				<c:choose>
					 <c:when test="${!empty otherUser.memberImgName}">
						<c:set var="userImgPath" value="${contextPath}/resources/images/member/${otherUser.member_id}/${otherUser.memberImgName}"/>
					</c:when>
					<c:otherwise>
						<c:set var="userImgPath" value="${contextPath}/resources/images/common/default-profile.png"/>
					</c:otherwise>
 				</c:choose>
			 	<p><img src="${userImgPath }" width="100" height="100"  onerror="this.src='${contextPath}/resources/images/common/default-profile.png'" ></p>
			 	<P id="nicknameText"> ${otherUser.nickname } </P>
			 	<p> ${otherUser.profileMessage } </p>
		 	</div>
			<div id = "myContent" class="mx-3" >
				<div class="row align-items-center g-0">
					<div id="myReview" class="col border bg-success rounded-3  p-2 text-center text-white" style="height: 100px">
				 		  <P> 리뷰 </P>
				 		<form action="${contextPath}/movie/userAllReviews.do" method="POST">
						    <input type="hidden" name="member_id" value="${otherUser.member_id}">
						    <button type="submit" class="btn text-white mybtn " id="myReviewLink">
						        ${reviewCnt }
						    </button>
						</form>
				 	</div> 
				 	<div id="myStarRating" class="col border bg-warning m-1 rounded-3 p-2 text-center  text-white" style="height: 100px">
					    <P> 별점 </P>
					    <form action="${contextPath}/user/userStarRating.do" method="post">
					       
					        <input type="hidden" name="member_id" value="${otherUser.member_id}">
					        <button type="submit" class="btn text-white mybtn" id="myStarRAtingLink">${avgStarCnt}</button>
					    </form>
					    
					</div>
					<div id="myWishMovie" class="col border bg-secondary me-1 rounded-3 p-2 text-center  text-white" style="height: 100px">
					    
					      <P> 보고싶은 영화 </P> 
					    <form action="${contextPath}/movie/myWishMovie.do" method="post">
						    <input type="hidden" name="member_id" value="${otherUser.member_id}">
					        <button type="submit" class="btn text-white mybtn" id="myWishMovieLink">${movieLikeCnt}</button>
					    </form>
					</div>
					<div id="myArticle" class="col border bg-primary-subtle rounded-3 p-2 text-center  text-white" style="height: 100px">
					    
					      <P> 게시물  </P> 
					    <form action="${contextPath}/user/userArticles" method="post">
						    <input type="hidden" name="member_id" value="${otherUser.member_id}">
					        <button type="submit" class="btn text-white mybtn" id="myArticleLink">${articleCnt}</button>
					    </form>
					</div>
				
				</div>
				<div class="my-4">
					<ul class="list-group fs-5">
					 	<li class="list-group-item border-end-0 border-start-0"><a href="${contextPath }/user/myTaste?nickname=${otherUser.nickname}"> 취향분석</a> </li> 
					 </ul>
			 	</div>
			</div>
		</div> 
	</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

	let member_id = "${anotheruser.member_id}";
	let nickname = "${anotheruser.nickname}";

	
	

	
	$('#myReview, #myStarRating, #myArticle, #myWishMovie').click(function() {
	    // 현재 클릭한 div 내의 폼을 선택하고 제출
	    $(this).find('form').submit();
	});
</script>


<%@ include file="../common/footer.jsp" %>	
 <%@ include file="../common/common-js.jsp" %>
</body>