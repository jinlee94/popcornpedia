<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
 	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
  request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝콘피디아 - 내 정보</title>
  
</head>
<body>
<%@ include file="../common/common-css.jsp" %>
<%@ include file="../common/nav.jsp" %>


<div class="container mt-5">
 	<div class="card info-card mt-4">
        <div class="card-body">
            <p class="card-text mb-3" style="font-size: 18px; line-height: 1.5;">
                아이디: ${user.member_id }
            </p>
            <p class="card-text mb-3" style="font-size: 18px; line-height: 1.5;">
                닉네임: ${user.nickname }
            </p>
            <p class="card-text mb-3" style="font-size: 18px; line-height: 1.5;">
                이메일: ${user.email }
            </p>
            <p class="card-text mb-3" style="font-size: 18px; line-height: 1.5;">
                <c:choose>
                    <c:when test="${user.gender == 0}">
                        성별: 남자
                    </c:when>
                    <c:when test="${user.gender == 1}">
                        성별: 여자
                    </c:when>
                    <c:otherwise>
                        성별: 선택안함
                    </c:otherwise>
                </c:choose>
            </p>
            <a href="${contextPath }/user/modMyInfo" class="btn btn-primary">내 정보 수정하기</a>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>	
 <%@ include file="../common/common-js.jsp" %>
</body>
</html>