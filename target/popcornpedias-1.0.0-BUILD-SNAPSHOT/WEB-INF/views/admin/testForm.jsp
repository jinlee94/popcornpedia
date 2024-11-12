<%@page import="org.springframework.web.servlet.ModelAndView"%>
<%@page import="com.popcornpedia.member.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
    
<%!
	String action,member_id, pwd, readonly,nickname,email,pic,gender,joinDate, checked;	
%>
<%
	
	MemberDTO dto =(MemberDTO) request.getAttribute("memberDTO");
	if(dto != null){
		action = "/popcornpedia/admin/updateMember.do";
		member_id = "value=" +dto.getMember_id();
		readonly = "readonly style='background-color:#dfdfdf;'";
		nickname = "value="+dto.getNickname();
		email = "value=" +dto.getEmail();
		pic = "value=" +dto.getMemberImgName();
		gender = dto.getGender();
		joinDate = "value="+dto.getJoinDate();
		checked ="checked";
	}
	else{
		action = "/popcornpedia/admin/insertMember.do";
		member_id = "";
		pwd="";
		readonly = "";
		nickname = "";
		email = "";
		gender= "";
		pic = "";
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정 페이지</title>
<!-- 공통 css include -->
<%@ include file="../common/common-css.jsp" %>
<link rel="stylesheet" href="<c:url value='/resources/css/listMovie.css'/>" />
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="container mt-5 mb-3">
	<form method="post" action="<%=action %>">
		<h3 align="center" style="margin-top:20px;">
		<%if(dto == null){%>
		회원 추가페이지
		<%}else{%>
		회원정보 수정 페이지
		<%} %>
		</h3>
		<table class="table align-middle tb-input text-center mt-3 mb-3" style="width:370px; align:center; margin:0px auto">
		   <tr>
		      <td align="right">아이디</td>
		     <td><input type="text" maxlength="20" placeholder="최대 20자" name="member_id"<%=member_id %> <%=readonly %>></td>
		   </tr>
		   
		   <tr>
		      <td align="right">비밀번호</td>
		     <td><input type="password" maxlength="20" placeholder="<%if(dto==null){ %>최대 20자<%} else{ %>수정 불가<%} %>" name="pwd" <%=readonly %>></td>
		    </tr>
		    <tr>
		       <td><p align="right">닉네임</td>
		      <td><p><input type="text" maxlength="20" placeholder="최대 20자" name="nickname"<%=nickname %>></td>
		    </tr>
		    <tr>
		      <td><p align="right">이메일</td>
		       <td><p><input type="text" maxlength="40" placeholder="email@gmail.com" name="email"<%=email %>></td>
		    </tr>
		    <tr>
		    	<td><p align="right">성별</td>
		     	<td>
		     	<p>
		     	<% if(gender != null){
		     		if(gender.equals("0")){
		     		%>
		     	<input type="radio" name="gender" value="0" <%=checked %>> 남자
		     	<input type="radio" name="gender" value="1"> 여자
		     	<input type="radio" name="gender" value="2"> 선택안함
		     	<%} 
		     	else if(gender.equals("1")){%>
		     	<input type="radio" name="gender" value="0" > 남자
		     	<input type="radio" name="gender" value="1" <%=checked %>> 여자
		     	<input type="radio" name="gender" value="2"> 선택안함
		     	<%}else{%>
		     	<input type="radio" name="gender" value="0" > 남자
		     	<input type="radio" name="gender" value="1"> 여자
		     	<input type="radio" name="gender" value="2" <%=checked %>> 선택안함	
		     	<%} 
		     	}%>
		     	</td>
		    </tr>
		    <input type="hidden" <%=pic %> name ="image_original">
		    <tr>
		       <td><p>&nbsp;</p></td>
		       <td><input type="submit" value="<%if(dto==null){ %>가입하기<%} else{%>수정하기<%}%>" class="btn btn-primary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .85rem;"> <input type="reset" value="다시입력" class="btn btn-secondary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .85rem;"></td>
		    </tr>
		</table>
	</form>
	<br><h4 align="center"><a href="/popcornpedia/admin/listMember.do" class="btn btn-primary">전체 회원 조회</a></h4>
</div>

<%@ include file="../common/footer.jsp" %>	
<%@ include file="../common/common-js.jsp" %>	

</body>
</html>