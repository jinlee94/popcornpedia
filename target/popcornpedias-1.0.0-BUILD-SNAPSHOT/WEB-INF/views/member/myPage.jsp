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
<title>마이페이지 - 팝콘피디아</title>

    <style>
    .container.test {width:800px;}
    </style>
   <link rel="stylesheet" href="<c:url value='/resources/css/myPage.css'/>" />
</head>
<body>

<%@ include file="../common/nav.jsp" %>
<%@ include file="../common/common-css.jsp" %>

	<div id="myPageSection" class="h-auto rounded-2 p-3 mx-auto bg-body-tertiary vh-75">
		<div class="container border bg-white rounded-3 g-0 set-width">
 			<div id="profilesection" class=" mb-4 "> 
			 	<p><img src="<c:url value='/resources/images/member/${user.member_id }/${user.memberImgName }'/>" width="100" height="100"  ></p>
			 	<P id="nicknameText"> ${user.nickname } </P>
			 	<p> ${user.profileMessage } </p>
		 	</div>
			<div id = "myContent" class="mx-3" >
				<div class="row align-items-center g-0">
					<div id="myReview" class="col border bg-success rounded-3 m-1 p-2 text-center" style="height: 100px">
				 		<a id="myReviewLink" href="${contextPath}/user/myReviews.do" class="text-white"> 내가 쓴 리뷰 </a>
				 	</div> 
				 	<div id="myStarRating" class="col border bg-warning m-1 rounded-3 p-2 text-center"  style="height: 100px">
				 		<a id="myStarRatingLink" href="${contextPath }/user/myStarRating.do" class="text-white"> 내가 준 별점 </a>
				 	</div> 
				 	<div id="myWishMovie" class="col border bg-secondary m-1 rounded-3 p-2 text-center"  style="height: 100px">
				 		<a id="myWishMovieLink" href="${contextPath }/movie/myWishMovie.do" class="text-white"> 보고싶은 영화 </a>
				 	</div> 
				 	<div id="myArticle" class="col border bg-primary-subtle m-1 rounded-3 p-2 text-center " style="height: 100px">
				 		<a id="myArticleLink" href="${contextPath }/user/myArticles.do" class="text-white"> 내가 쓴 게시물 </a>	
				 	</div> 
				</div>
				<div class="my-4">
					<ul class="list-group fs-5">
					 	<li class="list-group-item border-end-0 border-start-0"><a href="${contextPath}/user/myProfile "> 프로필 수정</a> </li>
					 	<li class="list-group-item border-end-0 border-start-0"><a href="${contextPath }/user/modMyInfo"> 내 정보 </a> </li>
					 	<li class="list-group-item border-end-0 border-start-0"><a href="${contextPath }/user/myTaste?nickname=${user.nickname}"> 취향분석</a> </li> 
					 	<li class="list-group-item border-end-0 border-start-0"><a href="#" id="deleteMember"> 회원 탈퇴</a> </li>
					 </ul>
			 	</div>
			</div>
		</div> 
	</div>

<%@ include file="../common/footer.jsp" %>
 <%@ include file="../common/common-js.jsp" %>
</body>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

	let member_id = "${user.member_id}";
	let nickname = "${user.nickname}";

	$(document).ready(function() {
	    // 내가 쓴 리뷰 개수
		$.get("${contextPath}/user/countMyReviews.do", function(data) {
	        // 서버에서 반환한 숫자를 사용
	        var reviewCount = data;

	        // HTML에 숫자를 추가
	        $('#myReview').append('<p class="text-white pt-1 fs-1">' + reviewCount + '</span>');
	    });
	    
	    // 내가 준 평균별점
	    $.get("${contextPath}/user/avgMyStarRating.do", function(data) {
	       	var avgStarRating = data;
	        $('#myStarRating').append('<p class="text-white pt-1 fs-1">' + avgStarRating.toFixed(2) + '</span>');
	    });
	    
	    // 내가 쓴 게시물 개수
	    $.get("${contextPath}/user/countMyArticles.do", function(data) {
	        
	        var articleCount = data;
   
	        $('#myArticle').append('<p class="text-white pt-1 fs-1">' + articleCount + '</span>');
	    });
	    
		 // 보고싶은영화 개수
	    $.get("${contextPath}/user/countMyWishMovie.do", function(data) {
	        
	        var wishMovieCount = data;
   
	        $('#myWishMovie').append('<p class="text-white pt-1 fs-1">' + wishMovieCount + '</span>');
	    });
	    
	    
	});
	
	
	// 회원탈퇴
	document.getElementById("deleteMember").addEventListener("click",function(event){
		if (confirm("탈퇴 하시겠습니까?")){
			
			//회원목록 삭제
			$.ajax({
				type: "GET",
				url :"${contextPath}/admin/deleteMember.do",
				data : {"member_id":member_id},
				success: function(response) {
					alert("탈퇴 완료.");
					window.location.href = "${contextPath}/user/login";
				}
		
			});

			// 로그아웃
			$.ajax({
				type:"GET",
				url :"${contextPath}/user/logout",
				success : function(){
					
				}
			});
				

		}
	});
	
	function myReviews(){
		alert("d");
		alert(member_id);
		$.ajax({
			type:"GET",
			url: "${contextPath}/user/myReviews.do",
			data: {'member_id': member_id},
			success: function(){
				alert(member_id);
			}
		});
	}
	
	$('#myReview').click(function() {
	    $('#myReviewLink')[0].click();
	});
	
	$('#myStarRating').click(function() {
	    $('#myStarRatingLink')[0].click();
	});
	
	$('#myArticle').click(function() {
	    $('#myArticleLink')[0].click();
	});
	
	$('#myWishMovie').click(function() {
	    $('#myWishMovieLink')[0].click();
	});
	
</script>

</html>