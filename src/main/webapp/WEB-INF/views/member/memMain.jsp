<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memMain.jsp</title>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/css.css"/>
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
</head>

<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<p><br/></p>
  <div class="container" style="margin-top: 110px; border:1px solid gray; border-radius:20px; background-color: #adb5bd24;">
	  <p><br/></p>
		<h2 style="text-align:center;">마이 페이지</h2>
	 	<hr/>
	  	<p style="font-size: 20px"><font color="blue"><b>${sNickName}</b></font>님 환영합니다.</p>
		<p style="font-size: 20px;">현재 등급 <font color="red"><b>${sStrLevel}</b></font></p>
		<a href="${ctp}/member/memPwdCheck" style="color:black; font-size:20px;"><b>회원 정보 변경</b></a>
	  <p><br/></p>
		<a href="${ctp}/member/memList" style="color:black; font-size:20px;"><b>회원 목록</b></a>
	  <p><br/></p>
		<a href="javascript:memDeleteCheck()" style="color:black; font-size:20px;"><b>회원 탈퇴</b></a>
  </div>
	<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>