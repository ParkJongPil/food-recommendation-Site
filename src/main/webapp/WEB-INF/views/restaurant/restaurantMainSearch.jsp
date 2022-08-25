<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>restaurantMainSearch.jsp</title>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/css.css"/>
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>

	<style>
		body{
			color:black;
		}
		/*필터기 스타일  */
		body {font-family: Arial, Helvetica, sans-serif;}
		* {box-sizing: border-box;}
	
	/* Set a style for all buttons */
		button {
		  background-color: #9b9b9b;
		  color: white;
		  margin: 8px 0;
		  border: none;
		  cursor: pointer;
		  width: 100%;
		  opacity: 0.9;
	}
	
		button:hover {
	  	opacity:1;
	}
	
	/* Float cancel and delete buttons and add an equal width */
		.cancelbtn, .deletebtn {
	  	float: left;
	  	width: 50%;
	}
	
	/* Add a color to the cancel button */
		.cancelbtn {
	  	background-color: #ccc;
	  	color: white;
	  	height:60px;
	}
	
	/* Add a color to the delete button */
		.deletebtn {
	  	background-color: #ff792a;
	  	height:60px;
	}
	
	/* Add padding and center-align text to the container */
		.container {
	  	padding: 16px;
	}
	
	/* The Modal (background) */
		.modal {
		  display: none; /* Hidden by default */
		  position: fixed; /* Stay in place */
		  z-index: 1; /* Sit on top */
		  left: 0;
		  top: 0;
		  width: 100%; /* Full width */
		  height: 100%; /* Full height */
		  overflow: auto; /* Enable scroll if needed */
		  background-color: #474e5d;
		  padding-top: 50px;
	}
	
	/* Modal Content/Box */
		.modal-content {
		  background-color: #fefefe;
		  margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
		  border: 1px solid #888;
		  width: 50%; /* Could be more or less, depending on screen size */
	}
	
	/* Style the horizontal ruler */
		hr {
		  border: 1px solid #f1f1f1;
		  margin-bottom: 25px;
		}
	 
	/* The Modal Close Button (x) */
		.close {
		  position: absolute;
		  right: 35px;
		  top: 15px;
		  font-size: 40px;
		  font-weight: bold;
		  color: #f1f1f1;
		}
	
		.close:hover,
		.close:focus {
		  color: #f44336;
		  cursor: pointer;
		}
		
		/* Clear floats */
		.clearfix::after {
		  content: "";
		  clear: both;
		  display: table;
		}
		
		/* Change styles for cancel button and delete button on extra small screens */
		@media screen and (max-width: 300px) {
		  .cancelbtn, .deletebtn {
		     width: 100%;
		  }
		}
	</style>
	
	<script>
		'use strict';
		/* 필터기  */
		// Get the modal
		var modal = document.getElementById('id02');
		
		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
		  if (event.target == modal) {
		    modal.style.display = "none";
		  }
		}
	
	</script>
</head>

<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<p><br/></p>
	<div class="row" style="margin-top:100px">
		<c:if test="${not empty param.tags}"> <!--빈값이 아니면 파라미터로 tags 값 호출  -->
	    <h3><b style="color:orange"></b># ${param.tags} 검색순위</h3>
		</c:if>
		<c:if test="${not empty param.searchString}"> <!--빈값이 아니면 파라미터로 searchString 값 호출  -->
	    <h3><b style="color:orange"></b>' ${param.searchString} '검색순위</h3>
		</c:if>
		<!--필터기  -->
		<button type="submit" onclick="location.href='${ctp}/restaurantFilter';" style="width:700px; height:150px; color: #ffc107; background:transparent;"><i class="fa-solid fa-sliders fa-2x w3-right"></i></button>
	</div>
	<div id="id02" class="modal">
	  <span onclick="document.getElementById('id02').style.display='none'" class="close" title="Close Modal">×</span>
	  <form class="modal-content" method="post">
	    <div class="container" style="padding:50px;">
       <div class="form-group">
	      <div class="form-check">
	        <span class="input-group-text">1인당 가격</span> &nbsp; &nbsp;
			  	<label class="form-check-label">
			    	<input type="radio" class="form-check-input" name="foodPrice" value="만원미만" checked>만원미만 &nbsp; &nbsp;
			    	<input type="radio" class="form-check-input" name="foodPrice" value="1만원대" >1만원대 &nbsp; &nbsp;
			    	<input type="radio" class="form-check-input" name="foodPrice" value="2만원대" >2만원대 &nbsp; &nbsp;
			    	<input type="radio" class="form-check-input" name="foodPrice" value="3만원대" >3만원대
			  	</label>
      		<span class="input-group-text">지역 :</span>
		  		<label class="form-check-label">
		    		&nbsp; <input type="radio" class="form-check-input" name="restaurantAddress" value="서울" checked>서울 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="restaurantAddress" value="인천">인천 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="restaurantAddress" value="대구">대구 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="restaurantAddress" value="부산">부산 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="restaurantAddress" value="제주">제주 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="restaurantAddress" value="대전">대전 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="restaurantAddress" value="광주">광주 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="restaurantAddress" value="울산">울산 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="restaurantAddress" value="세종">세종 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="restaurantAddress" value="경기">경기 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="restaurantAddress" value="강원">강원 &nbsp; &nbsp; &nbsp;
		  		</label>
     			<span class="input-group-text">음식종류 :</span>
		  		<label class="form-check-label">
		    		<input type="radio" class="form-check-input" name="foodCategory" value="한식" checked>한식 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="foodCategory" value="분식">분식 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="foodCategory" value="치킨">치킨 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="foodCategory" value="일식">일식 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="foodCategory" value="중식">중식 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="foodCategory" value="양식">양식 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="foodCategory" value="세계음식">세계음식 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="foodCategory" value="뷔페">뷔페 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="foodCategory" value="카페">카페 &nbsp; &nbsp; &nbsp;
		    		<input type="radio" class="form-check-input" name="foodCategory" value="주점">주점 &nbsp;
		  		</label>
 		   		<p><br/></p>
       		<hr/>
					<div class="form-group">
      			<span class="input-group-text">주차 가능 여부 :</span>
		       	<p><br/></p>
				  	<label class="form-check-label">
					    <input type="radio" class="form-check-input" name="parking" value="OK" checked >OK &nbsp; &nbsp; &nbsp;
					    <input type="radio" class="form-check-input" name="parking" value="NO" >NO
				  	</label>
			 		</div>	
	    
		      <div class="clearfix">
		        <button type="button" onclick="document.getElementById('id02').style.display='none'" class="cancelbtn">취소</button>
		        <button type="button" onclick="filterCheck()" class="deletebtn">적용</button>
		      </div>
				 </div>
			 	</div>	
	    </div>
	  </form>
	</div>
				
				
	<!--필터기 끝-->
	<c:if test="${not empty searchVos}">
		<table class="table table-bordered" style="width:940px;">
			<c:forEach var="vo" items="${searchVos}">
			  <tr>
					<td style="width:400px; padding:30px; background:#eee;">
					  <c:set var="bgImage" value="${fn:split(vo.FSName,'/')}" />
						  <a href="${ctp}/restaurantInfor?restaurantName=${vo.restaurantName}&idx=${vo.idx}">
						 	 <img src="${ctp}/data/foodImages/${bgImage[0]}" width="350px"/>
						  </a>
						  <p><br/></p>
						  <h2 style="text-align:center;"><font color="orange"><b style="font-size:17px;">${vo.restaurantName}</b></font></h2>
				  </td>
					<td class="text-left" style="padding:30px; background:#fff;">
					  - 주소 : <b>${vo.restaurantAddress}</b><br/> 
					  - 음식종류 : <b>${vo.foodCategory}</b><br/> 
					  - 가격 : <b>${vo.foodPrice}</b><br/> 
				  	- 영업시간 : <b>${vo.openingHours}</b><br/> 
					  <c:if test="${empty vo.breakTime}"></c:if> 
					  <c:if test="${not empty vo.breakTime}">
				  		- 쉬는시간 : <b>${vo.breakTime}</b><br/> 
					  </c:if> 
				  		- 주차 가능 여부 : <b>${vo.parking}</b><br/> 
					</td>
				</tr>
			</c:forEach>
		</table>	
		<!-- 블록 페이징 처리 시작 -->
		<div class="text-center">
		  <ul class="pagination justify-content-center">
			  <c:if test="${pageVO.pag > 1}">
			    <li class="page-item"><a href="mainSearch?pag=1&searchString=${searchString}" class="page-link text-secondary">◁◁</a></li>
			  </c:if>
			  <c:if test="${pageVO.curBlock > 0}">
			    <li class="page-item"><a href="mainSearch?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&searchString=${searchString}" class="page-link text-secondary">◀</a></li>
			  </c:if>
			  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
			    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">	
			      <li class="page-item active"><a href="mainSearch?pag=${i}&searchString=${searchString}" class="page-link text-light bg-secondary border-secondary">${i}</a></li>
			    </c:if>
			    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
			      <li class="page-item"><a href='mainSearch?pag=${i}&searchString=${searchString}' class="page-link text-secondary">${i}</a></li>
			    </c:if>
			  </c:forEach>
			  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
			    <li class="page-item"><a href="mainSearch?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&searchString=${searchString}" class="page-link text-secondary">▶</a></li>
			  </c:if>
			  <c:if test="${pageVO.pag != pageVO.totPage}">
			    <li class="page-item"><a href="mainSearch?pag=${pageVO.totPage}&searchString=${searchString}" class="page-link text-secondary">▷▷</a></li>
			  </c:if>
		  </ul>
		</div>
	</c:if>
	<!-- 블록 페이징 처리 끝 -->
			
	<c:if test="${empty searchVos}">
		<table class="table table-bordered" style="width:940px;">
			<tr>
				<td>찾으시는 식당이 없습니다.</td>
			</tr>
		</table>	
	</c:if>
	
	 <input type="hidden" name="pag" value="${pageVO.pag}"/>
	 <input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
	 
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>