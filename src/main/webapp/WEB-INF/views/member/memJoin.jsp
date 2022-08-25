<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memJoin.jsp</title>
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
	
	<script>
		'use strict';
		let idCheckSw = 0;
		let nickCheckSw= 0;
		
		// 회원가입폼 체크 시 서버로 전송
		function fCheck() {
			let regMid = /^[a-z0-9_]{4,15}$/;
			let	regPwd = /(?=.*[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,20}/;
			let regNickName= /^[가-힣]+$/;
			let regName= /^[가-힣]+$/;
			let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
			
			let submitFlag=0;
			
			let mid = myForm.mid.value;
			let pwd = myForm.pwd.value;
			let nickName = myForm.nickName.value;
			let name = myForm.name.value;
			let email1 = myForm.email1.value;
			let email2 = myForm.email2.value;
			let email = email1 +'@'+email2;
			let tel1 = myForm.tel1.value;
			let tel2 = myForm.tel2.value;
			let tel3 = myForm.tel3.value;
			let tel  = myForm.tel1.value + "-" + myForm.tel2.value + "-" + myForm.tel3.value;
	      	
			// 사진 업로드 체크
			let fName = myForm.fName.value;
			let ext = fName.substring(fName.lastIndexOf(".")+1);	// 파일 확장자 식별
			let uExt = ext.toUpperCase();													// 확장자를 대문자로 변환처리
			let maxSize = 1024 * 1024 * 2;												// 업로드 할 회원사진의 최대 용량은 2MByte로 제한함
			
			// 추가적으로 체크해야 할 항목들을 모두 체크하세요.
			if(!regMid.test(mid)) {
				alert("아이디는 영문 소문자와 숫자, 언더바(_)만 사용 가능합니다.(길이는 4~15자리까지 허용)");
				myForm.mid.focus();
				return false;
			}
			else if(!regPwd.test(pwd)) {
				alert("비밀번호는 1개 이상의 문자와 특수문자 조합의 8~20자리로 작성 가능합니다.");
				myForm.pwd.focus();
				return false;
			}
			else if(!regNickName.test(nickName)) {
				alert("닉네임은 한글만 사용 가능합니다.");
				myForm.nickName.focus();
				return false;
			}		
			else if(!regName.test(name)) {
				alert("이름은 한글만 사용 가능합니다.");
				myForm.name.focus();
				return false;
			}		
			else if(!regEmail.test(email)) {
				alert("이메일 형식에 맞지 않습니다.");
				myForm.email.focus();
				return false;
			}
			else {
				submitFlag=1;
			}
			
			if(tel2 != "" || tel3 != ""){
				if(!regTel.test(tel)) {
					alert("전화번호 형식에 맞지 않습니다.(000-0000-0000)");
					myForm.tel2.focus();
					return false;
				}
				else {
					submitFlag =1;
				}
			}
			// 전화번호를 입력하지 않을 시 DB에 '010- -'의 형태로 저장
			else {
				tel2 =" ";
				tel3 =" ";
				tel = tel1 + '-' + tel2 + '-' + tel3;
				submitFlag= 1;
			}
			// 전송전 '주소'를 하나로 묶어서 전송 준비
			let postcode = myForm.postcode.value + " ";
			let roadAddress = myForm.roadAddress.value + " ";
			let detailAddress = myForm.detailAddress.value + " ";
			let extraAddress = myForm.extraAddress.value + " ";
			myForm.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
			
			// 전송전 사진 파일에 관한 사항 체크
			if(fName.trim() == "") {
				myForm.photo.value = "noimage"
				submitFlag = 1;
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
				submitFlag= 1;
			}
			
			// 중복 체크 끝나면 서버로 전송
			if(submitFlag ==1) {
				if(idCheckSw==0) {
					alert('아이디 중복확인 버튼을 눌러주세요!');
				}
				else if(nickCheckSw==0) {
					alert('닉네임 중복확인 버튼을 눌러주세요!');
				}
				else {
					myForm.email.value= email;
					myForm.tel.value= tel;
					
					myForm.submit();
				}
			}
			else {
				alert("회원가입 실패!");
			}
		}
		
		
		// 아이디 중복 체크
		function idCheckmid() {
			let mid = $("#mid").val();
			if(mid == "" || $("#mid").val().length<4 || $("#mid").val().length>=15) {
				alert("아이디를 입력하세요! (아이디는 4~15자이내로 입력 가능합니다.)");
				myForm.mid.focus();
				return false;
			}
			$.ajax({
				type : "post",
				url : "${ctp}/member/memIdCheck",
				data : {
					mid : mid
				},
				success : function(res){
					if(res != '0'){
						alert("이미 사용중인 아이디입니다.");
						$("#mid").focus();				
					}
					else{
						alert("사용가능한 아이디입니다");
						idCheckSw =1;
					}
				},
				error : function(){
					alert("전송오류");
				}
			});
		}
		// 닉네임 중복체크
		function nickCheck() {
			let nickName = $("#nickName").val();
			if(nickName =="" || $("#nickName").val().length<2 || $("#nickName").val().length>=10) { 
				alert('닉네임을 입력하세요! (닉네임은 2~10자리이내로 입력 가능합니다.)');
				myForm.nickName.focus();
				return false;
			}
			
			$.ajax({
				type:"post",
				url : "${ctp}/member/nickNameCheck",
				data : {
					nickName : nickName
				},
				success : function(res) {
					if(res !='0') {
						alert('이미 사용중인 닉네임입니다.');
						$("#nickName").focus();
					}
					else {
						alert('사용 가능한 닉네임입니다.');
						nickCheckSw = 1;
					}
				},
				error : function() {
					alert("전송오류!");
				}
			});
		}
	</script>	
	<style>
	.create{
		background:#ff792a;
		color:white;
		border:0px;
		border-radius:5px;
	}
	.create2{
		background:#ff792a;
		color:white;
		border:0px;
		border-radius:5px;
	}
	.btn {
		background:#BDBDBD;
		color:black;
	}
	body{
		background:#eeee;
	}
	</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<p><br/></p>
	<div class="container" style="border:15px solid #ff792a; border-radius:10px 10px 15px 15px; margin:130px auto; width:80%; height:100%; padding-left:13%; padding-top:50px">
		<form name="myForm" method="post" class="was-validated" enctype="multipart/form-data">
			<h2>회원가입</h2>
			<hr/>
			<br/>
			<div class="main" style="width:90%">
				<div class="form-group">
					<label for="mid"><b><font color="red">*</font></b>아이디: </label>
					<input type="text" class="form-control" name="mid" id="mid" placeholder="아이디" required autofocus style="width:500px"/>
					<input type="button" value="중복확인" class="btn btn-secondary" onclick="idCheckmid()" style="margin-left: 510px; margin-top: -68px; background:#eeee"/>
				</div>
				<div class="form-group">
					<label for="pwd"><b><font color="red">*</font></b>비밀번호: </label>
					<input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호" required style="width:500px"/>
				</div>
				<div class="form-group">
					<label for="pwdCheck"><b><font color="red">*</font></b>비밀번호 확인 </label>
					<input type="password" class="form-control" name="pwdCheck" id="pwdCheck" placeholder="비밀번호" required style="width:500px"/>
				</div>
				<div class="form-group">
					<label for="name"><b><font color="red">*</font></b>성명 :</label>
					<input type="text" class="form-control" name="name" id="name" placeholder="성명" required style="width:500px"/>
				</div>
				<div class="form-group">
					<label for="nickName"><b><font color="red">*</font></b>닉네임 :</label>
					<input type="text" class="form-control" name="nickName" id="nickName" placeholder="닉네임" required style="width:500px"/>
					<input type="button" value="중복확인" class="btn btn-secondary" onclick="nickCheck()"style="margin-left: 510px; margin-top: -68px; background:#eeee"/>
				</div>
				<div class="form-group" style=width:62%>
	      		<label for="email"><b><font color="red">*</font></b>이메일:</label>
						<div class="input-group mb-3">
						  <input type="text" class="form-control" placeholder="이메일" id="email1" name="email1" required />
						  <div class="input-group-append">
						    <select name="email2" class="custom-select">
							    <option value="naver.com" selected>naver.com</option>
							    <option value="hanmail.net">hanmail.net</option>
							    <option value="hotmail.com">hotmail.com</option>
							    <option value="gmail.com">gmail.com</option>
							    <option value="nate.com">nate.com</option>
							    <option value="yahoo.com">yahoo.com</option>
						    </select>
						  </div>
						</div>
			 	 </div>
				 <div class="form-group">
		      <div class="form-check-inline">
			      <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
					  <label class="form-check-label">
					  	<input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
					  </label>
					</div>
					<div class="form-check-inline">
					  <label class="form-check-label">
					    <input type="radio" class="form-check-input" name="gender" value="여자">여자
					  </label>
					</div>
		     </div>
	      <div class="form-group" style="width:500px;">
	     	 <label for="birthday">생일</label>
	     	 <c:set var="now" value="<%=new java.util.Date() %>"/>
	   		 <fmt:formatDate var="birthday" value="${now}" pattern="yyyy-MM-dd"/>
		 	 	 <input type="date" name="birthday" value="${birthday}" class="form-control"/>
	 		  </div>
				<div class="form-group" style="width:62%">
		     	<div class="input-group mb-3" >
			      <div class="input-group-prepend">
						 <span class="input-group-text">전화번호 :</span>
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
	   			<label for="address">주소</label>
					<input type="hidden" name="address" id="address" value="">
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
				<div class="form-group" style=width:62%>
		    	회원 사진(파일용량:2MByte이내) :
		  		<input type="file" name="fName" id="file" class="form-control-file border"/>
	   		</div>
				<div class="form-group">
					<button type="button" class="create btn-secondary" value="가입" onclick="fCheck()" style= "width:166px;">회원가입</button>
					<button type="reset"  class="create2 btn-secondary"value="취소" style= "width:166px;">다시작성</button>
					<button type="button" class="create btn-secondary" value="이전" onclick="location.href='${ctp}/';" style= "width:160px;">돌아가기</button>
					<input type="hidden" name="email"/>
					<input type="hidden" name="tel"/>
					<input type="hidden" name="photo"/>
				</div>
			</div>	
		</form>
  </div>
	<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>