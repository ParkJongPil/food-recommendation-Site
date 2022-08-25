<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adFoodCreate.jsp</title>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/css.css"/>
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
	
	<script>
		function fCheck() {
			
		myForm.submit();
		
	}
	</script>
	<style>
		.form-check-inline{
		    flex-direction: column;
		    align-items: flex-start;
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
			<h2><font color="orange">음식 종류 등록</font></h2>
			<form name="myForm" method="post" action="adFoodCreate" class="was-validated">
				<div class="form-group">
	        <div class="form-check-inline">
	        	<span class="input-group-text">음식명 :</span>
	       		<input type="text" name="foodName" autofocus>
	       		<p><br/></p>
      			<span class="input-group-text">음식분류 :</span>
			  		<label class="form-check-label">
			    		<input type="radio" class="form-check-input" name="foodCategory" value="한식">한식 &nbsp;
			    		<input type="radio" class="form-check-input" name="foodCategory" value="분식">분식 &nbsp;
			    		<input type="radio" class="form-check-input" name="foodCategory" value="치킨">치킨 &nbsp;
			    		<input type="radio" class="form-check-input" name="foodCategory" value="일식">일식 &nbsp;
			    		<input type="radio" class="form-check-input" name="foodCategory" value="중식">중식 &nbsp;
			    		<input type="radio" class="form-check-input" name="foodCategory" value="양식">양식 &nbsp;
			    		<input type="radio" class="form-check-input" name="foodCategory" value="세계음식">세계음식 &nbsp;
			    		<input type="radio" class="form-check-input" name="foodCategory" value="뷔페">뷔페 &nbsp;
			    		<input type="radio" class="form-check-input" name="foodCategory" value="카페">카페 &nbsp;
			    		<input type="radio" class="form-check-input" name="foodCategory" value="주점">주점 &nbsp;
			    		<input type="radio" class="form-check-input" name="foodCategory" value="기타">기타 &nbsp;
			  		</label>
			  		<br/>
		  			<span class="input-group-text">음식가격:</span>
	 					<input type="text" name="foodPrice" autofocus>
		 			</div>
			 	</div>
			 	<div class="form-group">
					<button type="button" class="create btn-secondary" value="음식 종류 등록" onclick="fCheck()" style= "width:166px;">음식 종류 등록</button>
					<button type="reset"  class="create2 btn-secondary"value="취소" style= "width:166px;">다시 작성</button>
					<button type="button" class="create btn-secondary" value="이전" onclick="location.href='${ctp}/';" style= "width:160px;">돌아가기</button>
				</div>
			</form>
	  </div>
	<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>