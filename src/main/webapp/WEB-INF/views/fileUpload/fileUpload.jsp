<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>fileUpload.jsp</title>
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
	<div class="container">
  <h2>파일 업로드 연습</h2>
  <form name="myForm" method="post" enctype="multipart/form-data">
  	<p>파일명 :
  		<input type="file" name="fName" id="fName" class="form-control-file border" accept=".jpg,.gif,.png,.zip"/>
  	</p>
  	<p>
  		<input type="submit" value="파일업로드" class="btn btn-secondary"/>
  		<input type="reset" value="다시선택" class="btn btn-danger"/>
  	</p>
  </form>
  </div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>