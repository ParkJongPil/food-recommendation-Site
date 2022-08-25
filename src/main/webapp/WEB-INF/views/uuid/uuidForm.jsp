<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>uuidFrom.jsp</title>
  <jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
  <script>
  	'use strict';
  	let str = "";
  	let i = 0;
  	
  	function uuidCheck() {
  		$.ajax({
  			type : "post",
  			url  : "${ctp}/uuid/uuidProcess",
  			success:function(res) {
  				i++;
  				str += i + " : " + res + "<br/>";
  				$("#demo").html(str);
  			},
  			error : function() {
  				alert("전송오류!");
  			}
  		});
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
  <h2>UUID에 대하여</h2>
  <p>
    UUID(Universally Unique Identifier)란, 네트워크상에서 고유성이 보장되는 id를 만들기위한 규약<br/>
    32자리의 16진수(128Bit)로 표현된다.<br/>
    표시형식 : 8-4-4-4-12 자리로 표현한다.<br/>
    예 : 550e8400-f124-31d4-a123-3242ek567212
  </p>
  <hr/>
  <p>
    <input type="button" value="UUID생성" onclick="uuidCheck()"/>
  </p>
  <hr/>
  <div>
    출력결과<br/>
    <span id="demo"></span>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>