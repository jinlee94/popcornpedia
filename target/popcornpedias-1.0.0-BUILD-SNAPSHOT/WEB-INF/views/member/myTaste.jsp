<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<head>
<link rel="stylesheet" href="<c:url value='/resources/css/myTaste.css'/>" />
<meta charset="UTF-8">
<title>팝콘피디아 - 취향분석</title>
</head>
<body>
	<%@ include file="../common/nav.jsp" %>
	<%@ include file="../common/common-css.jsp" %>
	<c:if test="${empty starCnt }">
		<div class="set-width mx-auto"> 
			<div class="starRatingSection mt-5 pt-5 mx-auto text-center">
				<h2> 작성된 평가가 없습니다. </h2>
			</div>
		</div>
	</c:if>
	
	<div class="container ">
		<div class="set-width mx-auto">
			<div class="starRatingSection mt-5 pt-5 mx-auto">
				<h2>별점 분포</h2>
				<div class="starRatingInfo mx-auto text-center my-3">
					<p class="text-center fw-bold"> </p>
				</div>
				<div class="chart-wrap mx-auto">
					<canvas id="myChart" class="starRatingChart" width="400" height="300"></canvas>
				</div>
				<div class="row mx-auto">				
					<div class="col-4 text-center" >
						<h5 class="mb-2 fw-bold"> ${starCnt} </h5>
						<p> 별점 개수 </p>
						
					</div>
					<div class="col-4 text-center">
						<h5 class="mb-2 fw-bold"> ${starAvg} </h5>
						<p> 별점 평균 </p>
					</div>
					<div class="col-4 text-center">
						<h5 class="mb-2 fw-bold" > ${starMax} </h5>
						<p> 많이 준 별점  </p>
					</div>
				</div>
			</div>	
			
			<div class="mt-5 pt-5 mx-auto">
				<div class="mb-5">
					<h2 class="pb-2"> 많이 본 배우</h2>
					<div class="px-3 ">
						<ul>
						<c:choose>
							<c:when test="${fn:length(tasteMovieActor) < 4}">
        					<div class="text-center p-4">
        						<h4> 아직 평가가 부족해요.</h4>
        					</div>
   							 </c:when>
   							<c:otherwise>
							<c:forEach var="actor" items="${tasteMovieActor}" varStatus="loop">
								<c:if test="${loop.index lt 5}">
									<li class="border-bottom" >
										<div class="row my-3">
											<div class="col-6">
												<p class="fs-5"><span class="fw-bold me-4 fs-4">${loop.index + 1}</span>${actor.key}</p>  
											</div>
											<div class="col-6" >
												<p class="text-end ">${actor.value }편 </p>
											</div>
										</div>	
									</li>
								</c:if>
							</c:forEach>
							</c:otherwise>
						</c:choose>
						</ul>
					</div>

				</div>
				
				<div class="mb-5">
					<h2 class="pb-2"> 많이 본 감독</h2>
					<div class=" px-3 ">
						<ul>
						<c:choose>
							<c:when test="${fn:length(tasteMovieDirector) < 4}">
        					<div class="text-center p-4">
        						<h4> 아직 평가가 부족해요.</h4>
        					</div>
   							 </c:when>
   							<c:otherwise>
							<c:forEach var="movieDirector" items="${tasteMovieDirector}" varStatus="loop">
								<c:if test="${loop.index lt 5}">
									<li class="border-bottom" >
										<div class="row my-3">
											<div class="col-6">
												<p class="fs-5"><span class="fw-bold me-4 fs-4">${loop.index + 1}</span><c:out value="${movieDirector['movieDirector']}"/></p>  
											</div>
											<div class="col-6" >
												<p class="text-end "><c:out value="${movieDirector['count']}"/>편 </p>
											</div>
										</div>	
									</li>
								</c:if>
							</c:forEach>
							</c:otherwise>
						</c:choose>
						</ul>
					</div>
				</div>
				
				<div class="mb-5">
					<h2 class="pb-2"> 많이 본 국가</h2>
					<div class=" px-3 ">
						<ul>
							<c:choose>
								<c:when test="${fn:length(tasteMovieNation) < 4}">
	        					<div class="text-center p-4">
	        						<h4> 아직 평가가 부족해요.</h4>
	        					</div>
	   							 </c:when>
	   							<c:otherwise>
								<c:forEach var="movieNation" items="${tasteMovieNation}" varStatus="loop">
									<c:if test="${loop.index lt 5}">
										<li class="border-bottom" >
											<div class="row my-3">
												<div class="col-6">
													<p class="fs-5"><span class="fw-bold me-4 fs-4">${loop.index + 1}</span><c:out value="${movieNation['movieNation']}"/></p>  
												</div>
												<div class="col-6" >
													<p class="text-end "><c:out value="${movieNation['count']}"/>편 </p>
												</div>
											</div>	
										</li>
									</c:if>
								</c:forEach>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
				</div>
				<div class="mb-5">
					<h2 class="pb-2"> 많이 본 장르</h2>
					<div class=" px-3 ">
						<ul>
							<c:choose>
							<c:when test="${fn:length(tasteMovieNation) < 4}">
	        					<div class="text-center p-4">
	        						<h4> 아직 평가가 부족해요.</h4>
	        					</div>
	   						</c:when>
	   						<c:otherwise>
							<c:forEach var="genre" items="${tasteMovieGenre}" varStatus="loop">
								<c:if test="${loop.index lt 5}">
									<li class="border-bottom" >
										<div class="row my-3">
											<div class="col-6">
												<p class="fs-5"><span class="fw-bold me-4 fs-4">${loop.index + 1}</span>${genre.key}</p>  
											</div>
											<div class="col-6" >
												<p class="text-end ">${genre.value }편 </p>
											</div>
										</div>	
									</li>
								</c:if>
							</c:forEach>
							</c:otherwise>
							</c:choose>
						</ul>
					</div>
				</div>
	
				<div>
					<h2 class="pb-2">영화 감상 시간</h2>
					<div class="text-center showTimeInfo mt-3">
						<h5 class="text-primary mb-2">	${showTime } 시간 </h5>
						<p class="text-primary"></p>
					</div>
				</div>			
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
	    const ctx = document.getElementById('myChart');
		let tasteStarData = JSON.parse('${tasteStar}');
		console.log(tasteStarData[0].ratingCount);
		console.log(Chart.version);
		// 최댓값 찾기
		let maxRatingCount = Math.max(...tasteStarData.map(item => item.ratingCount));
		let maxIndex = tasteStarData.findIndex(item => item.ratingCount === maxRatingCount);

		// 각 막대의 색상 설정
		let backgroundColors = [...Array(10)].fill('rgb(200, 177, 255)'); // 기본 색상
		backgroundColors[maxIndex] = '#5326be'; // 최댓값에 다른 색상 적용
	
		// 별점 평균 값 
		let starAvg = ${starAvg};
		
		// 영화 본 시간
		let showTime = ${showTime};
		
	
		
		document.addEventListener('DOMContentLoaded', function() {
		
			// 별점 평균값에 따라 출력할 텍스트 값
			let classification = classifyStarRating(starAvg);		
			
			// 출력할 곳 선택자 .
			let starRatingInfoElement = document.querySelector('.starRatingInfo p');
			  starRatingInfoElement.textContent = classification;
			
			// 영화 본 시간에 따라 출력할 텍스트 값
			let classifyTotalTime = classifyShowTime(showTime);
			
			// 출력할 곳 선택
			let showTimeInfoElement = document.querySelector('.showTimeInfo p');
				showTimeInfoElement.textContent = classifyTotalTime;
			});
		
		// 차트 .js
	    new Chart(ctx, {
	      type: 'bar',
	      data: {
	        labels: ['', '1', '', '2', '', '3','','4','','5'],
	        datasets: [{
	        	
	          data: [tasteStarData[0].ratingCount,
     	 	 		tasteStarData[1].ratingCount,
    	 			tasteStarData[2].ratingCount,
    	 	 		tasteStarData[3].ratingCount,
    	 			tasteStarData[4].ratingCount,
    	 			tasteStarData[5].ratingCount,
    	 			tasteStarData[6].ratingCount,
    	 			tasteStarData[7].ratingCount,
    	 			tasteStarData[8].ratingCount,
    	 			tasteStarData[9].ratingCount],
	          borderWidth: 0,
	          backgroundColor:  backgroundColors,
	          borderColor : 'rgba(0, 0, 0, 0)',
	          minBarLength: 3,
	          borderWidth: 5,
	          barThickness : 45
	          
	        }]
	      },
	      options: {
	    	  aspectRatio: 2,
	    	  scales: {
	    	    x: {
	    	    	
	    	      	grid: {
	    	        display: false, // X축 그리드 라인 숨기기
	    	      },
	    	      
	    	     
	    	    },
	    	    y: {
	    	      grid: {
	    	        display: false, // Y축 그리드 라인 숨기기
	    	      },
	    	      display: false,
	    	    },
	    	  },
	    	  
	    	  plugins: {
	    	    legend: {
	    	      display: false, // 범례 숨기기
	    	    },
	    	    tooltip: {
	    	        enabled: false // 툴팁 비활성화
	    	     },
	    	  },
	    	}
	    });
	    
		
		// 별점 주기 범위
	    const starRanges = [
	    	  { min: 0.5, max: 1.9, description: "세상 영화들에 불만이 많으신 '개혁파'" },
	    	  { min: 1.9, max: 2.3, description: "웬만해선 영화에 만족하지 않는 '헝그리파' " },
	    	  { min: 2.3, max: 2.5, description: "별점을 대단히 짜게 주는 한줌의 '소금' 같은 분 :)" },
	    	  { min: 2.5, max: 2.9, description: "웬만해서는 호평을 하지 않는 매서운 '독수리파' " },
	    	  { min: 2.9, max: 3.2, description: "작품을 대단히 냉정하게 평가하는 '냉장고파'" },
	    	  { min: 3.2, max: 3.4, description: "평가에 상대적으로 깐깐한 '깐새우파'" },
	    	  { min: 3.4, max: 3.5, description: "대체로 영화를 즐기지만 때론 혹평도 마다치 않는 '이성파'" },
	    	  { min: 3.5, max: 3.6, description: "평가에 있어 주관이 뚜렷한 '소나무파'" },
	    	  { min: 3.6, max: 3.8, description: "대중의 평가에 잘 휘둘리지 않는 '지조파' " },
	    	  { min: 3.8, max: 3.9, description: "편식 없이 골고루 보는 '균형파'" },
	    	  { min: 3.9, max: 4.0, description: "영화를 정말로 즐길 줄 아는 '현명파'" },
	    	  { min: 4.0, max: 4.1, description: "남들보다 별점을 조금 후하게 주는 '인심파' " },
	    	  { min: 4.1, max: 4.3, description: "별점에 다소 관대한 경향이 있는 '다 주고파'" },
	    	  { min: 4.3, max: 4.4, description: "남 작품에 욕 잘 못하는 착한 품성의 '돌고래 파'" },
	    	  { min: 4.4, max: 4.7, description: "영화면 마냥 다 좋은 '천사 급' 착한 사람♥" },
	    	  { min: 4.7, max: 5.0, description: "5점 뿌리는 '부처님 급' 아량의 소유자 " },
	    	];
		
		
		// 별점 분류해서 값 할당 
		function classifyStarRating(rating) {
		  for (const range of starRanges) {
		    if (rating >= range.min && rating <= range.max) {
		      return range.description;
		    }
		  }
		  return "별점 평가를 해주세요."; // 해당 범위에 속하지 않는 경우
		}
		
		
		// 영화 감상시간 텍스트 범위
		const timeRanges = [
		    { min: 1, max: 50, description: "평가하는 거 나름 되게 재미있는데 어서 더 평가를..." },
		    { min: 50, max: 100, description: "영화 본 시간으로 아직 평균에 못 미쳐요 ㅠ" },
		    { min: 100, max: 200, description: "영화를 본 시간으로 딱 평균 정도시네요." },
		    { min: 200, max: 300, description: "상위 30% 만큼 영화를 보셨어요. 그래도 상위권 !" },
		    { min: 300, max: 400, description: "극장에 50만원쯤 쓰셨겠어요. 영화에 쓰는 돈은 사랑입니다." },
		    { min: 400, max: 500, description: "이제 자기만의 영화보는 관점이 생기셨을 거에요." },
		    { min: 500, max: 750, description: "인생의 3주는 순수하게 영화 본 시간. 대단합니다." },
		    { min: 750, max: 1000, description: "일주일에 두 편씩 1년이면 상위 5% 매니아예요." },
		    { min: 1000, max: 1500, description: "대..대단합니다. 순수 영화 본 시간 1000시간 돌파!" },
		    { min: 1500, max: 2000, description: "상위 0.1%" },
		];
		
		function classifyShowTime(time){
			for (const totalTime of timeRanges){
				if( time >= totalTime.min && time <= totalTime.max){
					return totalTime.description;
				}
			}
			return "영화 평가를 해주세요."
		}
		
		
	</script>	
 
	 <%@ include file="../common/footer.jsp" %>
	<%@ include file="../common/common-js.jsp" %>
</body>
</html>