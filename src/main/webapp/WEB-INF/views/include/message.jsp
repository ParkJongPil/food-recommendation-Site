<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>message.jsp</title>
  <script>
  	'use strict';
  	let msg= '${msg}';
  	let url= '${ctp}/${url}';
  	
  	alert(msg);
  	location.href= url;
  </script>
</head>
<body>
</body>
</html>