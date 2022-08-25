<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>restaurantInfor.jsp</title>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/css.css"/>
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
	
	<script>
	'use strict';
	function bookMarkCheck(idx) {
		
		$.ajax({
			type:'post',
			url:'${ctp}/bookMarkCheck',
			data:{
				idx : idx
				},
			success:function(data){
					if(data =='0') {
						alert('이미 즐겨찾기 버튼을 클릭하셨습니다!');
					}
					else{
						location.reload();
					}
			},
			error:function() {
				alert('전송오류~');				
			}
		});
	}
	
	</script>
</head>
<style>
	h2{
		margin-left: 10%;
		margin-top: 3%;
	}
</style>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<c:set var="bgImage" value="${fn:split(iVo.FSName,'/')}" />
<div style="width:100%; height:350px; text-align:center; pdding:30px auto; margin-top:100px; background-image: url('${ctp}/data/foodImages/${bgImage[0]}'); "></div>
	<div class="container">
	<p><br/></p>
			<table class="table" style="width:80%; height:400px;">
				<tr style="border:1px solid blue;">
					<td>
						<div class="title" style="font-size:30px; color:black;">${iVo.restaurantName}
							<button type="button" onclick="location.href='${ctp}/review/reviewInput?restaurantName=${iVo.restaurantName}&idx=${iVo.idx}';" style="border:0px; background-color: transparent;">
								<div style=" display:flex; flex-direction:column; align-items:center; font-size:small; margin-left:200px;">
									<i class="fa-solid fa-pen fa-2x"></i> 리뷰쓰기
								</div>
							</button>
							<button type="button" onclick="javascript:bookMarkCheck(${idx})" style="border:0px; background-color: transparent;">
								<div  style="display:flex; flex-direction:column; align-items:center; font-size:small;">
									<c:if test="${iVo.bookMarkOkNo == 'NO'}">
										<i class="fa-solid fa-star fa-2x"></i>가고싶다
									</c:if>
									<c:if test="${iVo.bookMarkOkNo != 'NO'}">
										<font color="orange">
											<i class="fa-solid fa-star fa-2x">
											</i><br/>가고싶다 
										</font>
									 </c:if>
									</div>
								</button>
							</div>
					  	<div style="display:flex; justify-content:flex-start;"> 
						  	<div style="font-size:16px; color:black;"><i class="fa-solid fa-eye"> ${iVo.readNum} </i></div>
						  	<div style="font-size:16px; color:black; margin-left:3%;"><i class="fa-solid fa-pencil"> ${reviewCnt} </i></div>
					  		<div style="font-size:16px; color:black; margin-left:3%;"><i class="fa-solid fa-star"> ${iVo.bookMark} </i></div>
					  	</div>
					  	<hr/>
					  	<c:if test="${not empty iVo.restaurantAddress}">
					  		<div style="font-size:16px; color:black;">주소 ${iVo.restaurantAddress}</div>
					  	</c:if>
					  	<c:if test="${empty iVo.restaurantAddress}"></c:if>
					  	
					  	<c:if test="${not empty iVo.restaurantNumber}">
					  		<div style="font-size:16px; color:black;">전화번호 ${iVo.restaurantNumber}</div>
					  	</c:if>
					  	<c:if test="${empty iVo.restaurantNumber}"></c:if>
					  	
					  	<c:if test="${not empty iVo.foodCategory}">
						  	<div style="font-size:16px; color:black;">음식 종류 ${iVo.foodCategory}</div>
					  	</c:if>
					  	<c:if test="${empty iVo.foodCategory}"></c:if>
					  	
					  	<c:if test="${not empty iVo.foodPrice}">
					  		<div style="font-size:16px; color:black;">가격대 ${iVo.foodPrice}</div>
					  	</c:if>
					  	<c:if test="${empty iVo.foodPrice}"></c:if>
						
					  	<c:if test="${not empty iVo.parking}">
					  		<div style="font-size:16px; color:black;">주차 ${iVo.parking}</div>
					  	</c:if>
					  	<c:if test="${empty iVo.parking}"></c:if>
					  	
					  	<c:if test="${not empty iVo.openingHours}">
					  		<div style="font-size:16px; color:black;">영업시간 ${iVo.openingHours}</div>
					  	</c:if>
					  	<c:if test="${empty iVo.openingHours}">
					  	</c:if>
					  	
					  	<c:if test="${not empty iVo.regularHoliday}">
					  		<div style="font-size:16px; color:black;">휴일 ${iVo.regularHoliday}</div>
					  	</c:if>
					  	<c:if test="${empty iVo.regularHoliday}">
					  	</c:if>
					  	
					  	<c:if test="${not empty iVo.hashTag}">
					  		<c:set var="tags" value="${fn:split(iVo.hashTag,'#')}"/>
							  <div style="font-size:16px; color:black;">해시태그</div>
							  <c:forEach var="i" begin="0" end="${fn:length(tags)-1}">
							  	<a href="${ctp}/mainSearch?tags=${tags[i]}">#${tags[i]}</a>
							  </c:forEach>
						  </c:if>
						  
					  	<c:if test="${empty iVo.hashTag}"></c:if>
						  
				  		<c:forEach var="mVos" items="${mVos}" varStatus="st">
						  	<div style="font-size:16px; color:black;">메뉴 ${mVos.foodName} ${mVos.foodPrice}</div>
						  </c:forEach>
				  		<c:forEach var="mVos" items="${mVos}" varStatus="st">
				  			<c:if test="${mVos==null}"></c:if>
						  	<div style="font-size:16px; color:black;"></div>
						  </c:forEach>
					  	<div>
					  		 <c:forEach var="img" items="${bgImage}" varStatus="st">
					  		   <img alt="" src="${ctp}/data/foodImages/${img}" style="width:200px; height:200px;" /> &nbsp;
					  		 </c:forEach>
					  	</div>
					  	<hr/>
					  	<p style="text-align:right; font-size:16px; color:black;">업데이트: ${fn:substring(iVo.FDate,0,10)}</p>
					  	<hr/>
					  	<div style="font-size:16px; color:black;">식당 소개 :${iVo.restaurantContent}</div>
					  	<p><br/></p>
	  					<button type="button" class="create btn-secondary" value="이전" onclick="location.href='${ctp}/';" style= "width:160px;">돌아가기</button>
					  	<hr/>
					</td>
				</tr>
			</table>
  	 </div>
		<hr/>
	<!--작성된 리뷰 보여주기  -->
	<div style="width: 800px; margin:400px; margin-top: 20px;  display: flex; flex-direction: column;">
		<header style="width:75%; height:100px; text-align:center; display: flex; justify-content: space-between; margin-bottom:14px; width: 800px; margin: 0 auto;">
			<c:if test="${reviewCnt != 0}">
				<h3 style="font-size: 18px; line-height: 1.2; color: #4F4F4F;">리뷰(${reviewCnt})</h3>
			</c:if>
			<c:if test="${reviewCnt == 0}">
				<h3 style="font-size: 18px; line-height: 1.2; color: #4F4F4F;">리뷰(0)</h3>
			</c:if>
			<ul style="list-style: none; display:flex;">
				<c:if test="${reviewCnt != 0}">
					<li>
						<button style="appearance: none; cursor: pointer; border: 0px; border-radius: 0; background-color: transparent; padding-right: 3px; font-size: 16px; color: #9b9b9b;">전체(${reviewCnt}) |</button>
					</li>
				</c:if>
				<c:if test="${reviewCnt != 0}">
					<li>
						<button style="appearance: none; cursor: pointer; border: 0px; border-radius: 0; background-color: transparent; padding-right: 3px; font-size: 16px; color: #9b9b9b;">맛있다(${reviewCntVo.gradeA}) |</button>
					</li>
				</c:if>
				<c:if test="${reviewCnt != 0}">
					<li>
						<button style="appearance: none; cursor: pointer; border: 0px; border-radius: 0; background-color: transparent; padding-right: 3px; font-size: 16px; color: #9b9b9b;">괜찮다(${reviewCntVo.gradeB}) |</button>
					</li> 
				</c:if>
				<c:if test="${reviewCnt != 0 }">
					<li>
						<button style="appearance: none; cursor: pointer; border: 0px; border-radius: 0; background-color: transparent; padding-right: 3px; font-size: 16px; color: #9b9b9b;">별로(${reviewCntVo.gradeC})</button>
					</li>
				</c:if>
			</ul>
		</header>
		
		<ul style="list-style:none">
			<li style="list-style:none; text-align:center;">
				<a>
				<!--작성된 리뷰가 없을때 -->
				<c:if test="${reviewCnt == 0}">
					<b>
					<span style="font-size: 21px; line-height: 1.4; color: #999">
						아직 작성된 리뷰가 없네요.<br/>
					</span>
					</b>
					<span style="line-height: 1.4; color: #999;">앱에서 해당 식당의 첫 리뷰를 작성해주시겠어요?</span>
				</c:if>
				
				<!--작성된 리뷰가 있을때  -->
				<c:if test="${reviewCnt != 0}">
					<c:forEach var="vo" items="${rVos}">
						<div style="width:100%; height: 120px;  ">
							<div style=" width:10%;float:left; margin-top:20px">
								<span class="w3-left">${vo.mid} </span>
							</div>
							<div style="width:75%;  text-align:center;  float:left;">
								<div style="height:10%; margin-top:20px; color:#9B9B9B;">
										${fn:substring(vo.FDate,0,10)}
								</div>
								<div style="height:90%;">	
										${vo.restaurantContent}
									<hr/>
								</div>		
							</div>
							<c:if test="${vo.grade == 'A'}">
								<div style="float:left; width:15%; ">
									<img src="${ctp}/images/good.png" ><br/>
									<span style="font-size: 15px; color: #ff792a;">맛있다</span>
								</div>
							</c:if>
							<c:if test="${vo.grade == 'B'}">
								<div style=" float:left; width:15%">
									<img src="${ctp}/images/soso.png"><br/>
									<span style="font-size: 15px; color: #ff792a;">괜찮다</span>
								</div>
							</c:if>
							<c:if test="${vo.grade == 'C'}">
								<div style="float:left; width:15%">
									<img src="${ctp}/images/bad.png"><br/>
									<span style="font-size: 15px; color: #ff792a;">별로</span>
								</div>
							</c:if>
						</div>
					</c:forEach>
				</c:if>
				</a>
			</li>
		</ul>
	</div>	


<div id="map" style="border:1px solid blue; width:350px; height:410px; margin-left:80%; margin-top:-32.8%;">
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4bdca9fd1682feca5a5acff3304e1e35"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
/* 		        center: new kakao.maps.LatLng(36.635094996846895, 127.4595267180685), // 지도의 중심좌표 */
		        center: new kakao.maps.LatLng(${kVo.latitude}, ${kVo.longitude}), // 지도의 중심좌표
		        
		        level: 2 // 지도의 확대 레벨
		    };
		
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
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
		    message += '&nbsp; <input type="button" value="처음위치로복귀" onclick="location.reload();"/><br/>';
		    message += '<p>선택한 지점의 장소명 : <input type="text" name="address"/> &nbsp;';
		    message += '<input type="button" value="장소저장" onclick="addressCheck('+latlng.getLat()+','+latlng.getLng()+')"/>';
		    
		    //var resultDiv = document.getElementById('clickLatlng'); 
		    //resultDiv.innerHTML = message;
		    document.getElementById("clickPoint").innerHTML = message;
		});
		
	</script>
</div>
  	 
</body>
</html>