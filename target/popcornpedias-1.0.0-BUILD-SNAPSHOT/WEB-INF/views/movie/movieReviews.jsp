<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
  request.setCharacterEncoding("UTF-8");
%>    

<html>
<head>
 <link rel="stylesheet" href="<c:url value='/resources/css/reviewListForm.css'/>" />

<meta charset=UTF-8>
<title>${movieNm }의 리뷰 - 팝콘피디아 </title>
</head>
<body>
<%@ include file="../common/common-css.jsp" %>
<%@ include file="../common/nav.jsp" %>
		

<div class="container mt-5 vh-75">
	<div class="set-width mx-auto">

		<ul class="list-unstyled">
	  <c:forEach var="review" items="${reviewList}">
	
	    <li class="card mb-3 p-4 memberReviewList " data-member_id="${review.member_id}" data-movie_id="${review.movie_id}">
	      <div class="li-header  row mb-2">  	
		       	<div class="row col-8">
		       		<div >			     	
			     		<div>
			     		<c:choose>
							<c:when test="${!empty review.memberImgName}">
								<c:set var="reviewImgPath" value="${contextPath}/resources/images/member/${review.member_id}/${review.memberImgName}"/>
							</c:when>
							<c:otherwise>
								<c:set var="reviewImgPath" value="${contextPath}/resources/images/common/default-profile.png"/>
							</c:otherwise>
						</c:choose>
			     			<img src="${reviewImgPath }" width="30px" height="30px" style="border-radius: 50%;">
			     			<a href="${contextPath }/user/userPage?nickname=${review.nickname}" class="memberReviewList" data-member_id="${review.member_id}" data-movie_id="${review.movie_id }">${review.nickname}</a>
			     		</div>	     		 
		   			</div>
		  			<div class="col-9 " id="movieNm">
		  				<a class="d-block mb-2"></a> 
		  				<p class="ReviewRating " data-member_id="${review.member_id}" data-movie_id="${review.movie_id}"></p>
		  			</div>

		  			
		  		</div>
		        <div  class="col-4">
		        	<div class="mb-2 textright">
		        		<p class="date-font text-body-tertiary"><fmt:formatDate value="${review.reviewdate}" pattern="yy-MM-dd HH:mm" type="date"/></p>
		        	</div>
		        	<div class="textright">
		        	 <button type="button" class="like_btn btn btn-outline-primary" id="like_btn_${review.reviewNO}" data-reviewno="${review.reviewNO}" onclick="updateLike(${review.reviewNO},'${user.member_id}'); return false;"> ♥ <span id="like_count_${review.reviewNO}">${review.likeNO}</span></button>
		        	</div>
		        </div>
		        
	      </div> 
	    <div class=" li-body "> 
						<div class="reviewInfo">
							<p class="text-lineheight">${review.content}</p>
			   			</div>
		  </div>
	   		
	    </li>
	    
	  </c:forEach>
		</ul>
		
	</div>	
</div>	


	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>

   
    let my_id = "${user.member_id}";

    
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
                data: { 'reviewNO': reviewNO , 'member_id': my_id},
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
      
       	$(".card-title").on("click", function(e) {
    	      e.preventDefault();

    	      var member_id = $(this).data("member_id");

    	      window.location.href = "${contextPath}/movie/userAllReviews.do?member_id=" + member_id;
    	});
       	
       	
       	// reviewDTO each 돌릴떄 별점,영화 데이터 가져오기
       	$(".memberReviewList").each(function() {
       		let member_id = $(this).data("member_id");
       		let movie_id = $(this).data("movie_id");
       		let $ratingTd = $(this).find(".ReviewRating");
       		//let $movieNmTd = $(this).find("#movieNm");
       	   // let $moviePosterPathTd = $(this).find("#moviePosterPath");
       		//let $movieCd =  $(this).find("#movieNm a");     		
       	 	
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
       		
			/*$.ajax({
       			type:"GET",
       			url: "${contextPath}/movie/selectMovieDTO.do",
       			data: { 'movie_id':movie_id},
       			dataType: "json",
       			success: function(movieDTO){
       				console.log(movieDTO.movieNm);
       				$movieCd.text(movieDTO.movieNm);
       				$movieCd.attr("href", "${contextPath}/movie/movieInfoInsert.do?movieCd="+movieDTO.movieCd);
       			 	$moviePosterPathTd.find('img').attr('src', "http://image.tmdb.org/t/p/w300"+movieDTO.moviePosterPath);
       				
       			
       			},
       			error: function(){
       				
       		
       			}
       			
       		});
       		
       		*/
       		
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
                data: { 'reviewNO': reviewNO, 'member_id': my_id},
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
	
    /* // 수정 모달창 보이기 
    	$(document).on("click", ".modReview", function(){
    		 $(".modReviewModal").attr("style", "display:block;");
    		 var reviewNO = $(this).data("reviewNO");
    		 var movie_id = $(this).data("movie_id");
    		 
    		  $("#myReviewContent").val(""); // 모달 내부 폼 초기화
    		  $("#reviewNO").val(reviewNO); // 리뷰 번호 설정
    		  $(".modReviewModal").attr("style", "display:block;");
    		 
    		$.ajax({
    			type:"get",
    			url: "${contextPath}/movie/checkReview.do",
    			data: { 'movie_id': movie_id, 'member_id': my_id },
    			success: function(reviewDTO) {
    				$("#myReviewContent").val(reviewDTO.content);
    				$("#reviewNO").val(reviewDTO.reviewNO);
    				
    			},
    			error: function(xhr, status, error) {
    				alert("다시만들어~");
    			}
    			 
    		 });
     
    	});
    	
    	// 모달창 취소버튼
    	$(".modal_cancel").click(function(){
   		 $(".modReviewModal").attr("style", "display:none;");
   		});
    	*/

    </script>
    <%@ include file="../common/footer.jsp" %>
 <%@ include file="../common/common-js.jsp" %>
</body>
</html>