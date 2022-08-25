<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>kakaomap.jsp</title>
  <jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
	<p><br/></p>
	<div class="container">
	  <h2>KakaoMap API(기본지도)</h2>
	  <hr/>
		<div id="map" style="width:100%;height:500px;"></div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4bdca9fd1682feca5a5acff3304e1e35"></script>
		<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = { 
			        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };
			
			// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
			var map = new kakao.maps.Map(mapContainer, mapOption); 
		</script>
		<hr/>
		<jsp:include page="kakaoMenu.jsp"/>
	  <hr/>
	</div>
	<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>