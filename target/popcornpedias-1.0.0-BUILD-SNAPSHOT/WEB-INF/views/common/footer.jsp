<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<footer id="footer" class="py-5">
	<div class="container gx-0 d-flex justify-content-between align-items-start">
	    <div class="footer-info-container col xsmall">
	      <ul class="d-flex mb-3 fw-bold">
	        <li><a href="#">개인정보처리방침</a></li>
	        <li><a href="#">서비스 이용약관</a></li>
	        <li><a href="#">회사 안내</a></li>
	      </ul>
	      <div>
	        <ul class="d-flex mb-2">
	          <li>(주) 팝콘피디아</li>
	          <li>대표자: 대장팝콘</li>
	          <li>사업자번호: 000-20-23922</li>
	        </ul>
	        <ul class="d-flex mb-2">
	          <li>전화번호: 010-1234-5678</li>
	          <li>주소: 경상남도 창원시 마산회원구 양덕북12길 113 경민인터빌 407호</li>
	        </ul>
	        <div class="d-flex justify-content-start align-items-center">
	        	<a class="footer-logo d-flex justify-content-end me-2" href="${contextPath}/movie/mainMovie"><img src="${contextPath}/resources/images/common/logo-w.png" class="w-100 opacity-50" alt="logo"></a>
	        	<p>© 2023 popcornpedia. All rights reserved.</p>
	        </div>
	      </div>
	    </div>
	    <div class="footer-familysites-container col-2">
	    	<div class="dropdown d-flex justify-content-end">
					<button class="btn btn-sm btn-outline-light dropdown-toggle" type="button" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">
							패밀리 사이트
					</button>
					<div class="dropdown-menu">
						<ul>
							<li class="list-group-item"><a href="https://www.kofic.or.kr/kofic/business/main/main.do" class="dropdown-item" target="_blank">영화진흥위원회</a></li>
							<li class="list-group-item"><a href="https://www.cgv.co.kr/" class="dropdown-item" target="_blank">CGV</a></li>
							<li class="list-group-item"><a href="https://www.lottecinema.co.kr/NLCHS" class="dropdown-item" target="_blank">롯데시네마</a></li>
							<li class="list-group-item"><a href="https://www.megabox.co.kr/" class="dropdown-item" target="_blank">메가박스</a></li>
						</ul>
					</div>
	    	</div>
	    </div>
	</div>
</footer>