<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
	
<style>
/*영화 배경화면 주소를 변수로 담아야 해서 뷰 페이지에 놔둡니다..*/
.backImg{
	height : 700px;
    background-image: linear-gradient( rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3) ), url(http://image.tmdb.org/t/p/original/${dto.movieBackdropPath });
    background-size: cover;
    position:relative;
}
</style>

<head>
<meta charset="UTF-8">
<title>${dto.movieNm } - 팝콘피디아</title>
<!-- 공통 css include -->
<%@ include file="../common/common-css.jsp" %>
<!-- movieInfo -->
<link rel="stylesheet" href="<c:url value='/resources/css/movieInfo.css'/>" />

</head>
<body>
<%@ include file="../common/nav.jsp" %>
		
		
	<div class="backImg ">
	<div class="container">
		<div class="movieInfoBox">
			<div class="d-flex align-items-center">
				<h1 class="me-2">${dto.movieNm } (${dto.movieYear })</h1>
				<div class="movieLike">
					<button type="button" class="btn btn-outline-light rounded-circle btn-sm" onclick="wishMoviebtn('${dto.movie_id }','${user.member_id}')" id="wishMoviebtn_">
						<i class="fas fa-heart"></i>
						<span></span>
					</button>
				</div>
			</div>
			<c:if test="${not empty dto.movieNm_EN }">${dto.movieNm_EN } <div class="vr align-middle m-1"></div></c:if>
			<c:if test="${not empty dto.movieNation }">${dto.movieNation } <div class="vr align-middle m-1"></div></c:if>
			<c:if test="${not empty dto.movieGenre }">${dto.movieGenre } <div class="vr align-middle m-1"></div></c:if>
			<c:if test="${not empty dto.showTm }">${dto.showTm }분</c:if>
			<c:if test="${not empty dto.movieDirector }"><br> 감독 : ${dto.movieDirector }</c:if>
			<c:if test="${not empty dto.movieActor }"><br> 출연 : ${dto.movieActor }</c:if>
			<c:if test="${empty dto.movieActor }"></c:if>
			<c:if test="${not empty dto.movieGrade }"><br> ${dto.movieGrade }<br></c:if>
			<input type="hidden" id="movieid" value=${dto.movie_id }>	
		</div>
	</div>	
	</div>
	<div class="container">
		<div class="flex">
			<div class="posterbox"><img src="${dto.moviePosterPath }"></div>	
			<div class="down">		
				<c:if test="${not empty dto.movieOverview }">
					<div class="movieOverview">${dto.movieOverview }</div>		
				</c:if>
				<div class="border-bottom mt-3 mb-3"></div>
				
				<!-- 별점 작성 -->
			<div>	
				<div class="star-text text-center">평가하기</div>
				
				<div id="starRatingContainer" class="toCenter text-center parent">  
				<form name="starRatingForm" id="starRatingForm" method="post">	
					<span class="star align-middle">
				  		★★★★★
					  	<span>★★★★★</span>
						<input type="number" id="starRating" name="starRating" oninput="drawStar(this)" value="0" step="0.5" min="0" max="5" onclick="starRatingOnClick(event)"/>
						<input type="hidden" id="updateStarRatingForm">
				  	</span>
			  	</form>
				<button id="showDetailRatingButton" class="btn btn-primary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .85rem;"> 상세평가 하기(선택)</button>	 
				
				
				
				
				<!-- 상세 별점 작성 -->
				<div id="detailRatingForm" class="RatingForm">
					<form name="detailOSTform" id="detailOSTForm" method="post">
						<fieldset>
							<div class="star-text text-center">OST</div>
							<input type="radio" name="detailOSTStar" value="5" id="OSTrate1"><label
								for="OSTrate1">★</label>
							<input type="radio" name="detailOSTStar" value="4" id="OSTrate2"><label
								for="OSTrate2">★</label>
							<input type="radio" name="detailOSTStar" value="3" id="OSTrate3"><label
								for="OSTrate3">★</label>
							<input type="radio" name="detailOSTStar" value="2" id="OSTrate4"><label
								for="OSTrate4">★</label>
							<input type="radio" name="detailOSTStar" value="1" id="OSTrate5"><label
								for="OSTrate5">★</label>
								<input type="hidden" id="updateDetailOSTForm">
								
						</fieldset>
					</form>
				
					<form name="detailDirection" id="detailDirectionForm" method="post">
						<fieldset>
							<div class="star-text text-center">연출</div>
							<input type="radio" name="detailDirectionStar" value="5" id="Directionrate1"><label
								for="Directionrate1">★</label>
							<input type="radio" name="detailDirectionStar" value="4" id="Directionrate2"><label
								for="Directionrate2">★</label>
							<input type="radio" name="detailDirectionStar" value="3" id="Directionrate3"><label
								for="Directionrate3">★</label>
							<input type="radio" name="detailDirectionStar" value="2" id="Directionrate4"><label
								for="Directionrate4">★</label>
							<input type="radio" name="detailDirectionStar" value="1" id="Directionrate5"><label
								for="Directionrate5">★</label>
								<input type="hidden" id="updateDetailDirectionForm">
							
						</fieldset>
					</form>
					
					<form name="detailVisual" id="detailVisualForm" method="post">
						<fieldset>
							<div class="star-text text-center">영상미</div>
							<input type="radio" name="detailVisualStar" value="5" id="Visualrate1"><label
								for="Visualrate1">★</label>
							<input type="radio" name="detailVisualStar" value="4" id="Visualrate2"><label
								for="Visualrate2">★</label>
							<input type="radio" name="detailVisualStar" value="3" id="Visualrate3"><label
								for="Visualrate3">★</label>
							<input type="radio" name="detailVisualStar" value="2" id="Visualrate4"><label
								for="Visualrate4">★</label>
							<input type="radio" name="detailVisualStar" value="1" id="Visualrate5"><label
								for="Visualrate5">★</label>
								<input type="hidden" id="updateDetailVisualForm">
								
						</fieldset>
					</form>
					
					<form name="detailActing" id="detailActingForm" method="post">
						<fieldset>
							<div class="star-text text-center">연기</div>
							<input type="radio" name="detailActingStar" value="5" id="Actingrate1"><label
								for="Actingrate1">★</label>
							<input type="radio" name="detailActingStar" value="4" id="Actingrate2"><label
								for="Actingrate2">★</label>
							<input type="radio" name="detailActingStar" value="3" id="Actingrate3"><label
								for="Actingrate3">★</label>
							<input type="radio" name="detailActingStar" value="2" id="Actingrate4"><label
								for="Actingrate4">★</label>
							<input type="radio" name="detailActingStar" value="1" id="Actingrate5"><label
								for="Actingrate5">★</label>
								<input type="hidden" id="updateDetailActingForm">
								
						</fieldset>
					</form>
					
					<form name="detailStory" id="detailStoryForm" method="post">
						<fieldset>
							<div class="star-text text-center">스토리</div>
							<input type="radio" name="detailStoryStar" value="5" id="Storyrate1"><label
								for="Storyrate1">★</label>
							<input type="radio" name="detailStoryStar" value="4" id="Storyrate2"><label
								for="Storyrate2">★</label>
							<input type="radio" name="detailStoryStar" value="3" id="Storyrate3"><label
								for="Storyrate3">★</label>
							<input type="radio" name="detailStoryStar" value="2" id="Storyrate4"><label
								for="Storyrate4">★</label>
							<input type="radio" name="detailStoryStar" value="1" id="Storyrate5"><label
								for="Storyrate5">★</label>
								<input type="hidden" id="updateDetailStoryForm">
						</fieldset>
					</form>
					
					<button onclick="writeDetailStarRating()" class="detailButton">반영하기</button>
					<button id="deleteDetailRatingButton" onclick="deleteDetailStarRating()" class="detailButton">삭제하기</button>
					<button id="hideDetailRatingButton" class="detailButton">닫기</button>
				</div><!-- 별점 상세평가 끝 -->
			</div><!-- starRatingContainer 끝 -->
		</div><!-- 별점 전체 div -->
				<div class="border-bottom mt-3 mb-3"></div>
				<!--  리뷰 창 -->
				<p class="movieReviewH5 border-dark mb-3">내가 작성한 리뷰 </p>
				<div class="text-center toCenter member-review-box mb-3">			
					<div id="reviewContent"></div>
					<div id="reviewButton">
						<c:if test="${empty user.member_id }">
						<a class="btn btn-light" href="${contextPath }/user/login">로그인하여 리뷰를 작성해주세요 </a> 
						</c:if>
						<c:if test="${not empty user.member_id }">
						<a class="writeReview btn btn-light" href="javascript:void(0)" id="writeReviewButton">클릭하여 리뷰를 작성해주세요 </a> 
						</c:if>
						<a class="modReview" href="javascript:void(0)" id="updateReviewButton">수정 </a>
						<a href="javascript:void(0)" id="deleteReviewButton" onclick="confirmDelete(event)">삭제</a>
					</div>
				</div>	
			</div>
		</div><!-- 여기까지 flex 클래스 div -->	
		
			<div  class="flex justify-content-between " style="margin:0 auto;">
				<h4>리뷰 <span>count </span><a href="${contextPath }/movie/moreReviews?movie_id=${dto.movie_id}">더보기</a></h4>
				<div class="flex avgStarRating-hover">
					<h4>평균 별점</h4>
					<div id="avgStarRatingSection" class="align-middle"></div> <!-- 평균 별점 -->
				</div>
			</div>
			</div><!-- container 끝 -->	
			<div id="reviewSection"></div> <!-- 해당 영화의 유저 리뷰 가져오기 -->

	<!--  리뷰 작성 모달창  -->
	<div class="writeReviewModal">  
	    <div class="modalContent">
	        <form id="commentForm" action="${contextPath}/movie/writeReview.do" method="post">
	            <textarea class="modal_repCon" name="content" id="myCommentContent" required="required" maxlength="300" placeholder="최대 300자까지 작성가능합니다."></textarea>           
	            <input type="hidden" id="nickname" name="nickname" value="${user.nickname}">
	            <input type="hidden" id="movie_id" name="movie_id" value="${dto.movie_id }">
	            <input type="hidden" id="member_id" name="member_id" value="${user.member_id}">
	            <div class="modal-footer"> 
	            <input type="submit"value="리뷰 작성" class="btn btn-light">
	            <input type="button" class="modal_cancel btn btn-light" value="취소" >
	            </div>
	        </form>
	        <div class="modalBackground"></div>
	    </div>
	</div>
	
	<!-- 리뷰 수정 모달창  -->
	<div class="modReviewModal"> 
		<div class="modalContent">
		 	<form id="reviewForm" action="${contextPath}/movie/modReview.do" method="post">
			   	<textarea class="modal_repCon" name="content" id="myReviewContent" required="required" maxlength="300"></textarea>		
				<input type=hidden id="reviewNO" name="reviewNO"  >
				<div class="modal-footer"> 
			  	<input type="submit" value="리뷰 수정" class="btn btn-light">
				<input type="button" class="modal_cancel btn btn-light" value="취소">
				</div>
			</form>
			<div class="modalBackground"></div>
		</div>
	</div>
	
	

<%@ include file="../common/footer.jsp" %>	
<%@ include file="../common/common-js.jsp" %>		

</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script> 



function confirmDelete(event) {
    var confirmed = confirm("정말 삭제하시겠습니까?");

    // "예"를 눌렀을 때만 URL로 이동
    if (!confirmed) {
        event.preventDefault(); // 기본 동작(링크 이동)을 취소
    }
}
let movie_id;
let member_id = "${user.member_id}";
let nickname = "${user.nickname}";


// 변수 할당 먼저 해줌.
window.addEventListener("DOMContentLoaded", function () {
    member_id = document.getElementById("member_id").value;
    nickname = document.getElementById("nickname").value;
    movie_id = document.getElementById("movieid").value;
});



	$(document).ready(function() {
		 
		checkReview();
		loadReviews(movie_id);
		avgStarRating();
		checkStarRating();
		checkDetailStarRating();
		
		
	});
	

	// 수정 모달창 보이기 
	$(document).on("click", ".modReview", function(){
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
		 $(".writeReviewModal").attr("style", "display:none;");
		});
	
	
	// 작성 모달창 보이기 
	$(document).on("click", ".writeReview", function(){
	
		 $(".writeReviewModal").attr("style", "display:block;");
	});

	//리뷰 리스트 jsp 페이지 가져오기
	function loadReviews(movie_id) {
		
	  $.ajax({
	    type: "GET",
	    url: "${contextPath}/movie/allReviews.do",
	    data: { "movie_id": movie_id},
	    dataType: "html",
	    success: function(data) {
	      $("#reviewSection").html(data); 
	    }
	  });
	}
	
	// 리뷰 작성 여부 체크
	function checkReview() {
		    $.ajax({
		      type: "GET",
		      url: "${contextPath}/movie/checkReview.do",
		      data: { 'movie_id': movie_id, 'member_id': member_id },
		      dataType: "json",
		      success: function(reviewDTO) {  
		        if (reviewDTO.reviewNO != 0) {
		        	$("#deleteReviewButton").attr("href", "${contextPath}/movie/deleteReview.do?reviewNO="+(reviewDTO.reviewNO)+"&member_id="+(reviewDTO.member_id));
		        	   $("#writeReviewButton").hide();
		               $("#updateReviewButton").show();
		               $("#updateReviewButton").after(" |");
		               $("#deleteReviewButton").show();
		               $("#reviewContent").text(reviewDTO.content);
		              
		             } 
		        else {
		            	 
		               $("#writeReviewButton").show();
		               $("#updateReviewButton").hide();
		               $("#deleteReviewButton").hide();
		               $("#reviewContent").hide();
		             
		        }
		      }
		      
		    });
		  }
	
	
	//평균 별점 나타내기
	function avgStarRating(){
		
		$.ajax({
			type:"GET",
			url: "${contextPath}/movie/avgStarRating.do",
			data: { 'movie_id' : movie_id},
			success: function(result){
			
				 $("#avgStarRatingSection").text(result.toFixed(2));
			}
		});
	}
	
	
	
	// 별점 (작성/수정) 요청 .
	$(document).on("click", "#starRatingForm input[type=number]", function(){
			
		    var rating = $(this).val(); // 클릭으로 부여할 별점
		    var check = $("#updateStarRatingForm").val(); // 이전에 부여된 rating 
			
		    if(check==0){  // 이전에 부여된 rating 이 0이면 별점 작성 되지않음 >  작성 요청
				$.ajax({
			    	type: "post",
			    	url: "${contextPath}/movie/writeStarRating.do",
			    	data: { 'movie_id': movie_id, 'member_id':member_id, 'rating':rating},
			    	success: function(result){
			    		avgStarRating();
			    		checkStarRating();
			    		
			    	}
			    
			    }); 
			}
		    else if(check==rating){ // 이전에 부여된 별점이랑 지금 부여한 별점이랑 같으면 삭제
				$.ajax({
			    	type: "post",
			    	url: "${contextPath}/movie/deleteStarRating.do",
			    	data: { 'movie_id': movie_id, 'member_id':member_id},
			    	success: function(result){
			    		avgStarRating();
			    		checkStarRating();	 
			    		 $("#showDetailRatingButton").hide();
			    		 $("#detailRatingForm").hide();
			    		
			    	}
			    
			    }); 
				
			}		  
			else{     // 이전에 부여된 별점이랑 지금 부여한 별점이 다르면 수정 
				$.ajax({
			    	type: "post",
			    	url: "${contextPath}/movie/modStarRating.do",
			    	data: { 'movie_id': movie_id, 'member_id':member_id, 'rating':rating},
			    	success: function(result){
			    		avgStarRating();
			    		checkStarRating();
			    	
			    	}
			    	
			    }); 
			}

	}); 
		  
	
	// 별점 작성 여부 확인후 별점 체크 해서 줌 
	function checkStarRating(){
	
		$.ajax({
			type:"GET",
			url: "${contextPath}/movie/checkStarRating.do",
			data: {'movie_id':movie_id, 'member_id': member_id},
			success: function(result){
				
	            $("#starRating").val(result);
	            $("#updateStarRatingForm").val(result);
	            const starSpan = document.querySelector('.star span');
	      		const starRatingInput = document.getElementById('starRating');
	   
	      		starSpan.style.width = starRatingInput.value * 20 + '%';
	            
	            
	            if(result!=0){
	            	 $("#showDetailRatingButton").show();
	            	
	            }
			}
		});
	}
	
	// 상세 평가 show 버튼 
	$("#showDetailRatingButton").click(function() {
	    $(this).hide(); // 상세 평가 버튼 숨기기
	    $("#detailRatingForm").show(); // 평가 폼 보이기
	});
	
	
	// 상세 평가 hide 버튼
	$("#hideDetailRatingButton").click(function() {
	    $("#showDetailRatingButton").show(); // 상세 평가 버튼 숨기기
	    $("#detailRatingForm").hide(); // 평가 폼 보이기
	});

	
	
	// 상세 별점 작성
	function writeDetailStarRating(){
		var OSTRating = $("input[name='detailOSTStar']:checked").val();  // ost 별점
		var directionRating = $("input[name='detailDirectionStar']:checked").val();  // 연출별점
		var visualRating = $("input[name='detailVisualStar']:checked").val();  // 영상미 별점
		var actingRating = $("input[name='detailActingStar']:checked").val(); // 연기 별점
		var storyRating = $("input[name='detailStoryStar']:checked").val(); // 스토리 별점
		var rating = $("input[name='starRating']").val();
		
		$.ajax({
			type:"GET",
			url: "${contextPath}/movie/modDetailStarRating.do",
			data: {'movie_id':movie_id, 'member_id': member_id, 'rating':rating, 'detailOST' : OSTRating, 'detailDirection' : directionRating, 'detailVisual': visualRating, 'detailActing': actingRating, 'detailStory': storyRating},
			success: function(result){
				alert("반영 완료");
	        }
			
		});
	
	}
	
	// 상세 별점 삭제 
	function deleteDetailStarRating(){
		var confirmed = confirm("정말 삭제하시겠습니까?");

	    // "예"를 눌렀을 때만 URL로 이동
	    if (!confirmed) {
	        event.preventDefault(); // 기본 동작(링크 이동)을 취소
	    }
	    
		$.ajax({
			type:"GET",
			url : "${contextPath}/movie/deleteDetailStarRating.do",
			data : {'movie_id':movie_id, 'member_id': member_id},
			success: function(result){
				checkDetailStarRating();

			},
			error : function(){
				alert("통신 에러1");
			}
		});
	}
	
	
	// 상세 별점 체크 후 뿌려주기
	function checkDetailStarRating(){
	
		$.ajax({
			type:"GET",
			url: "${contextPath}/movie/checkDetailStarRating.do",
			data: {'movie_id':movie_id, 'member_id': member_id},
			success: function(starRatingDTO){
				
				$("#detailOSTForm input[type=radio]").prop("checked", false); 
	            $("#detailOSTForm input[type=radio][value=" + starRatingDTO.detailOST + "]").prop("checked", true);
				
	            $("#detailDirectionForm input[type=radio]").prop("checked", false); 
	            $("#detailDirectionForm input[type=radio][value=" + starRatingDTO.detailDirection + "]").prop("checked", true);
				
	            $("#detailVisualForm input[type=radio]").prop("checked", false); 
	            $("#detailVisualForm input[type=radio][value=" + starRatingDTO.detailVisual + "]").prop("checked", true);
				
	            $("#detailActingForm input[type=radio]").prop("checked", false); 
	            $("#detailActingForm input[type=radio][value=" + starRatingDTO.detailActing + "]").prop("checked", true);
				
	            $("#detailStoryForm input[type=radio]").prop("checked", false); 
	            $("#detailStoryForm input[type=radio][value=" + starRatingDTO.detailStory + "]").prop("checked", true);
	        
			},
			error: function(){
				alert("통신 에러2");
			}
		});
	}
	
	
	
	// 별점 기능 구현 시작
	
		// 클릭시 별점 채워짐, input 의 value의 설정됨.
	  const drawStar = (target) => {
	    	
	    	const starSpan = document.querySelector('.star span');
	        starSpan.style.width = target.value * 20 + '%';
	      }
	    
	  
	  	function drawStarRating(){
	  		
	  		const starSpan = document.querySelector('.star span');
	  		const starRatingInput = document.getElementById('starRating');
	  		
	  		
	  		starSpan.style.width = starRatingInput.value * 20 + '%';
	  		

	  	}
	

	    
	    const starRating = document.querySelector('.star');

	    starRating.addEventListener('mouseenter', () => {
	        starRating.addEventListener('mousemove', starRatingOnMouseMove);
	    });

	    starRating.addEventListener('mouseleave', () => {
	        starRating.removeEventListener('mousemove', starRatingOnMouseMove);
	    });
	    
	   	starRating.addEventListener('mouseleave',starRatingOnMouseLeave);
	    
	   	

	   	// 마우스 움직임 감지해서 위치에 따라 별이 채워짐
	    function starRatingOnMouseMove(event) {
	        const rect = starRating.getBoundingClientRect();
	        const starWidth = rect.width / 10;
	        const mouseX = event.clientX - rect.left;
	        const rating = Math.min(10, Math.ceil(mouseX / starWidth) * 0.5);
	       
	        const starSpan = document.querySelector('.star span');
	        starSpan.style.width = rating * 20 + '%';
	        
	     
	       
	    }
	   	
	   	// 별점 Click 시 데이터 삽입
	   	function starRatingOnClick(event) {
	   	 	const rect = starRating.getBoundingClientRect();
	        const starWidth = rect.width / 10;
	        const mouseX = event.clientX - rect.left;
	        const rating = Math.min(10, Math.ceil(mouseX / starWidth) * 0.5);
			
	        const starSpan = document.querySelector('.star span');
	        const starRatingInput = document.getElementById('starRating');
	        starSpan.style.width = rating * 20 + '%';
	       
	        starRatingInput.value = rating;
	   		
	   	}
	    
	   	// 마우스 떠나면 value 값 찾아서 value의 맞게 별이 채워짐 
	    function starRatingOnMouseLeave(event) {
	    	let starRatingInput = document.getElementById('starRating');
	    	let starSpan = document.querySelector('.star span');
	    	let rating = starRatingInput.value * 20;
	    	
	    	starSpan.style.width = rating + "%";
	    }
	    
	 // 별점 기능 구현 끝
	 
	  //보고싶은영화 버튼
      function wishMoviebtn(movie_id, member_id) {	
		 
        $.ajax({
            type: "get",
            url: "${contextPath}/movie/wishMovie",
            data: { 'movie_id': movie_id, 'member_id': member_id},
            success: function (wishCheck) {	
                if (wishCheck == 0) {   //0이면 안 누른 상태라서 누르기.
                	$("#wishMoviebtn_").addClass("btn-primary");
                    $("#wishMoviebtn_").removeClass("btn-outline-light");
                } else if (wishCheck == 1) {  //1이면 좋아요 누른 상태라서 취소하기       
                	$("#wishMoviebtn_").removeClass("btn-primary");
                    $("#wishMoviebtn_").addClass("btn-outline-light");
                }
            },
            error: function () {
                alert("로그인해주세요");
            },      
        });	
      }
	 
      $(document).ready(function () {
    	    var movie_id = '${dto.movie_id}'; // 영화 ID 가져오기
    	    var member_id = '${user.member_id}'; // 사용자 ID 가져오기

    	    // 서버에서 wishCheck 상태 가져오기
    	    $.ajax({
    	        type: "get",
    	        url: "${contextPath}/movie/checkWishMovie",
    	        data: { 'movie_id': movie_id, 'member_id': member_id},
    	        success: function (wishCheck) {	
    	        	if (wishCheck == 0) {   
    	                $("#wishMoviebtn_").removeClass("btn-primary");
    	                $("#wishMoviebtn_").addClass("btn-outline-light");
    	            } else if (wishCheck == 1) {     
    	                $("#wishMoviebtn_").addClass("btn-primary");
    	                $("#wishMoviebtn_").removeClass("btn-outline-light");
    	            }
    	        }
    	    });
    	});

</script>
</html>