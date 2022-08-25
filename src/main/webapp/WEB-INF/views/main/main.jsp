<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Main.jsp</title>
 	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
	
	<style>
	 #searchInput{
	 	border:none;
	 	border-right: 0px;
	 	border-top: 0px;
	 	border-left: 0;
	 	border-bottom: 0px;
	 	width: 400px;
	 	height: 38px;
	 }
	 
	 #searchInput:focus{ outline:none;}
	 
	 *{
	 margin:0px;
	 }

	 #searchSubmit{
	 	background-color: #ff7100;
	 	color:#ffffff;
	 }
	</style>
	<script type="text/javascript">
		'use strict';
		$(function(){
			$("#searchInput").click(function(){
				$("#searchTab").slideDown();
			});
		})
		
		$('html').click(function(e){
			if($(e.target).parents('.layerPop').length < 1){
	    		$("#searchTab").slideUp();
        }
    });

		function openCity(evt, cityName) {
		  var i, x, tablinks;
		  x = document.getElementsByClassName("city");
		  for (i = 0; i < x.length; i++) {
		    x[i].style.display = "none";
		  }
		  tablinks = document.getElementsByClassName("tablink");
		  for (i = 0; i < x.length; i++) {
		    tablinks[i].className = tablinks[i].className.replace(" w3-border-orange", "");
		  }
		  document.getElementById(cityName).style.display = "block";
		  evt.currentTarget.firstElementChild.className += " w3-border-orange";
		}

		
	  function popupCheck() {
		  <c:forEach var="popup" items="${popupVos}"> /* main컨트롤러에서 popupSw가 'Y'인 자료만 보내준다. */
		  	var url = "${ctp}/notice/popup?idx=${popup.idx}";
		  	openPopup(url,${popup.idx});
		  </c:forEach>
	  }
	  
	  var xPos = 0;
	  function openPopup(url,idx) {
		  xPos += 100;
		  var cookieCheck = getCookie("popupYN"+idx);
		  if(cookieCheck != "N") {
		  	window.open(url,"","width=400,height=600,left="+xPos+",top=5");
		  }
	  }
	 
	  function getCookie(name) {
		  var cookie = document.cookie;  // 클라이언트에 저장된 쿠키의 정보를 읽어(가져)온다.
		  if(cookie != "") {
			  var cookieArray = cookie.split("; ");
			  for(var index in cookieArray) {
				  var cookieName = cookieArray[index].split("=");
				  if(cookieName[0] == name) {
					  return cookieName[1];
				  }
			  }
		  }
		  return;
	  }

  // 검색기 처리
    function searchCheck() {
    	let searchString = $("#searchInput").val();
    	
    	if(searchString.trim() == "") {
    		alert("검색어를 입력하세요!");
    		searchForm.searchString.focus();
    	}
    	else {
    		searchForm.submit();
    	}
    }
  </script>
</head>
<body class="w3-container" onload="javascript:popupCheck()">
<jsp:include page="/WEB-INF/views/include/nav2.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<div class="w3-container w3-top w3-center" style="margin-top: 200px; position:absolute;">
	<h3 style="color:white;"><b>솔직한 리뷰, 믿을수있는 평점! <br> 망고플레이트</b></h3>
	<p><br/></p>
	<div class="w3-border w3-white w3-border-orange w3-round-xxlarge layerPop" id="searchZone" style="width: 35%; height:40px; margin: auto">
		<div class="w3-row">
			<div class="w3-col m2">
				<img class="w3-center" alt="" src="${ctp}/images/searchIcon.png" style="width: 13%; height: 65%; margin-top: 6px; margin-left: 15px">
			</div>
			<form name="searchForm" method="get" action="${ctp}/mainSearch">
				<div class="w3-col m8">
					<input type="text" name="searchString" id="searchInput" class="layerPop" placeholder="지역,식당 또는 음식">
				</div>
				<div class="w3-col m2">
					<input type="button" class="w3-button w3-right w3-round-xxlarge" id="searchSubmit" value="검색" onclick="searchCheck()" style="width:120px;height: 40px;">
				</div>
			</form>
		</div>
		<div class="w3-container w3-white" id="searchTab" style="width: 80%;height:200px; margin: auto;display: none">
				<div class="w3-row">
			    <a href="javascript:void(0)" onclick="openCity(event, 'Paris');">
			      <span class="w3-third tablink w3-bottombar w3-hover-light-gray w3-padding" style="width:50%; color:#495057;">인기 검색어</span>
			    </a>
			    <a href="javascript:void(0)" onclick="openCity(event, 'Tokyo');" style="width:50%;">
			      <span class="w3-third tablink w3-bottombar w3-hover-light-gray w3-padding" style="width:50%; color:#495057;">최근 검색어</span>
			    </a>
			 	</div>
			 <div>
			   <table class="table table-borderless" style="width:100%;">
			     <tr>
			       <td>
			         <!--인기 검색어  -->
							 <c:forEach var="pVo" items="${pVos}" varStatus="st">
								<div id="Paris" class="w3-container">
								  <span>
								  	<a href="${ctp}/mainSearch?searchString=${pVo.keyword}" style="color:#495057">${st.count}. ${pVo.keyword}</a>
								  </span><br/>
								</div>
							 </c:forEach>
			       </td>
			       <td>
			         <!--최근 검색어  -->
							 <c:forEach var="rVo" items="${rVos}" varStatus="st">
								<div id="Tokyo" class="w3-container ">
								  <span>
								  	<a href="${ctp}/mainSearch?searchString=${rVo.keyword}" style="color:#495057">${st.count}. ${rVo.keyword}</a>
								  </span><br/>
								</div>
							 </c:forEach>
			       </td>
			     </tr>
			   </table>
			 </div>
		</div>
	</div>
</div>
<table class="table table-borderless" style="width:100%">
	<tr>
		<td>
			<h4 style="margin-left:2%;"><font color="orange">믿고 보는 맛집 리스트</font></h4>
			<div class="i1" style="width:122%; height:300px;">
				<c:forEach var="vo" items="${fVos}" varStatus="st">
					<c:set var="bgImage" value="${fn:split(vo.FSName,'/')}" />
					<div style="cursor:pointer">
						<div class="i" style=" width:25%; margin-left:42px; height:300px; float:left; background-color:#ffffff; display:flex; flex-direction:column; align-items: center;">
							<a href="${ctp}/restaurantInfor?idx=${vo.idx}&restaurantName=${vo.restaurantName}">
							  <img alt="" src="${ctp}/data/foodImages/${bgImage[0]}" style="width:600px; height:290px; z-index:1; filter: brightness(0.5); margin-right:-20%; "/>
							</a>
							<div style="color:black; text-align:center; margin-top:-35%; z-index:2; font-size: medium; margin-left: 11%; width:100%;">
						  	<span class="title" style="font-size:28px; color:#ffffff; over-flow:hidden;">${vo.restaurantName}</span>
					  		<c:if test="${vo.restaurantContent != null}">
									<p style="font-size:21px; color:#ffffff;" id="show2">${fn:substring(vo.restaurantContent,0,25)}</p>
								</c:if>
								<c:if test="${vo.restaurantContent == null}">
								</c:if>
							</div>
					 	</div>
					</div>
				</c:forEach>
			</div>
		</td>
	</tr>
</table>
<hr/>
<table class="table table-borderless" style="width:100%">
	<tr>
		<td>
			<h4 style="margin-left:2%;"><font color="orange">맛집 스토리</font></h4>
			<div class="i1" style="width:122%; height:300px;">
				<c:forEach var="vo" items="${fVos2}" varStatus="st">
					<c:set var="bgImage" value="${fn:split(vo.FSName,'/')}" />
					<div style="cursor:pointer">
							<div class="i" style=" width:25%; margin-left:42px; height:300px; float:left; background-color:#ffffff; display:flex; flex-direction:column; align-items: center;">
								<a href="${ctp}/restaurantInfor?idx=${vo.idx}&restaurantName=${vo.restaurantName}">
							  	<img alt="" src="${ctp}/data/foodImages/${bgImage[0]}" style="width:600px; height:290px; z-index:1; filter: brightness(0.5); margin-right:-20% "/>
							  </a>
							  <div style="color:black; text-align:center; margin-top:-29%; z-index:2; font-size: medium; margin-left: 3%; width:100%;">
							  	<span class="title" style="font-size:28px; color:#ffffff; over-flow:hidden;">${vo.restaurantName}</span>
							  	<c:if test="${vo.restaurantContent != null}">
										<p style="font-size:22px; color:#ffffff; width:104%;" id="show2">${fn:substring(vo.restaurantContent,0,24)}</p>
									</c:if>
									<c:if test="${vo.restaurantContent == null}">
										<p style="font-size:22px; color:#ffffff; width:104%;" id="show2"></p>
									</c:if>
								 </div>
							 </div>
						</div>					
				</c:forEach>
			</div>
		</td>
	</tr>
</table>
<hr/>
<table class="table table-borderless" style="width:100%">
	<tr>
		<td>
			<h4 style="margin-left:2%;"><font color="orange">에디터가 선정한 식당</font></h4>
			<div class="i1" style="width:122%; height:300px;">
				<c:forEach var="vo" items="${sVos}" varStatus="st">
					<c:set var="bgImage" value="${fn:split(vo.FSName,'/')}" />
					<div style="cursor:pointer">
							<div class="i" style=" width:25%; margin-left:42px; height:300px; float:left; background-color:#ffffff; display:flex; flex-direction:column; align-items: center;">
								<a href="${ctp}/restaurantInfor?idx=${vo.idx}&restaurantName=${vo.restaurantName}">
							  	<img alt="" src="${ctp}/data/foodImages/${bgImage[0]}" style="width:600px; height:290px; z-index:1; filter: brightness(0.5); margin-right:-20% "/>
							  </a>
							  <div style="color:black; text-align:center; margin-top:-29%; z-index:2; font-size: medium; margin-left: 3%; width:100%;">
							  	<span class="title" style="font-size:28px; color:#ffffff; over-flow:hidden;">${vo.restaurantName}</span>
							  	<c:if test="${vo.restaurantContent != null}">
										<p style="font-size:22px; color:#ffffff; width:104%;" id="show2">${fn:substring(vo.restaurantContent,0,24)}</p>
									</c:if>
									<c:if test="${vo.restaurantContent == null}">
										<p style="font-size:22px; color:#ffffff; width:104%;" id="show2"></p>
									</c:if>
								 </div>
							 </div>
						</div>					
				</c:forEach>
			</div>
		</td>
	</tr>
</table>
<hr/>
<table class="table table-borderless" style="width:100%">
	<tr>
		<td>
			<h4 style="margin-left:2%;"><font color="orange">TV에 나온 식당</font></h4>
			<div class="i1" style="width:122%; height:300px;">
				<c:forEach var="vo" items="${sVos2}" varStatus="st">
					<c:set var="bgImage" value="${fn:split(vo.FSName,'/')}" />
					<div style="cursor:pointer">
							<div class="i" style=" width:25%; margin-left:42px; height:300px; float:left; background-color:#ffffff; display:flex; flex-direction:column; align-items: center;">
								<a href="${ctp}/restaurantInfor?idx=${vo.idx}&restaurantName=${vo.restaurantName}">
							  	<img alt="" src="${ctp}/data/foodImages/${bgImage[0]}" style="width:600px; height:290px; z-index:1; filter: brightness(0.5); margin-right:-20% "/>
							  </a>
							  <div style="color:black; text-align:center; margin-top:-29%; z-index:2; font-size: medium; margin-left: 3%; width:100%;">
							  	<span class="title" style="font-size:28px; color:#ffffff; over-flow:hidden;">${vo.restaurantName}</span>
							  	<c:if test="${vo.restaurantContent != null}">
										<p style="font-size:22px; color:#ffffff; width:104%;" id="show2">${fn:substring(vo.restaurantContent,0,24)}</p>
									</c:if>
									<c:if test="${vo.restaurantContent == null}">
										<p style="font-size:22px; color:#ffffff; width:104%;" id="show2"></p>
									</c:if>
								 </div>
							 </div>
						</div>					
				</c:forEach>
			</div>
		</td>
	</tr>
</table>
<hr/>
</body>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</html>
