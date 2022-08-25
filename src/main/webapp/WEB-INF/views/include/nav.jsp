<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script>
	'use strict';
		function memDeleteCheck() {
			let ans = confirm("회원 탈퇴를 하시겠습니까?");
			if(!ans) return false;
			else location.href ="${ctp}/member/memDeleteOk";
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
	  padding:0.5rem 3rem;
	  border-bottom: 1px solid #DBDBDB;
	  box-sizing: border-box;
	  height:90px;
	}
	
	.navbar a {
	  float: right;
	  font-size: 16px;
	  color: #888888;
	  text-align: center;
	  padding: 14px 16px;
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
	  color: #212529;
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
	<div class="navbar w3-white" style="display: block">
	  <div class="subnav">
	  	<c:if test="${not empty sLevel}">
		    <button class="subnavbtn">
			    <i class="fa-solid fa-user"></i>
		    </button>
		    <div class="number" style="text-align:center;">
					<span style="color:white;" onclick="javascript:mainRecent(idx)">
						<button type="button"  class="w3-top" onclick="document.getElementById('id01').style.display='block'" style="border: 0px; border-radius: 50%; color: white; background-color: #ff792a; width:28px;">${rCount}</button>
					<c:if test="${sMid == null}">
						<button type="button" class="w3-top" onclick="document.getElementById('id01').style.display='block'" style="border: 0px; border-radius: 50%; color: white; background-color: #ff792a; width:28px;">0</button>
					</c:if>
					</span>
		    </div>
		    
	    </c:if>
	    <div class="subnav-content" style="color:#888888;">
	      <c:if test="${empty sLevel}">
		    	<a href="${ctp}/member/memLogin"><button type="button" class="subnavbtn">로그인</button></a>
	      </c:if>
				<c:if test="${not empty sLevel}"> 
				   <b><a class="w3-bar-item w3-padding-large w3-hide-small w3-right" href="${ctp}/"><font color="#ffffff"><b>${sNickName}</b></font>님 환영합니다.</a></b><
				   <b><a class="w3-bar-item w3-padding-large w3-hide-small w3-right" href="${ctp}/member/memLogout">로그아웃</a></b>
			   	 <b><a class="w3-bar-item w3-padding-large w3-hide-small w3-right" href="${ctp}/member/memMain">마이 페이지</a></b>
			     <c:if test="${sLevel == 0 || sLevel == 1}">
					   <b><a class="w3-bar-item w3-padding-large w3-hide-small w3-right" href="${ctp}/admin/adMenu">관리자 페이지</a></b>
	         </c:if>
				   <b><a class="w3-bar-item w3-padding-large w3-hide-small w3-right" href="${ctp}/member/memList">회원 목록</a></b>
				   <b><a class="w3-bar-item w3-padding-large w3-hide-small w3-right" href="javascript:memDeleteCheck()">회원탈퇴</a></b>
				   <b><a class="w3-bar-item w3-padding-large w3-hide-small w3-right" href="${ctp}/member/memPwdCheck">회원 정보 변경</a></b>
				</c:if>
	    </div>
	  </div>
		<c:if test="${empty sLevel}">
			<a class="w3-bar-item w3-padding-large w3-hover-none w3-hide-small w3-right" href="${ctp}/member/memLogin"><i class="fa-solid fa-user"></i></a>
		</c:if>
		<a class="w3-bar-item w3-padding-large w3-hover-none w3-hide-small w3-right" style="border-left: 1px solid #dbdbdb;" href="${ctp}/restaurantTopList">맛집 리스트</a>
		<a class="w3-bar-item w3-padding-large w3-hover-none w3-hide-small w3-right" style="border-left: 1px solid #dbdbdb; border-rigtht: 1px solid #dbdbdb" href="${ctp}/notice/noList">공지사항</a>
		<a class="w3-bar-item w3-padding-large w3-hover-none w3-hide-small w3-left"  href="${ctp}/">
			<img alt="" src="${ctp}/images/orangeLogo.png">
		</a>
<!-- 		검색창 구현		 -->
		<div class="w3-row">
			<div class="w3-col m2">
				<img class="w3-left" alt="" src="${ctp}/images/searchIcon.png" style="width: 9%; height: 65%; margin-top: -39px; margin-left: 180px">
			</div>
			<form name="searchForm" method="get" action="${ctp}/mainSearch">
				<div class="w3-col m8" style="margin-left: 223px; margin-top: -64px; width:55%;">
					<input type="text" name="searchString" id="searchInput" class="layerPop" placeholder="지역,식당 또는 음식" style="width: 1060px; height: 82px; border: 0px;">
				</div>
			</form>
		</div>
	</div>
</div>
		
<!-- 		검색창 구현끝		 -->
<div id="id01" class="w3-modal">
  <div class="w3-modal-content w3-border w3-round-xlarge" style="width:540px; margin-right:13px;">
		<table class="table">
		  <tr>
		    <td>
		  		<!--최근 맛집 리스트  -->
		      <div class="w3-container w3-panel w3-border-right">
		        <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-display-topright">&times;</span>
		        <h2>최근 본 맛집</h2>
		        <input type="button" value="X Clear All" onclick="delcheck()" class="btn btn-danger w3-right">
		        <p><br/></p>
		        <c:forEach var="vo" items="${rcVos}">
			        <c:set var="bgImage" value="${fn:split(vo.FSName,'/')}" />
								<a href="${ctp}/restaurantInfor?restaurantName=${vo.restaurantName}&idx=${vo.idx}"><img alt="" src="${ctp}/data/foodImages/${bgImage[0]}" style="width:190px; height:130px;"/></a>
					      <div class="menu">${vo.restaurantName}</div>
					      <div>${vo.foodCategory}</div>
					      <p class="w3-border-bottom"></p>
		        </c:forEach>	
		      </div>
		    </td>
  		<!--즐겨찾기 맛집 리스트  -->
		    <td>
					<div class="w3-container w3-panel">
						<span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-display-topright">&times;</span>
						<h2>즐겨찾기 맛집</h2>
						<p><br/></p>
						<c:forEach var="vo" items="${rcVos2}">
							<c:set var="bgImage" value="${fn:split(vo.FSName,'/')}" />
								<a href="${ctp}/restaurantInfor?restaurantName=${vo.restaurantName}&idx=${vo.idx}"><img alt="" src="${ctp}/data/foodImages/${bgImage[0]}" style="width:190px; height:130px;"/></a>
								<div class="menu">${vo.restaurantName}</div>
								<div>${vo.foodCategory}</div>
				      	<p class="w3-border-bottom"></p>
						</c:forEach>	
					</div>
		    </td>
		  </tr>
		</table>
	</div>
</div>