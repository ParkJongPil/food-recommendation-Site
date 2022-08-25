<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>noList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
  <script>
    'use strict';
    
  </script>

</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
  <h1 style="text-align:center; font-size: 1.8rem; color: #ff792a; margin-bottom: 30px; line-height: 2rem;">공지사항</h1>
	  <ul style="list-style: none; width:1600px; height:100px;">
		  <li style="list-style: none;">
			  <c:forEach var="vo" items="${nVos}">
				  <div>
				  ${vo.noticeTitle}
				  	<br/>
				  	<span style="color: #cbcbcb; font-size: .7rem;">${fn:substring(vo.NDate,0,10)}</span>
				  </div>
				  <div>
				  	<p>${vo.noticeContent}</p>
				  </div>
				  <hr/>
				 </c:forEach>
		  <li>
	  </ul>
</div>

<p><br/></p>
</body>
</html>