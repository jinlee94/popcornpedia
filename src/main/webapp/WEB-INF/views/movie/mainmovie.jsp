<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>팝콘피디아 - 영화 추천 및 평가 서비스</title>
    <!-- 공통 css include -->
    <%@ include file="../common/common-css.jsp" %>
    <!-- mainmovie css -->
    <link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>"/>
</head>
<body>
<%@ include file="../common/nav.jsp" %>

<!-- 박스오피스 순위 -->
<section class="visual">
    <div class="visual-bg">
        <div class="visual-pattern"></div>
        <img id="visual-img" src="${contextPath}/resources/images/main/visual-default.jpg">
    </div>
    <div class="container py-5">
        <div class="visual-form mb-5">
            <form method="get" action="${contextPath}/movie/movieSearch" class="row">
                <div class="col-10">
                    <input type="text" name="keyword" placeholder="영화명 / 감독명 / 배우명" class="form-control form-control-lg"
                           required="required">
                </div>
                <div class="col-2">
                    <button type="submit" class="btn btn-primary w-100 h-100">검색</button>
                </div>
            </form>
        </div>
        <div class="visual-rank">
            <h5 class="rank-title mb-5 text-center">
                <span>${date } 일별 박스오피스</span>
            </h5>
            <div class="rank-container row g-0 justify-content-center">
                <div class="rank-poster col me-5">
                    <c:forEach var="poster" items="${posterPathList }"><img class="rounded-2"
                                                                            src="${poster }"></c:forEach>
                </div>
                <div class="rank-list col-7">
                    <c:forEach var="boxoffice" items="${dailyResult.boxOfficeResult.dailyBoxOfficeList}">
                        <a class="d-block" href="${contextPath}/movie/movieInfo?movieCd=${boxoffice.movieCd}">
                            <div class="rank-list-con row g-0 align-items-center py-3">
                                <div class="col-1 ps-1 text-center fw-bold">${boxoffice.rank}</div>
                                <div class="col-1 text-center">
                                    <c:if test="${boxoffice.rankInten eq 0}"><span class="small">-</span></c:if>
                                    <c:if test="${boxoffice.rankInten > 0}">
                                        <span class="rank-up small">▲${boxoffice.rankInten}</span>
                                    </c:if>
                                    <c:if test="${boxoffice.rankInten < 0}">
                                        <span class="rank-down small">▼${boxoffice.drop}</span>
                                    </c:if>
                                </div>
                                <div class="col px-2 text-truncate">${boxoffice.movieNm}</div>
                                <div class="col-3 pe-3 text-end"><span
                                        class="xsmall opacity-75">누적관객수 ${boxoffice.audience }</span></div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="main-collection">
    <div class="container g-0">
        <div class="collection-container">
            <h4 class="main-title mb-3 fw-bold">한국 천만 관객 영화</h4>
            <div class="collection-slide-container">
                <div class="collection-slide-list">
                    <c:forEach var="tenMillion" items="${collection.tenMillionList}">
                        <div>
                            <a href="${contextPath }/movie/movieInfoByID.do?movie_id=${tenMillion.movie_id}">
                                <div class="collection-slide-img d-flex justify-content-center align-items-center rounded">
                                    <img class="h-100"
                                         src="http://image.tmdb.org/t/p/w500${tenMillion.moviePosterPath }"></div>
                                <p class="fw-bold lh-sm">${tenMillion.movieNm }</p>
                                <p><span class="small">${tenMillion.movieYear } | ${tenMillion.movieDirector }</span>
                                </p>
                            </a>
                        </div>
                    </c:forEach>
                </div>
                <div class="collection-slide-arrows">
                    <div class="prev-arrow fs-4 shadow"><i
                            class="fas fa-caret-left position-absolute top-50 start-50 translate-middle"></i></div>
                    <div class="next-arrow fs-4 shadow"><i
                            class="fas fa-caret-right position-absolute top-50 start-50 translate-middle"></i></div>
                </div>
            </div>
        </div>

        <div class="collection-container">
            <h4 class="main-title mb-3 fw-bold">영국 마법학교 체험</h4>
            <div class="collection-slide-container">
                <div class="collection-slide-list">
                    <c:forEach var="harry" items="${collection.harryList}">
                        <div>
                            <a href="${contextPath }/movie/movieInfoByID.do?movie_id=${harry.movie_id}">
                                <div class="collection-slide-img d-flex justify-content-center align-items-center rounded">
                                    <img class="h-100" src="http://image.tmdb.org/t/p/w500${harry.moviePosterPath }">
                                </div>
                                <p class="fw-bold lh-sm">${harry.movieNm }</p>
                                <p><span class="small">${harry.movieYear } | ${harry.movieDirector }</span></p>
                            </a>
                        </div>
                    </c:forEach>
                </div>
                <div class="collection-slide-arrows">
                    <div class="prev-arrow fs-4 shadow"><i
                            class="fas fa-caret-left position-absolute top-50 start-50 translate-middle"></i></div>
                    <div class="next-arrow fs-4 shadow"><i
                            class="fas fa-caret-right position-absolute top-50 start-50 translate-middle"></i></div>
                </div>
            </div>
        </div>

        <div class="collection-container">
            <h4 class="main-title mb-3 fw-bold">마블 영화를 개봉순으로!</h4>
            <div class="collection-slide-container">
                <div class="collection-slide-list">
                    <c:forEach var="marvel" items="${collection.marvelList}">
                        <div>
                            <a href="${contextPath }/movie/movieInfoByID.do?movie_id=${marvel.movie_id}">
                                <div class="collection-slide-img d-flex justify-content-center align-items-center rounded">
                                    <img class="h-100" src="http://image.tmdb.org/t/p/w200${marvel.moviePosterPath }">
                                </div>
                                <p class="fw-bold lh-sm">${marvel.movieNm }</p>
                                <p><span class="small">${marvel.movieYear } | ${marvel.movieDirector }</span></p>
                            </a>
                        </div>
                    </c:forEach>
                </div>
                <div class="collection-slide-arrows">
                    <div class="prev-arrow fs-4 shadow"><i
                            class="fas fa-caret-left position-absolute top-50 start-50 translate-middle"></i></div>
                    <div class="next-arrow fs-4 shadow"><i
                            class="fas fa-caret-right position-absolute top-50 start-50 translate-middle"></i></div>
                </div>
            </div>
        </div>

        <div class="collection-container">
            <h4 class="main-title mb-3 fw-bold">쥐어짜낸 한국 판타지 영화</h4>
            <div class="collection-slide-container">
                <div class="collection-slide-list">
                    <c:forEach var="krFantagy" items="${collection.krFantagyList}">
                        <div>
                            <a href="${contextPath }/movie/movieInfoByID.do?movie_id=${krFantagy.movie_id}">
                                <div class="collection-slide-img d-flex justify-content-center align-items-center rounded">
                                    <img class="h-100"
                                         src="http://image.tmdb.org/t/p/w200${krFantagy.moviePosterPath }"></div>
                                <p class="fw-bold lh-sm">${krFantagy.movieNm }</p>
                                <p><span class="small">${krFantagy.movieYear } | ${krFantagy.movieDirector }</span></p>
                            </a>
                        </div>
                    </c:forEach>
                </div>
                <div class="collection-slide-arrows">
                    <div class="prev-arrow fs-4 shadow"><i
                            class="fas fa-caret-left position-absolute top-50 start-50 translate-middle"></i></div>
                    <div class="next-arrow fs-4 shadow"><i
                            class="fas fa-caret-right position-absolute top-50 start-50 translate-middle"></i></div>
                </div>
            </div>
        </div>

    </div>
</section>
<%@ include file="../common/footer.jsp" %>
<!-- 공통 js include -->
<%@ include file="../common/common-js.jsp" %>


</body>
<script>
    $(document).ready(function () {
        initVisual();
        initializeSlide();
        changePoster();
    });

    // 가져온 포스터 이미지와 파일이름 배열
    const posterImgs = document.querySelector('.rank-poster');
    const imgElements = posterImgs.querySelectorAll('img');
    const visualImg = document.getElementById('visual-img');
    const imgPath = 'http://image.tmdb.org/t/p/w200';
    let posterNames = [];

    // 비쥬얼메인 초기화
    function initVisual() {
        // 1위 포스터 이미지 보이기
        if (imgElements.length > 0) {
            imgElements[0].style.display = 'block';
        }
        // 뒷배경을 1위 포스터 이미지로 지정
        <c:forEach var="poster" items="${posterPathList}">
        posterNames.push('${poster}');
        </c:forEach>
        let topRankPoster = imgPath + posterNames[0];
        if (visualImg) {
            visualImg.src = topRankPoster;
        }
    }

    // 포스터, 뒷배경 이미지 바꾸기
    function changePoster() {
        $('.rank-list a').hover(function () {
            // 현재 마우스를 올린 a 태그의 인덱스 가져오기
            let index = $(this).index();
            // 해당 인덱스에 해당하는 img(포스터) 보이게+뒷배경 변경
            imgElements.forEach(function (img) {
                img.style.display = 'none';
            })
            imgElements[index].style.display = 'block';
            let selectedRankPoster = imgPath + posterNames[index];
            if (visualImg) {
                visualImg.src = selectedRankPoster;
            }
        }, function () {
            // 마우스가 떠날 때(변화 없음)
        });
    }

    // 컬렉션 슬라이드
    function initializeSlide() {
        // 모든 슬라이드에 공통 내용 적용
        $('.collection-slide-container').each(function () {
            var slider = $(this).find('.collection-slide-list');
            var arrows = $(this).find('.collection-slide-arrows');

            // 슬라이드 옵션 설정
            slider.slick({
                infinite: true,
                slidesToShow: 5,
                slidesToScroll: 5,
                arrows: false
            });

            // 이전 슬라이드로 이동
            arrows.find('.prev-arrow').on('click', function () {
                slider.slick('slickPrev');
            });

            // 다음 슬라이드로 이동
            arrows.find('.next-arrow').on('click', function () {
                slider.slick('slickNext');
            });
        });
    }
</script>
</html>