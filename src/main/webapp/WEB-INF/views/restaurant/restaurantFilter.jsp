<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>restaurantFilter.jsp</title>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/css.css"/>
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>

	<style>
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
	</style>
	
	<script>
		'use strict';
		
		function filterCheck() {
			let foodCategory = document.myForm.foodCategory.value;
			let foodPrice= document.myForm.foodPrice.value;
			let restaurantAddress= document.myForm.restaurantAddress.value;
			let parking = document.myForm.parking.value;
			
			alert(foodCategory+','+foodPrice+','+restaurantAddress+','+parking);
			
	 		location.href='${ctp}/filterSearch?foodCategory='+foodCategory+'&foodPrice='+foodPrice+'&restaurantAddress='+restaurantAddress+'&parking='+parking; 
	  }
	</script>
</head>

<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<p><br/></p>
	<div class="container" style="margin-left:25%; margin-top:2%;" >
	
		<!--필터기  -->
		<form class="modal-content" name="myForm" method="get" action="mainSearch" style="margin-top: 11%; border:0px;">
	    <div class="container" style="padding:50px;">
	      <div class="form-group">
			    <div class="form-check">
			      <span class="input-group-text">1인당 가격</span> &nbsp; &nbsp;
						<label class="form-check-label">
					  	&nbsp; <input type="radio" class="form-check-input" name="foodPrice" id="foodPrice" value="1만원미만" checked>1만원미만 &nbsp; &nbsp;
					  	<input type="radio" class="form-check-input" name="foodPrice" value="1만원대" >1만원대 &nbsp; &nbsp;
					  	<input type="radio" class="form-check-input" name="foodPrice" value="2만원대" >2만원대 &nbsp; &nbsp;
					  	<input type="radio" class="form-check-input" name="foodPrice" value="3만원대" >3만원대
						</label>
					  <p><br/></p>
	        	<hr/>
	       		<span class="input-group-text">지역 :</span>
				  	<label class="form-check-label">
				    	&nbsp; &nbsp; &nbsp; <input type="radio" class="form-check-input" name="restaurantAddress" id="restaurantAddress" value="서울" checked>서울 &nbsp; &nbsp; &nbsp;
				    	<input type="radio" class="form-check-input" name="restaurantAddress" value="인천">인천 &nbsp; &nbsp; &nbsp;
				    	<input type="radio" class="form-check-input" name="restaurantAddress" value="제주">제주 &nbsp; &nbsp; &nbsp;
				    	<input type="radio" class="form-check-input" name="restaurantAddress" value="대구">대구 &nbsp; &nbsp; &nbsp;
				    	<input type="radio" class="form-check-input" name="restaurantAddress" value="강릉">강릉 &nbsp; &nbsp; &nbsp;
				    	<input type="radio" class="form-check-input" name="restaurantAddress" value="광주">광주 &nbsp; &nbsp; &nbsp;
				    	<input type="radio" class="form-check-input" name="restaurantAddress" value="경주">경주 &nbsp; &nbsp; &nbsp;
				    	<input type="radio" class="form-check-input" name="restaurantAddress" value="삼척">삼척 &nbsp; &nbsp; &nbsp;
				    	<input type="radio" class="form-check-input" name="restaurantAddress" value="경기">경기 &nbsp; &nbsp; &nbsp;
				  	</label>
				  	<p><br/></p>
	        	<hr/>
	        	<span class="input-group-text">음식종류 :</span>			  		
						<label class="form-check-label">
				    	&nbsp; &nbsp; &nbsp; <input type="radio" class="form-check-input" name="foodCategory" id="foodCategory" value="한식" checked>한식 &nbsp; &nbsp; &nbsp;
				    	<input type="radio" class="form-check-input" name="foodCategory"  value="일식" >일식 &nbsp; &nbsp; &nbsp;
				    	<input type="radio" class="form-check-input" name="foodCategory"  value="중식" >중식 &nbsp; &nbsp; &nbsp;
				    	<input type="radio" class="form-check-input" name="foodCategory"  value="양식" >양식 &nbsp; &nbsp; &nbsp;
				    	<input type="radio" class="form-check-input" name="foodCategory"  value="세계음식">세계음식 &nbsp; &nbsp; &nbsp;
				    	<input type="radio" class="form-check-input" name="foodCategory"  value="뷔페" >뷔페 &nbsp; &nbsp; &nbsp;
				    	<input type="radio" class="form-check-input" name="foodCategory"  value="카페" >카페 &nbsp; &nbsp; &nbsp;
				    	<input type="radio" class="form-check-input" name="foodCategory"  value="주점" >주점 &nbsp; &nbsp; &nbsp;
				    	<input type="radio" class="form-check-input" name="foodCategory"  value="기타" >기타 &nbsp; &nbsp; &nbsp;
				  	</label>
	   		   	<p><br/></p>
	        	<hr/>
						<div class="form-group">
		        	<span class="input-group-text">주차 가능 여부 :</span>
				     	<p><br/></p>
							<label class="form-check-label">
						  &nbsp; &nbsp; &nbsp; <input type="radio" class="form-check-input" name="parking" id="parking" value="OK" checked >OK &nbsp; &nbsp; &nbsp;
						  <input type="radio" class="form-check-input" name="parking" value="NO" >NO
							</label>
					 	</div>	
					</div>
			 	</div>	
	    
	      <div class="clearfix">
	        <button type="button" onclick="javascript:filterCheck()">적용</button>
	        <button type="button" onclick="location.href=${ctp}/" class="cancelbtn">취소</button>
	      </div>
	    </div>
		</form>
	</div>
	<!--필터기 끝-->
			
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>