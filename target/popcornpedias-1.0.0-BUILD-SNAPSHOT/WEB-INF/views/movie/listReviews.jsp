<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
  request.setCharacterEncoding("UTF-8");
%>    

<html>
<head>
<style>
.like_btn.on {color:white; background-color: #6f34f8;}
</style>
<meta charset=UTF-8>
<title>회원 리뷰 출력창</title>
<!-- 공통 css include -->
<%@ include file="../common/common-css.jsp" %>
<!-- movieInfo -->
<link rel="stylesheet" href="<c:url value='/resources/css/movieInfo.css'/>" />
</head>
<body>
	
<div class="container">
		<div class="row row-cols-4 reviewBox">
		<c:if test="${not empty reviewList }">
	 	<c:forEach var="review" items="${reviewList}" end="7">   
	 	<c:choose>
			<c:when test="${!empty review.memberImgName}">
				<c:set var="reviewImgPath" value="${contextPath}/resources/images/member/${review.member_id}/${review.memberImgName}"/>
			</c:when>
			<c:otherwise>
				<c:set var="reviewImgPath" value="${contextPath}/resources/images/common/default-profile.png"/>
			</c:otherwise>
		</c:choose> 
	  	<div style="padding:10px;">
	  	<div class="card col">
	    	<div class="card-body ">
	    		<div class="flex">				     	
			     		<div>
			     			<img src="${reviewImgPath }" width="30px" height="30px" style="border-radius: 50%;">
			     		</div>
			     		<div class="middle-center">
			     		<a href="${contextPath }/user/userPage?nickname=${review.nickname}" class="memberReviewList" data-member_id="${review.member_id}" data-movie_id="${review.movie_id }">${review.nickname}</a>
			     		</div>		     		 
		   		</div>
		   		<div class="align-bottom rightplz">
			     	<p class="text-body-secondary sm-font fst-italic rightplz" > ${review.reviewdate} </p>
			   	</div>
		     	<hr>
	     	<p class="card-text reviewCon">${review.content}</p>
	     	<hr>  
	     	<div class="flex">
		     <button type="button" class="like_btn btn btn-outline-primary" id="like_btn_${review.reviewNO}" data-reviewno="${review.reviewNO}" onclick="updateLike(${review.reviewNO},'${user.member_id}'); return false;">리뷰 추천</button>
		     <div id="like_count_${review.reviewNO}" class="middle-center reviewLikeText">${review.likeNO}</div>   
		     <span class="ReviewRating" data-member_id=${review.member_id } data-movie_id=${review.movie_id }></span>
		   </div>
	     </div>	          
	    </div>  
	    </div> 
	  </c:forEach>
	  </c:if>
	   </div>   
	  <c:if test="${empty reviewList }">  
	  	<div class="border-bottom mt-3 mb-3"></div>
	  	<div class="emptyReviewBox">	
	  		<p class="text-center align-middel" style="display:inline-block;"> 이 영화의 첫번째 리뷰를 작성해주세요 </p>	
	  	</div>
	  	<div class="border-bottom mt-3 mb-3"></div>
	  </c:if>
</div>
	
</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script> 
   	/*  
   		페이지 로딩시 좋아요 여부 체크 
   		.each(function) 으로 반복해서 게시글 하나마다 check
   	*/
  	$(document).ready(function() {
       	$(".like_btn").each(function() {
            var reviewNO = $(this).data("reviewno");
           $.ajax({
                type: "GET",
                url: "${contextPath}/movie/likeCheck.do",
                data: { 'reviewNO': reviewNO , 'member_id': member_id},
                dataType: "json",
                success: function(likeCheck) {
                    if (likeCheck == "1") {
                        $("#like_btn_" + reviewNO).addClass("on");
                    }
                    else if(likeCheck == "0"){
                    	 $("#like_btn_" + reviewNO).removeClass("on");
                    }
                }
            });
        });
      
      /* 	$(".memberReviewList").on("click", function(e) {
    	      e.preventDefault();

    	      var member_id = $(this).data("member_id");

    	      window.location.href = "${contextPath}/movie/userAllReviews.do?member_id=" + member_id;
    	});
       	
       	*/
       	// reviewDTO each 돌릴떄 별점 따로 가져오기
       	$(".memberReviewList").each(function() {
       		let member_id = $(this).data("member_id");
       		let movie_id = $(this).data("movie_id");
       		let $ratingTd = $(this).closest("tr").find(".ReviewRating"); 
       	 	
       		$.ajax({
	            type: "GET",
	            url: "${contextPath}/movie/checkStarRating.do",
	            data: { 'member_id': member_id , 'movie_id':movie_id},
	            success: function(rating) {
	            	
	                // 별점 정보를 별점 td 엘리먼트에 출력
	                $ratingTd.text(" ★ " + rating);
	                if(rating==0){
	                	 $ratingTd.text("");
	                }
	             }
	            
         	});
       		
       	});
    	
  	});
   	

	// 좋아요 버튼    
        function updateLike(reviewNO, member_id) {
			
           	
        	 let likeCountElement = document.getElementById("like_count_"+reviewNO);
             let currentLikeCount = parseInt(likeCountElement.textContent);
			
		
            $.ajax({
                type: "POST",
                url: "${contextPath}/movie/updateLike.do",
                dataType: "json",
                data: { 'reviewNO': reviewNO, 'member_id': member_id},
                error: function () {
                    alert("로그인이 필요합니다.");
                },
                success: function (likeCheck) {
                	
                    if (likeCheck == 0) {
                       
                        $("#like_btn_" + reviewNO).addClass("on");
                        let updatedLikeCount = currentLikeCount + 1;
                        likeCountElement.textContent = updatedLikeCount;
    
                    } else if (likeCheck == 1) {
                    
                        $("#like_btn_" + reviewNO).removeClass("on");
                        let updatedLikeCount = currentLikeCount - 1;
                        likeCountElement.textContent = updatedLikeCount;
                    }
                }
                
            });
        	
		}
	

    </script>
</html>