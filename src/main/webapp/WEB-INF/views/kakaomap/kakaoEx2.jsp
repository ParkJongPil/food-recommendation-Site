<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>kakaoEx2.jsp</title>
  <jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
  <script>
		var address  = '${address}';
		var latitude = '${vo.latitude}';
		var longitude= '${vo.longitude}';
    //alert(address + "/" + latitude + "/" + longitude);
    
    function addressSearch() {
    	address = document.getElementById("address").value;
    	if(address == "") {
    		alert("검색할 지점을 선택하세요.");
    		return false;
    	}
    	location.href = "${ctp}/study/kakaoEx2?address="+address;
    }
    
    // 지점 삭제처리
    function addressDelete() {
    	address = document.getElementById("address").value;
    	if(address == "") {
    		alert("검색할 지점을 선택하세요.");
    		return false;
    	}
    	var ans = confirm("선택하신 지역명을 DB에서 삭제하시겠습니까?");
    	if(!ans) return false;
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/study/kakaoEx2Delete",
    		data : {address : address},
    		success:function() {
    			alert("DB에 저장된 지역명이 삭제되었습니다.");
    			location.href="${ctp}/study/kakaoEx2";
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
	  <h2>저장된 지명으로 검색하기</h2>
	  <hr/>
		<div>
		  <form name="myForm" method="post">
		    <div>
		      <font size="4"><b>저장된 지명으로 검색하기</b></font>
		      <select name="address" id="address">
		        <option value="">지명선택</option>
		        <c:forEach var="vo" items="${vos}">
		          <option value="${vo.address}" <c:if test="${vo.address == address}">selected</c:if>>${vo.address}</option>
		        </c:forEach>
		      </select>
		      <input type="button" value="지역검색" onclick="addressSearch()"/>
		      <input type="button" value="지역명DB에서삭제" onclick="addressDelete()"/>
		    </div>
		  </form>
		</div>
	  <hr/>
		<div id="map" style="width:100%;height:600px;"></div>
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
			ps.keywordSearch(address, placesSearchCB); 
	
			// 키워드 검색 완료 시 호출되는 콜백함수 입니다
			function placesSearchCB (data, status, pagination) {
			    if (status === kakao.maps.services.Status.OK) {
	
			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			        // LatLngBounds 객체에 좌표를 추가합니다
			        var bounds = new kakao.maps.LatLngBounds();
							/*
			        for (var i=0; i<data.length; i++) {
			            displayMarker(data[i]);    
			            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
			        }       
							*/
							displayMarker(data[0]);	// 마커플 표시하는 함수를 호출한다.
							
			        bounds.extend(new kakao.maps.LatLng(latitude, longitude));
			        
			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			        map.setBounds(bounds);
			    } 
			}
	
			// 지도에 마커를 표시하는 함수입니다
			function displayMarker(place) {
			    
			    // 마커를 생성하고 지도에 표시합니다
			    var marker = new kakao.maps.Marker({
			        map: map,
			        position: new kakao.maps.LatLng(latitude, longitude) 
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