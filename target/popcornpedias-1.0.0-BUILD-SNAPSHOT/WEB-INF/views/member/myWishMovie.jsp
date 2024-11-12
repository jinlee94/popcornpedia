<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>팝콘피디아 - 보고 싶은 영화</title>
 <link rel="stylesheet" href="<c:url value='/resources/css/myStarRating.css'/>" />
</head>
<body>
 <%@ include file="../common/nav.jsp" %> 
<%@ include file="../common/common-css.jsp" %>

<div class="container">	 
		<div class="text-center mt-5">
			<h3 class="fw-bold">보고 싶은 영화</h3>
		</div>
		<ul class="list-unstyled row p-5 set-width">
		  	<c:forEach var="starRating" items="${starRatingList}">
			    <li class="mb-4 starRatingList col-md-2" data-movie_id="${starRating.movie_id }" >
			      <div class="card no-border cursor-p" onclick="redirectToLink(this)">
			      	<div class="card-img mb-2 rounded moviePosterPath" id="moviePosterPath"  >
			        	<img src="" alt="Movie Poster" class="card-img-top h-100" >
			        </div>
			        <div class="card-body">
			          <h5 class="card-title" id="movieNm"><a href="#"></a></h5>
			        </div>
			      </div>
			    </li>
		  	</c:forEach>
		  	<c:if test="${empty starRatingList }">
		  		<div class="border-bottom mt-2 mb-3" ></div>
			  	<div class="emptyReviewBox text-center " style="min-height:60vh;">	
			  		<p class="align-middle" style="display:inline-block; line-height: 60vh; -webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none; font-size:17px;"> 보고 싶은 영화를 추가해보세요. </p>	
			  	</div>
			  	<div class="border-bottom mt-3 mb-3" ></div>
		  	</c:if>
		</ul>
</div>

<%@ include file="../common/footer.jsp" %>
<%@ include file="../common/common-js.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>	
<script>

let member_id =  "${user.member_id}";
$(document).ready(function() {
	$(".starRatingList").each(function() {
			let movie_id = $(this).data("movie_id");
			let $movieNmTd = $(this).find("#movieNm");
			let $moviePosterPathTd = $(this).find("#moviePosterPath");
			let $movieCd =  $(this).find("#movieNm a"); 
			let $starRating = $(this).find("#starRating");
			let $updateStarRatingForm = $(this).find("#updateStarRatingForm");
			let $starSpan = $(this).find("#spanstar");
	
			
			$starSpan.css('width', $starRating.val()* 20 + "%"); 
			
			$.ajax({
				type:"GET",
				url: "${contextPath}/movie/selectMovieDTO.do",
				data: { 'movie_id':movie_id},
				dataType: "json",
				success: function(movieDTO){
					
					$movieCd.text(movieDTO.movieNm);
					$movieCd.attr("href", "${contextPath}/movie/movieInfoInsert.do?movieCd="+movieDTO.movieCd);
				 	$moviePosterPathTd.find('img').attr('src', "http://image.tmdb.org/t/p/w300"+movieDTO.moviePosterPath);
	
				},
				error: function(){
					
				}
				
			});
		
		});
	});

function redirectToLink(element) {
	  var link = $(element).find('a').attr('href');
	  window.location.href = link;
	}

</script>
</body>

</html>