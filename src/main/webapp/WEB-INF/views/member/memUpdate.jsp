<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memUpdate.jsp</title>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/css.css"/>
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
 	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 	<script src="${ctp}/js/woo.js"></script>
 	
	<script>
	'use strict';
  	let nickCheckSw = 0;
  	
    // 회원가입폼 체크후 서버로 전송하기
    function fCheck() {
      let regPwd = /(?=.*[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,20}/;
      let regNickName = /^[가-힣]+$/;
      let regName = /^[가-힣a-zA-Z]+$/;
      let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
      let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
      
      let submitFlag = 0;		// 전송체크버튼으로 값이 1이면 체크완료되어 전송처리한다.
    	
   	  let pwd = myForm.pwd.value;
   	  let nickName = myForm.nickName.value;
   	  let name = myForm.name.value;
   	  let email1 = myForm.email1.value;
   	  let email2 = myForm.email2.value;
      let email = email1 + '@' + email2;
      let tel1 = myForm.tel1.value;
      let tel2 = myForm.tel2.value;
      let tel3 = myForm.tel3.value;
      let tel = myForm.tel1.value + "-" + myForm.tel2.value + "-" + myForm.tel3.value;
    	
   		// 사진 업로드 체크
      let fName = myForm.fName.value;
   	  let ext = fName.substring(fName.lastIndexOf(".")+1);	// 파일 확장자 발췌
   	  let uExt = ext.toUpperCase();		// 확장자를 대문자로 변환
   	  let maxSize = 1024 * 1024 * 2; 	// 업로드할 회원사진의 용량은 2MByte까지로 제한한다.
    	
    	// 기타 추가로 체크해야 할 항목들을 모두 체크하세요.....
   	  if(!regPwd.test(pwd)) {
	 		alert("비밀번호는 1개 이상의 문자와 특수문자 조합의 8~20자리로 작성 가능합니다."); 
        myForm.pwd.focus();
        return false;
      }
      else if(!regNickName.test(nickName)) {
        alert("닉네임은 한글만 사용가능합니다.");
        myForm.nickName.focus();
        return false;
      }
      else if(!regName.test(name)) {
        alert("성명은 한글과 영문대소문자만 사용가능합니다.");
        myForm.name.focus();
        return false;
      }
      else if(!regEmail.test(email)) {
        alert("이메일 형식에 맞지않습니다.");
        myForm.email1.focus();
        return false;
      }
      else {
   	  	submitFlag = 1;
      }
    	
      if(tel2 != "" || tel3 != "") {
	      if(!regTel.test(tel)) {
	        alert("전화번호 형식에 맞지않습니다.(000-0000-0000)");
	        myForm.tel2.focus();
	        return false;
	      }
	      else {
	    	  submitFlag = 1;
	      }
      }
    	
  		// 전송전에 '주소'를 하나로 묶어서 전송처리 준비한다.
  		let postcode = myForm.postcode.value;
  		let roadAddress = myForm.roadAddress.value;
  		let detailAddress = myForm.detailAddress.value;
  		let extraAddress = myForm.extraAddress.value;
  		myForm.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
  		
  		// 전송전에 파일에 관한 사항체크...
  		if(fName.trim() == "") {
  			myForm.photo.value = "${vo.photo}"
				submitFlag = 1;
  		}
  		else {
  			let fileSize = document.getElementById("file").files[0].size;
  			
  			if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG") {
  				alert("업로드 가능한 파일은 'JPG/GIF/PNG'파일 입니다.");
  				return false;
  			}
  			else if(fName.indexOf(" ") != -1) {
  				alert("업로드 파일명에 공백을 포함할 수 없습니다.");
  				return false;
  			}
  			else if(fileSize > maxSize) {
  				alert("업로드 파일의 크기는 2MByte를 초과할수 없습니다.");
  				return false;
  			}
    		submitFlag = 1;
    	}
    	
  		// 전송전에 모든 체크가 끝나서 submitFlag가 1이되면 서버로 전송한다.
  		let nickName_ = '${sNickName}';
    	if(submitFlag == 1) {
    		if(nickName_ != nickName && nickCheckSw == 0) {
    			alert("닉네임 중복체크버튼을 눌러주세요!");
    		}
    		else {
	  			// 묶여진 필드(email/tel)를 폼태그안에 hidden태그의 값으로 저장시켜준다.
	  			myForm.email.value = email;
	  			myForm.tel.value = tel;
	  			
	  			myForm.submit();
    		}
    	}
    	else {
    		alert("회원정보 변경 실패~~");
    	}
    }
    
    // nickName 중복체크
    function nickCheck() {
    	let nickName = $("#nickName").val();
    	if(nickName == "" || $("#nickName").val().length<2 || $("#nickName").val().length>=20 ) {
    		alert("닉네임을 입력하세요(닉네임은 4~20자이내로 입력하세요.)!");
    		myForm.nickName.focus(); // JS
    		return false;
    	}
    	if(nickName == '${sNickName}') {
    		nickCheckSw= 1;
    		return false;
    	}
    	
    	$.ajax({
    		type :"post",
    		url : "${ctp}/member/nickNameCheck",
    		data : {nickName : nickName},
    		success : function(res) {
					if(res == 1) {
						alert("이미 사용중인 닉네임입니다.");
						$("#nickName").focus();
					}    			
					else {
						alert("사용 가능한 닉네임입니다.");
						nickCheckSw =1;			//닉네임  검색 버튼을 클리한 경우는 nickCheckSw는 1이다.
					
					}
    		},
  			error : function() {
					alert("전송오류!");
  			}
    	});
    }
  </script>
	<style>
	.btn2{
			background:#ff792a;
			color:white;
			border:0px;
			border-radius:5px;
	}
	.btn {
		background:#BDBDBD;
		color:black;
	}
	</style>
</head>
<body>
	<div>
		<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	</div>
		<div class="container" style="border:15px solid #ff792a; border-radius:10px 10px 15px 15px; margin:126px auto; width:80%; height:100%; padding-left:13%; padding-top:50px">
		 <form name="myForm" method="post" class="was-validated" action="${ctp}/member/memUpdateOk" enctype="multipart/form-data">
			<h2>회원 정보 변경</h2>
			<br/>
			<div class="form-group" style="width:90%">
				아이디: ${sMid}
			</div>
			<div class="form-group">
				<label for="pwd">비밀번호: </label>
				<input type="password" class="form-control" name="pwd" id="pwd" value="${sPwd}" required autofocus style="width:500px"/>
			</div>
			<div class="form-group">
	      <label for="name">성명 :</label>
	      <input type="text" class="form-control" id="name" name="name" value="${vo.name}" required style="width:500px"/>
	  	</div>
			<div class="form-group">
				<label for="nickName">닉네임</label>
				<input type="text" class="form-control" name="nickName" id="nickName" value="${vo.nickName}" required style="width:500px"/>
				<input type="button" value="중복확인" class="btn btn-secondary" onclick="nickCheck()"style="margin-left: 510px; margin-top: -68px; background:#eeee"/>
			</div>
			<div class="form-group" style="width:500px">
				<label for="email1">이메일 :</label>
				<div class="input-group mb-3">
				  <c:set var="emails" value="${fn:split(vo.email,'@')}"/>
				  <c:set var="email1" value="${emails[0]}"/>
				  <c:set var="email2" value="${emails[1]}"/>
				  <input type="text" class="form-control" value="${email1}" id="email1" name="email1" required />
				  <div class="input-group-append">
				    <select name="email2" class="custom-select">
					    <option value="naver.com" 	<c:if test="${email2=='naver.com'}">selected</c:if>>naver.com</option>
					    <option value="hanmail.net"	<c:if test="${email2=='hanmail.net'}">selected</c:if>>hanmail.net</option>
					    <option value="hotmail.com"	<c:if test="${email2=='hotmail.com'}">selected</c:if>>hotmail.com</option>
			 			<option value="gmail.com"	<c:if test="${email2=='gmail.com'}">selected</c:if>>gmail.com</option>
					    <option value="nate.com"	<c:if test="${email2=='nate.com'}">selected</c:if>>nate.com</option>
					    <option value="yahoo.com"	<c:if test="${email2=='yahoo.com'}">selected</c:if>>yahoo.com</option>
					 </select>
				  </div>
				</div>
  		</div>
			<div class="form-group">
				<div class="form-check-inline">
					<span class="input-group-text">성별 :</span> &nbsp; &nbsp;
					<label class="form-check-label">
						<input type="radio" class="form-check-input" name="gender" value="남자" <c:if test="${vo.gender=='남자'}">checked</c:if>>남자
					</label>
				</div>
				<div class="form-check-inline">
					<label class="form-check-label">
						<input type="radio" class="form-check-input" name="gender" value="여자" <c:if test="${vo.gender=='여자'}">checked</c:if>>여자
					</label>
				</div>
			</div>
	    <div class="form-group">
     	 <label for="birthday">생일</label>
			 <input type="date" name="birthday" value="${fn:substring(vo.birthday,0,10)}" class="form-control" style="width:500px"/>
   		</div>
				<div class="form-group" style="width:62%">
					<div class="input-group mb-3" >
						<div class="input-group-prepend">
							<span class="input-group-text">전화번호 :</span>
							<c:set var="tel" value="${fn:split(vo.tel,'-')}"/>
							<c:set var="tel1" value="${tel[0]}"/>
							<c:set var="tel2" value="${tel[1]}"/>
							<c:set var="tel3" value="${tel[2]}"/>
								<select name="tel1" class="custom-select">
									<option value="010"	${tel1=="010" ? selected : ""}>010</option>
									<option value="02"	${tel1=="02"  ? selected : ""}>서울</option>
									<option value="031"	${tel1=="031" ? selected : ""}>경기</option>
									<option value="032"	${tel1=="032" ? selected : ""}>인천</option>
									<option value="041"	${tel1=="041" ? selected : ""}>충남</option>
									<option value="042"	${tel1=="042" ? selected : ""}>대전</option>
									<option value="043"	${tel1=="043" ? selected : ""}>충북</option>
									<option value="051"	${tel1=="051" ? selected : ""}>부산</option>
									<option value="052"	${tel1=="052" ? selected : ""}>울산</option>
									<option value="061"	${tel1=="061" ? selected : ""}>전북</option>
									<option value="062"	${tel1=="062" ? selected : ""}>광주</option>
								</select>➖
						</div>
						<input type="text" name="tel2" value="${tel2}" size=4 maxlength=4 class="form-control"/>➖
						<input type="text" name="tel3" value="${tel3}" size=4 maxlength=4 class="form-control"/>
					</div> 
				</div>
		  	<div class="form-group" style=width:62%>
      		<label for="address">주소</label>
					<input type="hidden" name="address" id="address">
						<c:set var="address" value="${fn:split(vo.address,'/')}"/>
						<c:set var="postcode" value="${address[0]}"/>
						<c:set var="roadAddress" value="${address[1]}"/>
						<c:set var="detailAddress" value="${address[2]}"/>
						<c:set var="extraAddress" value="${address[3]}"/>
					<div class="input-group mb-1">
						<input type="text" name="postcode" id="sample6_postcode" value="${postcode}" placeholder="우편번호" class="form-control">
						<div class="input-group-append">
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
						</div>
					</div>
					<input type="text" name="roadAddress" id="sample6_address" size="50" value="${roadAddress}" class="form-control mb-1">
					<div class="input-group mb-1">
						<input type="text" name="detailAddress" id="sample6_detailAddress" value="${detailAddress}" class="form-control"> &nbsp;&nbsp;
						<div class="input-group-append">
							<input type="text" name="extraAddress" id="sample6_extraAddress" value="${extraAddress}" class="form-control">
						</div>
					</div>
	    	</div>
			<div class="form-group" style=width:62%>
    		회원 사진(파일용량:2MByte이내) :	<img src="${ctp}/member/${vo.photo}" width="80px"/>
    		<input type="file" name="fName" id="file" class="form-control-file border"/>
	   	</div>
			<div class="form-group">
				<button type="button" class="btn2 btn-secondary"  onclick="fCheck()" style= "width:166px;">회원 정보 수정</button>
				<button type="reset"  class="btn2 btn-secondary" style= "width:166px;">다시작성</button>
				<button type="button" class="btn2 btn-secondary"  onclick="location.href='${ctp}/';" style= "width:160px;">돌아가기</button>
				<input type="hidden" name="email"/>
				<input type="hidden" name="tel"/>
				<input type="hidden" name="photo" value="${vo.photo}"/>
				<input type="hidden" name="mid" value="${sMid}"/>
			</div>
		</form>
	  </div>
	<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>