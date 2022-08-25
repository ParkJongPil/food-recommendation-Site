<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adMenu.jsp(관리자메뉴)</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  
  <frameset cols="250px, *" style="text-align:left">
    <frame src="${ctp}/admin/adLeft" name="adLeft" frameborder="0"/>
    <frame src="${ctp}/admin/adContent" name="adContent"  frameborder="0"/>
  </frameset>
  <style>
  head,body{
  	color:black;
  }
  </style>
</head>
<body>
</body>
</html>