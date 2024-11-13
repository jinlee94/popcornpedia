<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>팝콘피디아 - 영화 검색 결과</title>
    <!-- 공통 css include -->
    <%@ include file="../common/common-css.jsp" %>
    <!-- SearchResult -->
    <link rel="stylesheet" href="<c:url value='/resources/css/searchResult.css'/>"/>
    <script type="text/javascript">
        //키워드 클릭할 때 실행
        function onButtonClicked(keyword) {
            var currentUrl = window.location.href;
            var newUrl = "${contextPath}/movie/movieSearch?keyword=" + encodeURIComponent(keyword) + "&page=1"; // 페이지 초기값 설정
            window.location.href = newUrl;
        }

        //페이지 번호를 클릭할 때 실행
        function onPageNumberClick(page) {
            var currentUrl = window.location.href;
            var exKeyword = currentUrl.match(/keyword=([^&]*)/); //url에 있는 keyword 가져오기
            var keyword = exKeyword ? decodeURIComponent(exKeyword[1]) : '';
            var newUrl = "${contextPath}/movie/movieSearch?keyword=" + encodeURIComponent(keyword) + "&page=" + page;
            window.location.href = newUrl;

            var resultDiv = document.getElementById("resultText");
            resultDiv.innerHTML = "클릭된 버튼의 텍스트: " + keyword;
        }

        const startYear = 1981;
        const endYear = 2023;

        // 연도 목록을 생성하고 <select>에 추가하는 함수
        function createYearList() {
            const yearSelect = document.getElementById("yearSelect");
            for (let year = endYear; year >= startYear; year--) {
                const option = document.createElement("option");
                option.value = year.toString(); // 연도 값을 option의 value로 설정
                option.textContent = year.toString(); // 연도를 표시
                yearSelect.appendChild(option);
            }
        }

        // 페이지 로드 시 연도 목록 생성 실행
        window.onload = createYearList;

        // 연도를 선택했을 때 실행되는 함수
        function onYearSelected() {
            const yearSelect = document.getElementById("yearSelect");
            const selectedYear = yearSelect.value; // 선택한 연도 값 가져오기
            var newUrl = "${contextPath}/movie/movieSearch?keyword=" + encodeURIComponent(selectedYear) + "&page=1";
            window.location.href = newUrl;

            yearSelect.value = selectedYear;

        }
    </script>
</head>
<!-- 
------------------------------------------------------------
* 여기서부터 body
------------------------------------------------------------
 -->
<body>
<%@ include file="../common/nav.jsp" %>
<div class="container mt-5 mb-3 px-4">
    <h3 class="fw-bold text-center mb-4">팝콘피디아 영화 검색</h3>
    <form method="get" action="/popcornpedias/movie/movieSearch" class="row gx-2 justify-content-center">
        <div class="col-6">
            <input type="text" name="keyword" placeholder="영화명 / 감독명 / 배우명" class="form-control form-control-lg"
                   required>
        </div>
        <div class="col-1">
            <input type="submit" value="검색" class="btn btn-outline-primary w-100 h-100">
        </div>
    </form>
</div>
<div class="container">
    <div class="buttonWrap">
        <button type="button" onclick="onButtonClicked('판타지')" class="genre btn btn-primary">#판타지</button>
        <button type="button" onclick="onButtonClicked('액션')" class="genre btn btn-primary">#액션</button>
        <button type="button" onclick="onButtonClicked('공포')" class="genre btn btn-primary">#공포</button>
        <button type="button" onclick="onButtonClicked('드라마')" class="genre btn btn-primary">#드라마</button>
        <button type="button" onclick="onButtonClicked('멜로')" class="genre btn btn-primary">#멜로/로맨스</button>
        <button type="button" onclick="onButtonClicked('미스터리')" class="genre btn btn-primary">#미스터리</button>
        <button type="button" onclick="onButtonClicked('스릴러')" class="genre btn btn-primary">#스릴러</button>
        <button type="button" onclick="onButtonClicked('코미디')" class="genre btn btn-primary">#코미디</button>
        <button type="button" onclick="onButtonClicked('애니메이션')" class="genre btn btn-primary">#애니메이션</button>
        <button type="button" onclick="onButtonClicked('SF')" class="genre btn btn-primary">#SF</button>
        <button type="button" onclick="onButtonClicked('다큐멘터리')" class="genre btn btn-primary">#다큐멘터리</button>
        <select id="yearSelect" onchange="onYearSelected()" class="btn btn-primary"
                style="padding:6px 12px; height:38px;">
            <option value="" disabled selected>연도별 영화</option>
        </select>
    </div>

    <div id="resultText" class="fst-italic resultText">
        <c:if test="${not empty total }">
            ${total }개의 검색결과
        </c:if>
        <c:if test="${empty total }">
        </c:if>
    </div>
    <c:choose>
    <c:when test="${empty result}">
        <!-- 처리할 내용 (비어있을 때) -->
        <div class="noResultBox">
            <div class="noResult alert alert-secondary text-center">
                검색 결과가 없습니다. <br>
                <div class="mt-2">띄어쓰기를 확인해주세요.</div>
            </div>
        </div>
        <br>
    </c:when>
    <c:otherwise>
    <!-- 처리할 내용 (비어있지 않을 때) -->
    <div class="container text-center " style="min-height:60vh;">
        <div class="row row-cols-5" id="container">
            <c:if test="${not empty result}">
            <c:forEach items="${result}" var="movie">
            <c:if test="${not empty movie.movieCd }">
            <div class="resultImg col mb-2">
                <a href="${contextPath }/movie/movieInfoInsert.do?movieCd=${movie.movieCd}">
                    <img src="http://image.tmdb.org/t/p/w200${movie.moviePosterPath }" class="rounded">
                    <div>
                        <span class="mb-1 fw-bold">${movie.movieNm }</span><br>
                        <div class="small">
                                ${movie.movieYear } |
                        ${movie.movieDirector }</a><br>
            </div>
        </div>
    </div>
    </c:if>
    </c:forEach>
    </c:if>
</div>
</div>
</table>
</c:otherwise>
</c:choose>


<!-- 페이징을 위한 변수 set -->
<c:if test="${page.endPageNum != 1 }">
    <c:choose>
        <c:when test="${not empty searchMap}">
            <c:set var="pageUrl" value="${contextPath}/movie/movieSearch?num="/>
            <c:set var="pageQuery" value="&searchType=${searchMap.searchType}&keyword=${searchMap.keyword}"/>
        </c:when>
        <c:otherwise>
            <c:set var="pageUrl" value="${contextPath}/movie/movieSearch?num="/>
            <c:set var="pageQuery" value=""/>
        </c:otherwise>
    </c:choose>

    <div class="board-pagination-container mt-4 d-flex justify-content-center">
        <ul class="pagination justify-content-center paging">
            <c:if test="${page.prev}">
                <li class="page-item">
                    <a class="page-link" href="${pageUrl}${page.startPageNum - 1}${pageQuery}">Prev</a>
                </li>
            </c:if>
            <c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
                <li class="page-item">
                    <a class="page-link <c:if test='${selectPageNum == num}'>active</c:if>"
                       href="${pageUrl}${num}${pageQuery}">${num}</a>
                </li>
            </c:forEach>
            <c:if test="${page.next}">
                <li class="page-item">
                    <a class="page-link" href="${pageUrl}${page.endPageNum + 1}${pageQuery}">Next</a>
                </li>
            </c:if>
        </ul>
    </div>
</c:if>
<c:if test="${page.endPageNum == 1  }"><br></c:if>

</div>
<%@ include file="../common/footer.jsp" %>
<%@ include file="../common/common-js.jsp" %>

</body>
</html>