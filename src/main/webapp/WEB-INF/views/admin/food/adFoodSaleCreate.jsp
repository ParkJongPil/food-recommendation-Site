<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adFoodSaleCreate.jsp</title>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/css.css"/>
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
	
	<script>
	'use strict';
	function fCheck() {
		let restaurantName = document.getElementById("restaurantName").value;
		let foodName = document.getElementById("foodName").value;
		let foodPrice = document.getElementById("foodPrice").value;
		$.ajax({
			type:"post",
			url:"${ctp}/admin/adFoodSaleCreate", 
			data: {
				foodName:foodName,
				restaurantName:restaurantName,
				foodPrice:foodPrice
			},
			success: function(data) {
				alert('식당, 메뉴 등록이 되었습니다.');
				location.reload();
			},
			error : function() {
				alert('전송실패');
			}
		});
	}

	
	</script>
	<style>
	.form-check-inline{
	    align-items: flex-start;
	    flex-direction: column;
	}
	select{
		width:300px;
	}
	.btn-secondary {
    color: #fff;
    background-color: #ff792a;
    border-color: rgb(0 0 0 / 8%);
	}
	</style>
</head>
<body>
<p><br/></p>
	<div class="container">
		<h2><font color="orange">식당 판매 음식 등록</font></h2>
			<div class="form-group">
       	<div class="form-check-inline">
        	<span class="input-group-text">식당명 :</span>
		    	 <select name="restaurantName" id="restaurantName">
	    			<c:forEach var="restaurantName" items="${sVos}">
	    				<option value="${restaurantName}">${restaurantName}</option>
	    			</c:forEach>	
		    	 </select>
	    		<p><br/></p>
        	<span class="input-group-text">음식 카테고리 :</span>
					<select name="foodName" id="foodName">
	    			<c:forEach var="foodName" items="${fVos}">
	    				<option value="${foodName}">${foodName}</option>
	    			</c:forEach>	
			    </select>			 	
        	<p><br/></p>
        	<span class="input-group-text">음식 가격 :</span>
					<select name="foodPrice" id="foodPrice" >
	    			<c:forEach var="foodPrice" items="${fVos2}">
	    				<option value="${foodPrice}">${foodPrice}</option>
    				</c:forEach>
			    </select>			 	
	    	 	</div>
		 		</div>
		 	<p><br/></p>
		 	<div class="form-group">
				<input type="button" class="create btn-secondary" value="등록" onclick="fCheck()" style= "width:166px;">
				<button type="reset"  class="create btn-secondary"value="취소" style= "width:166px;">다시 작성</button>
			</div>
  </div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>