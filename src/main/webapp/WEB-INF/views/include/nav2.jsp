<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>

<script>
'use strict';
	function memDeleteCheck() {
		let ans = confirm("회원 탈퇴를 하시겠습니까?");
		if(!ans) return false;
		else location.href = "${ctp}/member/memDeleteOk";
	}
	
	/* When the user clicks on the button, 
	toggle between hiding and showing the dropdown content */
	function myFunction() {
	  document.getElementById("myDropdown").classList.toggle("show");
	}

	// Close the dropdown if the user clicks outside of it
	window.onclick = function(event) {
	  if (!event.target.matches('.dropbtn')) {
	    var dropdowns = document.getElementsByClassName("dropdown-content");
	    var i;
	    for (i = 0; i < dropdowns.length; i++) {
	      var openDropdown = dropdowns[i];
	      if (openDropdown.classList.contains('show')) {
	        openDropdown.classList.remove('show');
	      }
	    }
	  }
	}
	
	function delcheck() {
		let ans = confirm("최근 식당 리스트를 전체 삭제 하시겠습니까?");
		if(ans) {
			location.href="${ctp}/recentListDel?size=${rCount}";
		}
	}
</script>

<style>
	body {
	  font-family: Arial, Helvetica, sans-serif;
	  margin: 0;
	}
	
	.navbar {
	  overflow: hidden;
	  background-color:transparent; 
	  height:500px;
	  padding: 0.5rem 3rem;
	  
	}
	
	.navbar a {
	  float: right;
	  font-size: 16px;
	  color: white;
	  text-align: center;
	  text-decoration: none;
	}
	
	.subnav {
	  float:right;
	  overflow: hidden;
	}
	
	.subnav .subnavbtn {
	  font-size: 16px;  
	  outline: none;
	  color: white;
	  background-color: inherit;
	  font-family: inherit;
	  margin-top: 31%;
	  border:0px;
	}
	
	.navbar a:hover, .subnav:hover .subnavbtn {
	  background-color: gray;
	}
	
	.subnav-content {
	  display: none;
	  position: absolute;
	  right: 0;
	  background-color: gray;
	  width: -30%;
	  z-index: 1;
	}
	
	.subnav-content a {
	  color: black;
	  text-decoration: none;
	}
	
	.subnav-content a:hover {
	  background-color: gray;
	  color: black;
	}
	
	.subnav:hover .subnav-content {
	  display: block;
	}
	/*최근 맛집 리스트  */
	.city {display:none}
</style>

<div class="w3-top">
	<div class="navbar" style="display: block">
	  <div class="subnav">
	  	<c:if test="${not empty sLevel}">
		    <button class="subnavbtn">
			    <i class="fa-solid fa-user w3-hover-none"></i>
		    </button>
		    <div class="number" style="text-align:center;">
					<span style="color:white">
					<c:if test="${sMid == null}">
						<button type="button" class="w3-top" onclick="document.getElementById('id01').style.display='block'" style="border: 0px; border-radius: 50%; color: white; background-color: #ff792a; width:28px;">0</button>
					</c:if>
						<button type="button" class="w3-top" onclick="document.getElementById('id01').style.display='block'" style="border: 0px; border-radius: 50%; color: white; background-color: #ff792a; width:28px;">${rCount}</button>
					</span>
		    </div>
	    </c:if>
	    
	    <div class="subnav-content" style="z-indx:99;">
				<c:if test="${empty sLevel}">
					<a href="${ctp}/member/memLogin"><button type="button" class="subnavbtn">로그인</button></a>
				</c:if>
				<c:if test="${not empty sLevel}"> 
					<b><a class="w3-bar-item w3-padding-large w3-hide-small w3-right" href="${ctp}/"><font color="#ffffff"><b>${sNickName}</b></font>님 환영합니다.</a></b>
					<b><a class="w3-bar-item w3-padding-large w3-hide-small w3-right" href="${ctp}/member/memLogout">로그아웃</a></b>
					<b><a class="w3-bar-item w3-padding-large w3-hide-small w3-right" href="${ctp}/member/memMain">마이 페이지</a></b>
				<c:if test="${sLevel == 0 || sLevel == 1}">
					<b><a class="w3-bar-item w3-padding-large w3-hide-small w3-right" href="${ctp}/admin/adMenu">관리자 페이지</a></b>
				</c:if>
					<b><a class="w3-bar-item w3-padding-large w3-hide-small w3-right" href="${ctp}/member/memList">회원 목록</a></b>
					<b><a class="w3-bar-item w3-padding-large w3-hide-small w3-right" href="javascript:memDeleteCheck()">회원 탈퇴 신청</a></b>
					<b><a class="w3-bar-item w3-padding-large w3-hide-small w3-right" href="${ctp}/member/memPwdCheck">회원 정보 변경</a></b>
				</c:if>
	    </div>
	  </div>
		<c:if test="${empty sLevel}">
			<a class="w3-bar-item w3-padding-large w3-hover-none w3-hide-small w3-right" href="${ctp}/member/memLogin"><i class="fa-solid fa-user"></i></a>
		</c:if>
		<a class="w3-bar-item w3-padding-large w3-hover-none w3-hide-small w3-right" href="${ctp}/restaurantTopList">맛집 리스트</a>
		<a class="w3-bar-item w3-padding-large w3-hover-none w3-hide-small w3-right" href="${ctp}/notice/noList">공지사항</a>
		<a class="w3-bar-item w3-padding-large w3-hover-none w3-hide-small w3-left"  href="${ctp}/">
			<img alt="" src="${ctp}/images/logo.png">
		</a>
	</div>
</div>

<!--모달 처리  -->
<div id="id01" class="w3-modal">
  <div class="w3-modal-content w3-border w3-round-xlarge" style="width:540px; margin-right:13px;">
		<table class="table">
		  <tr>
		    <td style="border-top:none;">
		  		<!--최근 맛집 리스트  -->
		      <div class="w3-container w3-panel w3-border-right">
		        <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-display-topright">&times;</span>
		        <h4><b>최근 본 맛집</b></h4>
		        <input type="button" value="X Clear All" onclick="delcheck()" class="btn btn-danger w3-right" style="margin-left: auto; font-size: 12px; color: #dbdbdb;">
		        <p><br/></p>
		        <c:forEach var="vo" items="${rcVos}">
		        <c:set var="bgImage" value="${fn:split(vo.FSName,'/')}" />
							<a href="${ctp}/restaurantInfor?restaurantName=${vo.restaurantName}&idx=${vo.idx}"><img alt="" src="${ctp}/data/foodImages/${bgImage[0]}" style="width:190px; height:130px;"/></a>
				      <div class="menu" style="color:#ff792a"><b>${vo.restaurantName}</b></div>
				      <div>${vo.foodCategory}</div>
				      <p class="w3-border-bottom"><br></p>
		        </c:forEach>	
		      </div>
		    </td>
		    <td style="border-top:none;">
		  		<!--즐겨찾기 맛집 리스트  -->
		      <div class="w3-container w3-panel">
		        <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-display-topright">&times;</span>
		        <h4><b>즐겨찾기 맛집</b></h4>
		        <p><br/></p>
		        <c:forEach var="vo" items="${rcVos2}">
		        <c:set var="bgImage" value="${fn:split(vo.FSName,'/')}" />
							<a href="${ctp}/restaurantInfor?restaurantName=${vo.restaurantName}&idx=${vo.idx}"><img alt="" src="${ctp}/data/foodImages/${bgImage[0]}" style="width:190px; height:130px;"/></a>
				      <div class="menu" style="color:#ff792a"><b>${vo.restaurantName}</b></div>
				      <div>${vo.foodCategory}</div>
 				      <p class="w3-border-bottom"><br></p>
		        </c:forEach>	
		      </div>
		    </td>
		  </tr>
		</table>
	</div>
</div>
<!--모달 끝  -->