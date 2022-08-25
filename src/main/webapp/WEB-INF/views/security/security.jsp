<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>security.jsp</title>
	<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
		<script>
		'use strict';
		let str = "";
		let i = 0;
		
		function securityCheck() {
			let pwd = document.getElementById("pwd").value;
			
			$.ajax({
				type :"post",
				url : "${ctp}/security/securityCheck",
				data : {pwd : pwd},
				success : function(res) {
					i++;
					str += i + ":" + res + "<br/>";
					$("#demo").html(str);
				},
				error :function() {
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
  	<h2>BCryptPasswordEncoder란?</h2>
  	<pre>
  		- 스프링 시큐리티(Spring Security) 프레임 워크에서 제공하는 클래스중 하나로 비밀번호를 암호화 하는데 사용함.
  			자바 서버 개발을 위해 필요한 인증/권한부여 및 기타 보안기능을 제공해주는 프레임워크이다.
  		- BCryptPasswordEncoder는 BCrypt해싱함수(BCrypt hashing function)를 사용하여 비밀번호를 인코딩해주는 메소드와
  			사용자에 의해 제출된 비밀번호와 저장조에 저장된 비밀번호의 일치여불르 확인해주는 메소드를 제공한다.
  		- PasswordEncoder 인터페이스를 구현한 클래스이다.
  		- encode(java.lang.CharSequence) :
  			패스워드 암호화 해주는 메소드이다. 반환타입은 String이다.
  			encode()메서드는 sha-1, 8바이트로 결합된 해시키를 랜덤하게 생성된 솔트(salt)를 지원한다.
  		- matchers(java.lang.CharSequence)
  			제출된 인코딩 되지 않은 패스워드의 일치여부를 판단하기 위해 인코딩된 패스워드와 비교 판단한다.
  			반환타입은 boolean이다.
  	</pre>
  	<hr/>
  	<p>
  		<input type="text" name="pwd" id="pwd" autofocus/>
  		<input type="button" value='실습' onclick="securityCheck()"/>
  	</p>
  	<hr/>
  	출력결과 <br/>
  	<span id="demo"></span>
  	</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>