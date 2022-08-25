<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adAddressName3.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  
  <script>
		var address = '${address}';
    
    function addressSearch() {
    	address = document.getElementById("address").value;
    	if(address == "") {
    		alert("검색할 지점을 선택하세요.");
    		return false;
    	}
    	location.href = "${ctp}/admin/adAddressName3?address="+address;
    }
    
  </script>
  
  <script>
    function addressCheck(latitude,longitude) {
    	var address = document.myForm.address.value;
    	if(address == "") {
    		alert("선택한 지점의 장소명을 입력하세요.");
    		document.myForm.address.focus();
    		return false;
    	}
    	//alert("위도:"+latitude+" 경도:"+longitude+" 장소명:"+address);
    	var query = {
    		address  : address,
    		latitude : latitude,
    		longitude: longitude
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/admin/adAddressName",
    		data : query,
    		success:function(data) {
    			if(data == "1") alert("선택한 지점이 등록되었습니다.");
    			else alert("이미 같은지점이 있습니다. 이름을 변경해서 다시 등록할수 있습니다.");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    	
    }
  </script>
  <style>
  .btn-warning {
    color: #fff;
    background-color: #ff792a;
    border-color: rgb(0 0 0 / 8%);
}
  </style>
</head>
<body>
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
	<div style="color:black">
	  <p>
			<button type="button" class="create btn-warning"  onclick="location.href='${ctp}/admin/adAddressName2';" style= "width:200px;">저장된 지명 검색 & 삭제</button>
			<button type="button" class="create btn-warning"  onclick="location.href='${ctp}/admin/adAddressName3';" style= "width:160px;">지명 검색</button>
			<button type="button" class="create btn-warning"  onclick="location.href='${ctp}/admin/adAddressName';" style= "width:160px;">돌아가기</button>
	  </p>
	</div>
	<div>
		<form name="myForm">
			<div id="clickPoint"></div>
		</form>
	</div>
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
		
		
		
		// 지도를 클릭한 위치에 표출할 마커입니다
		var marker = new kakao.maps.Marker({ 
		    // 지도 중심좌표에 마커를 생성합니다 
		    position: map.getCenter() 
		}); 
		// 지도에 마커를 표시합니다
		marker.setMap(map);
		
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다
		    marker.setPosition(latlng);
		    
		    var message = '클릭한 위치의 위도는 <font color="red">' + latlng.getLat() + '</font> 이고, ';
		    message += '경도는 <font color="red">' + latlng.getLng() + '</font> 입니다';
		    message += '&nbsp; <input type="button" value="처음 위치로 복귀" onclick="location.reload();"/><br/>';
		    message += '<p>선택한 지점의 장소명 : <input type="text" name="address"/> &nbsp;';
		    message += '<input type="button" value="장소 저장" onclick="addressCheck('+latlng.getLat()+','+latlng.getLng()+')"/>';
		    
		    //var resultDiv = document.getElementById('clickLatlng'); 
		    //resultDiv.innerHTML = message;
		    document.getElementById("clickPoint").innerHTML = message;
		});
	</script>
	
  <hr/>
</div>
<p><br/></p>
</body>
</html>