<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>qrcode.jsp</title>
  <%@ include file="/WEB-INF/views/include/2bs4.jsp" %>
  <script>
    'use strict';
    
    function qrCreate() {
    	let moveUrl = myForm.moveUrl.value;
    	let restaurantName = myForm.restaurantName.value;
    	
    	$.ajax({
  			type : "post",
  			url  : "${ctp}/admin/qrCreate",
  			data : {
  				moveUrl : moveUrl,
  				restaurantName : restaurantName
  			},
  			success : function(data) {
 					alert("qr코드 생성완료 : "+data);
 					$("#qrCodeView").show();
 					$("#qrView").html(data);
 					var qrImage = '<img src="${ctp}/data/qrCode/'+data+'.png"/>';
 					$("#qrImage").html(qrImage);
				},
				error : function() {
					alert("전송오류!");
				}
			});
		}
  </script>
  <style>
    .btn {
    color: #fff;
    background-color: #ff792a;
    border-color: rgb(0 0 0 / 8%);
  </style>
</head>
<body>
<p><br/></p>
<div class="container">
  <form name="myForm">
	  <h2>QR코드 생성하기</h2>
	  <hr/>
	  <div>
	    <h4>QR코드 체크시 이동할 주소를 입력후 QR코드를 생성해 주세요.</h4>
	    <p>(소개하고 싶은 지역의 홈페이지 주소를 입력하세요.)</p>
	  </div>
	  <p>
	    매장명 :  <input type="text" name="restaurantName">
	  </p>
	  <p>
	    이동할 주소1 : <input type="text" name="moveUrl" value="http://49.142.157.251:9090/javagreenS_pjp/" size="30"/>
	    <input type="button" value="qr코드 생성" onclick="qrCreate()" class="btn btn-primary btn-sm"/>
	  </p>
	  <hr/>
	  <div id="qrCodeView" style="display:none">
	    <h3>생성된 QR코드 확인하기</h3>
	    <div>
		  - 생성된 qr코드명 : <span id="qrView"></span><br/>
		  <span id="qrImage"></span>
		  </div>
	  </div>
  </form>
</div>
<p><br/></p>
</body>
</html>