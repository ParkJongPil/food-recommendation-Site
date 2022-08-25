<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>kakaoEx3.jsp</title>
  <jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
  <script>
		var address = '${address}';
    
    function addressSearch() {
    	address = document.getElementById("address").value;
    	if(address == "") {
    		alert("검색할 지점을 선택하세요.");
    		return false;
    	}
    	location.href = "${ctp}/study/kakaoEx3?address="+address;
    }
    
  </script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
	<p><br/></p>
	<div class="container">
	  <h2>지명으로 검색하기(키워드로 장소 검색)</h2>
	  <hr/>
		<p>주소입력 :
		  <input type="text" name="address" id="address" autofocus onkeypress="if(event.keyCode==13){addressSearch();}" />
		  <input type="button" value="검색" onclick="addressSearch()" class="btn btn-success btn-sm" /> &nbsp;
		  / 검색한주소 : <font color="blue"><b>${address}</b></font>
		</p>
	  <hr/>
		<div id="map" style="width:100%;height:500px;"></div>
		<hr/>
		<jsp:include page="kakaoMenu.jsp"/>
		
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4bdca9fd1682feca5a5acff3304e1e35&libraries=services"></script>
		<script>
			// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
			var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = { 
			        center: new kakao.maps.LatLng(36.635094996846895, 127.4595267180685), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };
			
			// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 장소 검색 객체를 생성합니다
			var ps = new kakao.maps.services.Places(); 
	
			// 키워드로 장소를 검색합니다
			ps.keywordSearch('${address}', placesSearchCB); 
	
			// 키워드 검색 완료 시 호출되는 콜백함수 입니다
			function placesSearchCB (data, status, pagination) {
			    if (status === kakao.maps.services.Status.OK) {
	
			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			        // LatLngBounds 객체에 좌표를 추가합니다
			        var bounds = new kakao.maps.LatLngBounds();
							
			        for (var i=0; i<data.length; i++) {
			            displayMarker(data[i]);    
			            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
			        }       
			        
			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			        map.setBounds(bounds);
			    } 
			}
	
			// 지도에 마커를 표시하는 함수입니다
			function displayMarker(place) {
			    
			    // 마커를 생성하고 지도에 표시합니다
			    var marker = new kakao.maps.Marker({
			        map: map,
			        position: new kakao.maps.LatLng(place.y, place.x) 
			    });
	
			    // 마커에 클릭이벤트를 등록합니다
			    kakao.maps.event.addListener(marker, 'click', function() {
			        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
			        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
			        infowindow.open(map, marker);
			    });
			}
		</script>
		
	  <hr/>
	</div>
	<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>