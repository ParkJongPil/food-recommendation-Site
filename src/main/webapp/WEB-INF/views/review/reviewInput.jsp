<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>reviewInput.jsp</title>
  <jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>

</head>
<body>
	<p><br></p>
	<div class="container">
	  <form name="myForm" method="post">
		  <table class="table table-borderless">
		    <tr>
		      <td><h2>리뷰 작성하기</h2></td>
		    </tr>
		  </table>
		  <table class="table">
		    <tr>
		      <th>음식점 이름</th>
		      <td>${restaurantName}</td>
		    </tr>
		    <tr>
		      <th>평가</th>
		      <td>
		      	<input type="radio" name="grade" value="A" checked />맛있다 &nbsp;
		      	<input type="radio" name="grade" value="B"/>괜찮다 &nbsp;
		      	<input type="radio" name="grade" value="C"/>별로
		      </td>
		    </tr>
		    <tr>
		      <th>글쓴이</th>
		      <td>${sMid}</td>
		    </tr>
		    <tr>
		      <th>글내용</th>
		      <td><textarea rows="6" name="restaurantContent" id="CKEDITOR" class="form-control" required></textarea></td>
		      <script>
		      	CKEDITOR.replace("restaurantContent",{
		      		height:500,
		      		filebrowserUploadUrl : "${ctp}/imageUpload",
		      		uploadUrl : "${ctp}/imageUpload"
		      	});
		      </script>
		    </tr>
		    <tr>
		      <td colspan="2" class="text-center">
		        <input type="submit" value="글올리기" class="btn btn-secondary"/> &nbsp;
		        <input type="reset" value="다시입력" class="btn btn-secondary"/> &nbsp;
		        <input type="button" value="돌아가기" onclick="location.href='${ctp}/';" class="btn btn-secondary"/>
		      </td>
		    </tr>
		  </table>
		  <input type="hidden" name="mid" value="${sMid}"/>
		  <input type="hidden" name="tempRestaurantName" value="${param.restaurantName}"/>
		  <input type="hidden" name="restaurantIdx" value="${param.idx}"/>
	  </form>
	</div>
	<br/>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>