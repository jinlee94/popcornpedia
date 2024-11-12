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
<title>팝콘피디아 - 나의 리뷰</title>
</head>
<body>
<%@ include file="../common/common-css.jsp" %>
<%@ include file="../common/nav.jsp" %>
 
		 
		 
<div class="container mt-5 vh-75">
	<div class="set-width mx-auto">
	
		<div class="text-center mb-5">
			<h3 class="fw-bold">내가 쓴 리뷰 </h3>
		</div>

		<ul class="list-unstyled">
	  <c:forEach var="review" items="${reviewList}">
	
	    <li class="card mb-3 px-4 pt-4 memberReviewList " data-member_id="${review.member_id}" data-movie_id="${review.movie_id}">
	      <div class="li-header  row">
				<div class="moviePosterPath col-2" id="moviePosterPath">
				  	<img class="w-100 rounded">
				</div>		       		
		
		        <div  class="col-10">
		        	<div class="row li-header pb-2">
						<div  id="movieNm" class="col-9">
			  				<a class="d-block mb-2"></a> 
			  				<p class="ReviewRating " data-member_id="${review.member_id}" data-movie_id="${review.movie_id}"></p>
			  			</div>
		        	
			        	<div  class="col-3">
				        	<div class="mb-2 textright">
				        		<p class="date-font text-body-tertiary"><fmt:formatDate value="${review.reviewdate}" pattern="yy-MM-dd HH:mm" type="date"/></p>
				        	</div>
				        	<div class="textright">
				        	 <button type="button" class="like_btn btn btn-outline-primary" id="like_btn_${review.reviewNO}" data-reviewno="${review.reviewNO}"> ♥ <span id="like_count_${review.reviewNO}">${review.likeNO}</span></button>
				        	</div>
			        	</div>
		        	</div>
		        	
		        	<div class=" li-body row "> 
						<div class="reviewInfo col=10">
							<p class="text-lineheight text-1rem">${review.content}</p>
			   			</div>
			   			<div class="d-flex justify-content-end " >
					   		<div class="me-2">
					          <a class="modReview float-right " href="javascript:void(0)" id="updateReviewButton" data-reviewNO="${review.reviewNO}" data-movie_id="${review.movie_id}">수정</a>
					         </div>
					         <div> 
					          <a  href="${contextPath}/movie/deleteReview.do?member_id=${user.member_id}&reviewNO=${review.reviewNO}" onclick="confirmDelete(event)">삭제</a>
					        </div>
					   	</div>
		 			</div>
				</div>
	      </div> 
	    </li>
	  </c:forEach>
	  <c:if test="${empty reviewList }">
			<div class="border-bottom mt-2 mb-3" ></div>
			  	<div class="emptyReviewBox text-center " style="min-height:60vh;">	
			  		<p class="align-middle" style="display:inline-block; line-height: 60vh; -webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none; font-size:17px;"> 작성된 리뷰가 없습니다. </p>	
			  	</div>
			  	<div class="border-bottom mt-3 mb-3" ></div>
			</div>
		</c:if>		
		</ul>	
	</div>	
</div>	
		

	
	<div class="modReviewModal"> 
		<div class="modalContent">
		 	<form id="reviewForm" action="${contextPath}/movie/modReview.do" method="post">
		
			   	<textarea class="modal_repCon" name="content" id="myReviewContent"></textarea>
			
				<input type=hidden id="reviewNO" name="reviewNO"  >
			  	<input type="submit" value="리뷰 수정">
				<input type="button" class="modal_cancel" value="취소">
			</form>
			<div class="modalBackground"></div>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>

   
    let member_id = "${user.member_id}";

    
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
       		let $movieNmTd = $(this).find("#movieNm");
       	    let $moviePosterPathTd = $(this).find("#moviePosterPath");
       		let $movieCd =  $(this).find("#movieNm a");     		
       	 	
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
       		
			$.ajax({
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
	
     // 수정 모달창 보이기 
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
    			data: { 'movie_id': movie_id, 'member_id': member_id },
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
    	
    	
		// 삭제 재확인.
    	function confirmDelete(event) {
    	    var confirmed = confirm("정말 삭제하시겠습니까?");

    	    // "예"를 눌렀을 때만 URL로 이동
    	    if (!confirmed) {
    	        event.preventDefault(); // 기본 동작(링크 이동)을 취소
    	    }
    	}

    </script>
    <%@ include file="../common/footer.jsp" %>
 <%@ include file="../common/common-js.jsp" %>
</body>
</html>