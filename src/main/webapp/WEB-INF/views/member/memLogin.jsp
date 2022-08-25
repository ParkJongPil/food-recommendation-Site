<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memLogin.jsp</title>
 	<link rel="stylesheet" type="text/css" href="${ctp}/css/css.css"/>
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
	
	<style>
		body{
			background:#eeee;
		}
		#find{
			margin-left:55%;
			margin-top:-5%;
		}
		.form{
			border-radius:20px 20px 40px 40px;
			border:10px solid #ff792a;
			width:450px;
			height:450px;
			margin-left:40%;
			margin-top:5%;
			padding-left:4px;
		}
		.form-group2{
			text-align:left;
		    padding-bottom: 20px;
		    margin-top:-7%;
		}
		#reset{
			background:#ff792a;
			border:0px;
			color:white;
		}
		.btn2 {
			background:#ff792a;
			color:white;
			border:0px
		}
	</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<p><br/></p>
	<div class="form">
		<div class="container">
		 <form name="myForm" method="post" class="was-validated">
			<h2 style="text-align:center; color:black;">로그인</h2>
			<h5 style=text-align:center>가입하신 <font color="orange"><b>아이디</b></font>로 로그인 하세요.</h5>
			<div class="form-group">
				<label for="mid">아이디: </label>
				<input type="text" class="form-control" name="mid" id="mid" placeholder="아이디" value="${mid}" required autofocus style="width:400px"/>
				<div class="valid-feedback">입력 성공!</div>
				<div class="invalid-feedback">아이디는 필수 입력사항입니다.</div>
				<br/>
			</div>
			<div class="form-group">
				<label for="pwd">비밀번호 : </label>
				<input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호" required style="width:400px" />
				<div class="invalid-feedback">비밀번호 필수 입력사항입니다.</div>
			</div>
			<p><br/></p>
			<div class="form-group2">
				<button type="submit" class="btn2 btn-secondary" style="height:40px">로그인</button>
				<button type="reset" class="btn2 btn-secondary" style="height:40px" id="reset">취소</button>
				<button type="button" class="btn2 btn-secondary" onclick="location.href='${ctp}/member/memJoin';" style="height:40px">회원가입</button>
				<a href="https://kauth.kakao.com/oauth/authorize?client_id=f9332d17289c0485f922f6c746c53ca6&redirect_uri=http://localhost:9090/javagreenS_pjp/kakao/kakaoMain&response_type=code">
					<!-- <a href="https://kauth.kakao.com/oauth/authorize?client_id=ad8a95f25da4d209c0cad67cf5f6da01&redirect_uri=http://192.168.50.117:9090/javagreenS_pjp/kakao/kakaoMain&response_type=code"> -->
	        <!-- <a href="https://kauth.kakao.com/oauth/authorize?client_id=ad8a95f25da4d209c0cad67cf5f6da01&redirect_uri=http://49.142.157.251:9090/javagreenS_pjp/kakao/kakaoMain&response_type=code"> -->
					<%-- <img src="${ctp}/images/kakao_login.jpg" class="text-center" style="height:30px;"/> --%>
					<button type="button" style="border-radius:2px; border:0px; background:#f6de00; height:40px; font-size:13px;"><b><i class="fa-solid fa-comment"></i> 카카오 간편 로그인</b></button>
	    	</a>
			</div>
			<div class="row" style="font-size:13px; margin-left:0%;">
				<span class="col"><input type="checkbox" name="idCheck" checked/><b>아이디 저장 🔒</b></span>
				<div id="find">
					<span class="col">
						<a href="${ctp}/member/memIdPwdSearch" style="color:black"><b>아이디  |  비밀번호 찾기</b></a>
			 		</span>
			 	</div>
			</div>
		 </form>
		</div>
	</div>
	<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>