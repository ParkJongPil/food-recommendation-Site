<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <c:set var="ctp" value="${pageContext.request.contextPath}"/>
  <title>kakaoMain.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
    location.href = "${ctp}/member/memKakaoLogin?nickName=${nickName}&mid=${email}";
  </script>
</head>
<body>
	<p><br/></p>
	<div class="container">
	  <h2>이곳은 kakaoMain.jsp 입니다.</h2>
	  <hr/>
	  <p>
	    닉네임 : ${nickname}<br/>메일주소 : ${email}<br/>
	  </p>
	  <hr/>
	  <p>
	    <a href="${ctp}/kakao/kakaoLogout" class="btn btn-danger">Logout</a>
	  </p>
	</div>
	<p><br/></p>
</body>
</html>