<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adRestaurantCreate.jsp</title>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/css.css"/>
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
	  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	  <script src="${ctp}/js/woo.js"></script>
	  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	  
	  
	  <script>
	  'use strict';
	  //식당 정보 등록 시 서버로 전송
	  function fCheck() {
	 		/*
	      	let restaurantName =myForm.restaurantName.value;
	    	let restaurantContent = myForm.restaurantContent.value;
	    	let parking = myForm.parking.value;
	      	let tel1 = myForm.tel1.value;
	      	let tel2 = myForm.tel2.value;
	      	let tel3 = myForm.tel3.value;
	      	let tel = myForm.tel1.value + "-" + myForm.tel2.value + "-" + myForm.tel3.value;
	      	
			// 사진 업로드 체크
			let fName = myForm.fName.value;
			let ext = fName.substring(fName.lastIndexOf(".")+1);	// 파일 확장자 식별
			let uExt = ext.toUpperCase();							// 확장자를 대문자로 변환처리
			let maxSize = 1024 * 1024 * 2;							// 업로드 할 회원사진의 최대 용량은 2MByte로 제한함
			
			// 전송전 '주소'를 하나로 묶어서 전송 준비
			let postcode = myForm.postcode.value + " ";
			let roadAddress = myForm.roadAddress.value + " ";
			let detailAddress = myForm.detailAddress.value + " ";
			let extraAddress = myForm.extraAddress.value + " ";
			myForm.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
			
			// 전송전 사진 파일에 관한 사항 체크
			if(fName.trim() == "") {
				myForm.photo.value = "noimage"
			}
			else {
				let fileSize = document.getElementById("file").files[0].size;
				
				if(uExt != "JPG" && uExt != "GIF" && uExt  != "PNG") {
					alert("업로드가 가능한 파일은 'JPG/GIF/PNG'파일입니다.");
					return false;
				}
				else if(fName.indexOf(" ") != -1) {
					alert("업로드 파일명에 공백을 포함할 수 없습니다.");
					return false;
				}
				else if(fileSize > maxSize) {
					alert("업로드 파일의 크기는 2MByte를 초과할 수 없습니다.");
					return false;
				}
			}
			*/
			
			let tel1 = myForm.tel1.value;
	      	let tel2 = myForm.tel2.value;
	      	let tel3 = myForm.tel3.value;
	      	let restaurantNumber = myForm.tel1.value + "-" + myForm.tel2.value + "-" + myForm.tel3.value;
	      	myForm.restaurantNumber.value=restaurantNumber;
			
		  // 전송전 '주소'를 하나로 묶어서 전송 준비
		  let postcode = myForm.postcode.value + " ";
		  let roadAddress = myForm.roadAddress.value + " ";
		  let detailAddress = myForm.detailAddress.value + " ";
		  let extraAddress = myForm.extraAddress.value + " ";
		  myForm.restaurantAddress.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
			
		  myForm.submit();
	  }
	  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
	<div class="container">
		<h2><font color="orange">식당 정보 등록</font></h2>
		<!-- <form name="myForm" method="post" enctype="multipart/form-data"> -->
		<form name="myForm" method="post" class="was-validated" enctype="multipart/form-data">
			<hr/>
			<br/>
			<div class="main" style="width:61.5%">
				<div class="invalid-mid" id="invalid-mid">
					<label for="restaurantName"><b><font color="red">*</font></b>식당명: </label>
					<input type="text" class="form-control" name="restaurantName" id="restaurantName" placeholder="식당명" required autofocus style="width:61.5%;"/>
				</div>
				<p><br/></p>
				<div class="invalid-mid" id="invalid-mid">
					<label for="restaurantContent"><b><font color="red">*</font></b>식당 소개: </label>
					<input type="text" class="form-control" name="restaurantContent" id="restaurantContent" placeholder="식당 소개를 하세요." required style="width:61.5%;"/>
				</div>
				<p><br/></p>
				<div class="form-group">
					<label for="openingHours"><b><font color="red">*</font></b>영업시간 :</label>
					<input type="text" class="form-control" name="openingHours" id="openingHours" placeholder="영업시간" required style="width:61.5%;"/>
				</div>
				<p><br/></p>
				<div class="form-group">
					<label for="breakTime"><b><font color="red">*</font></b>쉬는시간 :</label>
					<input type="text" class="form-control" name="breakTime" id="breakTime" placeholder="쉬는시간" required style="width:61.5%;"/>
				</div>
	 		    <p><br/></p>
				<div class="form-group">
					<label for="regularHoliday"><b><font color="red">*</font></b>정기휴일 :</label>
					<input type="text" class="form-control" name="regularHoliday" id="regularHoliday" placeholder="정기휴일" required style="width:61.5%;"/>
				</div>
	  		    <p><br/></p>
			    <div class="form-group">
			    <label for="restaurantSite">식당 사이트:</label>
			    <input type="text" class="form-control" name="restaurantSite" value="http://" placeholder="홈페이지를 입력하세요." id="restaurantSite" style="width:61.5%;"/>
		  	    </div>
	   		 	<p><br/></p>
		        <div class="form-group">
		        <div class="form-check-inline">
		        	<span class="input-group-text">주차 여부 :</span>
	       			<p><br/></p>
			  		<label class="form-check-label">
			    		<input type="radio" class="form-check-input" name="parking" value="가능" checked >가능
			    		<input type="radio" class="form-check-input" name="parking" value="불가능" >불가능
			  		</label>
			 	</div>
	    		</div>
			 	<p><br/></p>
				<div class="form-group" style="width:62%">
			     	 <div class="input-group mb-3" >
					 	<div class="input-group-prepend">
							  <span class="input-group-text">식당 전화번호 :</span>		 	
							  <p><br/></p>
						      <select name="tel1" class="custom-select">
								    <option value="010" selected>010</option>
								    <option value="서울">02</option>
								    <option value="경기">031</option>
								    <option value="인천">032</option>
								    <option value="충남">041</option>
								    <option value="대전">042</option>
								    <option value="충북">043</option>
							        <option value="부산">051</option>
							        <option value="울산">052</option>
							        <option value="전북">061</option>
							        <option value="광주">062</option>
							  </select>➖
					      </div>
				      <input type="text" name="tel2" size=4 maxlength=4 class="form-control"/>➖
				      <input type="text" name="tel3" size=4 maxlength=4 class="form-control"/>
				    </div> 
  		    </div>
		  	<div class="form-group" style=width:62%>
	      		<label for="restaurantAddress">식당 주소 :</label>
				<input type="hidden" name="restaurantAddress" id="restaurantAddress" value="">
				<div class="input-group mb-1">
					<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
					<div class="input-group-append">
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
					</div>
				</div>
				<input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
				<div class="input-group mb-1">
					<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
					<div class="input-group-append">
						<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
					</div>
				</div>
	    	</div>
			<div class="form-group" style="width:62%">
	      		식당 사진(파일용량:2MByte이내) :
	      		<input type="file" name="file" id="file" class="form-control-file border" multiple />
	   		</div>
			<div class="form-group">
				<!-- <button type="submit" class="create btn-secondary" value="매장등록" style="width:166px;">매장 등록</button> -->
				<button type="button" class="create btn-secondary" value="식당등록" onclick="fCheck()" style= "width:20%;">식당 등록</button>
				<button type="reset"  class="create2 btn-secondary"value="취소" style= "width:20%;">다시 작성</button>
				<button type="button" class="create btn-secondary" value="이전" onclick="location.href='${ctp}/';" style= "width:20%;">돌아가기</button>
				<input type="hidden" name="restaurantNumber"/>
				<input type="hidden" name="photo"/>
			</div>
			</div>	
		</form>
  </div>
<p><br/></p>
			
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>