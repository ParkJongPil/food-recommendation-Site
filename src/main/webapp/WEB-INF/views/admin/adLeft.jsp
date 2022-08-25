<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adLeft.jsp</title>
  <jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
<script>
    function logoutCheck() {
    	parent.location.href = "${ctp}/member/memLogout";
    }
    function openNav() {
    	  document.getElementById("mySidenav").style.width = "250px";
    	}

    	function closeNav() {
    	  document.getElementById("mySidenav").style.width = "0";
    	}
   	function home() {
		
	}
</script>
<style>
    
    body {
  font-family: "Lato", sans-serif;
  
}

.sidenav {
  height: 100%;
  width: 0;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #ff792a;
  color:white;
  overflow-x: hidden;
  transition: 0.5s;
  padding-top: 60px;
}

.sidenav a {
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 25px;
  color: white;
  display: block;
  transition: 0.3s;
}

.sidenav a:hover {
  color: #f1f1f1;
}

.sidenav .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
    
</style>
</head>
<body>
<br/>
<span style="font-size:25px;cursor:pointer" onclick="openNav()">&#9776; 관리자 메뉴</span>
<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="${ctp}/" target="adContent" onclick="home()">홈으로</a>
  <a href="${ctp}/admin/adMemList" target="adContent">회원 관리</a>
  <a href="${ctp}/admin/adRestaurantList" target="adContent">식당 관리</a>
  <a href="${ctp}/notice/noList" target="adContent">공지사항 관리</a>
  <hr/>
  <a href="${ctp}/notice/noInput" target="adContent">공지사항 등록</a>
  <hr/>
  <a href="${ctp}/admin/adRestaurantCreate" target="adContent">식당 정보 등록</a>
  <a href="${ctp}/admin/adFoodCreate" 			target="adContent">음식 종류 등록</a>
  <a href="${ctp}/admin/adFoodSaleCreate" 	target="adContent">식당 메뉴 등록</a>
  <a href="${ctp}/admin/adAddressName" 			target="adContent">식당 위치 등록</a>
  <hr/>
  <a href="${ctp}/admin/qrCode" 			target="adContent">QR코드 등록</a>
  <a href="${ctp}/admin/googleChart2Recently" 	target="adContent">최근 방문자 분석</a>
  <a href="javascript:logoutCheck()">로그아웃</a>
</div>



</body>
</html>