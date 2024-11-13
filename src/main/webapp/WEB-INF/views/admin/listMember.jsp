<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%request.setCharacterEncoding("UTF-8");%>    
<html>
<head>
<meta charset=UTF-8">
<title>팝콘피디아 - 전체 회원 목록</title>
<!-- 공통 css include -->
<%@ include file="../common/common-css.jsp" %>
<link rel="stylesheet" href="<c:url value='/resources/css/listMovie.css'/>" />
<script type="text/javascript">
function confirmDelete(event) {
    var confirmed = confirm("정말 삭제하시겠습니까?");

    // "예"를 눌렀을 때만 URL로 이동
    if (!confirmed) {
        event.preventDefault(); // 기본 동작(링크 이동)을 취소
    }
}
</script>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<h2 class="fw-bold text-center mt-5 mb-1"><a href="${contextPath }/admin/listMember.do">회원 조회</a></h2>
<p class="text-center">현재 테스트버전으로 모든 사람에게 보입니다.</p>
<div class="container">
	<form method="get" action="${contextPath}/admin/searchMember.do" align="center">
		<select name="searchType" class="searchForm">
		    <option value="mid" selected="selected">아이디</option>
		    <option value="nick">닉네임</option>
		    <option value="em">이메일</option>
		</select>
		<input type="text" size="20" name="keyword" class="searchForm">
		<input type="submit" value="검색" class="btn btn-outline-primary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .85rem;"> 
	</form>
	<div class="mt-3 d-flex" style="justify-content: space-between;">
		<div class="align-middle fst-italic mt-4">전체 회원수 : ${total }</div>
		<div class="text-end mb-3">
			<a href="/popcornpedias/admin/memberForm" class="btn btn-primary">회원 추가하기(관리자 테스트용)</a>
		</div>
	</div>
	<table border="1"  align="center"  width="90%" class="table table-border table-hover align-middle">
	    <tr align="center" class="table-light">
	      <td class="border"><b>아이디</b></td>
	      <td class="border"><b>닉네임</b></td>
	      <td class="border"><b>이메일</b></td>
	      <td class="border"><b>성별</b></td>
	      <td class="border" style:height="100px"><b>멤버 이미지</b></td>
	      <td class="border"><b>가입일</b></td>
	      <td class="border"><b>관리</b></td>
		</tr>   
		<c:forEach var="member" items="${membersList}" >     
		<tr align="center">
	      <td class="border">${member.member_id}</td>
	      <td class="border">${member.nickname}</td>
	      <td class="border">${member.email}</td>
	      <td class="border">
		      <c:if test="${member.gender eq 0}">남자</c:if>
		      <c:if test="${member.gender eq 1}">여자</c:if>
		      <c:if test="${member.gender eq 2}">선택안함</c:if>
	      </td>
	      <td class="border">
	      	<c:if test="${not empty member.memberImgName }"><img src="/popcornpedia/resources/images/member/${member.memberImgName}"></c:if>
	      	<c:if test="${empty member.memberImgName }"><img src="/popcornpedia/resources/images/common/default-profile.png" width="30px"></c:if>
	      </td>
	      <td class="border">${member.joinDate}</td>
	      <td class="border">
	      	<a href="${contextPath}/admin/updateMemberForm.do?member_id=${member.member_id }" class="btn btn-secondary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .85rem;">수정</a> 
	      	<a href="${contextPath}/admin/deleteMember.do?member_id=${member.member_id }" class="btn btn-danger" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .85rem;" onclick="confirmDelete(event)">삭제</a>
	      </td>
	    </tr>
	  </c:forEach>   
	</table>
	
	<!-- 페이징을 위한 변수 set -->
<c:choose>
	<c:when test="${not empty searchMap}">
		<c:set var="pageUrl" value="${contextPath}/admin/searchMember?num="/>
		<c:set var="pageQuery" value="&searchType=${searchMap.searchType}&keyword=${searchMap.keyword}"/>
	</c:when>
	<c:otherwise>
		<c:set var="pageUrl" value="${contextPath}/admin/listMember.do?num="/>
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
				<a class="page-link <c:if test='${selectPageNum == num}'>active</c:if>" href="${pageUrl}${num}${pageQuery}">${num}</a>
			</li>
		</c:forEach>			
		<c:if test="${page.next}">
			<li class="page-item">
				<a class="page-link" href="${pageUrl}${page.endPageNum + 1}${pageQuery}">Next</a>
			</li>
		</c:if>
	</ul>
</div>
	<div class="mt-5"></div>
</div>
<%@ include file="../common/footer.jsp" %>	
<%@ include file="../common/common-js.jsp" %>	

</body>
</html>
